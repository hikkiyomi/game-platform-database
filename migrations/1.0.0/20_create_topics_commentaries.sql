CREATE TABLE IF NOT EXISTS topics_commentaries (
    topic_id BIGINT REFERENCES topics(id),
    commentary_id BIGINT REFERENCES commentaries(id),
    PRIMARY KEY (topic_id, commentary_id)
);

INSERT INTO topics_commentaries (topic_id, commentary_id)
SELECT
    id,
    FLOOR(RANDOM() * (1000000 - 1 + 1) + 1)
FROM GENERATE_SERIES(1, 100000) AS id;