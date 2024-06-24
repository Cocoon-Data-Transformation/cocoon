-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"crashes_app_version_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "app_version",
        "date_",
        "device",
        "meets_threshold",
        "crashes"
    FROM "crashes_app_version"
),

"crashes_app_version_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> record_datetime
    -- device -> device_type
    -- meets_threshold -> threshold_met
    -- crashes -> crash_count
    SELECT 
        app_id,
        app_version,
        date_ AS record_datetime,
        device AS device_type,
        meets_threshold AS threshold_met,
        crashes AS crash_count
    FROM crashes_app_version_projected
),

"crashes_app_version_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- record_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "app_version",
        "device_type",
        "threshold_met",
        "crash_count",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("record_datetime" AS TIMESTAMP) AS "record_datetime"
    FROM "crashes_app_version_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "crashes_app_version_projected_renamed_casted"