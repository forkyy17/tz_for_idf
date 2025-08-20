CREATE TABLE IF NOT EXISTS default.raw_data
(
    raw_json String,
    _inserted_at DateTime64(3) DEFAULT now64(3)
)
ENGINE = MergeTree
ORDER BY _inserted_at;
