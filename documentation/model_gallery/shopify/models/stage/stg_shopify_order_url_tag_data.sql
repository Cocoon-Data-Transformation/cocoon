-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_url_tag_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "key_",
        "order_id",
        "value_"
    FROM "shopify_order_url_tag_data"
),

"shopify_order_url_tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- key_ -> metadata_key
    -- value_ -> metadata_value
    SELECT 
        "key_" AS "metadata_key",
        "order_id",
        "value_" AS "metadata_value"
    FROM "shopify_order_url_tag_data_projected"
),

"shopify_order_url_tag_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- order_id: from INT to VARCHAR
    SELECT
        "metadata_key",
        "metadata_value",
        CAST("order_id" AS VARCHAR) AS "order_id"
    FROM "shopify_order_url_tag_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_url_tag_data_projected_renamed_casted"