-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_line_data_projected" AS (
    -- Projection: Selecting 20 out of 21 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "order_id",
        "id",
        "product_id",
        "variant_id",
        "name",
        "title",
        "vendor",
        "price",
        "quantity",
        "grams",
        "sku",
        "fulfillable_quantity",
        "fulfillment_service",
        "gift_card",
        "requires_shipping",
        "taxable",
        "index_",
        "total_discount",
        "pre_tax_price",
        "fulfillment_status"
    FROM "shopify_order_line_data"
),

"shopify_order_line_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> line_item_id
    -- name -> product_name
    -- title -> product_title
    -- vendor -> vendor_id
    -- price -> item_price
    -- grams -> weight_grams
    -- gift_card -> is_gift_card
    -- taxable -> is_taxable
    -- index_ -> item_position
    SELECT 
        "order_id",
        "id" AS "line_item_id",
        "product_id",
        "variant_id",
        "name" AS "product_name",
        "title" AS "product_title",
        "vendor" AS "vendor_id",
        "price" AS "item_price",
        "quantity",
        "grams" AS "weight_grams",
        "sku",
        "fulfillable_quantity",
        "fulfillment_service",
        "gift_card" AS "is_gift_card",
        "requires_shipping",
        "taxable" AS "is_taxable",
        "index_" AS "item_position",
        "total_discount",
        "pre_tax_price",
        "fulfillment_status"
    FROM "shopify_order_line_data_projected"
),

"shopify_order_line_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- line_item_id: from INT to VARCHAR
    -- order_id: from INT to VARCHAR
    -- pre_tax_price: from DECIMAL to VARCHAR
    -- product_id: from INT to VARCHAR
    -- total_discount: from INT to DECIMAL
    -- variant_id: from INT to VARCHAR
    SELECT
        "product_name",
        "product_title",
        "vendor_id",
        "item_price",
        "quantity",
        "weight_grams",
        "sku",
        "fulfillable_quantity",
        "fulfillment_service",
        "is_gift_card",
        "requires_shipping",
        "is_taxable",
        "item_position",
        "fulfillment_status",
        CAST("line_item_id" AS VARCHAR) AS "line_item_id",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("pre_tax_price" AS VARCHAR) AS "pre_tax_price",
        CAST("product_id" AS VARCHAR) AS "product_id",
        CAST("total_discount" AS DECIMAL) AS "total_discount",
        CAST("variant_id" AS VARCHAR) AS "variant_id"
    FROM "shopify_order_line_data_projected_renamed"
),

"shopify_order_line_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- pre_tax_price has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "product_name",
        "product_title",
        "vendor_id",
        "item_price",
        "quantity",
        "weight_grams",
        "sku",
        "fulfillable_quantity",
        "fulfillment_service",
        "is_gift_card",
        "requires_shipping",
        "is_taxable",
        "item_position",
        "fulfillment_status",
        "line_item_id",
        "order_id",
        "product_id",
        "total_discount",
        "variant_id"
    FROM "shopify_order_line_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_line_data_projected_renamed_casted_missing_handled"