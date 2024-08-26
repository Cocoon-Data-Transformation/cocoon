-- Slowly Changing Dimension: Dimension keys are "campaign_id"
-- Version columns are last_update_timestamp, remaining_budget_cents
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "campaign_name",
    "campaign_status",
    "daily_budget_cents",
    "lifetime_budget_cents",
    "account_id",
    "campaign_id",
    "creation_timestamp",
    "end_timestamp",
    "start_timestamp"
FROM "stg_facebook_ads_campaign_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "campaign_id"
    ORDER BY
        last_update_timestamp DESC,
        remaining_budget_cents DESC
) = 1