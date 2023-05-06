#!/bin/bash

# Show database information
echo "Showing database information ..."
gnome-terminal --tab --title="Database Info" \
        --command="bash -c 'cd /home/$USER/PFINAL-FBID2022; mongosh agile_data_science showdb.js; $SHELL'"
