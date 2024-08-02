-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 00:46:56.163747+00:00
WITH 
"device_casted" AS (
    -- Column Type Casting: 
    -- device_exposure_end_date: from VARCHAR to DATE
    -- device_exposure_end_datetime: from VARCHAR to TIMESTAMP
    -- device_exposure_start_date: from VARCHAR to DATE
    -- device_exposure_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "device_id",
        "person_id",
        "unique_device_id",
        "quantity",
        "provider_id",
        "visit_occurrence_id",
        "device_source_value",
        CAST("device_exposure_end_date" AS DATE) 
        AS "device_exposure_end_date",
        CAST("device_exposure_end_datetime" AS TIMESTAMP) 
        AS "device_exposure_end_datetime",
        CAST("device_exposure_start_date" AS DATE) 
        AS "device_exposure_start_date",
        CAST("device_exposure_start_datetime" AS TIMESTAMP) 
        AS "device_exposure_start_datetime"
    FROM "memory"."main"."device"
)

-- COCOON BLOCK END
SELECT *
FROM "device_casted"