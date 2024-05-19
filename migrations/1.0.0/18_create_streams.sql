CREATE TABLE IF NOT EXISTS streams (
    id BIGSERIAL PRIMARY KEY,
    author_id BIGINT REFERENCES users(id),
    community_id BIGINT REFERENCES communities(id),
    url TEXT NOT NULL
);

INSERT INTO streams (author_id, community_id, url)
SELECT
    FLOOR(RANDOM() * (1000000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (100000 - 1 + 1) + 1),
    MD5(RANDOM()::TEXT)
FROM GENERATE_SERIES(1, 1000000);