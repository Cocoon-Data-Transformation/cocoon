-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"payer_plan_period_renamed" AS (
    -- Rename: Renaming columns
    -- payer_plan_period_id -> coverage_period_id
    -- payer_plan_period_start_date -> coverage_start_date
    -- payer_plan_period_end_date -> coverage_end_date
    -- payer_source_value -> payer_id
    -- plan_source_value -> plan_id
    -- sponsor_source_value -> sponsor_id
    -- family_plan_source_value -> family_plan_id
    SELECT 
        "payer_plan_period_id" AS "coverage_period_id",
        "person_id",
        "payer_plan_period_start_date" AS "coverage_start_date",
        "payer_plan_period_end_date" AS "coverage_end_date",
        "stop_reason",
        "payer_source_value" AS "payer_id",
        "plan_source_value" AS "plan_id",
        "sponsor_source_value" AS "sponsor_id",
        "family_plan_source_value" AS "family_plan_id"
    FROM "payer_plan_period"
),

"payer_plan_period_renamed_casted" AS (
    -- Column Type Casting: 
    -- coverage_end_date: from VARCHAR to DATE
    -- coverage_start_date: from VARCHAR to DATE
    SELECT
        "coverage_period_id",
        "person_id",
        "stop_reason",
        "payer_id",
        "plan_id",
        "sponsor_id",
        "family_plan_id",
        CAST("coverage_end_date" AS DATE) AS "coverage_end_date",
        CAST("coverage_start_date" AS DATE) AS "coverage_start_date"
    FROM "payer_plan_period_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "payer_plan_period_renamed_casted"