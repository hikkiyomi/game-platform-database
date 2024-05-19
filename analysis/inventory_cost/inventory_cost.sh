#!/bin/bash

output_path="$1"

query="
    EXPLAIN (ANALYZE, FORMAT JSON)
    SELECT AVG(cost)
    FROM lots
    INNER JOIN (
        SELECT
            user_inventories.item_id,
            user_inventories.game_id
        FROM user_inventories
        WHERE user_id = "$user_id"
    ) AS ui
    ON ui.item_id = lots.item_id
        AND ui.game_id = lots.game_id;
"

psql -U "$user" -d "$db" -c "$query" >"$output_path"
