-- Slowly Changing Dimension: Dimension keys are "product_id"
-- Effective date columns are "updated_at"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "product_title",
    "product_handle",
    "product_type",
    "vendor_id",
    "visibility_scope",
    "is_deleted",
    "created_at",
    "product_id",
    "published_at"
FROM (
     SELECT 
            "product_title",
            "product_handle",
            "product_type",
            "vendor_id",
            "visibility_scope",
            "is_deleted",
            "created_at",
            "product_id",
            "published_at",
            ROW_NUMBER() OVER (
                PARTITION BY "product_id" 
                ORDER BY "updated_at" 
            DESC) AS "cocoon_rn"
    FROM "stg_shopify_product_data"
) ranked
WHERE "cocoon_rn" = 1