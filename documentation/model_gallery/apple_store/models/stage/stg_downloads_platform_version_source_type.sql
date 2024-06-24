-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"downloads_platform_version_source_type_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "platform_version",
        "source_type",
        "meets_threshold",
        "first_time_downloads",
        "redownloads",
        "total_downloads"
    FROM "downloads_platform_version_source_type"
),

"downloads_platform_version_source_type_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> statistics_date
    -- source_type -> download_source
    SELECT 
        app_id,
        date_ AS statistics_date,
        platform_version,
        source_type AS download_source,
        meets_threshold,
        first_time_downloads,
        redownloads,
        total_downloads
    FROM downloads_platform_version_source_type_projected
),

"downloads_platform_version_source_type_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- download_source: ['Unavailable']
    SELECT 
        CASE
            WHEN "download_source" = 'Unavailable' THEN NULL
            ELSE "download_source"
        END AS "download_source",
        "statistics_date",
        "first_time_downloads",
        "redownloads",
        "app_id",
        "total_downloads",
        "platform_version",
        "meets_threshold"
    FROM "downloads_platform_version_source_type_projected_renamed"
),

"downloads_platform_version_source_type_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- statistics_date: from VARCHAR to TIMESTAMP
    SELECT
        "download_source",
        "first_time_downloads",
        "redownloads",
        "total_downloads",
        "platform_version",
        "meets_threshold",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("statistics_date" AS TIMESTAMP) AS "statistics_date"
    FROM "downloads_platform_version_source_type_projected_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "downloads_platform_version_source_type_projected_renamed_null_casted"