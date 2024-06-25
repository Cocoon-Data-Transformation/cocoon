-- Slowly Changing Dimension: Dimension keys are "variant_id"
-- Effective date columns are "updated_at"
-- We will create Type 1 SCD (latest snapshot)
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
    "variant_id",
    "weight"
FROM (
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
            "variant_id",
            "weight",
            ROW_NUMBER() OVER (
                PARTITION BY "variant_id" 
                ORDER BY "updated_at" 
            DESC) AS "cocoon_rn"
    FROM "stg_shopify_product_variant_data"
) ranked
WHERE "cocoon_rn" = 1