CREATE TABLE IF NOT EXISTS user_inventories (
    user_id BIGINT REFERENCES users(id),
    item_id BIGINT,
    game_id BIGINT,
    FOREIGN KEY (item_id, game_id) REFERENCES items(id, game_id)
);

INSERT INTO user_inventories (user_id, item_id, game_id)
SELECT
    FLOOR(RANDOM() * (1000000 - 1 + 1) + 1),
    it.id,
    it.game_id
FROM (
    SELECT id, game_id
    FROM items
    ORDER BY RANDOM()
    LIMIT FLOOR(RANDOM() * (1000000 - 500000 + 1) + 500000)
) it;
