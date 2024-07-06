-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:01:13.008982+00:00
WITH 
"story_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_at",
        "created_by_id",
        "hearted",
        "num_hearts",
        "source",
        "target_id",
        "text",
        "type"
    FROM "memory"."main"."story_data"
),

"story_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> entry_id
    -- created_by_id -> author_id
    -- hearted -> is_hearted
    -- num_hearts -> heart_count
    -- source -> source_platform
    -- text -> content
    -- type -> entry_type
    SELECT 
        "id" AS "entry_id",
        "created_at",
        "created_by_id" AS "author_id",
        "hearted" AS "is_hearted",
        "num_hearts" AS "heart_count",
        "source" AS "source_platform",
        "target_id",
        "text" AS "content",
        "type" AS "entry_type"
    FROM "story_data_projected"
),

"story_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- author_id: from INT to VARCHAR
    -- created_at: from VARCHAR to TIMESTAMP
    -- entry_id: from INT to VARCHAR
    -- is_hearted: from DECIMAL to BOOLEAN
    -- target_id: from INT to VARCHAR
    SELECT
        "heart_count",
        "source_platform",
        "content",
        "entry_type",
        CAST("author_id" AS VARCHAR) AS "author_id",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("entry_id" AS VARCHAR) AS "entry_id",
        CAST("is_hearted" AS BOOLEAN) AS "is_hearted",
        CAST("target_id" AS VARCHAR) AS "target_id"
    FROM "story_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "story_data_projected_renamed_casted"