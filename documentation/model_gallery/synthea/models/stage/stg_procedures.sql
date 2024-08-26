-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:14:58.976415+00:00
WITH 
"procedures_renamed" AS (
    -- Rename: Renaming columns
    -- START -> procedure_start_time
    -- STOP -> procedure_end_time
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> procedure_code
    -- DESCRIPTION -> procedure_description
    -- BASE_COST -> procedure_cost
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "START" AS "procedure_start_time",
        "STOP" AS "procedure_end_time",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "procedure_code",
        "DESCRIPTION" AS "procedure_description",
        "BASE_COST" AS "procedure_cost",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "memory"."main"."procedures"
),

"procedures_renamed_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- procedure_code: from INT to VARCHAR
    -- procedure_end_time: from VARCHAR to TIMESTAMP
    -- procedure_start_time: from VARCHAR to TIMESTAMP
    -- reason_code: from DECIMAL to VARCHAR
    SELECT
        "procedure_description",
        "procedure_cost",
        "reason_description",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("procedure_code" AS VARCHAR) 
        AS "procedure_code",
        CAST("procedure_end_time" AS TIMESTAMP) 
        AS "procedure_end_time",
        CAST("procedure_start_time" AS TIMESTAMP) 
        AS "procedure_start_time",
        CAST("reason_code" AS VARCHAR) 
        AS "reason_code"
    FROM "procedures_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "procedures_renamed_casted"