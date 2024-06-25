-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_customer_tag_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "customer_id",
        "index_",
        "value_"
    FROM "shopify_customer_tag_data"
),

"shopify_customer_tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> tag_index
    -- value_ -> tag_value
    SELECT 
        "customer_id",
        "index_" AS "tag_index",
        "value_" AS "tag_value"
    FROM "shopify_customer_tag_data_projected"
),

"shopify_customer_tag_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- customer_id: from INT to VARCHAR
    SELECT
        "tag_index",
        "tag_value",
        CAST("customer_id" AS VARCHAR) AS "customer_id"
    FROM "shopify_customer_tag_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_customer_tag_data_projected_renamed_casted"