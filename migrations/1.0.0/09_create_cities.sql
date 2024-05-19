CREATE TABLE IF NOT EXISTS cities (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

INSERT INTO cities (name)
SELECT MD5(RANDOM()::TEXT) FROM GENERATE_SERIES(1, 1000000);