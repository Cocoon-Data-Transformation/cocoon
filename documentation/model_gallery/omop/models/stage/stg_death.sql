-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"death_renamed" AS (
    -- Rename: Renaming columns
    -- cause_source_value -> death_cause_code
    SELECT 
        "person_id",
        "death_date",
        "death_datetime",
        "cause_source_value" AS "death_cause_code"
    FROM "death"
),

"death_renamed_casted" AS (
    -- Column Type Casting: 
    -- death_date: from VARCHAR to DATE
    -- death_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "person_id",
        "death_cause_code",
        CAST("death_date" AS DATE) AS "death_date",
        CAST("death_datetime" AS TIMESTAMP) AS "death_datetime"
    FROM "death_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "death_renamed_casted"