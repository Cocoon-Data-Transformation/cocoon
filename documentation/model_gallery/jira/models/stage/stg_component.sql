-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"component_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "description",
        "name",
        "project_id"
    FROM "component"
),

"component_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> component_id
    -- description -> component_description
    -- name -> component_name
    SELECT 
        "id" AS "component_id",
        "description" AS "component_description",
        "name" AS "component_name",
        "project_id"
    FROM "component_projected"
),

"component_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- component_description: from DECIMAL to VARCHAR
    SELECT
        "component_id",
        "component_name",
        "project_id",
        CAST("component_description" AS VARCHAR) AS "component_description"
    FROM "component_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "component_projected_renamed_casted"