#!/bin/bash

export user_id="$1" # might be equal to '.'
export item_id="$2" # might be equal to '.' or empty
export game_id="$3" # might be equal to '.' or empty
export user="$POSTGRES_USER"
export db="$POSTGRES_DB"

if [ -z "$user" ]; then
    export user="postgres"
fi

if [ -z "$db" ]; then
    export db="postgres"
fi

# DROP INDEXES IF EXIST

psql -U "$user" -d "$db" -f "/analysis/indices/01_lots_drop_index.sql"
psql -U "$user" -d "$db" -f "/analysis/indices/02_user_inventories_drop_index.sql"

# ANALYZE BEFORE INDEXING TABLES

./analyze.sh lots_for_item lots_for_item
./analyze.sh lowest_prices lowest_prices
./analyze.sh inventory_cost inventory_cost

# CREATE INDEXES

psql -U "$user" -d "$db" -f "/analysis/indices/01_lots_create_index.sql"
psql -U "$user" -d "$db" -f "/analysis/indices/02_user_inventories_create_index.sql"

# ANALYZE AFTER INDEXING TABLES

./analyze.sh lots_for_item lots_for_item
./analyze.sh lowest_prices lowest_prices
./analyze.sh inventory_cost inventory_cost
