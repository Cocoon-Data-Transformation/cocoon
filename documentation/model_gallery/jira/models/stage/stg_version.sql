-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"version_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "archived",
        "description",
        "name",
        "overdue",
        "project_id",
        "release_date",
        "released",
        "start_date"
    FROM "version"
),

"version_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> version_id
    -- archived -> is_archived
    -- description -> version_description
    -- name -> version_name
    -- overdue -> is_overdue
    -- released -> is_released
    SELECT 
        "id" AS "version_id",
        "archived" AS "is_archived",
        "description" AS "version_description",
        "name" AS "version_name",
        "overdue" AS "is_overdue",
        "project_id",
        "release_date",
        "released" AS "is_released",
        "start_date"
    FROM "version_projected"
),

"version_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- version_name: The problem is inconsistent formatting for version 2.0. It appears as both "Version 2.0" and "v2.0". The correct values should follow the most common format, which is "Version X.0". "Version 2.0" is already in the correct format and is the most frequent, so "v2.0" should be changed to match it. 
    SELECT
        "version_id",
        "is_archived",
        "version_description",
        CASE
            WHEN "version_name" = 'v2.0' THEN 'Version 2.0'
            ELSE "version_name"
        END AS "version_name",
        "is_overdue",
        "project_id",
        "release_date",
        "is_released",
        "start_date"
    FROM "version_projected_renamed"
),

"version_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- release_date: from VARCHAR to DATE
    -- start_date: from VARCHAR to DATE
    SELECT
        "version_id",
        "is_archived",
        "version_description",
        "version_name",
        "is_overdue",
        "project_id",
        "is_released",
        CAST("release_date" AS DATE) AS "release_date",
        CAST("start_date" AS DATE) AS "start_date"
    FROM "version_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "version_projected_renamed_cleaned_casted"