CREATE INDEX IF NOT EXISTS user_inventories_index
ON user_inventories(user_id, item_id, game_id);
