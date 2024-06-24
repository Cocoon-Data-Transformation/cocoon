-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"product_ad_history_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
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
    FROM "product_ad_history_data"
),

"product_ad_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> product_ad_id
    -- last_updated_date -> last_updated_datetime
    -- asin -> product_asin
    -- creation_date -> ad_creation_datetime
    -- serving_status -> ad_serving_status
    -- sku -> product_sku
    -- state -> ad_state
    SELECT 
        id AS product_ad_id,
        last_updated_date AS last_updated_datetime,
        ad_group_id,
        asin AS product_asin,
        campaign_id,
        creation_date AS ad_creation_datetime,
        serving_status AS ad_serving_status,
        sku AS product_sku,
        state AS ad_state
    FROM product_ad_history_data_projected
),

"product_ad_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- ad_creation_datetime: from VARCHAR to TIMESTAMP
    -- last_updated_datetime: from VARCHAR to TIMESTAMP
    -- product_sku: from DECIMAL to VARCHAR
    SELECT
        "product_ad_id",
        "ad_group_id",
        "product_asin",
        "campaign_id",
        "ad_serving_status",
        "ad_state",
        CAST("ad_creation_datetime" AS TIMESTAMP) AS "ad_creation_datetime",
        CAST("last_updated_datetime" AS TIMESTAMP) AS "last_updated_datetime",
        CAST("product_sku" AS VARCHAR) AS "product_sku"
    FROM "product_ad_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "product_ad_history_data_projected_renamed_casted"