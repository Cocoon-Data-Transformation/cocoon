-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 00:55:31.099701+00:00
WITH 
"measurement_casted" AS (
    -- Column Type Casting: 
    -- measurement_date: from VARCHAR to DATE
    -- measurement_datetime: from VARCHAR to TIMESTAMP
    -- value_source_value: from INT to VARCHAR
    SELECT
        "measurement_id",
        "person_id",
        "value_as_number",
        "provider_id",
        "visit_occurrence_id",
        "measurement_source_value",
        "unit_source_value",
        CAST("measurement_date" AS DATE) 
        AS "measurement_date",
        CAST("measurement_datetime" AS TIMESTAMP) 
        AS "measurement_datetime",
        CAST("value_source_value" AS VARCHAR) 
        AS "value_source_value"
    FROM "memory"."main"."measurement"
)

-- COCOON BLOCK END
SELECT *
FROM "measurement_casted"