-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"priority_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "description",
        "name"
    FROM "priority"
),

"priority_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> priority_id
    -- description -> priority_impact
    -- name -> priority_level
    SELECT 
        "id" AS "priority_id",
        "description" AS "priority_impact",
        "name" AS "priority_level"
    FROM "priority_projected"
)

-- COCOON BLOCK END
SELECT * FROM "priority_projected_renamed"