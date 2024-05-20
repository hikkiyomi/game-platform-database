-- This script is partitioning 'user_inventories' table by hash into 5 partitions.

DROP TABLE IF EXISTS user_inventories_1;
DROP TABLE IF EXISTS user_inventories_2;
DROP TABLE IF EXISTS user_inventories_3;
DROP TABLE IF EXISTS user_inventories_4;
DROP TABLE IF EXISTS user_inventories_5;
DROP INDEX IF EXISTS user_inventories_partitioned_index;
DROP TABLE IF EXISTS user_inventories_partitioned;

CREATE TABLE user_inventories_partitioned (
    user_id BIGINT,
    item_id BIGINT,
    game_id BIGINT
) PARTITION BY HASH(game_id);

CREATE TABLE user_inventories_1
PARTITION OF user_inventories_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 0);

CREATE TABLE user_inventories_2
PARTITION OF user_inventories_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 1);

CREATE TABLE user_inventories_3
PARTITION OF user_inventories_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 2);

CREATE TABLE user_inventories_4
PARTITION OF user_inventories_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 3);

CREATE TABLE user_inventories_5
PARTITION OF user_inventories_partitioned
FOR VALUES WITH (MODULUS 5, REMAINDER 4);

INSERT INTO user_inventories_partitioned
SELECT * FROM user_inventories;

CREATE INDEX user_inventories_partitioned_index
ON user_inventories_partitioned(user_id, item_id, game_id);
