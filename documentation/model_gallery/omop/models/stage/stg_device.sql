-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"device_renamed" AS (
    -- Rename: Renaming columns
    -- person_id -> patient_id
    -- quantity -> device_quantity
    -- visit_occurrence_id -> visit_id
    -- device_source_value -> device_type
    SELECT 
        "device_id",
        "person_id" AS "patient_id",
        "device_exposure_start_date",
        "device_exposure_start_datetime",
        "device_exposure_end_date",
        "device_exposure_end_datetime",
        "unique_device_id",
        "quantity" AS "device_quantity",
        "provider_id",
        "visit_occurrence_id" AS "visit_id",
        "device_source_value" AS "device_type"
    FROM "device"
),

"device_renamed_casted" AS (
    -- Column Type Casting: 
    -- device_exposure_end_date: from VARCHAR to DATE
    -- device_exposure_end_datetime: from VARCHAR to TIMESTAMP
    -- device_exposure_start_date: from VARCHAR to DATE
    -- device_exposure_start_datetime: from VARCHAR to TIMESTAMP
    -- device_id: from INT to VARCHAR
    -- patient_id: from INT to VARCHAR
    -- provider_id: from INT to VARCHAR
    -- visit_id: from INT to VARCHAR
    SELECT
        "unique_device_id",
        "device_quantity",
        "device_type",
        CAST("device_exposure_end_date" AS DATE) AS "device_exposure_end_date",
        CAST("device_exposure_end_datetime" AS TIMESTAMP) AS "device_exposure_end_datetime",
        CAST("device_exposure_start_date" AS DATE) AS "device_exposure_start_date",
        CAST("device_exposure_start_datetime" AS TIMESTAMP) AS "device_exposure_start_datetime",
        CAST("device_id" AS VARCHAR) AS "device_id",
        CAST("patient_id" AS VARCHAR) AS "patient_id",
        CAST("provider_id" AS VARCHAR) AS "provider_id",
        CAST("visit_id" AS VARCHAR) AS "visit_id"
    FROM "device_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "device_renamed_casted"