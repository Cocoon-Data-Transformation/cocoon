-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"user_tag_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "tag",
        "user_id"
    FROM "user_tag_data"
),

"user_tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- tag -> tag_id
    SELECT 
        "tag" AS "tag_id",
        "user_id"
    FROM "user_tag_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "user_tag_data_projected_renamed"