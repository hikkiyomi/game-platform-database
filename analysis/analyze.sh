#!/bin/bash

get_total_sum_by_parameter() {
    pattern="$1"
    path="$2"
    sum=0
    costs="$( grep "$pattern" $path \
                        | awk -F: '{ print $2 }' \
                        | awk -F. '{ print $1 }' \
                        | tr -d ' ' )"

    while read -r value; do
        (( sum += value ))
    done <<<"$costs"

    echo "$sum"
}

task_name="$1"
script_name="$2"
attempts="$QUERY_ATTEMPTS"
result_path="/analysis/$task_name/timestamp_$( date +%s )"

mkdir -p "$result_path"

sum_cost=0
worst_attempt=-1
best_attempt=-1

for (( attempt = 1; attempt <= attempts; ++attempt )); do
    output_path="$result_path/$attempt"

    ./"$task_name"/"$script_name".sh "$output_path"

    cost="$( get_total_sum_by_parameter 'Total Cost' "$output_path" )"
    (( sum_cost += cost ))

    rm -f "$output_path"

    if [[ "$best_attempt" -eq -1 ]] || [[ "$cost" -lt "$best_attempt" ]]; then
        best_attempt="$cost"
    fi

    if [[ "$worst_attempt" -eq -1 ]] || [[ "$cost" -gt "$worst_attempt" ]]; then
        worst_attempt="$cost"
    fi
done

avg_attempt="$(( sum_cost / attempts ))"

echo "$worst_attempt" >"$result_path/worst"
echo "$avg_attempt" >"$result_path/avg"
echo "$best_attempt" >"$result_path/best"
