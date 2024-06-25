-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"resolution_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "description",
        "name"
    FROM "resolution"
),

"resolution_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> resolution_id
    -- description -> status_description
    -- name -> status_name
    SELECT 
        "id" AS "resolution_id",
        "description" AS "status_description",
        "name" AS "status_name"
    FROM "resolution_projected"
)

-- COCOON BLOCK END
SELECT * FROM "resolution_projected_renamed"