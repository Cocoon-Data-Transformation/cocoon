-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 00:58:49.253537+00:00
WITH 
"observation_casted" AS (
    -- Column Type Casting: 
    -- observation_date: from VARCHAR to DATE
    -- observation_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "observation_id",
        "person_id",
        "value_as_number",
        "value_as_string",
        "provider_id",
        "visit_occurrence_id",
        "observation_source_value",
        "unit_source_value",
        "qualifier_source_value",
        CAST("observation_date" AS DATE) 
        AS "observation_date",
        CAST("observation_datetime" AS TIMESTAMP) 
        AS "observation_datetime"
    FROM "memory"."main"."observation"
)

-- COCOON BLOCK END
SELECT *
FROM "observation_casted"