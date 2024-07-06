-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:05:40.193939+00:00
WITH 
"user_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "email",
        "name"
    FROM "memory"."main"."user_data"
),

"user_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> user_id
    -- _fivetran_deleted -> is_deleted
    -- email -> hashed_email
    -- name -> hashed_name
    SELECT 
        "id" AS "user_id",
        "_fivetran_deleted" AS "is_deleted",
        "email" AS "hashed_email",
        "name" AS "hashed_name"
    FROM "user_data_projected"
),

"user_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- user_id: from INT to VARCHAR
    SELECT
        "is_deleted",
        "hashed_email",
        "hashed_name",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "user_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "user_data_projected_renamed_casted"