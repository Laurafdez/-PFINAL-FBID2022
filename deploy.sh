#!/bin/bash

# Clone the repository
echo "Cloning the repository ..."
git clone https://github.com/ging/practica_big_data_2019.git
cd practica_big_data_2019

# Required installation for new gnome terminals
echo "Installing package for gnome terminals ..."
sudo apt install -y dbus-x11
sudo apt install -y gnome-terminal

# Install initial requirements
echo "Installing initial requirements ..."
resources/download_data.sh
pip install -r requirements.txt

# Start zookeeper and kafka
echo "Starting zookeeper ..."
gnome-terminal --tab --title="Zookeeper" \
        --command="bash -c 'cd; chmod 777 /usr/local/kafka/; /usr/local/kafka/bin/zookeeper-server-start.sh /usr/local/kafka/config/zookeeper.properties; $SHELL'"
echo "Starting kafka ..."
gnome-terminal --tab --title="Kafka" \
        --command="bash -c 'cd; /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties; $SHELL'"

# Create a kafka topic
echo "Creating a new kafka topic ..."
sleep 10
/usr/local/kafka/bin/kafka-topics.sh \
      --create \
      --bootstrap-server localhost:9092 \
      --replication-factor 1 \
      --partitions 1 \
      --topic flight_delay_classification_request

# Start MongoDB
echo "Starting mongoDB ..."
sudo service mongod start

# Import airline data using monsh
echo "Importing airline data ..."
cd ..
sed -i 's/mongo /mongosh /g' practica_big_data_2019/resources/import_distances.sh
cd practica_big_data_2019
./resources/import_distances.sh
cd ..

# Export environment variables
echo "Exporting environment variables ..."
export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
export SPARK_HOME=/opt/spark

# Train the model
echo "Training the model ..."
python3 practica_big_data_2019/resources/train_spark_mllib_model.py practica_big_data_2019

# Modify the base_path
echo "Creating JAR file ..."
sed -i 's@val base_path= "/Users/admin/IdeaProjects/ging/practica_big_data_2019"@val base_path= "/home/" + sys.env("USER") + "/PFINAL-FBID2022/practica_big_data_2019"@g' \
	/home/$USER/PFINAL-FBID2022/practica_big_data_2019/flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala

# Create JAR file to use with spark-submit command
cd /home/$USER/PFINAL-FBID2022/practica_big_data_2019/flight_prediction
sbt package
chmod 777 target/scala-2.12/flight_prediction_2.12-0.1.jar
cd ..

# Spark-submit
echo "Submitting JAR file to Spark ..."
gnome-terminal --tab --title="Spark Submit" \
	--command="bash -c 'cd; /opt/spark/bin/spark-submit --deploy-mode client --class es.upm.dit.ging.predictor.MakePrediction --master local[2] --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.0 /home/$USER/PFINAL-FBID2022/practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar; $SHELL'"

# Run the web service
echo "Running the web service ..."
export PROJECT_HOME=/home/$USER/PFINAL-FBID2022/practica_big_data_2019
gnome-terminal --tab --title="Web Service" \
	--command="bash -c 'cd /home/$USER/PFINAL-FBID2022/practica_big_data_2019/resources/web; pip install joblib; echo "http://localhost:5000/flights/delays/predict_kafka"; python3 predict_flask.py; $SHELL'"

# Install and run airflow
echo "Executing airflow ..."

export AIRFLOW_HOME=~/airflow

cd
cd PFINAL-FBID2022/
sudo chmod 777 create-airflow.sh
sudo su -c ./create-airflow.sh root

cd
cd PFINAL-FBID2022/practica_big_data_2019/resources/airflow

sed -i 's/numpy==1.20.3/numpy==1.21.5/g' constraints.txt
sed -i 's/certifi==2020.12.5/certifi==2021.10.8/g' constraints.txt

sudo pip install -r requirements.txt -c constraints.txt
sudo pip install apache-airflow[cncf.kubernetes]

echo "Choose a password for the airflow's admin account ..."
sudo airflow users create \
    --username admin \
    --firstname Jack \
    --lastname  Sparrow\
    --role Admin \
    --email example@mail.org

sudo airflow db init

cd
gnome-terminal --tab --title="Airflow Webserver" \
        --command="bash -c 'cd; sudo airflow webserver --port 8080; $SHELL'"

gnome-terminal --tab --title="Airflow Scheduler" \
        --command="bash -c 'cd; sudo airflow scheduler; $SHELL'"

# Finished deployment
cd PFINAL-FBID2022
echo "Scenario successfully deployed! Visit http://localhost:5000/flights/delays/predict_kafka to make use of the flight delay predictions."


