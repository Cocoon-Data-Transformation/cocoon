-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:31:44.842442+00:00
WITH 
"campaign_history_data_projected" AS (
    -- Projection: Selecting 15 out of 16 columns
    -- Columns projected out: ['id', 'last_updated_date', '_fivetran_synced', 'bidding_strategy', 'creation_date', 'budget', 'end_date', 'name', 'portfolio_id', 'profile_id', 'serving_status', 'start_date', 'state', 'targeting_type', 'budget_type', 'effective_budget']
    SELECT 
        "id",
        "last_updated_date",
        "bidding_strategy",
        "creation_date",
        "budget",
        "end_date",
        "name",
        "portfolio_id",
        "profile_id",
        "serving_status",
        "start_date",
        "state",
        "targeting_type",
        "budget_type",
        "effective_budget"
    FROM "memory"."main"."campaign_history_data"
),

"campaign_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> campaign_id
    -- budget -> budget_amount
    -- name -> campaign_name
    -- state -> campaign_state
    SELECT 
        "id" AS "campaign_id",
        "last_updated_date",
        "bidding_strategy",
        "creation_date",
        "budget" AS "budget_amount",
        "end_date",
        "name" AS "campaign_name",
        "portfolio_id",
        "profile_id",
        "serving_status",
        "start_date",
        "state" AS "campaign_state",
        "targeting_type",
        "budget_type",
        "effective_budget"
    FROM "campaign_history_data_projected"
),

"campaign_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- budget_amount: from INT to DECIMAL
    -- creation_date: from VARCHAR to TIMESTAMP
    -- effective_budget: from DECIMAL to VARCHAR
    -- end_date: from DECIMAL to DATE
    -- last_updated_date: from VARCHAR to TIMESTAMP
    -- start_date: from VARCHAR to DATE
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
        CAST("budget_amount" AS DECIMAL) 
        AS "budget_amount",
        CAST("creation_date" AS TIMESTAMP) 
        AS "creation_date",
        CAST("effective_budget" AS VARCHAR) 
        AS "effective_budget",
        CAST("end_date" AS DATE) 
        AS "end_date",
        CAST("last_updated_date" AS TIMESTAMP) 
        AS "last_updated_date",
        CAST("start_date" AS DATE) 
        AS "start_date"
    FROM "campaign_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "campaign_history_data_projected_renamed_casted"