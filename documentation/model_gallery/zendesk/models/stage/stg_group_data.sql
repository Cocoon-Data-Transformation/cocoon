-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"group_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "created_at",
        "name",
        "updated_at",
        "url"
    FROM "group_data"
),

"group_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> group_id
    -- _fivetran_deleted -> is_deleted
    -- name -> group_name
    -- url -> api_url
    SELECT 
        "id" AS "group_id",
        "_fivetran_deleted" AS "is_deleted",
        "created_at",
        "name" AS "group_name",
        "updated_at",
        "url" AS "api_url"
    FROM "group_data_projected"
),

"group_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- group_id: from INT to VARCHAR
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "is_deleted",
        "group_name",
        "api_url",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("group_id" AS VARCHAR) AS "group_id",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "group_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "group_data_projected_renamed_casted"