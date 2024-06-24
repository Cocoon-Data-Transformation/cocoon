-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"facebook_ads_ad_set_history_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ad_set_id
    -- name -> encrypted_ad_set_name
    -- updated_time -> last_updated_datetime
    -- start_at -> start_datetime
    -- end_at -> end_datetime
    -- daily_budget -> daily_budget_cents
    -- budget_remaining -> remaining_budget_cents
    -- status -> ad_set_status
    SELECT 
        id AS ad_set_id,
        account_id,
        campaign_id,
        name AS encrypted_ad_set_name,
        updated_time AS last_updated_datetime,
        start_at AS start_datetime,
        end_at AS end_datetime,
        bid_strategy,
        daily_budget AS daily_budget_cents,
        budget_remaining AS remaining_budget_cents,
        status AS ad_set_status
    FROM facebook_ads_ad_set_history_data
),

"facebook_ads_ad_set_history_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- ad_set_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- end_datetime: from VARCHAR to TIMESTAMP
    -- last_updated_datetime: from VARCHAR to TIMESTAMP
    -- start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "encrypted_ad_set_name",
        "bid_strategy",
        "daily_budget_cents",
        "remaining_budget_cents",
        "ad_set_status",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("ad_set_id" AS VARCHAR) AS "ad_set_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("end_datetime" AS TIMESTAMP) AS "end_datetime",
        CAST("last_updated_datetime" AS TIMESTAMP) AS "last_updated_datetime",
        CAST("start_datetime" AS TIMESTAMP) AS "start_datetime"
    FROM "facebook_ads_ad_set_history_data_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "facebook_ads_ad_set_history_data_renamed_casted"