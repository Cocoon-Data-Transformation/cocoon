-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:36:19.223629+00:00
WITH 
"product_ad_history_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['id', 'last_updated_date', '_fivetran_synced', 'ad_group_id', 'asin', 'campaign_id', 'creation_date', 'serving_status', 'sku', 'state']
    SELECT 
        "id",
        "last_updated_date",
        "ad_group_id",
        "asin",
        "campaign_id",
        "creation_date",
        "serving_status",
        "sku",
        "state"
    FROM "memory"."main"."product_ad_history_data"
),

"product_ad_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ad_id
    -- asin -> product_asin
    -- serving_status -> ad_serving_status
    -- sku -> product_sku
    -- state -> ad_state
    SELECT 
        "id" AS "ad_id",
        "last_updated_date",
        "ad_group_id",
        "asin" AS "product_asin",
        "campaign_id",
        "creation_date",
        "serving_status" AS "ad_serving_status",
        "sku" AS "product_sku",
        "state" AS "ad_state"
    FROM "product_ad_history_data_projected"
),

"product_ad_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to TIMESTAMP
    -- last_updated_date: from VARCHAR to TIMESTAMP
    -- product_sku: from DECIMAL to VARCHAR
    SELECT
        "ad_id",
        "ad_group_id",
        "product_asin",
        "campaign_id",
        "ad_serving_status",
        "ad_state",
        CAST("creation_date" AS TIMESTAMP) 
        AS "creation_date",
        CAST("last_updated_date" AS TIMESTAMP) 
        AS "last_updated_date",
        CAST("product_sku" AS VARCHAR) 
        AS "product_sku"
    FROM "product_ad_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "product_ad_history_data_projected_renamed_casted"