#!/bin/bash

attempts=$QUERY_ATTEMPTS

result_path="/analysis/lowest_prices_indexed/"
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
    psql -U $user -d $db -c "EXPLAIN ANALYZE SELECT item_id, game_id, MIN(cost) FROM lots GROUP BY item_id, game_id;" > "$result_path/$attempt"

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
