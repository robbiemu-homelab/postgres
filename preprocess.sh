#!/bin/bash

echo "[INFO] Preprocessing SQL template files"

set -e

# Loop through all .tpl files in the current directory
for tpl_file in *.tpl; do
    # Check if the file is not empty
    if [[ -s "$tpl_file" ]]; then
        echo "[INFO] Preprocessing $tpl_file into sql"

        # Substitute environment variables into the SQL template file and output to a new .sql file
        envsubst < "$tpl_file" > "${tpl_file%.tpl}.sql"
    fi
done