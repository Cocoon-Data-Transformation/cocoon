-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:33:52.591635+00:00
WITH 
"keyword_history_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['id', 'last_updated_date', '_fivetran_synced', 'ad_group_id', 'bid', 'campaign_id', 'creation_date', 'keyword_text', 'match_type', 'native_language_keyword', 'serving_status', 'state', 'native_language_locale']
    SELECT 
        "id",
        "last_updated_date",
        "ad_group_id",
        "bid",
        "campaign_id",
        "creation_date",
        "keyword_text",
        "match_type",
        "native_language_keyword",
        "serving_status",
        "state",
        "native_language_locale"
    FROM "memory"."main"."keyword_history_data"
),

"keyword_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> keyword_id
    -- bid -> bid_amount
    -- state -> keyword_state
    SELECT 
        "id" AS "keyword_id",
        "last_updated_date",
        "ad_group_id",
        "bid" AS "bid_amount",
        "campaign_id",
        "creation_date",
        "keyword_text",
        "match_type",
        "native_language_keyword",
        "serving_status",
        "state" AS "keyword_state",
        "native_language_locale"
    FROM "keyword_history_data_projected"
),

"keyword_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to TIMESTAMP
    -- last_updated_date: from VARCHAR to TIMESTAMP
    -- native_language_keyword: from DECIMAL to VARCHAR
    -- native_language_locale: from DECIMAL to VARCHAR
    SELECT
        "keyword_id",
        "ad_group_id",
        "bid_amount",
        "campaign_id",
        "keyword_text",
        "match_type",
        "serving_status",
        "keyword_state",
        CAST("creation_date" AS TIMESTAMP) 
        AS "creation_date",
        CAST("last_updated_date" AS TIMESTAMP) 
        AS "last_updated_date",
        CAST("native_language_keyword" AS VARCHAR) 
        AS "native_language_keyword",
        CAST("native_language_locale" AS VARCHAR) 
        AS "native_language_locale"
    FROM "keyword_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "keyword_history_data_projected_renamed_casted"