CREATE TABLE IF NOT EXISTS default.people
(
    craft String,
    name String,
    _inserted_at DateTime64(3) DEFAULT now64(3)
)
ENGINE = ReplacingMergeTree(_inserted_at)
ORDER BY (craft, name);
