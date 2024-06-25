-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_abandoned_checkout_shipping_line_data_projected" AS (
    -- Projection: Selecting 23 out of 24 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "checkout_id",
        "index_",
        "api_client_id",
        "carrier_identifier",
        "carrier_service_id",
        "code",
        "delivery_category",
        "discounted_price",
        "id",
        "markup",
        "phone",
        "price",
        "requested_fulfillment_service_id",
        "source",
        "title",
        "validation_context",
        "delivery_expectation_range",
        "delivery_expectation_type",
        "original_shop_markup",
        "original_shop_price",
        "presentment_title",
        "delivery_expectation_range_min",
        "delivery_expectation_range_max"
    FROM "shopify_abandoned_checkout_shipping_line_data"
),

"shopify_abandoned_checkout_shipping_line_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> shipping_option_order
    -- code -> shipping_method_code
    -- id -> shipping_line_id
    -- markup -> shipping_markup
    -- phone -> shipping_phone
    -- price -> shipping_price
    -- requested_fulfillment_service_id -> fulfillment_service_id
    -- source -> shipping_option_source
    -- title -> shipping_option_title
    -- presentment_title -> display_title
    -- delivery_expectation_range_min -> min_delivery_days
    -- delivery_expectation_range_max -> max_delivery_days
    SELECT 
        "checkout_id",
        "index_" AS "shipping_option_order",
        "api_client_id",
        "carrier_identifier",
        "carrier_service_id",
        "code" AS "shipping_method_code",
        "delivery_category",
        "discounted_price",
        "id" AS "shipping_line_id",
        "markup" AS "shipping_markup",
        "phone" AS "shipping_phone",
        "price" AS "shipping_price",
        "requested_fulfillment_service_id" AS "fulfillment_service_id",
        "source" AS "shipping_option_source",
        "title" AS "shipping_option_title",
        "validation_context",
        "delivery_expectation_range",
        "delivery_expectation_type",
        "original_shop_markup",
        "original_shop_price",
        "presentment_title" AS "display_title",
        "delivery_expectation_range_min" AS "min_delivery_days",
        "delivery_expectation_range_max" AS "max_delivery_days"
    FROM "shopify_abandoned_checkout_shipping_line_data_projected"
),

"shopify_abandoned_checkout_shipping_line_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- api_client_id: from DECIMAL to VARCHAR
    -- carrier_identifier: from DECIMAL to VARCHAR
    -- carrier_service_id: from DECIMAL to VARCHAR
    -- checkout_id: from INT to VARCHAR
    -- delivery_category: from DECIMAL to VARCHAR
    -- delivery_expectation_range: from DECIMAL to VARCHAR
    -- delivery_expectation_type: from DECIMAL to VARCHAR
    -- discounted_price: from DECIMAL to VARCHAR
    -- fulfillment_service_id: from DECIMAL to VARCHAR
    -- max_delivery_days: from DECIMAL to VARCHAR
    -- min_delivery_days: from DECIMAL to VARCHAR
    -- shipping_phone: from DECIMAL to VARCHAR
    -- validation_context: from DECIMAL to VARCHAR
    SELECT
        "shipping_option_order",
        "shipping_method_code",
        "shipping_line_id",
        "shipping_markup",
        "shipping_price",
        "shipping_option_source",
        "shipping_option_title",
        "original_shop_markup",
        "original_shop_price",
        "display_title",
        CAST("api_client_id" AS VARCHAR) AS "api_client_id",
        CAST("carrier_identifier" AS VARCHAR) AS "carrier_identifier",
        CAST("carrier_service_id" AS VARCHAR) AS "carrier_service_id",
        CAST("checkout_id" AS VARCHAR) AS "checkout_id",
        CAST("delivery_category" AS VARCHAR) AS "delivery_category",
        CAST("delivery_expectation_range" AS VARCHAR) AS "delivery_expectation_range",
        CAST("delivery_expectation_type" AS VARCHAR) AS "delivery_expectation_type",
        CAST("discounted_price" AS VARCHAR) AS "discounted_price",
        CAST("fulfillment_service_id" AS VARCHAR) AS "fulfillment_service_id",
        CAST("max_delivery_days" AS VARCHAR) AS "max_delivery_days",
        CAST("min_delivery_days" AS VARCHAR) AS "min_delivery_days",
        CAST("shipping_phone" AS VARCHAR) AS "shipping_phone",
        CAST("validation_context" AS VARCHAR) AS "validation_context"
    FROM "shopify_abandoned_checkout_shipping_line_data_projected_renamed"
),

"shopify_abandoned_checkout_shipping_line_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- validation_context has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "shipping_option_order",
        "shipping_method_code",
        "shipping_line_id",
        "shipping_markup",
        "shipping_price",
        "shipping_option_source",
        "shipping_option_title",
        "original_shop_markup",
        "original_shop_price",
        "display_title",
        "api_client_id",
        "carrier_identifier",
        "carrier_service_id",
        "checkout_id",
        "delivery_category",
        "delivery_expectation_range",
        "delivery_expectation_type",
        "discounted_price",
        "fulfillment_service_id",
        "max_delivery_days",
        "min_delivery_days",
        "shipping_phone"
    FROM "shopify_abandoned_checkout_shipping_line_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_abandoned_checkout_shipping_line_data_projected_renamed_casted_missing_handled"