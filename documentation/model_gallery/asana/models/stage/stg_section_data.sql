-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:00:06.130210+00:00
WITH 
"section_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_at",
        "name",
        "project_id"
    FROM "memory"."main"."section_data"
),

"section_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> section_id
    -- name -> section_hash
    SELECT 
        "id" AS "section_id",
        "created_at",
        "name" AS "section_hash",
        "project_id"
    FROM "section_data_projected"
),

"section_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- project_id: from INT to VARCHAR
    -- section_id: from INT to VARCHAR
    SELECT
        "section_hash",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("project_id" AS VARCHAR) AS "project_id",
        CAST("section_id" AS VARCHAR) AS "section_id"
    FROM "section_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "section_data_projected_renamed_casted"