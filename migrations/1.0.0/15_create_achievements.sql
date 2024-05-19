CREATE TABLE IF NOT EXISTS achievements (
    id BIGSERIAL,
    game_id BIGINT REFERENCES games(id),
    picture_uri TEXT,
    description TEXT,
    acquired_count BIGINT,
    PRIMARY KEY (id, game_id)
);

INSERT INTO achievements (game_id, picture_uri, description, acquired_count)
SELECT
    FLOOR(RANDOM() * (100000 - 1 + 1) + 1),
    MD5(RANDOM()::TEXT),
    MD5(RANDOM()::TEXT),
    FLOOR(RANDOM() * (10000 - 1 + 1) + 1)
FROM GENERATE_SERIES(1, 1000000);