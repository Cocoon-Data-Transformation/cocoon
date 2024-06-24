-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"app_store_source_type_device_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "device",
        "source_type",
        "meets_threshold",
        "impressions",
        "impressions_unique_device",
        "page_views",
        "page_views_unique_device"
    FROM "app_store_source_type_device"
),

"app_store_source_type_device_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> metric_date
    -- device -> device_type
    -- source_type -> discovery_source
    -- impressions -> total_impressions
    -- impressions_unique_device -> unique_impressions
    -- page_views -> total_page_views
    -- page_views_unique_device -> unique_page_views
    SELECT 
        app_id,
        date_ AS metric_date,
        device AS device_type,
        source_type AS discovery_source,
        meets_threshold,
        impressions AS total_impressions,
        impressions_unique_device AS unique_impressions,
        page_views AS total_page_views,
        page_views_unique_device AS unique_page_views
    FROM app_store_source_type_device_projected
),

"app_store_source_type_device_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- discovery_source: ['Unavailable']
    SELECT 
        CASE
            WHEN "discovery_source" = 'Unavailable' THEN NULL
            ELSE "discovery_source"
        END AS "discovery_source",
        "metric_date",
        "unique_impressions",
        "app_id",
        "device_type",
        "unique_page_views",
        "total_page_views",
        "total_impressions",
        "meets_threshold"
    FROM "app_store_source_type_device_projected_renamed"
),

"app_store_source_type_device_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- metric_date: from VARCHAR to TIMESTAMP
    SELECT
        "discovery_source",
        "unique_impressions",
        "device_type",
        "unique_page_views",
        "total_page_views",
        "total_impressions",
        "meets_threshold",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("metric_date" AS TIMESTAMP) AS "metric_date"
    FROM "app_store_source_type_device_projected_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "app_store_source_type_device_projected_renamed_null_casted"