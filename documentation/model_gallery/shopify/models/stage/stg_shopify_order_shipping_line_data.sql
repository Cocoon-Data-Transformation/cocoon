-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_shipping_line_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "order_id",
        "carrier_identifier",
        "code",
        "delivery_category",
        "discounted_price",
        "phone",
        "price",
        "requested_fulfillment_service_id",
        "source",
        "title",
        "discounted_price_set",
        "price_set"
    FROM "shopify_order_shipping_line_data"
),

"shopify_order_shipping_line_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> shipping_line_id
    -- carrier_identifier -> carrier_id
    -- code -> shipping_code
    -- delivery_category -> delivery_type
    -- discounted_price -> discounted_price_numeric
    -- phone -> shipping_phone
    -- price -> price_numeric
    -- requested_fulfillment_service_id -> fulfillment_service_id
    -- source -> shipping_source
    -- title -> shipping_method_title
    -- discounted_price_set -> discounted_price_details
    -- price_set -> price_details
    SELECT 
        "id" AS "shipping_line_id",
        "order_id",
        "carrier_identifier" AS "carrier_id",
        "code" AS "shipping_code",
        "delivery_category" AS "delivery_type",
        "discounted_price" AS "discounted_price_numeric",
        "phone" AS "shipping_phone",
        "price" AS "price_numeric",
        "requested_fulfillment_service_id" AS "fulfillment_service_id",
        "source" AS "shipping_source",
        "title" AS "shipping_method_title",
        "discounted_price_set" AS "discounted_price_details",
        "price_set" AS "price_details"
    FROM "shopify_order_shipping_line_data_projected"
),

"shopify_order_shipping_line_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- carrier_id: from DECIMAL to VARCHAR
    -- delivery_type: from DECIMAL to VARCHAR
    -- discounted_price_details: from VARCHAR to JSON
    -- fulfillment_service_id: from DECIMAL to VARCHAR
    -- price_details: from VARCHAR to JSON
    -- shipping_phone: from DECIMAL to VARCHAR
    SELECT
        "shipping_line_id",
        "order_id",
        "shipping_code",
        "discounted_price_numeric",
        "price_numeric",
        "shipping_source",
        "shipping_method_title",
        CAST("carrier_id" AS VARCHAR) AS "carrier_id",
        CAST("delivery_type" AS VARCHAR) AS "delivery_type",
        CAST("discounted_price_details" AS JSON) AS "discounted_price_details",
        CAST("fulfillment_service_id" AS VARCHAR) AS "fulfillment_service_id",
        CAST("price_details" AS JSON) AS "price_details",
        CAST("shipping_phone" AS VARCHAR) AS "shipping_phone"
    FROM "shopify_order_shipping_line_data_projected_renamed"
),

"shopify_order_shipping_line_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- delivery_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fulfillment_service_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "shipping_line_id",
        "order_id",
        "shipping_code",
        "discounted_price_numeric",
        "price_numeric",
        "shipping_source",
        "shipping_method_title",
        "carrier_id",
        "discounted_price_details",
        "price_details"
    FROM "shopify_order_shipping_line_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_shipping_line_data_projected_renamed_casted_missing_handled"