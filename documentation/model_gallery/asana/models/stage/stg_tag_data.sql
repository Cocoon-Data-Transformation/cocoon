-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:02:09.098470+00:00
WITH 
"tag_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "color",
        "created_at",
        "message",
        "name",
        "notes",
        "workspace_id"
    FROM "memory"."main"."tag_data"
),

"tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> tag_id
    -- _fivetran_deleted -> is_deleted
    -- color -> tag_color
    -- created_at -> creation_timestamp
    -- message -> tag_message
    -- name -> tag_hash
    -- notes -> tag_notes
    SELECT 
        "id" AS "tag_id",
        "_fivetran_deleted" AS "is_deleted",
        "color" AS "tag_color",
        "created_at" AS "creation_timestamp",
        "message" AS "tag_message",
        "name" AS "tag_hash",
        "notes" AS "tag_notes",
        "workspace_id"
    FROM "tag_data_projected"
),

"tag_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- tag_color: from DECIMAL to VARCHAR
    -- tag_id: from INT to VARCHAR
    -- tag_message: from DECIMAL to VARCHAR
    -- tag_notes: from DECIMAL to VARCHAR
    -- workspace_id: from INT to VARCHAR
    SELECT
        "is_deleted",
        "tag_hash",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("tag_color" AS VARCHAR) AS "tag_color",
        CAST("tag_id" AS VARCHAR) AS "tag_id",
        CAST("tag_message" AS VARCHAR) AS "tag_message",
        CAST("tag_notes" AS VARCHAR) AS "tag_notes",
        CAST("workspace_id" AS VARCHAR) AS "workspace_id"
    FROM "tag_data_projected_renamed"
),

"tag_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- tag_color has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tag_message has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tag_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_deleted",
        "tag_hash",
        "creation_timestamp",
        "tag_id",
        "workspace_id"
    FROM "tag_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "tag_data_projected_renamed_casted_missing_handled"