#!/bin/bash

output_path="$1"
prefix=""

if [[ -n "$PARTITIONED" ]]; then
    prefix="_partitioned"
fi

query="
    EXPLAIN (ANALYZE, FORMAT JSON)
    SELECT
        item_id,
        game_id,
        MIN(cost)
    FROM lots$prefix
    GROUP BY item_id, game_id;
"

psql -U "$user" -d "$db" -c "$query" >"$output_path"
