-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "type",
        "portal_id"
    FROM "engagement_data"
),

"engagement_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> engagement_id
    -- type -> engagement_type
    -- portal_id -> customer_portal_id
    SELECT 
        "id" AS "engagement_id",
        "type" AS "engagement_type",
        "portal_id" AS "customer_portal_id"
    FROM "engagement_data_projected"
),

"engagement_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- customer_portal_id: from INT to VARCHAR
    -- engagement_id: from INT to VARCHAR
    SELECT
        "engagement_type",
        CAST("customer_portal_id" AS VARCHAR) AS "customer_portal_id",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id"
    FROM "engagement_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_data_projected_renamed_casted"