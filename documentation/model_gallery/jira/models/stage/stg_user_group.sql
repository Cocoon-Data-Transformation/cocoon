-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"user_group_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "group_name",
        "user_id"
    FROM "user_group"
),

"user_group_projected_renamed" AS (
    -- Rename: Renaming columns
    -- user_id -> user_identifier
    SELECT 
        "group_name",
        "user_id" AS "user_identifier"
    FROM "user_group_projected"
)

-- COCOON BLOCK END
SELECT * FROM "user_group_projected_renamed"