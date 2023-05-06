db = new Mongo().getDB("agile_data_science");
db.createCollection("origin_dest_distances", {capped: false});
