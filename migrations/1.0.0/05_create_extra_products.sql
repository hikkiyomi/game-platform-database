CREATE TABLE IF NOT EXISTS extra_products (
    extra_id BIGINT REFERENCES extras(id),
    game_id BIGINT REFERENCES games(id),
    cost BIGINT,
    PRIMARY KEY (extra_id, game_id)
);

INSERT INTO extra_products (extra_id, game_id, cost)
SELECT
    FLOOR(RANDOM() * (10000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (100000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (1000 - 1 + 1) + 0)
FROM GENERATE_SERIES(1, 10000);