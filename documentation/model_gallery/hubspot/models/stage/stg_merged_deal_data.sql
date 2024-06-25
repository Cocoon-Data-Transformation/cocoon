-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"merged_deal_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "deal_id",
        "merged_deal_id"
    FROM "merged_deal_data"
),

"merged_deal_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- merged_deal_id -> group_deal_id
    SELECT 
        "deal_id",
        "merged_deal_id" AS "group_deal_id"
    FROM "merged_deal_data_projected"
),

"merged_deal_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- deal_id: from INT to VARCHAR
    -- group_deal_id: from INT to VARCHAR
    SELECT
        CAST("deal_id" AS VARCHAR) AS "deal_id",
        CAST("group_deal_id" AS VARCHAR) AS "group_deal_id"
    FROM "merged_deal_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "merged_deal_data_projected_renamed_casted"