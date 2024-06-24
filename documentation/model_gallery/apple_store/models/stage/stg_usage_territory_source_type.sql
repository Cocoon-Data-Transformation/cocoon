-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"usage_territory_source_type_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "source_type",
        "territory",
        "meets_threshold",
        "installations",
        "sessions",
        "active_devices",
        "active_devices_last_30_days",
        "deletions"
    FROM "usage_territory_source_type"
),

"usage_territory_source_type_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> metric_date
    -- source_type -> acquisition_source
    -- installations -> daily_installations
    -- sessions -> daily_sessions
    -- active_devices -> daily_active_devices
    -- active_devices_last_30_days -> monthly_active_devices
    -- deletions -> daily_deletions
    SELECT 
        app_id,
        date_ AS metric_date,
        source_type AS acquisition_source,
        territory,
        meets_threshold,
        installations AS daily_installations,
        sessions AS daily_sessions,
        active_devices AS daily_active_devices,
        active_devices_last_30_days AS monthly_active_devices,
        deletions AS daily_deletions
    FROM usage_territory_source_type_projected
),

"usage_territory_source_type_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- acquisition_source: ['Unavailable']
    SELECT 
        CASE
            WHEN "acquisition_source" = 'Unavailable' THEN NULL
            ELSE "acquisition_source"
        END AS "acquisition_source",
        "daily_deletions",
        "daily_sessions",
        "daily_active_devices",
        "metric_date",
        "monthly_active_devices",
        "app_id",
        "daily_installations",
        "territory",
        "meets_threshold"
    FROM "usage_territory_source_type_projected_renamed"
),

"usage_territory_source_type_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- metric_date: from VARCHAR to TIMESTAMP
    SELECT
        "acquisition_source",
        "daily_deletions",
        "daily_sessions",
        "daily_active_devices",
        "monthly_active_devices",
        "daily_installations",
        "territory",
        "meets_threshold",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("metric_date" AS TIMESTAMP) AS "metric_date"
    FROM "usage_territory_source_type_projected_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "usage_territory_source_type_projected_renamed_null_casted"