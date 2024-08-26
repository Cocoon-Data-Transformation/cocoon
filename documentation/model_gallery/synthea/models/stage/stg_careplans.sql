-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 00:47:43.534687+00:00
WITH 
"careplans_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> care_plan_id
    -- START -> start_date
    -- STOP -> end_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> treatment_code
    -- DESCRIPTION -> treatment_description
    -- REASONCODE -> diagnosis_code
    -- REASONDESCRIPTION -> diagnosis_description
    SELECT 
        "Id" AS "care_plan_id",
        "START" AS "start_date",
        "STOP" AS "end_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "treatment_code",
        "DESCRIPTION" AS "treatment_description",
        "REASONCODE" AS "diagnosis_code",
        "REASONDESCRIPTION" AS "diagnosis_description"
    FROM "memory"."main"."careplans"
),

"careplans_renamed_casted" AS (
    -- Column Type Casting: 
    -- care_plan_id: from VARCHAR to UUID
    -- encounter_id: from VARCHAR to UUID
    -- end_date: from VARCHAR to DATE
    -- patient_id: from VARCHAR to UUID
    -- start_date: from VARCHAR to DATE
    -- treatment_code: from INT to VARCHAR
    SELECT
        "treatment_description",
        "diagnosis_code",
        "diagnosis_description",
        CAST("care_plan_id" AS UUID) 
        AS "care_plan_id",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("end_date" AS DATE) 
        AS "end_date",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("start_date" AS DATE) 
        AS "start_date",
        CAST("treatment_code" AS VARCHAR) 
        AS "treatment_code"
    FROM "careplans_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "careplans_renamed_casted"