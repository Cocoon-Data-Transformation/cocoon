-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"campaign_history_data_projected" AS (
    -- Projection: Selecting 15 out of 16 columns
    -- Columns projected out: ['_fivetran_synced']
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
    FROM "campaign_history_data"
),

"campaign_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> campaign_id
    -- last_updated_date -> last_updated_datetime
    -- creation_date -> creation_datetime
    -- budget -> daily_budget
    -- name -> campaign_name
    -- state -> campaign_state
    SELECT 
        id AS campaign_id,
        last_updated_date AS last_updated_datetime,
        bidding_strategy,
        creation_date AS creation_datetime,
        budget AS daily_budget,
        end_date,
        name AS campaign_name,
        portfolio_id,
        profile_id,
        serving_status,
        start_date,
        state AS campaign_state,
        targeting_type,
        budget_type,
        effective_budget
    FROM campaign_history_data_projected
),

"campaign_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_datetime: from VARCHAR to TIMESTAMP
    -- daily_budget: from INT to DECIMAL
    -- effective_budget: from DECIMAL to VARCHAR
    -- end_date: from DECIMAL to DATE
    -- last_updated_datetime: from VARCHAR to TIMESTAMP
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
        CAST("creation_datetime" AS TIMESTAMP) AS "creation_datetime",
        CAST("daily_budget" AS DECIMAL) AS "daily_budget",
        CAST("effective_budget" AS VARCHAR) AS "effective_budget",
        CAST("end_date" AS DATE) AS "end_date",
        CAST("last_updated_datetime" AS TIMESTAMP) AS "last_updated_datetime",
        CAST("start_date" AS DATE) AS "start_date"
    FROM "campaign_history_data_projected_renamed"
),

"campaign_history_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- end_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
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
        "last_updated_datetime",
        "start_date"
    FROM "campaign_history_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "campaign_history_data_projected_renamed_casted_missing_handled"