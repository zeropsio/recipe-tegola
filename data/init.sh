#!/bin/bash

set -u

psql -h postgis.zerops -c "CREATE EXTENSION postgis;" || true
psql -h postgis.zerops -c "CREATE DATABASE bonn;"

psql -h postgis.zerops -d bonn < ./data/bonn_example.sql
psql -h postgis.zerops -d bonn < ./data/sql/add_index.sql
rm ./data/bonn_example.sql
rm ./data/._bonn_example.sql

psql -h postgis.zerops -c "ALTER DATABASE bonn OWNER TO postgis;"
psql -h postgis.zerops -d bonn -c "ALTER SCHEMA public OWNER TO postgis;"
psql -h postgis.zerops -d bonn -c "GRANT ALL ON DATABASE bonn TO postgis;"
psql -h postgis.zerops -d bonn -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO postgis;"
