#!/bin/bash

output_path="$1"

query="
    EXPLAIN (ANALYZE, FORMAT JSON)
    SELECT
        item_id,
        game_id,
        MIN(cost)
    FROM lots
    GROUP BY item_id, game_id;
"

psql -U "$user" -d "$db" -c "$query" >"$output_path"
