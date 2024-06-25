-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_line_refund_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "location_id",
        "refund_id",
        "restock_type",
        "quantity",
        "order_line_id",
        "subtotal",
        "total_tax_set",
        "subtotal_set",
        "total_tax"
    FROM "shopify_order_line_refund_data"
),

"shopify_order_line_refund_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> refund_line_item_id
    -- location_id -> store_location_id
    -- quantity -> refunded_quantity
    -- order_line_id -> original_order_line_id
    -- subtotal -> refund_subtotal
    -- total_tax_set -> tax_amount_set
    -- total_tax -> refund_tax_amount
    SELECT 
        "id" AS "refund_line_item_id",
        "location_id" AS "store_location_id",
        "refund_id",
        "restock_type",
        "quantity" AS "refunded_quantity",
        "order_line_id" AS "original_order_line_id",
        "subtotal" AS "refund_subtotal",
        "total_tax_set" AS "tax_amount_set",
        "subtotal_set",
        "total_tax" AS "refund_tax_amount"
    FROM "shopify_order_line_refund_data_projected"
),

"shopify_order_line_refund_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- original_order_line_id: from INT to VARCHAR
    -- refund_id: from INT to VARCHAR
    -- refund_line_item_id: from INT to VARCHAR
    -- refund_subtotal: from INT to DECIMAL
    -- subtotal_set: from DECIMAL to VARCHAR
    -- tax_amount_set: from DECIMAL to VARCHAR
    SELECT
        "store_location_id",
        "restock_type",
        "refunded_quantity",
        "refund_tax_amount",
        CAST("original_order_line_id" AS VARCHAR) AS "original_order_line_id",
        CAST("refund_id" AS VARCHAR) AS "refund_id",
        CAST("refund_line_item_id" AS VARCHAR) AS "refund_line_item_id",
        CAST("refund_subtotal" AS DECIMAL) AS "refund_subtotal",
        CAST("subtotal_set" AS VARCHAR) AS "subtotal_set",
        CAST("tax_amount_set" AS VARCHAR) AS "tax_amount_set"
    FROM "shopify_order_line_refund_data_projected_renamed"
),

"shopify_order_line_refund_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- subtotal_set has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_amount_set has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "store_location_id",
        "restock_type",
        "refunded_quantity",
        "refund_tax_amount",
        "original_order_line_id",
        "refund_id",
        "refund_line_item_id",
        "refund_subtotal"
    FROM "shopify_order_line_refund_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_line_refund_data_projected_renamed_casted_missing_handled"