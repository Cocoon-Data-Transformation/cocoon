-- Slowly Changing Dimension: Dimension keys are "keyword_id"
-- Effective date columns are "last_updated_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "keyword_id",
    "ad_group_id",
    "keyword_bid",
    "campaign_id",
    "keyword_text",
    "keyword_match_type",
    "keyword_serving_status",
    "keyword_state",
    "creation_timestamp",
    "native_language_keyword",
    "native_language_locale"
FROM (
     SELECT 
            "keyword_id",
            "ad_group_id",
            "keyword_bid",
            "campaign_id",
            "keyword_text",
            "keyword_match_type",
            "keyword_serving_status",
            "keyword_state",
            "creation_timestamp",
            "native_language_keyword",
            "native_language_locale",
            ROW_NUMBER() OVER (
                PARTITION BY "keyword_id" 
                ORDER BY "last_updated_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_keyword_history_data"
) ranked
WHERE "cocoon_rn" = 1