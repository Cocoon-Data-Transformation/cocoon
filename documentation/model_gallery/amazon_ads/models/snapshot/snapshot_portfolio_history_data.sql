-- Slowly Changing Dimension: Dimension keys are "portfolio_id"
-- Effective date columns are "last_updated_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "portfolio_id",
    "currency_code",
    "budget_policy_type",
    "is_within_budget",
    "portfolio_name",
    "profile_id",
    "portfolio_serving_status",
    "portfolio_state",
    "budget_amount",
    "budget_end_date",
    "budget_start_date",
    "creation_timestamp"
FROM (
     SELECT 
            "portfolio_id",
            "currency_code",
            "budget_policy_type",
            "is_within_budget",
            "portfolio_name",
            "profile_id",
            "portfolio_serving_status",
            "portfolio_state",
            "budget_amount",
            "budget_end_date",
            "budget_start_date",
            "creation_timestamp",
            ROW_NUMBER() OVER (
                PARTITION BY "portfolio_id" 
                ORDER BY "last_updated_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_portfolio_history_data"
) ranked
WHERE "cocoon_rn" = 1