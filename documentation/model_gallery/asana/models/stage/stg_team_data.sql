-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:05:01.424219+00:00
WITH 
"team_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "name",
        "organization_id"
    FROM "memory"."main"."team_data"
),

"team_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> team_id
    -- _fivetran_deleted -> is_deleted
    -- name -> encrypted_team_name
    SELECT 
        "id" AS "team_id",
        "_fivetran_deleted" AS "is_deleted",
        "name" AS "encrypted_team_name",
        "organization_id"
    FROM "team_data_projected"
),

"team_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- organization_id: from INT to VARCHAR
    -- team_id: from INT to VARCHAR
    SELECT
        "is_deleted",
        "encrypted_team_name",
        CAST("organization_id" AS VARCHAR) AS "organization_id",
        CAST("team_id" AS VARCHAR) AS "team_id"
    FROM "team_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "team_data_projected_renamed_casted"