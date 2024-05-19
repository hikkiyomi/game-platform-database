CREATE TABLE IF NOT EXISTS game_products (
    id BIGSERIAL PRIMARY KEY,
    game_id BIGINT REFERENCES games(id),
    cost FLOAT NOT NULL,
    currency TEXT NOT NULL,
    tags TEXT NOT NULL,
    description TEXT NOT NULL,
    genre_id INT REFERENCES genres(id),
    publisher TEXT NOT NULL,
    release_date DATE NOT NULL,
    requirements TEXT,
    discount INT
);

INSERT INTO game_products
    (game_id, cost, currency, tags, description, genre_id, publisher, release_date, requirements, discount)
SELECT
    FLOOR(RANDOM() * (100000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (1000 - 1 + 1) + 1),
    MD5(RANDOM()::TEXT),
    MD5(RANDOM()::TEXT),
    MD5(RANDOM()::TEXT),
    FLOOR(RANDOM() * (1000 - 1 + 1) + 1),
    MD5(RANDOM()::TEXT),
    TIMESTAMP '2004-01-01 00:00:00' + RANDOM() * (TIMESTAMP '2024-01-01 00:00:00' - TIMESTAMP '2004-01-01 00:00:00'),
    MD5(RANDOM()::TEXT),
    FLOOR(RANDOM() * (100 - 1 + 1) + 1)
FROM GENERATE_SERIES(1, 100000);