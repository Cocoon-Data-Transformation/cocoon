-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"portfolio_history_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "last_updated_date",
        "budget_amount",
        "budget_currency_code",
        "budget_end_date",
        "budget_policy",
        "budget_start_date",
        "creation_date",
        "in_budget",
        "name",
        "profile_id",
        "serving_status",
        "state"
    FROM "portfolio_history_data"
),

"portfolio_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> portfolio_id
    -- last_updated_date -> last_updated_timestamp
    -- budget_currency_code -> currency_code
    -- budget_policy -> budget_policy_type
    -- creation_date -> creation_timestamp
    -- in_budget -> is_within_budget
    -- name -> portfolio_name
    -- serving_status -> portfolio_serving_status
    -- state -> portfolio_state
    SELECT 
        id AS portfolio_id,
        last_updated_date AS last_updated_timestamp,
        budget_amount,
        budget_currency_code AS currency_code,
        budget_end_date,
        budget_policy AS budget_policy_type,
        budget_start_date,
        creation_date AS creation_timestamp,
        in_budget AS is_within_budget,
        name AS portfolio_name,
        profile_id,
        serving_status AS portfolio_serving_status,
        state AS portfolio_state
    FROM portfolio_history_data_projected
),

"portfolio_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- budget_amount: from INT to DECIMAL
    -- budget_end_date: from VARCHAR to DATE
    -- budget_start_date: from VARCHAR to DATE
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_updated_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "portfolio_id",
        "currency_code",
        "budget_policy_type",
        "is_within_budget",
        "portfolio_name",
        "profile_id",
        "portfolio_serving_status",
        "portfolio_state",
        CAST("budget_amount" AS DECIMAL) AS "budget_amount",
        CAST("budget_end_date" AS DATE) AS "budget_end_date",
        CAST("budget_start_date" AS DATE) AS "budget_start_date",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("last_updated_timestamp" AS TIMESTAMP) AS "last_updated_timestamp"
    FROM "portfolio_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "portfolio_history_data_projected_renamed_casted"