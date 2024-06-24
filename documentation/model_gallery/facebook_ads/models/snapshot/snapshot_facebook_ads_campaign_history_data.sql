-- Slowly Changing Dimension: Dimension keys are "campaign_id"
-- Effective date columns are "last_update_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "encrypted_campaign_name",
    "campaign_status",
    "account_id",
    "campaign_id",
    "creation_timestamp",
    "daily_budget",
    "end_timestamp",
    "lifetime_budget",
    "remaining_budget",
    "start_timestamp"
FROM (
     SELECT 
            "encrypted_campaign_name",
            "campaign_status",
            "account_id",
            "campaign_id",
            "creation_timestamp",
            "daily_budget",
            "end_timestamp",
            "lifetime_budget",
            "remaining_budget",
            "start_timestamp",
            ROW_NUMBER() OVER (
                PARTITION BY "campaign_id" 
                ORDER BY "last_update_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_facebook_ads_campaign_history_data"
) ranked
WHERE "cocoon_rn" = 1