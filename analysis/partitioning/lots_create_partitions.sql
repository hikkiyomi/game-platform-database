-- This script is partitioning 'lots' table by hash into 5 partitions.

DROP TABLE IF EXISTS lots_1;
DROP TABLE IF EXISTS lots_2;
DROP TABLE IF EXISTS lots_3;
DROP TABLE IF EXISTS lots_4;
DROP TABLE IF EXISTS lots_5;
DROP INDEX IF EXISTS lots_partitioned_index;
DROP TABLE IF EXISTS lots_partitioned;

CREATE TABLE lots_partitioned (
    id BIGSERIAL,
    author_id BIGINT,
    item_id BIGINT,
    game_id BIGINT,
    cost DECIMAL
) PARTITION BY HASH(game_id);

CREATE TABLE lots_1
PARTITION OF lots_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 0);

CREATE TABLE lots_2
PARTITION OF lots_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 1);

CREATE TABLE lots_3
PARTITION OF lots_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 2);

CREATE TABLE lots_4
PARTITION OF lots_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 3);

CREATE TABLE lots_5
PARTITION OF lots_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 4);

INSERT INTO lots_partitioned
SELECT * FROM lots;

CREATE INDEX lots_partitioned_index
ON lots_partitioned(author_id, item_id, game_id);
