-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:35:12.530950+00:00
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
        CASE
            WHEN regexp_full_match("encounter_id", '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}') THEN CAST("encounter_id" AS UUID)
            WHEN regexp_full_match("encounter_id", '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}') THEN CAST("encounter_id" AS UUID)
        END 
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