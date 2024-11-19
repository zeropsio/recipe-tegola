#!/bin/bash

set -u

psql -h postgis -p 5432 -U postgres -c "CREATE EXTENSION postgis;"
psql -h postgis -p 5432 -U postgres -c "ALTER user postgis CREATEDB;"

export PGPASSWORD="$DB_PASSWORD"
psql -h postgis -p 5432 -U postgis -c "CREATE DATABASE bonn;"
psql -h postgis -p 5432 -U postgis -d bonn < ./data/bonn_example.sql
psql -h postgis -p 5432 -U postgis -d bonn < ./data/sql/add_index.sql

rm ./data/bonn_example.sql
rm ./data/._bonn_example.sql
