#!/bin/bash

version=$STEAMDB_VERSION
user=$POSTGRES_USER
db=$POSTGRES_DB

if [ -z $version ]; then
    version=$( find /migrations -type d | sort -r | head -n1 | awk -F '/' '{ print $3 }' )
fi

if [ -z $user ]; then
    user="postgres"
fi

if [ -z $db ]; then
    db="postgres"
fi

echo "[LOG]: STEAMDB_VERSION is $STEAMDB_VERSION"
echo "[LOG]: Using version $version"

for script in $( find /migrations/$version/ -name "*.sql" -type f | sort); do
    echo "[LOG]: Running migration script $script"
    psql -U $user -d $db -f $script
done

psql -U $user -d $db -c "CREATE ROLE reader"
psql -U $user -d $db -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader"

psql -U $user -d $db -c "CREATE ROLE writer"
psql -U $user -d $db -c "GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO writer"

psql -U $user -d $db -c "CREATE USER analytic LOGIN"
psql -U $user -d $db -c "GRANT SELECT ON TABLE users TO analytic"

psql -U $user -d $db -c "CREATE ROLE super NOLOGIN"
psql -U $user -d $db -c "GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO super"

OLDIFS="$IFS"
export IFS=","

for pguser in $USERS; do
    psql -U $user -d $db -c "CREATE USER $pguser"
    psql -U $user -d $db -c "GRANT reader TO $pguser"
done

export IFS="$OLDIFS"

