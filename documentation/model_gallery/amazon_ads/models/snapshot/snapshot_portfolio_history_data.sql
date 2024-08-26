-- Slowly Changing Dimension: Dimension keys are "portfolio_name", "profile_id"
-- Version columns are creation_date, last_updated_date
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "entry_id",
    "currency_code",
    "budget_policy",
    "is_within_budget",
    "portfolio_name",
    "profile_id",
    "operational_status",
    "portfolio_state",
    "budget_amount",
    "budget_end_date",
    "budget_start_date"
FROM "stg_portfolio_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "portfolio_name", "profile_id"
    ORDER BY
        last_updated_date DESC,
        creation_date DESC
) = 1