-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_tag_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "tag",
        "ticket_id"
    FROM "ticket_tag_data"
),

"ticket_tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- tag -> tag_name
    SELECT 
        "tag" AS "tag_name",
        "ticket_id"
    FROM "ticket_tag_data_projected"
),

"ticket_tag_data_projected_renamed_dedup" AS (
    -- Deduplication: Removed 2 duplicated rows
    SELECT DISTINCT * FROM "ticket_tag_data_projected_renamed"
),

"ticket_tag_data_projected_renamed_dedup_casted" AS (
    -- Column Type Casting: 
    -- ticket_id: from INT to VARCHAR
    SELECT
        "tag_name",
        CAST("ticket_id" AS VARCHAR) AS "ticket_id"
    FROM "ticket_tag_data_projected_renamed_dedup"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_tag_data_projected_renamed_dedup_casted"