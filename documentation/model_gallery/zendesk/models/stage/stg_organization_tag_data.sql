-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"organization_tag_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "organization_id",
        "tag"
    FROM "organization_tag_data"
),

"organization_tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- tag -> tag_hash
    SELECT 
        "organization_id",
        "tag" AS "tag_hash"
    FROM "organization_tag_data_projected"
),

"organization_tag_data_projected_renamed_dedup" AS (
    -- Deduplication: Removed 4 duplicated rows
    SELECT DISTINCT * FROM "organization_tag_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "organization_tag_data_projected_renamed_dedup"