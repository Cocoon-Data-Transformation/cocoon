-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"devices_renamed" AS (
    -- Rename: Renaming columns
    -- START -> usage_start_datetime
    -- STOP -> usage_end_datetime
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> device_code
    -- DESCRIPTION -> device_description
    -- UDI -> unique_device_identifier
    SELECT 
        "START" AS "usage_start_datetime",
        "STOP" AS "usage_end_datetime",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "device_code",
        "DESCRIPTION" AS "device_description",
        "UDI" AS "unique_device_identifier"
    FROM "devices"
),

"devices_renamed_casted" AS (
    -- Column Type Casting: 
    -- device_code: from INT to VARCHAR
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- usage_end_datetime: from VARCHAR to TIMESTAMP
    -- usage_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "device_description",
        "unique_device_identifier",
        CAST("device_code" AS VARCHAR) AS "device_code",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("usage_end_datetime" AS TIMESTAMP) AS "usage_end_datetime",
        CAST("usage_start_datetime" AS TIMESTAMP) AS "usage_start_datetime"
    FROM "devices_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "devices_renamed_casted"