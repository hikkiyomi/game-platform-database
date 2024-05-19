CREATE TABLE IF NOT EXISTS marketplace (
    community_id BIGINT REFERENCES communities(id),
    lot_id BIGINT REFERENCES lots(id),
    PRIMARY KEY (community_id, lot_id)
);

INSERT INTO marketplace (community_id, lot_id)
SELECT
    id,
    FLOOR(RANDOM() * (55159 - 1 + 1) + 1)
FROM GENERATE_SERIES(1, 40000) AS id;
