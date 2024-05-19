CREATE TABLE IF NOT EXISTS lots (
    id BIGSERIAL PRIMARY KEY,
    author_id BIGINT REFERENCES users(id),
    item_id BIGINT,
    game_id BIGINT,
    cost DECIMAL,
    FOREIGN KEY (item_id, game_id) REFERENCES items(id, game_id)
);

INSERT INTO lots (author_id, item_id, game_id, cost)
SELECT
    generated_author_id,
    it.id,
    it.game_id,
    RANDOM() * 10000
FROM GENERATE_SERIES(1, 10000) AS generated_author_id
CROSS JOIN LATERAL (
    SELECT items.id, items.game_id
    FROM items
    WHERE generated_author_id IS NOT NULL
    ORDER BY RANDOM()
    LIMIT FLOOR(RANDOM() * (10 - 1 + 1) + 1)
) it;
