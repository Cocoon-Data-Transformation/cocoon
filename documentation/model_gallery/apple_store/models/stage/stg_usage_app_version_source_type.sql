-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"usage_app_version_source_type_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "app_version",
        "date_",
        "source_type",
        "meets_threshold",
        "installations",
        "sessions",
        "active_devices",
        "active_devices_last_30_days",
        "deletions"
    FROM "usage_app_version_source_type"
),

"usage_app_version_source_type_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> record_date
    -- installations -> daily_installations
    -- sessions -> daily_sessions
    -- active_devices -> daily_active_devices
    -- active_devices_last_30_days -> monthly_active_devices
    -- deletions -> daily_deletions
    SELECT 
        app_id,
        app_version,
        date_ AS record_date,
        source_type,
        meets_threshold,
        installations AS daily_installations,
        sessions AS daily_sessions,
        active_devices AS daily_active_devices,
        active_devices_last_30_days AS monthly_active_devices,
        deletions AS daily_deletions
    FROM usage_app_version_source_type_projected
),

"usage_app_version_source_type_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- source_type: ['Unavailable']
    SELECT 
        CASE
            WHEN "source_type" = 'Unavailable' THEN NULL
            ELSE "source_type"
        END AS "source_type",
        "daily_deletions",
        "daily_sessions",
        "daily_active_devices",
        "record_date",
        "monthly_active_devices",
        "app_id",
        "daily_installations",
        "app_version",
        "meets_threshold"
    FROM "usage_app_version_source_type_projected_renamed"
),

"usage_app_version_source_type_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- record_date: from VARCHAR to TIMESTAMP
    SELECT
        "source_type",
        "daily_deletions",
        "daily_sessions",
        "daily_active_devices",
        "monthly_active_devices",
        "daily_installations",
        "app_version",
        "meets_threshold",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("record_date" AS TIMESTAMP) AS "record_date"
    FROM "usage_app_version_source_type_projected_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "usage_app_version_source_type_projected_renamed_null_casted"