#!/bin/bash

output_path="$1"

query="
    EXPLAIN (ANALYZE, FORMAT JSON)
    SELECT *
    FROM lots
    WHERE item_id = $item_id
        AND game_id = $game_id;
"

psql -U "$user" -d "$db" -c "$query" >"$output_path"
