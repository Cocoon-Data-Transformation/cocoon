-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 00:43:29.404892+00:00
WITH 
"death_casted" AS (
    -- Column Type Casting: 
    -- death_date: from VARCHAR to DATE
    -- death_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "person_id",
        "cause_source_value",
        CAST("death_date" AS DATE) 
        AS "death_date",
        CAST("death_datetime" AS TIMESTAMP) 
        AS "death_datetime"
    FROM "memory"."main"."death"
)

-- COCOON BLOCK END
SELECT *
FROM "death_casted"