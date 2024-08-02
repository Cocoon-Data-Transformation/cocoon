-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 01:19:10.198462+00:00
WITH 
"specimen_casted" AS (
    -- Column Type Casting: 
    -- specimen_date: from VARCHAR to DATE
    -- specimen_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "specimen_id",
        "person_id",
        "quantity",
        "specimen_source_value",
        "unit_source_value",
        "anatomic_site_source_value",
        "disease_status_source_value",
        CAST("specimen_date" AS DATE) 
        AS "specimen_date",
        CAST("specimen_datetime" AS TIMESTAMP) 
        AS "specimen_datetime"
    FROM "memory"."main"."specimen"
)

-- COCOON BLOCK END
SELECT *
FROM "specimen_casted"