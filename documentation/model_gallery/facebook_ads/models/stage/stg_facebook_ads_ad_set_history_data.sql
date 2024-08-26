-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 15:54:57.322010+00:00
WITH 
"facebook_ads_ad_set_history_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ad_set_id
    -- name -> ad_set_name
    -- updated_time -> last_updated
    -- start_at -> start_date
    -- end_at -> end_date
    -- daily_budget -> daily_budget_cents
    -- budget_remaining -> remaining_budget_cents
    SELECT 
        "id" AS "ad_set_id",
        "account_id",
        "campaign_id",
        "name" AS "ad_set_name",
        "updated_time" AS "last_updated",
        "start_at" AS "start_date",
        "end_at" AS "end_date",
        "bid_strategy",
        "daily_budget" AS "daily_budget_cents",
        "budget_remaining" AS "remaining_budget_cents",
        "status"
    FROM "memory"."main"."facebook_ads_ad_set_history_data"
),

"facebook_ads_ad_set_history_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- ad_set_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- end_date: from VARCHAR to TIMESTAMP
    -- last_updated: from VARCHAR to TIMESTAMP
    -- start_date: from VARCHAR to TIMESTAMP
    SELECT
        "ad_set_name",
        "bid_strategy",
        "daily_budget_cents",
        "remaining_budget_cents",
        "status",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("ad_set_id" AS VARCHAR) 
        AS "ad_set_id",
        CAST("campaign_id" AS VARCHAR) 
        AS "campaign_id",
        CAST("end_date" AS TIMESTAMP) 
        AS "end_date",
        CAST("last_updated" AS TIMESTAMP) 
        AS "last_updated",
        CAST("start_date" AS TIMESTAMP) 
        AS "start_date"
    FROM "facebook_ads_ad_set_history_data_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "facebook_ads_ad_set_history_data_renamed_casted"