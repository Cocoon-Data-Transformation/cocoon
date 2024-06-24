-- Slowly Changing Dimension: Dimension keys are "product_ad_id"
-- Effective date columns are "last_updated_datetime"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "product_ad_id",
    "ad_group_id",
    "product_asin",
    "campaign_id",
    "ad_serving_status",
    "ad_state",
    "ad_creation_datetime",
    "product_sku"
FROM (
     SELECT 
            "product_ad_id",
            "ad_group_id",
            "product_asin",
            "campaign_id",
            "ad_serving_status",
            "ad_state",
            "ad_creation_datetime",
            "product_sku",
            ROW_NUMBER() OVER (
                PARTITION BY "product_ad_id" 
                ORDER BY "last_updated_datetime" 
            DESC) AS "cocoon_rn"
    FROM "stg_product_ad_history_data"
) ranked
WHERE "cocoon_rn" = 1