-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"downloads_territory_source_type_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "app_id",
        "date_",
        "source_type",
        "territory",
        "meets_threshold",
        "first_time_downloads",
        "redownloads",
        "total_downloads"
    FROM "downloads_territory_source_type"
),

"downloads_territory_source_type_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> stat_date
    -- source_type -> acquisition_channel
    -- territory -> country
    -- first_time_downloads -> new_downloads
    SELECT 
        app_id,
        date_ AS stat_date,
        source_type AS acquisition_channel,
        territory AS country,
        meets_threshold,
        first_time_downloads AS new_downloads,
        redownloads,
        total_downloads
    FROM downloads_territory_source_type_projected
),

"downloads_territory_source_type_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- acquisition_channel: ['Unavailable']
    SELECT 
        CASE
            WHEN "acquisition_channel" = 'Unavailable' THEN NULL
            ELSE "acquisition_channel"
        END AS "acquisition_channel",
        "stat_date",
        "new_downloads",
        "country",
        "redownloads",
        "app_id",
        "total_downloads",
        "meets_threshold"
    FROM "downloads_territory_source_type_projected_renamed"
),

"downloads_territory_source_type_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- stat_date: from VARCHAR to TIMESTAMP
    SELECT
        "acquisition_channel",
        "new_downloads",
        "country",
        "redownloads",
        "total_downloads",
        "meets_threshold",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("stat_date" AS TIMESTAMP) AS "stat_date"
    FROM "downloads_territory_source_type_projected_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "downloads_territory_source_type_projected_renamed_null_casted"