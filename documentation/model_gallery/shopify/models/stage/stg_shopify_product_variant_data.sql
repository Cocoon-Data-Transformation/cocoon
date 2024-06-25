-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_product_variant_data_projected" AS (
    -- Projection: Selecting 26 out of 27 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "product_id",
        "inventory_item_id",
        "title",
        "price",
        "sku",
        "position_",
        "inventory_policy",
        "compare_at_price",
        "fulfillment_service",
        "inventory_management",
        "created_at",
        "updated_at",
        "taxable",
        "barcode",
        "grams",
        "image_id",
        "inventory_quantity",
        "weight",
        "weight_unit",
        "old_inventory_quantity",
        "requires_shipping",
        "option_2",
        "tax_code",
        "option_3",
        "option_1"
    FROM "shopify_product_variant_data"
),

"shopify_product_variant_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> variant_id
    -- position_ -> display_position
    -- compare_at_price -> original_price
    -- taxable -> is_taxable
    -- grams -> weight_grams
    -- inventory_quantity -> stock_quantity
    -- old_inventory_quantity -> previous_stock_quantity
    SELECT 
        "id" AS "variant_id",
        "product_id",
        "inventory_item_id",
        "title",
        "price",
        "sku",
        "position_" AS "display_position",
        "inventory_policy",
        "compare_at_price" AS "original_price",
        "fulfillment_service",
        "inventory_management",
        "created_at",
        "updated_at",
        "taxable" AS "is_taxable",
        "barcode",
        "grams" AS "weight_grams",
        "image_id",
        "inventory_quantity" AS "stock_quantity",
        "weight",
        "weight_unit",
        "old_inventory_quantity" AS "previous_stock_quantity",
        "requires_shipping",
        "option_2",
        "tax_code",
        "option_3",
        "option_1"
    FROM "shopify_product_variant_data_projected"
),

"shopify_product_variant_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- barcode: from DECIMAL to VARCHAR
    -- created_at: from VARCHAR to TIMESTAMP
    -- image_id: from DECIMAL to VARCHAR
    -- inventory_item_id: from INT to VARCHAR
    -- option_2: from DECIMAL to VARCHAR
    -- option_3: from DECIMAL to VARCHAR
    -- original_price: from DECIMAL to VARCHAR
    -- price: from INT to VARCHAR
    -- product_id: from INT to VARCHAR
    -- sku: from DECIMAL to VARCHAR
    -- updated_at: from VARCHAR to TIMESTAMP
    -- variant_id: from INT to VARCHAR
    -- weight: from INT to DECIMAL
    SELECT
        "title",
        "display_position",
        "inventory_policy",
        "fulfillment_service",
        "inventory_management",
        "is_taxable",
        "weight_grams",
        "stock_quantity",
        "weight_unit",
        "previous_stock_quantity",
        "requires_shipping",
        "tax_code",
        "option_1",
        CAST("barcode" AS VARCHAR) AS "barcode",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("image_id" AS VARCHAR) AS "image_id",
        CAST("inventory_item_id" AS VARCHAR) AS "inventory_item_id",
        CAST("option_2" AS VARCHAR) AS "option_2",
        CAST("option_3" AS VARCHAR) AS "option_3",
        CAST("original_price" AS VARCHAR) AS "original_price",
        CAST("price" AS VARCHAR) AS "price",
        CAST("product_id" AS VARCHAR) AS "product_id",
        CAST("sku" AS VARCHAR) AS "sku",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at",
        CAST("variant_id" AS VARCHAR) AS "variant_id",
        CAST("weight" AS DECIMAL) AS "weight"
    FROM "shopify_product_variant_data_projected_renamed"
),

"shopify_product_variant_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 7 columns with unacceptable missing values
    -- barcode has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inventory_management has 60.0 percent missing. Strategy: 🔄 Unchanged
    -- option_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- option_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_price has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sku has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_code has 80.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "title",
        "display_position",
        "inventory_policy",
        "fulfillment_service",
        "inventory_management",
        "is_taxable",
        "weight_grams",
        "stock_quantity",
        "weight_unit",
        "previous_stock_quantity",
        "requires_shipping",
        "tax_code",
        "option_1",
        "created_at",
        "image_id",
        "inventory_item_id",
        "price",
        "product_id",
        "updated_at",
        "variant_id",
        "weight"
    FROM "shopify_product_variant_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_product_variant_data_projected_renamed_casted_missing_handled"