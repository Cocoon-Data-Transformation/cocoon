-- Slowly Changing Dimension: Dimension keys are "keyword_id"
-- Version columns are creation_date, last_updated_date
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "keyword_id",
    "ad_group_id",
    "bid_amount",
    "campaign_id",
    "keyword_text",
    "match_type",
    "serving_status",
    "keyword_state",
    "native_language_keyword",
    "native_language_locale"
FROM "stg_keyword_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "keyword_id"
    ORDER BY
        last_updated_date DESC,
        creation_date DESC
) = 1