#!/bin/bash

user_id=$1
attempts=$QUERY_ATTEMPTS

result_path="/analysis/inventory_cost/$1"
user=$POSTGRES_USER
db=$POSTGRES_DB

mkdir -p "$result_path"

if [ -z $user ]; then
    user="postgres"
fi

if [ -z $db ]; then
    db="postgres"
fi

sum_cost=0
worst_attempt=-1
best_attempt=-1

for (( attempt = 1; attempt <= attempts; ++attempt )); do
    psql -U $user -d $db -c "EXPLAIN ANALYZE SELECT AVG(cost) FROM lots INNER JOIN (SELECT user_inventories.item_id, user_inventories.game_id FROM user_inventories WHERE user_id = $user_id) AS ui ON ui.item_id = lots.item_id AND ui.game_id = lots.game_id;" > "$result_path/$attempt"

    cost=$( grep cost "$result_path/$attempt" | head -n1 | awk -F 'cost=' '{ print $2 }' | awk -F 'rows=' '{ print $1 }' | awk -F. '{ print $(NF - 1) }' )

    (( sum_cost += cost ))
    (( total_attempts++ ))

    if [[ $best_attempt -eq -1 ]] || [[ $cost -lt $best_attempt ]]; then
        best_attempt=$cost
    fi

    if [[ $worst_attempt -eq -1 ]] || [[ $cost -gt $worst_attempt ]]; then
        worst_attempt=$cost
    fi
done

avg_attempt=$(( sum_cost / attempts ))

echo "$worst_attempt" > "$result_path/worst"
echo "$avg_attempt" > "$result_path/avg"
echo "$best_attempt" > "$result_path/best"
