-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"status_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "description",
        "name",
        "status_category_id"
    FROM "status"
),

"status_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> status_id
    -- description -> status_description
    -- name -> status_name
    -- status_category_id -> category_id
    SELECT 
        "id" AS "status_id",
        "description" AS "status_description",
        "name" AS "status_name",
        "status_category_id" AS "category_id"
    FROM "status_projected"
),

"status_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- status_id: from INT to VARCHAR
    SELECT
        "status_description",
        "status_name",
        "category_id",
        CAST("status_id" AS VARCHAR) AS "status_id"
    FROM "status_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "status_projected_renamed_casted"