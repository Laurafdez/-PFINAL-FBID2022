FROM ubuntu:22.04

WORKDIR /home/

# Install Python3 & Pip & Other dependencies
RUN apt update && apt install -y curl && \
	apt install curl mlocate default-jdk -y && \
	apt install -y python3 && \
	apt install -y python3-pip && \
	dpkg --configure -a

# Install Git & Clone the repository
RUN apt update && apt install -y git && \
        git clone https://github.com/ging/practica_big_data_2019.git && \
	chmod 777 practica_big_data_2019 && \
        practica_big_data_2019/resources/download_data.sh && \
	pip install -r practica_big_data_2019/requirements.txt

# Environment variables
ENV PROJECT_HOME=/home/practica_big_data_2019
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

# Update localhost variables to the refered container names
RUN cd practica_big_data_2019/resources/web && \
	pip install joblib && \
	sed -i 's@MongoClient()@MongoClient("mongo", 27017)@g' predict_flask.py && \
	sed -i 's@localhost:9092@kafka:9092@g' predict_flask.py

# Execute the web from entrypoint file
COPY flask.sh /
RUN chmod 777 /flask.sh

ENTRYPOINT ["/flask.sh"]

# Expose the required port for the web
EXPOSE 5000


