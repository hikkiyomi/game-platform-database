#!/bin/bash

output_path="$1"
prefix=""

if [[ -n "$PARTITIONED" ]]; then
    prefix="_partitioned"
fi

query="
    EXPLAIN (ANALYZE, FORMAT JSON)
    SELECT *
    FROM lots$prefix
    WHERE item_id = $item_id
        AND game_id = $game_id;
"

psql -U "$user" -d "$db" -c "$query" >"$output_path"
