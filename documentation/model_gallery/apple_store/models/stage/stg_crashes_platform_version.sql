-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"crashes_platform_version_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "device",
        "platform_version",
        "meets_threshold",
        "crashes"
    FROM "crashes_platform_version"
),

"crashes_platform_version_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> timestamp_
    -- device -> device_type
    -- platform_version -> os_version
    -- crashes -> crash_count
    SELECT 
        app_id,
        date_ AS timestamp_,
        device AS device_type,
        platform_version AS os_version,
        meets_threshold,
        crashes AS crash_count
    FROM crashes_platform_version_projected
),

"crashes_platform_version_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- timestamp_: from VARCHAR to TIMESTAMP
    SELECT
        "device_type",
        "os_version",
        "meets_threshold",
        "crash_count",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("timestamp_" AS TIMESTAMP) AS "timestamp_"
    FROM "crashes_platform_version_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "crashes_platform_version_projected_renamed_casted"