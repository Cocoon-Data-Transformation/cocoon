-- Slowly Changing Dimension: Dimension keys are "campaign_id"
-- Version columns are last_updated_date, creation_date
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "campaign_id",
    "bidding_strategy",
    "campaign_name",
    "portfolio_id",
    "profile_id",
    "serving_status",
    "campaign_state",
    "targeting_type",
    "budget_type",
    "budget_amount",
    "effective_budget",
    "end_date",
    "start_date"
FROM "stg_campaign_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "campaign_id"
    ORDER BY
        last_updated_date DESC,
        creation_date DESC
) = 1