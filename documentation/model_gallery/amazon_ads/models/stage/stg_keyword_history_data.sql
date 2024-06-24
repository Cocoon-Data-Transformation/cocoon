-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"keyword_history_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
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
    FROM "keyword_history_data"
),

"keyword_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> keyword_id
    -- last_updated_date -> last_updated_timestamp
    -- bid -> keyword_bid
    -- creation_date -> creation_timestamp
    -- match_type -> keyword_match_type
    -- serving_status -> keyword_serving_status
    -- state -> keyword_state
    SELECT 
        id AS keyword_id,
        last_updated_date AS last_updated_timestamp,
        ad_group_id,
        bid AS keyword_bid,
        campaign_id,
        creation_date AS creation_timestamp,
        keyword_text,
        match_type AS keyword_match_type,
        native_language_keyword,
        serving_status AS keyword_serving_status,
        state AS keyword_state,
        native_language_locale
    FROM keyword_history_data_projected
),

"keyword_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_updated_timestamp: from VARCHAR to TIMESTAMP
    -- native_language_keyword: from DECIMAL to VARCHAR
    -- native_language_locale: from DECIMAL to VARCHAR
    SELECT
        "keyword_id",
        "ad_group_id",
        "keyword_bid",
        "campaign_id",
        "keyword_text",
        "keyword_match_type",
        "keyword_serving_status",
        "keyword_state",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("last_updated_timestamp" AS TIMESTAMP) AS "last_updated_timestamp",
        CAST("native_language_keyword" AS VARCHAR) AS "native_language_keyword",
        CAST("native_language_locale" AS VARCHAR) AS "native_language_locale"
    FROM "keyword_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "keyword_history_data_projected_renamed_casted"