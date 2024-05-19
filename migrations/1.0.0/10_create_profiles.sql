CREATE TABLE IF NOT EXISTS profiles (
    id BIGSERIAL PRIMARY KEY,
    nickname TEXT NOT NULL,
    link TEXT NOT NULL,
    country_id INT REFERENCES countries(id),
    region_id INT REFERENCES regions(id),
    city_id INT REFERENCES cities(id),
    bio TEXT,
    avatar_uri TEXT
);

INSERT INTO profiles
    (nickname, link, country_id, region_id, city_id, bio, avatar_uri)
SELECT
    MD5(RANDOM()::TEXT),
    MD5(RANDOM()::TEXT),
    FLOOR(RANDOM() * (300 - 1 + 1) + 1),
    FLOOR(RANDOM() * (1000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (1000000 - 1 + 1) + 1),
    MD5(RANDOM()::TEXT),
    MD5(RANDOM()::TEXT)
FROM GENERATE_SERIES(1, 1000000);