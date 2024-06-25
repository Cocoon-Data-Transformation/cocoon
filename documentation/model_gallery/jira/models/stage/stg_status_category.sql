-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"status_category_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "name"
    FROM "status_category"
),

"status_category_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> status_id
    -- name -> status_name
    SELECT 
        "id" AS "status_id",
        "name" AS "status_name"
    FROM "status_category_projected"
)

-- COCOON BLOCK END
SELECT * FROM "status_category_projected_renamed"