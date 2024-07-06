-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:00:30.364905+00:00
WITH 
"survey_version_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "survey_id",
        "_fivetran_deleted",
        "creation_date",
        "description",
        "published",
        "user_id",
        "version_number",
        "was_published"
    FROM "memory"."main"."survey_version"
),

"survey_version_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> version_id
    -- _fivetran_deleted -> is_deleted
    -- published -> is_published
    -- was_published -> was_ever_published
    SELECT 
        "id" AS "version_id",
        "survey_id",
        "_fivetran_deleted" AS "is_deleted",
        "creation_date",
        "description",
        "published" AS "is_published",
        "user_id",
        "version_number",
        "was_published" AS "was_ever_published"
    FROM "survey_version_projected"
),

"survey_version_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to TIMESTAMP
    -- version_id: from INT to VARCHAR
    SELECT
        "survey_id",
        "is_deleted",
        "description",
        "is_published",
        "user_id",
        "version_number",
        "was_ever_published",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("version_id" AS VARCHAR) AS "version_id"
    FROM "survey_version_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "survey_version_projected_renamed_casted"