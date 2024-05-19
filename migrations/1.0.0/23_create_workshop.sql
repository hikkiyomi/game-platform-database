CREATE TABLE IF NOT EXISTS workshop (
    community_id BIGINT REFERENCES communities(id),
    workpiece_id BIGINT REFERENCES workpieces(id)
);

INSERT INTO workshop (community_id, workpiece_id)
SELECT
    FLOOR(RANDOM() * (100000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (100000 - 1 + 1) + 1)
FROM GENERATE_SERIES(1, 100000);