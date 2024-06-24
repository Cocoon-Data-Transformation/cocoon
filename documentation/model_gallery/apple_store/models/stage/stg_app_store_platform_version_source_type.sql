-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"app_store_platform_version_source_type_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "platform_version",
        "source_type",
        "meets_threshold",
        "impressions",
        "impressions_unique_device",
        "page_views",
        "page_views_unique_device"
    FROM "app_store_platform_version_source_type"
),

"app_store_platform_version_source_type_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> performance_date
    -- platform_version -> ios_version
    -- source_type -> traffic_source
    -- impressions -> total_impressions
    -- impressions_unique_device -> unique_device_impressions
    -- page_views -> total_page_views
    -- page_views_unique_device -> unique_device_page_views
    SELECT 
        app_id,
        date_ AS performance_date,
        platform_version AS ios_version,
        source_type AS traffic_source,
        meets_threshold,
        impressions AS total_impressions,
        impressions_unique_device AS unique_device_impressions,
        page_views AS total_page_views,
        page_views_unique_device AS unique_device_page_views
    FROM app_store_platform_version_source_type_projected
),

"app_store_platform_version_source_type_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- traffic_source: ['Unavailable']
    SELECT 
        CASE
            WHEN "traffic_source" = 'Unavailable' THEN NULL
            ELSE "traffic_source"
        END AS "traffic_source",
        "unique_device_impressions",
        "performance_date",
        "app_id",
        "unique_device_page_views",
        "ios_version",
        "total_page_views",
        "total_impressions",
        "meets_threshold"
    FROM "app_store_platform_version_source_type_projected_renamed"
),

"app_store_platform_version_source_type_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- performance_date: from VARCHAR to TIMESTAMP
    SELECT
        "traffic_source",
        "unique_device_impressions",
        "unique_device_page_views",
        "ios_version",
        "total_page_views",
        "total_impressions",
        "meets_threshold",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("performance_date" AS TIMESTAMP) AS "performance_date"
    FROM "app_store_platform_version_source_type_projected_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "app_store_platform_version_source_type_projected_renamed_null_casted"