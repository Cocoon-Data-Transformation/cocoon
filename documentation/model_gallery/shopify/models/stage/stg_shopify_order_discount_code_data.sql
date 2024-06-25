-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_discount_code_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "index_",
        "order_id",
        "amount",
        "code",
        "type"
    FROM "shopify_order_discount_code_data"
),

"shopify_order_discount_code_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> discount_order
    -- amount -> discount_value
    -- code -> discount_code
    -- type -> discount_type
    SELECT 
        "index_" AS "discount_order",
        "order_id",
        "amount" AS "discount_value",
        "code" AS "discount_code",
        "type" AS "discount_type"
    FROM "shopify_order_discount_code_data_projected"
),

"shopify_order_discount_code_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- order_id: from INT to VARCHAR
    SELECT
        "discount_order",
        "discount_value",
        "discount_code",
        "discount_type",
        CAST("order_id" AS VARCHAR) AS "order_id"
    FROM "shopify_order_discount_code_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_discount_code_data_projected_renamed_casted"