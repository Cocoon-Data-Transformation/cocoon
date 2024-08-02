-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 01:30:36.918807+00:00
WITH 
"person_casted" AS (
    -- Column Type Casting: 
    -- birth_datetime: from VARCHAR to TIMESTAMP
    -- person_source_value: from INT to VARCHAR
    SELECT
        "person_id",
        "year_of_birth",
        "month_of_birth",
        "day_of_birth",
        "location_id",
        "provider_id",
        "care_site_id",
        "gender_source_value",
        "race_source_value",
        "ethnicity_source_value",
        CAST("birth_datetime" AS TIMESTAMP) 
        AS "birth_datetime",
        CAST("person_source_value" AS VARCHAR) 
        AS "person_source_value"
    FROM "memory"."main"."person"
)

-- COCOON BLOCK END
SELECT *
FROM "person_casted"