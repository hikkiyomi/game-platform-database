#!/bin/bash

psql -U "$user" -d "$db" -f "/analysis/partitioning/lots_create_partitions.sql"
psql -U "$user" -d "$db" -f "/analysis/partitioning/user_inventories_create_partitions.sql"
