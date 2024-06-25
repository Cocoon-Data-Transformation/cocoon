-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_company_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "company_id",
        "engagement_id",
        "engagement_type",
        "type_id"
    FROM "engagement_company_data"
),

"engagement_company_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- engagement_type -> engagement_category
    -- type_id -> engagement_subcategory_id
    SELECT 
        "company_id",
        "engagement_id",
        "engagement_type" AS "engagement_category",
        "type_id" AS "engagement_subcategory_id"
    FROM "engagement_company_data_projected"
),

"engagement_company_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- company_id: from INT to VARCHAR
    -- engagement_id: from INT to VARCHAR
    -- engagement_subcategory_id: from INT to VARCHAR
    SELECT
        "engagement_category",
        CAST("company_id" AS VARCHAR) AS "company_id",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id",
        CAST("engagement_subcategory_id" AS VARCHAR) AS "engagement_subcategory_id"
    FROM "engagement_company_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_company_data_projected_renamed_casted"