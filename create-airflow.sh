#!/bin/bash

cd /root
mkdir airflow
cd airflow
mkdir dags
mkdir logs
mkdir plugins

cd ..
git clone https://github.com/ging/practica_big_data_2019.git

cp practica_big_data_2019/resources/airflow/setup.py airflow/dags/
