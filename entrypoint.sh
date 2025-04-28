#!/bin/bash
set -e

# Run preprocessing
/usr/local/bin/preprocess.sh

# Start Postgres
exec /usr/local/bin/docker-entrypoint.sh "$@"
