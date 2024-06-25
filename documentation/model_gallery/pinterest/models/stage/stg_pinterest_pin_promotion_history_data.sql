-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_pin_promotion_history_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "ad_group_id",
        "created_time",
        "destination_url",
        "name",
        "pin_id",
        "status",
        "creative_type",
        "ad_account_id"
    FROM "pinterest_pin_promotion_history_data"
),

"pinterest_pin_promotion_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> promoted_pin_id
    -- created_time -> creation_timestamp
    -- destination_url -> landing_page_url
    -- name -> campaign_name
    -- status -> promotion_status
    SELECT 
        "id" AS "promoted_pin_id",
        "ad_group_id",
        "created_time" AS "creation_timestamp",
        "destination_url" AS "landing_page_url",
        "name" AS "campaign_name",
        "pin_id",
        "status" AS "promotion_status",
        "creative_type",
        "ad_account_id"
    FROM "pinterest_pin_promotion_history_data_projected"
),

"pinterest_pin_promotion_history_data_projected_renamed_dedup" AS (
    -- Deduplication: Removed 5 duplicated rows
    SELECT DISTINCT * FROM "pinterest_pin_promotion_history_data_projected_renamed"
),

"pinterest_pin_promotion_history_data_projected_renamed_dedup_casted" AS (
    -- Column Type Casting: 
    -- ad_account_id: from INT to VARCHAR
    -- ad_group_id: from INT to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- pin_id: from INT to VARCHAR
    -- promoted_pin_id: from INT to VARCHAR
    SELECT
        "landing_page_url",
        "campaign_name",
        "promotion_status",
        "creative_type",
        CAST("ad_account_id" AS VARCHAR) AS "ad_account_id",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        strptime("creation_timestamp", '%Y-%m-%d %H:%M:%S.%f %z') AS "creation_timestamp",
        CAST("pin_id" AS VARCHAR) AS "pin_id",
        CAST("promoted_pin_id" AS VARCHAR) AS "promoted_pin_id"
    FROM "pinterest_pin_promotion_history_data_projected_renamed_dedup"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_pin_promotion_history_data_projected_renamed_dedup_casted"