#!/bin/bash
set -e

# Run preprocessing
echo "[ENTRYPOINT] starting entrypoint.sh, pwd=$(pwd), ls=$(ls -1 /docker-entrypoint-initdb.d)"
( cd /docker-entrypoint-initdb.d && /usr/local/bin/preprocess.sh )

# Start Postgres
exec /usr/local/bin/docker-entrypoint.sh "$@"
