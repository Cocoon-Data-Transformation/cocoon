-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 01:05:28.730475+00:00
WITH 
"payer_plan_period_casted" AS (
    -- Column Type Casting: 
    -- payer_plan_period_end_date: from VARCHAR to DATE
    -- payer_plan_period_id: from INT to VARCHAR
    -- payer_plan_period_start_date: from VARCHAR to DATE
    SELECT
        "person_id",
        "stop_reason",
        "payer_source_value",
        "plan_source_value",
        "sponsor_source_value",
        "family_plan_source_value",
        CAST("payer_plan_period_end_date" AS DATE) 
        AS "payer_plan_period_end_date",
        CAST("payer_plan_period_id" AS VARCHAR) 
        AS "payer_plan_period_id",
        CAST("payer_plan_period_start_date" AS DATE) 
        AS "payer_plan_period_start_date"
    FROM "memory"."main"."payer_plan_period"
)

-- COCOON BLOCK END
SELECT *
FROM "payer_plan_period_casted"