-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"downloads_source_type_device_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "device",
        "source_type",
        "meets_threshold",
        "first_time_downloads",
        "redownloads",
        "total_downloads"
    FROM "downloads_source_type_device"
),

"downloads_source_type_device_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> timestamp_
    -- device -> device_type
    -- source_type -> download_source
    -- meets_threshold -> threshold_met
    -- first_time_downloads -> new_downloads
    SELECT 
        app_id,
        date_ AS timestamp_,
        device AS device_type,
        source_type AS download_source,
        meets_threshold AS threshold_met,
        first_time_downloads AS new_downloads,
        redownloads,
        total_downloads
    FROM downloads_source_type_device_projected
),

"downloads_source_type_device_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- timestamp_: from VARCHAR to TIMESTAMP
    SELECT
        "device_type",
        "download_source",
        "threshold_met",
        "new_downloads",
        "redownloads",
        "total_downloads",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("timestamp_" AS TIMESTAMP) AS "timestamp_"
    FROM "downloads_source_type_device_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "downloads_source_type_device_projected_renamed_casted"