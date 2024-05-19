CREATE TABLE IF NOT EXISTS workpieces (
    id BIGSERIAL PRIMARY KEY,
    author_id BIGINT REFERENCES users(id)
);

INSERT INTO workpieces (author_id)
SELECT FLOOR(RANDOM() * (1000000 - 1 + 1) + 1) FROM GENERATE_SERIES(1, 100000);