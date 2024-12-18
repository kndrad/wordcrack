-- name: CreatePhrasesBatch :one
WITH batch AS (
    INSERT INTO phrase_batches (name)
    VALUES ($1)
    RETURNING id
)

INSERT INTO phrases (value, batch_id)
SELECT
    phrase_value,
    (SELECT id FROM batch)
FROM UNNEST($2::text []) AS phrase_value
RETURNING id, value, batch_id;
