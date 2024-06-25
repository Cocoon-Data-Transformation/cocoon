-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_tax_line_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "index_",
        "order_line_id",
        "price",
        "rate",
        "title",
        "price_set"
    FROM "shopify_tax_line_data"
),

"shopify_tax_line_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> row_id
    -- price -> tax_amount
    -- rate -> tax_rate
    -- title -> tax_type
    -- price_set -> tax_price_set
    SELECT 
        "index_" AS "row_id",
        "order_line_id",
        "price" AS "tax_amount",
        "rate" AS "tax_rate",
        "title" AS "tax_type",
        "price_set" AS "tax_price_set"
    FROM "shopify_tax_line_data_projected"
),

"shopify_tax_line_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- order_line_id: from INT to VARCHAR
    -- tax_price_set: from VARCHAR to JSON
    SELECT
        "row_id",
        "tax_amount",
        "tax_rate",
        "tax_type",
        CAST("order_line_id" AS VARCHAR) AS "order_line_id",
        CAST("tax_price_set" AS JSON) AS "tax_price_set"
    FROM "shopify_tax_line_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_tax_line_data_projected_renamed_casted"