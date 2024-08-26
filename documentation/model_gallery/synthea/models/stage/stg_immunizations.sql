-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:01:52.568671+00:00
WITH 
"immunizations_renamed" AS (
    -- Rename: Renaming columns
    -- DATE_ -> immunization_datetime
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> vaccine_code
    -- DESCRIPTION -> vaccine_description
    -- BASE_COST -> base_cost
    SELECT 
        "DATE_" AS "immunization_datetime",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "vaccine_code",
        "DESCRIPTION" AS "vaccine_description",
        "BASE_COST" AS "base_cost"
    FROM "memory"."main"."immunizations"
),

"immunizations_renamed_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- immunization_datetime: from VARCHAR to TIMESTAMP
    -- patient_id: from VARCHAR to UUID
    SELECT
        "vaccine_code",
        "vaccine_description",
        "base_cost",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("immunization_datetime" AS TIMESTAMP) 
        AS "immunization_datetime",
        CAST("patient_id" AS UUID) 
        AS "patient_id"
    FROM "immunizations_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "immunizations_renamed_casted"