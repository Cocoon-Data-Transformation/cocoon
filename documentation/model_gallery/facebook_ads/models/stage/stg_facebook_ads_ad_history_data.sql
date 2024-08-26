-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 15:53:35.459415+00:00
WITH 
"facebook_ads_ad_history_data_projected" AS (
    -- Projection: Selecting 7 out of 8 columns
    -- Columns projected out: ['id', 'account_id', 'ad_set_id', 'campaign_id', 'creative_id', 'name', '_fivetran_synced', 'updated_time']
    SELECT 
        "id",
        "account_id",
        "ad_set_id",
        "campaign_id",
        "creative_id",
        "name",
        "updated_time"
    FROM "memory"."main"."facebook_ads_ad_history_data"
),

"facebook_ads_ad_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ad_id
    -- name -> ad_name
    -- updated_time -> last_updated
    SELECT 
        "id" AS "ad_id",
        "account_id",
        "ad_set_id",
        "campaign_id",
        "creative_id",
        "name" AS "ad_name",
        "updated_time" AS "last_updated"
    FROM "facebook_ads_ad_history_data_projected"
),

"facebook_ads_ad_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- ad_id: from INT to VARCHAR
    -- ad_set_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- creative_id: from INT to VARCHAR
    -- last_updated: from VARCHAR to TIMESTAMP
    SELECT
        "ad_name",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("ad_id" AS VARCHAR) 
        AS "ad_id",
        CAST("ad_set_id" AS VARCHAR) 
        AS "ad_set_id",
        CAST("campaign_id" AS VARCHAR) 
        AS "campaign_id",
        CAST("creative_id" AS VARCHAR) 
        AS "creative_id",
        CAST("last_updated" AS TIMESTAMP) 
        AS "last_updated"
    FROM "facebook_ads_ad_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "facebook_ads_ad_history_data_projected_renamed_casted"