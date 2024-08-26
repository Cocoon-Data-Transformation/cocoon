-- Slowly Changing Dimension: Dimension keys are "ad_set_id"
-- Version columns are last_updated, start_date, end_date
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "ad_set_name",
    "bid_strategy",
    "daily_budget_cents",
    "remaining_budget_cents",
    "status",
    "account_id",
    "ad_set_id",
    "campaign_id"
FROM "stg_facebook_ads_ad_set_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "ad_set_id"
    ORDER BY
        last_updated DESC,
        end_date IS NULL DESC,
        start_date DESC
) = 1