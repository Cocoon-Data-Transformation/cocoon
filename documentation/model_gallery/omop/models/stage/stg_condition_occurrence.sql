-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 00:40:17.491145+00:00
WITH 
"condition_occurrence_casted" AS (
    -- Column Type Casting: 
    -- condition_end_date: from VARCHAR to DATE
    -- condition_end_datetime: from VARCHAR to TIMESTAMP
    -- condition_start_date: from VARCHAR to DATE
    -- condition_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "condition_occurrence_id",
        "person_id",
        "stop_reason",
        "provider_id",
        "visit_occurrence_id",
        "visit_detail_id",
        "condition_source_value",
        "condition_status_source_value",
        CAST("condition_end_date" AS DATE) 
        AS "condition_end_date",
        CAST("condition_end_datetime" AS TIMESTAMP) 
        AS "condition_end_datetime",
        CAST("condition_start_date" AS DATE) 
        AS "condition_start_date",
        CAST("condition_start_datetime" AS TIMESTAMP) 
        AS "condition_start_datetime"
    FROM "memory"."main"."condition_occurrence"
)

-- COCOON BLOCK END
SELECT *
FROM "condition_occurrence_casted"