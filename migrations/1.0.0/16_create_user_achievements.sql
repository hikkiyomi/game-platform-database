CREATE TABLE IF NOT EXISTS user_achievements (
    user_id BIGINT REFERENCES users(id),
    achievement_id BIGINT,
    game_id BIGINT,
    FOREIGN KEY (achievement_id, game_id) REFERENCES achievements(id, game_id)
);

INSERT INTO user_achievements (user_id, achievement_id, game_id)
SELECT
    FLOOR(RANDOM() * (1000000 - 1 + 1) + 1),
    it.id,
    it.game_id
FROM (
    SELECT id, game_id
    FROM achievements
    ORDER BY RANDOM()
    LIMIT FLOOR(RANDOM() * (100000 - 1000 + 1) + 1000)
) it;