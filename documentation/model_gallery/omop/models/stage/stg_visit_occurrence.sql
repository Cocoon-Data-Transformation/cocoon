-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 01:33:41.653626+00:00
WITH 
"visit_occurrence_casted" AS (
    -- Column Type Casting: 
    -- visit_end_date: from VARCHAR to DATE
    -- visit_end_datetime: from VARCHAR to TIMESTAMP
    -- visit_start_date: from VARCHAR to DATE
    -- visit_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "visit_occurrence_id",
        "person_id",
        "provider_id",
        "care_site_id",
        "visit_source_value",
        "admitting_source_value",
        "discharge_to_source_value",
        "preceding_visit_occurrence_id",
        CAST("visit_end_date" AS DATE) 
        AS "visit_end_date",
        CAST("visit_end_datetime" AS TIMESTAMP) 
        AS "visit_end_datetime",
        CAST("visit_start_date" AS DATE) 
        AS "visit_start_date",
        CAST("visit_start_datetime" AS TIMESTAMP) 
        AS "visit_start_datetime"
    FROM "memory"."main"."visit_occurrence"
)

-- COCOON BLOCK END
SELECT *
FROM "visit_occurrence_casted"