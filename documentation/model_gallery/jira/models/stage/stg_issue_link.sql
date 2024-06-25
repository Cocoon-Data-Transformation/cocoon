-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"issue_link_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "issue_id",
        "related_issue_id",
        "relationship"
    FROM "issue_link"
),

"issue_link_projected_renamed" AS (
    -- Rename: Renaming columns
    -- relationship -> relationship_type
    SELECT 
        "issue_id",
        "related_issue_id",
        "relationship" AS "relationship_type"
    FROM "issue_link_projected"
)

-- COCOON BLOCK END
SELECT * FROM "issue_link_projected_renamed"