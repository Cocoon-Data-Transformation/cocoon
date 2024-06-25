-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_shipping_tax_line_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "index_",
        "order_shipping_line_id",
        "price",
        "rate",
        "title",
        "price_set"
    FROM "shopify_order_shipping_tax_line_data"
),

"shopify_order_shipping_tax_line_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> row_index
    -- price -> shipping_tax_amount
    -- rate -> shipping_tax_rate
    -- title -> tax_name
    -- price_set -> tax_amount_currencies
    SELECT 
        "index_" AS "row_index",
        "order_shipping_line_id",
        "price" AS "shipping_tax_amount",
        "rate" AS "shipping_tax_rate",
        "title" AS "tax_name",
        "price_set" AS "tax_amount_currencies"
    FROM "shopify_order_shipping_tax_line_data_projected"
),

"shopify_order_shipping_tax_line_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- tax_name: The problem is that 'BANANAN' is a misspelling of 'BANANA', and 'GEIWIHG' is an unrecognizable term that doesn't appear to be a valid fruit or vegetable name. The correct values should be common fruit or vegetable names. 'TOMATO' is already correct and doesn't need to be changed. 
    SELECT
        "row_index",
        "order_shipping_line_id",
        "shipping_tax_amount",
        "shipping_tax_rate",
        CASE
            WHEN "tax_name" = 'BANANAN' THEN 'BANANA'
            WHEN "tax_name" = 'GEIWIHG' THEN ''
            ELSE "tax_name"
        END AS "tax_name",
        "tax_amount_currencies"
    FROM "shopify_order_shipping_tax_line_data_projected_renamed"
),

"shopify_order_shipping_tax_line_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- tax_name: ['']
    SELECT 
        CASE
            WHEN "tax_name" = '' THEN NULL
            ELSE "tax_name"
        END AS "tax_name",
        "order_shipping_line_id",
        "row_index",
        "tax_amount_currencies",
        "shipping_tax_amount",
        "shipping_tax_rate"
    FROM "shopify_order_shipping_tax_line_data_projected_renamed_cleaned"
),

"shopify_order_shipping_tax_line_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- order_shipping_line_id: from INT to VARCHAR
    -- tax_amount_currencies: from VARCHAR to JSON
    SELECT
        "tax_name",
        "row_index",
        "shipping_tax_amount",
        "shipping_tax_rate",
        CAST("order_shipping_line_id" AS VARCHAR) AS "order_shipping_line_id",
        CAST("tax_amount_currencies" AS JSON) AS "tax_amount_currencies"
    FROM "shopify_order_shipping_tax_line_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_shipping_tax_line_data_projected_renamed_cleaned_null_casted"