CREATE TABLE IF NOT EXISTS genres (
    id SERIAL PRIMARY KEY,
    name TEXT
);

INSERT INTO genres (name)
SELECT MD5(RANDOM()::TEXT) FROM GENERATE_SERIES(1, 1000);