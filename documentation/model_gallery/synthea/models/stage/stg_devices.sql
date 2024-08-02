-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:15:38.940567+00:00
WITH 
"devices_renamed" AS (
    -- Rename: Renaming columns
    -- START -> device_start_date
    -- STOP -> device_end_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> device_code
    -- DESCRIPTION -> device_description
    -- UDI -> device_udi
    SELECT 
        "START" AS "device_start_date",
        "STOP" AS "device_end_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "device_code",
        "DESCRIPTION" AS "device_description",
        "UDI" AS "device_udi"
    FROM "memory"."main"."devices"
),

"devices_renamed_casted" AS (
    -- Column Type Casting: 
    -- device_code: from INT to VARCHAR
    -- device_end_date: from VARCHAR to TIMESTAMP
    -- device_start_date: from VARCHAR to TIMESTAMP
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    SELECT
        "device_description",
        "device_udi",
        CAST("device_code" AS VARCHAR) 
        AS "device_code",
        CAST("device_end_date" AS TIMESTAMP) 
        AS "device_end_date",
        CAST("device_start_date" AS TIMESTAMP) 
        AS "device_start_date",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id"
    FROM "devices_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "devices_renamed_casted"