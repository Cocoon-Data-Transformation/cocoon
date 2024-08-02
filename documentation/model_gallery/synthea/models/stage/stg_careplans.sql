-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 15:55:04.348108+00:00
WITH 
"careplans_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> care_plan_id
    -- START -> start_date
    -- STOP -> end_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> care_plan_code
    -- DESCRIPTION -> care_plan_description
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "Id" AS "care_plan_id",
        "START" AS "start_date",
        "STOP" AS "end_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "care_plan_code",
        "DESCRIPTION" AS "care_plan_description",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "memory"."main"."careplans"
),

"careplans_renamed_casted" AS (
    -- Column Type Casting: 
    -- care_plan_code: from INT to VARCHAR
    -- care_plan_id: from VARCHAR to UUID
    -- encounter_id: from VARCHAR to UUID
    -- end_date: from VARCHAR to DATE
    -- patient_id: from VARCHAR to UUID
    -- reason_code: from DECIMAL to VARCHAR
    -- start_date: from VARCHAR to DATE
    SELECT
        "care_plan_description",
        "reason_description",
        CAST("care_plan_code" AS VARCHAR) 
        AS "care_plan_code",
        CAST("care_plan_id" AS UUID) 
        AS "care_plan_id",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("end_date" AS DATE) 
        AS "end_date",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("reason_code" AS VARCHAR) 
        AS "reason_code",
        CAST("start_date" AS DATE) 
        AS "start_date"
    FROM "careplans_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "careplans_renamed_casted"