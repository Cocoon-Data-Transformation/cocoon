-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"usage_source_type_device_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "device",
        "source_type",
        "meets_threshold",
        "installations",
        "sessions",
        "active_devices",
        "active_devices_last_30_days",
        "deletions"
    FROM "usage_source_type_device"
),

"usage_source_type_device_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> record_date
    -- device -> device_type
    -- source_type -> acquisition_channel
    -- installations -> new_installations
    -- sessions -> daily_sessions
    -- active_devices -> daily_active_devices
    -- active_devices_last_30_days -> monthly_active_devices
    -- deletions -> app_deletions
    SELECT 
        app_id,
        date_ AS record_date,
        device AS device_type,
        source_type AS acquisition_channel,
        meets_threshold,
        installations AS new_installations,
        sessions AS daily_sessions,
        active_devices AS daily_active_devices,
        active_devices_last_30_days AS monthly_active_devices,
        deletions AS app_deletions
    FROM usage_source_type_device_projected
),

"usage_source_type_device_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- record_date: from VARCHAR to TIMESTAMP
    SELECT
        "device_type",
        "acquisition_channel",
        "meets_threshold",
        "new_installations",
        "daily_sessions",
        "daily_active_devices",
        "monthly_active_devices",
        "app_deletions",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("record_date" AS TIMESTAMP) AS "record_date"
    FROM "usage_source_type_device_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "usage_source_type_device_projected_renamed_casted"