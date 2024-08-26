-- Slowly Changing Dimension: Dimension keys are "ad_id"
-- Version columns are last_updated_date, ad_serving_status, ad_state
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "ad_id",
    "ad_group_id",
    "product_asin",
    "campaign_id",
    "creation_date",
    "product_sku"
FROM "stg_product_ad_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "ad_id"
    ORDER BY
        last_updated_date DESC,
        CASE 
            WHEN ad_serving_status = 'AD_STATUS_LIVE' THEN 1
            WHEN ad_serving_status = 'CAMPAIGN_PAUSED' THEN 2
            WHEN ad_serving_status = 'AD_STATUS_PAUSED' THEN 3
            ELSE 4
        END,
        CASE 
            WHEN ad_state = 'enabled' THEN 1
            WHEN ad_state = 'disabled' THEN 2
            ELSE 3
        END
) = 1