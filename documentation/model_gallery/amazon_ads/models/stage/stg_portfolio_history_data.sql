-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:35:21.494921+00:00
WITH 
"portfolio_history_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['id', 'last_updated_date', '_fivetran_synced', 'budget_amount', 'budget_currency_code', 'budget_end_date', 'budget_policy', 'budget_start_date', 'creation_date', 'in_budget', 'name', 'profile_id', 'serving_status', 'state']
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
    FROM "memory"."main"."portfolio_history_data"
),

"portfolio_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> entry_id
    -- budget_currency_code -> currency_code
    -- in_budget -> is_within_budget
    -- name -> portfolio_name
    -- serving_status -> operational_status
    -- state -> portfolio_state
    SELECT 
        "id" AS "entry_id",
        "last_updated_date",
        "budget_amount",
        "budget_currency_code" AS "currency_code",
        "budget_end_date",
        "budget_policy",
        "budget_start_date",
        "creation_date",
        "in_budget" AS "is_within_budget",
        "name" AS "portfolio_name",
        "profile_id",
        "serving_status" AS "operational_status",
        "state" AS "portfolio_state"
    FROM "portfolio_history_data_projected"
),

"portfolio_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- budget_amount: from INT to DECIMAL
    -- budget_end_date: from VARCHAR to DATE
    -- budget_start_date: from VARCHAR to DATE
    -- creation_date: from VARCHAR to TIMESTAMP
    -- last_updated_date: from VARCHAR to TIMESTAMP
    SELECT
        "entry_id",
        "currency_code",
        "budget_policy",
        "is_within_budget",
        "portfolio_name",
        "profile_id",
        "operational_status",
        "portfolio_state",
        CAST("budget_amount" AS DECIMAL) 
        AS "budget_amount",
        CAST("budget_end_date" AS DATE) 
        AS "budget_end_date",
        CAST("budget_start_date" AS DATE) 
        AS "budget_start_date",
        CAST("creation_date" AS TIMESTAMP) 
        AS "creation_date",
        CAST("last_updated_date" AS TIMESTAMP) 
        AS "last_updated_date"
    FROM "portfolio_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "portfolio_history_data_projected_renamed_casted"