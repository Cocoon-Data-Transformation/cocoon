-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 15:56:52.569745+00:00
WITH 
"facebook_ads_campaign_history_data_projected" AS (
    -- Projection: Selecting 11 out of 12 columns
    -- Columns projected out: ['id', 'account_id', 'name', 'created_time', 'start_time', 'stop_time', 'status', 'daily_budget', 'lifetime_budget', 'budget_remaining', '_fivetran_synced', 'updated_time']
    SELECT 
        "id",
        "account_id",
        "name",
        "created_time",
        "start_time",
        "stop_time",
        "status",
        "daily_budget",
        "lifetime_budget",
        "budget_remaining",
        "updated_time"
    FROM "memory"."main"."facebook_ads_campaign_history_data"
),

"facebook_ads_campaign_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> campaign_id
    -- name -> campaign_name
    -- created_time -> creation_timestamp
    -- start_time -> start_timestamp
    -- stop_time -> end_timestamp
    -- status -> campaign_status
    -- daily_budget -> daily_budget_cents
    -- lifetime_budget -> lifetime_budget_cents
    -- budget_remaining -> remaining_budget_cents
    -- updated_time -> last_update_timestamp
    SELECT 
        "id" AS "campaign_id",
        "account_id",
        "name" AS "campaign_name",
        "created_time" AS "creation_timestamp",
        "start_time" AS "start_timestamp",
        "stop_time" AS "end_timestamp",
        "status" AS "campaign_status",
        "daily_budget" AS "daily_budget_cents",
        "lifetime_budget" AS "lifetime_budget_cents",
        "budget_remaining" AS "remaining_budget_cents",
        "updated_time" AS "last_update_timestamp"
    FROM "facebook_ads_campaign_history_data_projected"
),

"facebook_ads_campaign_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- end_timestamp: from VARCHAR to TIMESTAMP
    -- last_update_timestamp: from VARCHAR to TIMESTAMP
    -- start_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "campaign_name",
        "campaign_status",
        "daily_budget_cents",
        "lifetime_budget_cents",
        "remaining_budget_cents",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("campaign_id" AS VARCHAR) 
        AS "campaign_id",
        CAST("creation_timestamp" AS TIMESTAMP) 
        AS "creation_timestamp",
        CAST("end_timestamp" AS TIMESTAMP) 
        AS "end_timestamp",
        CAST("last_update_timestamp" AS TIMESTAMP) 
        AS "last_update_timestamp",
        CAST("start_timestamp" AS TIMESTAMP) 
        AS "start_timestamp"
    FROM "facebook_ads_campaign_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "facebook_ads_campaign_history_data_projected_renamed_casted"