-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_collection_product_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "collection_id",
        "product_id"
    FROM "shopify_collection_product_data"
),

"shopify_collection_product_data_projected_casted" AS (
    -- Column Type Casting: 
    -- collection_id: from INT to VARCHAR
    -- product_id: from INT to VARCHAR
    SELECT
        CAST("collection_id" AS VARCHAR) AS "collection_id",
        CAST("product_id" AS VARCHAR) AS "product_id"
    FROM "shopify_collection_product_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_collection_product_data_projected_casted"