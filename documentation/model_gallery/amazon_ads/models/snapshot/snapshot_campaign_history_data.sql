-- Slowly Changing Dimension: Dimension keys are "campaign_id"
-- Effective date columns are "last_updated_datetime"
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
    "creation_datetime",
    "daily_budget",
    "effective_budget",
    "start_date"
FROM (
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
            "creation_datetime",
            "daily_budget",
            "effective_budget",
            "start_date",
            ROW_NUMBER() OVER (
                PARTITION BY "campaign_id" 
                ORDER BY "last_updated_datetime" 
            DESC) AS "cocoon_rn"
    FROM "stg_campaign_history_data"
) ranked
WHERE "cocoon_rn" = 1