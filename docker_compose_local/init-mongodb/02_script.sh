#!/bin/bash

echo "Loading data to MongoDB ..."
mongoimport --jsonArray -d agile_data_science -c origin_dest_distances --file /tmp/data/origin_dest_distances.json
