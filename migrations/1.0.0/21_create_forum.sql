CREATE TABLE IF NOT EXISTS forum (
    community_id BIGINT REFERENCES communities(id),
    topic_id BIGINT REFERENCES topics(id),
    PRIMARY KEY (community_id, topic_id)
);

INSERT INTO forum (community_id, topic_id)
SELECT
    comm_id,
    top_id
FROM GENERATE_SERIES(1, CAST(FLOOR(RANDOM() * (1000 - 100 + 1) + 100) AS INT)) AS comm_id
CROSS JOIN LATERAL GENERATE_SERIES(1, CAST(FLOOR(RANDOM() * (10000 - 1000 + 1) + 1000) AS INT)) AS top_id
