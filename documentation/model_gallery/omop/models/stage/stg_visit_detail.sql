-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 01:21:48.782571+00:00
WITH 
"visit_detail_casted" AS (
    -- Column Type Casting: 
    -- admitting_source_value: from DECIMAL to VARCHAR
    -- discharge_to_source_value: from DECIMAL to VARCHAR
    -- visit_detail_end_date: from VARCHAR to DATE
    -- visit_detail_end_datetime: from VARCHAR to TIMESTAMP
    -- visit_detail_start_date: from VARCHAR to DATE
    -- visit_detail_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "visit_detail_id",
        "person_id",
        "provider_id",
        "care_site_id",
        "visit_detail_source_value",
        "visit_occurrence_id",
        CAST("admitting_source_value" AS VARCHAR) 
        AS "admitting_source_value",
        CAST("discharge_to_source_value" AS VARCHAR) 
        AS "discharge_to_source_value",
        CAST("visit_detail_end_date" AS DATE) 
        AS "visit_detail_end_date",
        CAST("visit_detail_end_datetime" AS TIMESTAMP) 
        AS "visit_detail_end_datetime",
        CAST("visit_detail_start_date" AS DATE) 
        AS "visit_detail_start_date",
        CAST("visit_detail_start_datetime" AS TIMESTAMP) 
        AS "visit_detail_start_datetime"
    FROM "memory"."main"."visit_detail"
)

-- COCOON BLOCK END
SELECT *
FROM "visit_detail_casted"