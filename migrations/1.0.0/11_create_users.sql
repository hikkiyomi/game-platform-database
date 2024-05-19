CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    email TEXT,
    password TEXT NOT NULL,
    profile_id BIGINT REFERENCES profiles(id),
    balance FLOAT NOT NULL
);

INSERT INTO users (email, password, profile_id, balance)
SELECT
    MD5(RANDOM()::TEXT),
    MD5(RANDOM()::TEXT),
    FLOOR(RANDOM() * (1000000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (10000 - 1 + 1) + 1)
FROM GENERATE_SERIES(1, 1000000);