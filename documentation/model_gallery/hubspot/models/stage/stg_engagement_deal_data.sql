-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_deal_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "deal_id",
        "engagement_id",
        "engagement_type",
        "type_id"
    FROM "engagement_deal_data"
),

"engagement_deal_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- type_id -> engagement_type_id
    SELECT 
        "deal_id",
        "engagement_id",
        "engagement_type",
        "type_id" AS "engagement_type_id"
    FROM "engagement_deal_data_projected"
),

"engagement_deal_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- deal_id: from INT to VARCHAR
    -- engagement_id: from INT to VARCHAR
    -- engagement_type_id: from INT to VARCHAR
    SELECT
        "engagement_type",
        CAST("deal_id" AS VARCHAR) AS "deal_id",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id",
        CAST("engagement_type_id" AS VARCHAR) AS "engagement_type_id"
    FROM "engagement_deal_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_deal_data_projected_renamed_casted"