CREATE TABLE IF NOT EXISTS items (
    id BIGSERIAL,
    game_id BIGINT REFERENCES games(id),
    PRIMARY KEY (id, game_id)
);

INSERT INTO items (id, game_id)
SELECT
    generated_id,
    generated_game_id
FROM GENERATE_SERIES(1, CAST(FLOOR(RANDOM() * (1000 - 100 + 1) + 100) AS INT)) AS generated_id
CROSS JOIN LATERAL GENERATE_SERIES(1, CAST(FLOOR(RANDOM() * (1000 - 500 + 1) + 500) AS INT)) AS generated_game_id
