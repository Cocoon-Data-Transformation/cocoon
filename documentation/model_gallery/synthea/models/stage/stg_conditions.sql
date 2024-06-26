-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"conditions_renamed" AS (
    -- Rename: Renaming columns
    -- START -> start_date
    -- STOP -> end_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> condition_code
    -- DESCRIPTION -> condition_description
    SELECT 
        "START" AS "start_date",
        "STOP" AS "end_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "condition_code",
        "DESCRIPTION" AS "condition_description"
    FROM "conditions"
),

"conditions_renamed_casted" AS (
    -- Column Type Casting: 
    -- condition_code: from INT to VARCHAR
    -- encounter_id: from VARCHAR to UUID
    -- end_date: from VARCHAR to DATE
    -- patient_id: from VARCHAR to UUID
    -- start_date: from VARCHAR to DATE
    SELECT
        "condition_description",
        CAST("condition_code" AS VARCHAR) AS "condition_code",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CAST("end_date" AS DATE) AS "end_date",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("start_date" AS DATE) AS "start_date"
    FROM "conditions_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "conditions_renamed_casted"