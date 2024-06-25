-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_keyword_history_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_id",
        "ad_group_id",
        "advertiser_id",
        "archived",
        "bid",
        "campaign_id",
        "id",
        "match_type",
        "parent_type",
        "value_"
    FROM "pinterest_keyword_history_data"
),

"pinterest_keyword_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_id -> fivetran_sync_id
    -- archived -> is_archived
    -- bid -> bid_amount
    -- id -> keyword_id
    -- value_ -> keyword_text
    SELECT 
        "_fivetran_id" AS "fivetran_sync_id",
        "ad_group_id",
        "advertiser_id",
        "archived" AS "is_archived",
        "bid" AS "bid_amount",
        "campaign_id",
        "id" AS "keyword_id",
        "match_type",
        "parent_type",
        "value_" AS "keyword_text"
    FROM "pinterest_keyword_history_data_projected"
),

"pinterest_keyword_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- ad_group_id: from INT to VARCHAR
    -- advertiser_id: from DECIMAL to VARCHAR
    -- bid_amount: from DECIMAL to VARCHAR
    -- campaign_id: from DECIMAL to VARCHAR
    -- keyword_id: from INT to VARCHAR
    SELECT
        "fivetran_sync_id",
        "is_archived",
        "match_type",
        "parent_type",
        "keyword_text",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        CAST("bid_amount" AS VARCHAR) AS "bid_amount",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("keyword_id" AS VARCHAR) AS "keyword_id"
    FROM "pinterest_keyword_history_data_projected_renamed"
),

"pinterest_keyword_history_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- advertiser_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bid_amount has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- campaign_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "fivetran_sync_id",
        "is_archived",
        "match_type",
        "parent_type",
        "keyword_text",
        "ad_group_id",
        "keyword_id"
    FROM "pinterest_keyword_history_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_keyword_history_data_projected_renamed_casted_missing_handled"