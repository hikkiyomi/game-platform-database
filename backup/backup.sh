#!/bin/bash

count_backups() {
	find ./backups -mindepth 1 -maxdepth 1 | wc -l
}

find_oldest_backup() {
	find ./backups -mindepth 1 -maxdepth 1 | sort | head -n 1
}

user="$POSTGRES_USER"
db="$POSTGRES_DB"

if [[ -z "$user" ]]; then
	user="postgres"
fi

if [[ -z "$db" ]]; then
	db="postgres"
fi

current_date="$( date +"%Y-%m-%d_%H:%M:%S" )"
dump_name="$db"_"$current_date"
backup_dir="./backups"

mkdir -p "$backup_dir"

pg_dump -U "$user" -d "$db" >"$backup_dir/$dump_name"

while [[ "$( count_backups )" -gt "$BACKUPS_ALLOWED" ]]; do
	oldest_backup="$( find_oldest_backup )"
	rm -rf "$oldest_backup"
done
