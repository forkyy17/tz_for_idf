-- Materialized View: парсит массив people из raw_json и пишет в default.people

CREATE MATERIALIZED VIEW IF NOT EXISTS default.people_mv
TO default.people AS
SELECT
    JSONExtractString(person_raw, 'craft') AS craft,
    JSONExtractString(person_raw, 'name')  AS name,
    _inserted_at
FROM default.raw_data
ARRAY JOIN JSONExtractArrayRaw(raw_json, 'people') AS person_raw;
