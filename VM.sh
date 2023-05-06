#!/bin/bash

# Python3
cd
echo "Installing Python3 ..."
sudo apt update
sudo apt install -y python3
echo "Python3 successfully installed!"

# Pip
cd
echo "Installing Pip ..."
sudo apt update
sudo apt install -y python3-pip
echo "Pip successfully installed!"

# Sbt
cd
echo "Installing sbt ..."
sudo apt install curl mlocate default-jdk -y
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install -y sbt
sbt --version
echo "Sbt successfully installed!"

# MongoDB
cd
echo "Installing MongoDB ..."
sudo apt update
sudo apt install -y dirmngr gnupg apt-transport-https ca-certificates software-properties-common
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt update
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo apt-get install -y mongodb-org
echo "MongoDB successfully installed!"

# Mongosh
cd
echo "Installing Mongosh ..."
wget https://downloads.mongodb.com/compass/mongodb-mongosh_1.6.0_amd64.deb
sudo dpkg -i mongodb-mongosh_1.6.0_amd64.deb
echo "Mongosh successfully installed!"

# Spark
cd
echo "Installing Spark ..."
sudo apt update && sudo apt -y full-upgrade
wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz
tar xvf spark-3.1.2-bin-hadoop2.7.tgz
sudo mv spark-3.1.2-bin-hadoop2.7/ /opt/spark
echo "Spark successfully installed!"

# Scala
cd
echo "Installing Scala ..."
sudo apt-get -y install scala
echo "Scala successfully installed!"

# Zookeeper
cd
echo "Installing Zookeeper ..."
sudo useradd zookeeper -m
sudo usermod --shell /bin/bash zookeeper
sudo usermod -aG sudo zookeeper
sudo mkdir -p /data/zookeeper
chown -R zookeeper:zookeeper /data/zookeeper
cd /opt
sudo wget https://downloads.apache.org/zookeeper/zookeeper-3.6.3/apache-zookeeper-3.6.3-bin.tar.gz
sudo tar -xvf apache-zookeeper-3.6.3-bin.tar.gz
mv apache-zookeeper-3.6.3-bin zookeeper
chown -R zookeeper:zookeeper /opt/zookeeper
cat > /opt/zookeeper/conf/zoo.cfg
printf "tickTime = 2000\ndataDir = /data/zookeeper\nclientPort = 2181\ninitLimit = 5\nsyncLimit = 2" > /opt/zookeeper/conf/zoo.cfg
cd
echo "Zookeeper successfully installed!"

# Kafka
cd
echo "Installing Kafka ..."
sudo apt update
wget https://archive.apache.org/dist/kafka/3.0.0/kafka_2.12-3.0.0.tgz
tar xzf kafka_2.12-3.0.0.tgz
sudo mv kafka_2.12-3.0.0 /usr/local/kafka
echo "Kafka successfully installed!"

# Google Chrome
echo "Installing Google Chrome ..."
sudo apt update
sudo apt upgrade
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
echo "Google Chrome successfully installed!"

# Limpieza
echo "Removing installation files ..."
cd /home/$USER
rm kafka_2.12-3.0.0.tgz
rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb
rm spark-3.1.2-bin-hadoop2.7.tgz
rm mongodb-mongosh_1.6.0_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "All dependencies have been successfully installed. Please proceed with the execution of the flight-delay predictor scenario."
