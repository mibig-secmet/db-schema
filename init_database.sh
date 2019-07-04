#!/bin/bash

set -o errexit
set -o nounset

echo "Using ${PSQL_HOST:=localhost}:${PSQL_PORT:=5432} with db ${PSQL_DB:=mibig} as ${PSQL_USER:=postgres}"
PSQL_SCHEMA=mibig

PSQL="psql -h $PSQL_HOST -p $PSQL_PORT -U $PSQL_USER"
PSQL_MIBIG="$PSQL $PSQL_DB"

$PSQL -tc "SELECT 1 FROM pg_database WHERE datname = '${PSQL_DB}';" | grep -q 1 || $PSQL -c "CREATE DATABASE $PSQL_DB;"

echo "Clearing out the whole schema"
$PSQL_MIBIG -c "DROP SCHEMA IF EXISTS ${PSQL_SCHEMA} CASCADE;"

$PSQL_MIBIG -c "CREATE SCHEMA IF NOT EXISTS ${PSQL_SCHEMA};"

# tables not depending on other tables
TABLES="taxa bgc_types"
# tables depending on other tables. Please keep the order intact
TABLES="$TABLES entries compounds"
# tables that create many-to-many relations
TABLES="$TABLES rel_entries_types"
# precalculated data, load this last
TABLES="$TABLES preload_taxa"

for t in $TABLES; do
    echo "Processing $t"
    $PSQL_MIBIG < "${t}.sql"
done
