-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 00:55:38.865223+00:00
WITH 
"conditions_renamed" AS (
    -- Rename: Renaming columns
    -- START -> condition_start_date
    -- STOP -> condition_end_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> condition_code
    -- DESCRIPTION -> condition_description
    SELECT 
        "START" AS "condition_start_date",
        "STOP" AS "condition_end_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "condition_code",
        "DESCRIPTION" AS "condition_description"
    FROM "memory"."main"."conditions"
),

"conditions_renamed_casted" AS (
    -- Column Type Casting: 
    -- condition_code: from INT to VARCHAR
    -- condition_end_date: from VARCHAR to DATE
    -- condition_start_date: from VARCHAR to DATE
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    SELECT
        "condition_description",
        CAST("condition_code" AS VARCHAR) 
        AS "condition_code",
        CAST("condition_end_date" AS DATE) 
        AS "condition_end_date",
        CAST("condition_start_date" AS DATE) 
        AS "condition_start_date",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id"
    FROM "conditions_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "conditions_renamed_casted"