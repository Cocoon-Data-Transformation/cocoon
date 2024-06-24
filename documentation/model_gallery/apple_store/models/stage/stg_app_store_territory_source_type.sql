-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"app_store_territory_source_type_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "source_type",
        "territory",
        "meets_threshold",
        "impressions",
        "impressions_unique_device",
        "page_views",
        "page_views_unique_device"
    FROM "app_store_territory_source_type"
),

"app_store_territory_source_type_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> metric_date
    -- source_type -> discovery_source
    -- impressions_unique_device -> unique_device_impressions
    -- page_views_unique_device -> unique_device_page_views
    SELECT 
        app_id,
        date_ AS metric_date,
        source_type AS discovery_source,
        territory,
        meets_threshold,
        impressions,
        impressions_unique_device AS unique_device_impressions,
        page_views,
        page_views_unique_device AS unique_device_page_views
    FROM app_store_territory_source_type_projected
),

"app_store_territory_source_type_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- territory: The problem is inconsistent naming for 'Cote d'Ivoire' vs 'Côte d'Ivoire', and 'Turkey' vs 'Türkiye'. The correct values are 'Côte d'Ivoire' and 'Türkiye', based on their more frequent occurrences. 
    SELECT
        "app_id",
        "metric_date",
        "discovery_source",
        CASE
            WHEN "territory" = 'Cote d''Ivoire' THEN 'Côte d''Ivoire'
            WHEN "territory" = 'Turkey' THEN 'Türkiye'
            ELSE "territory"
        END AS "territory",
        "meets_threshold",
        "impressions",
        "unique_device_impressions",
        "page_views",
        "unique_device_page_views"
    FROM "app_store_territory_source_type_projected_renamed"
),

"app_store_territory_source_type_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- discovery_source: ['Unavailable']
    SELECT 
        CASE
            WHEN "discovery_source" = 'Unavailable' THEN NULL
            ELSE "discovery_source"
        END AS "discovery_source",
        "unique_device_impressions",
        "page_views",
        "metric_date",
        "app_id",
        "unique_device_page_views",
        "impressions",
        "territory",
        "meets_threshold"
    FROM "app_store_territory_source_type_projected_renamed_cleaned"
),

"app_store_territory_source_type_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- metric_date: from VARCHAR to TIMESTAMP
    SELECT
        "discovery_source",
        "unique_device_impressions",
        "page_views",
        "unique_device_page_views",
        "impressions",
        "territory",
        "meets_threshold",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("metric_date" AS TIMESTAMP) AS "metric_date"
    FROM "app_store_territory_source_type_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "app_store_territory_source_type_projected_renamed_cleaned_null_casted"