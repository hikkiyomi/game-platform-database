CREATE TABLE IF NOT EXISTS reviews (
    id BIGSERIAL PRIMARY KEY,
    comm_id BIGINT REFERENCES commentaries(id),
    game_product_id BIGINT REFERENCES game_products(id),
    mark BOOLEAN
);

INSERT INTO reviews (comm_id, game_product_id, mark)
SELECT
    FLOOR(RANDOM() * (1000000 - 1 + 1) + 1),
    FLOOR(RANDOM() * (100000 - 1 + 1) + 1),
    RANDOM() > 0.5
FROM GENERATE_SERIES(1, 100000);