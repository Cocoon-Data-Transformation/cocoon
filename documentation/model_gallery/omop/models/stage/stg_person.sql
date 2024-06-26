-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"person_renamed" AS (
    -- Rename: Renaming columns
    -- year_of_birth -> birth_year
    -- month_of_birth -> birth_month
    -- day_of_birth -> birth_day
    -- person_source_value -> original_person_id
    -- gender_source_value -> gender
    -- race_source_value -> race
    -- ethnicity_source_value -> ethnicity
    SELECT 
        "person_id",
        "year_of_birth" AS "birth_year",
        "month_of_birth" AS "birth_month",
        "day_of_birth" AS "birth_day",
        "birth_datetime",
        "location_id",
        "provider_id",
        "care_site_id",
        "person_source_value" AS "original_person_id",
        "gender_source_value" AS "gender",
        "race_source_value" AS "race",
        "ethnicity_source_value" AS "ethnicity"
    FROM "person"
),

"person_renamed_casted" AS (
    -- Column Type Casting: 
    -- birth_datetime: from VARCHAR to TIMESTAMP
    -- original_person_id: from INT to VARCHAR
    SELECT
        "person_id",
        "birth_year",
        "birth_month",
        "birth_day",
        "location_id",
        "provider_id",
        "care_site_id",
        "gender",
        "race",
        "ethnicity",
        CAST("birth_datetime" AS TIMESTAMP) AS "birth_datetime",
        CAST("original_person_id" AS VARCHAR) AS "original_person_id"
    FROM "person_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "person_renamed_casted"