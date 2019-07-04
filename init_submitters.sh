#!/bin/bash

set -o errexit
set -o nounset

PSQL_HOST=localhost
PSQL_PORT=5432
PSQL_USER=postgres
PSQL_DB=mibig
PSQL_SCHEMA=mibig_submitters

PSQL="psql -h $PSQL_HOST -p $PSQL_PORT -U $PSQL_USER"
PSQL_MIBIG="$PSQL $PSQL_DB"

$PSQL -tc "SELECT 1 FROM pg_database WHERE datname = '${PSQL_DB}';" | grep -q 1 || $PSQL -c "CREATE DATABASE $PSQL_DB;"

$PSQL_MIBIG -c "CREATE SCHEMA IF NOT EXISTS ${PSQL_SCHEMA};"

TABLES="submitters"

for t in $TABLES; do
    echo "Processing $t"
    $PSQL_MIBIG < "${t}.sql"
done
