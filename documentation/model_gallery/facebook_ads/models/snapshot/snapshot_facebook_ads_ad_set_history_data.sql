-- Slowly Changing Dimension: Dimension keys are "ad_set_id"
-- Effective date columns are "last_updated_datetime"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "encrypted_ad_set_name",
    "bid_strategy",
    "daily_budget_cents",
    "remaining_budget_cents",
    "ad_set_status",
    "account_id",
    "ad_set_id",
    "campaign_id",
    "end_datetime",
    "start_datetime"
FROM (
     SELECT 
            "encrypted_ad_set_name",
            "bid_strategy",
            "daily_budget_cents",
            "remaining_budget_cents",
            "ad_set_status",
            "account_id",
            "ad_set_id",
            "campaign_id",
            "end_datetime",
            "start_datetime",
            ROW_NUMBER() OVER (
                PARTITION BY "ad_set_id" 
                ORDER BY "last_updated_datetime" 
            DESC) AS "cocoon_rn"
    FROM "stg_facebook_ads_ad_set_history_data"
) ranked
WHERE "cocoon_rn" = 1