#!/bin/bash

output_path="$1"
prefix=""

if [[ -n "$PARTITIONED" ]]; then
    prefix="_partitioned"
fi

query="
    EXPLAIN (ANALYZE, FORMAT JSON)
    SELECT AVG(cost)
    FROM lots$prefix
    INNER JOIN (
        SELECT
            user_inventories$prefix.item_id,
            user_inventories$prefix.game_id
        FROM user_inventories$prefix
        WHERE user_id = $user_id
    ) AS ui
    ON ui.item_id = lots$prefix.item_id
        AND ui.game_id = lots$prefix.game_id;
"

psql -U "$user" -d "$db" -c "$query" >"$output_path"
