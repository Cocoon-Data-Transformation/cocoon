-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_fulfillment_event_data_projected" AS (
    -- Projection: Selecting 18 out of 19 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "address_1",
        "city",
        "country",
        "created_at",
        "estimated_delivery_at",
        "fulfillment_id",
        "happened_at",
        "latitude",
        "longitude",
        "message",
        "order_id",
        "province",
        "shop_id",
        "status",
        "updated_at",
        "zip",
        "_fivetran_deleted"
    FROM "shopify_fulfillment_event_data"
),

"shopify_fulfillment_event_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- address_1 -> shipping_address_line1
    -- city -> shipping_city
    -- country -> shipping_country_code
    -- created_at -> event_created_at
    -- happened_at -> event_occurred_at
    -- latitude -> shipping_latitude
    -- longitude -> shipping_longitude
    -- message -> event_message
    -- province -> shipping_province
    -- status -> fulfillment_status
    -- updated_at -> event_updated_at
    -- zip -> shipping_zip_code
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "id" AS "event_id",
        "address_1" AS "shipping_address_line1",
        "city" AS "shipping_city",
        "country" AS "shipping_country_code",
        "created_at" AS "event_created_at",
        "estimated_delivery_at",
        "fulfillment_id",
        "happened_at" AS "event_occurred_at",
        "latitude" AS "shipping_latitude",
        "longitude" AS "shipping_longitude",
        "message" AS "event_message",
        "order_id",
        "province" AS "shipping_province",
        "shop_id",
        "status" AS "fulfillment_status",
        "updated_at" AS "event_updated_at",
        "zip" AS "shipping_zip_code",
        "_fivetran_deleted" AS "is_deleted"
    FROM "shopify_fulfillment_event_data_projected"
),

"shopify_fulfillment_event_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- shipping_city: The problem is inconsistency in city naming conventions and potentially incorrect data. 'LA' is an abbreviation for 'Los Angeles' and should be written in full to match the format of other cities. 'LAZYTOWN' appears to be a fictional place and is likely an error or placeholder. The correct values should be full city names, consistent with the format used for 'LONDON' and 'ECHO PARK'. 
    -- shipping_zip_code: The problem is that the zip code '2759' is missing a leading zero, which is required for standard 5-digit US zip codes. 'CR0' is not a valid US zip code format at all, suggesting it might be an international postal code or an error. The correct values for US zip codes should be 5-digit numbers, starting with a leading zero for codes less than 10000. 
    SELECT
        "event_id",
        "shipping_address_line1",
        CASE
            WHEN "shipping_city" = 'LA' THEN 'LOS ANGELES'
            WHEN "shipping_city" = 'LAZYTOWN' THEN ''
            ELSE "shipping_city"
        END AS "shipping_city",
        "shipping_country_code",
        "event_created_at",
        "estimated_delivery_at",
        "fulfillment_id",
        "event_occurred_at",
        "shipping_latitude",
        "shipping_longitude",
        "event_message",
        "order_id",
        "shipping_province",
        "shop_id",
        "fulfillment_status",
        "event_updated_at",
        CASE
            WHEN "shipping_zip_code" = '2759' THEN '02759'
            WHEN "shipping_zip_code" = 'CR0' THEN ''
            ELSE "shipping_zip_code"
        END AS "shipping_zip_code",
        "is_deleted"
    FROM "shopify_fulfillment_event_data_projected_renamed"
),

"shopify_fulfillment_event_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- shipping_city: ['']
    -- shipping_zip_code: ['']
    SELECT 
        CASE
            WHEN "shipping_city" = '' THEN NULL
            ELSE "shipping_city"
        END AS "shipping_city",
        CASE
            WHEN "shipping_zip_code" = '' THEN NULL
            ELSE "shipping_zip_code"
        END AS "shipping_zip_code",
        "estimated_delivery_at",
        "event_occurred_at",
        "shipping_address_line1",
        "event_id",
        "shipping_latitude",
        "shipping_longitude",
        "event_message",
        "shipping_province",
        "order_id",
        "shop_id",
        "event_created_at",
        "fulfillment_id",
        "fulfillment_status",
        "is_deleted",
        "event_updated_at",
        "shipping_country_code"
    FROM "shopify_fulfillment_event_data_projected_renamed_cleaned"
),

"shopify_fulfillment_event_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- estimated_delivery_at: from VARCHAR to TIMESTAMP
    -- event_created_at: from VARCHAR to TIMESTAMP
    -- event_id: from INT to VARCHAR
    -- event_occurred_at: from VARCHAR to TIMESTAMP
    -- event_updated_at: from VARCHAR to TIMESTAMP
    -- fulfillment_id: from INT to VARCHAR
    -- order_id: from INT to VARCHAR
    -- shipping_address_line1: from DECIMAL to VARCHAR
    -- shop_id: from INT to VARCHAR
    SELECT
        "shipping_city",
        "shipping_zip_code",
        "shipping_latitude",
        "shipping_longitude",
        "event_message",
        "shipping_province",
        "fulfillment_status",
        "is_deleted",
        "shipping_country_code",
        CAST("estimated_delivery_at" AS TIMESTAMP) AS "estimated_delivery_at",
        CAST("event_created_at" AS TIMESTAMP) AS "event_created_at",
        CAST("event_id" AS VARCHAR) AS "event_id",
        CAST("event_occurred_at" AS TIMESTAMP) AS "event_occurred_at",
        CAST("event_updated_at" AS TIMESTAMP) AS "event_updated_at",
        CAST("fulfillment_id" AS VARCHAR) AS "fulfillment_id",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("shipping_address_line1" AS VARCHAR) AS "shipping_address_line1",
        CAST("shop_id" AS VARCHAR) AS "shop_id"
    FROM "shopify_fulfillment_event_data_projected_renamed_cleaned_null"
),

"shopify_fulfillment_event_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 8 columns with unacceptable missing values
    -- event_message has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- shipping_address_line1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_city has 40.0 percent missing. Strategy: 🔄 Unchanged
    -- shipping_country_code has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- shipping_latitude has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- shipping_longitude has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- shipping_province has 60.0 percent missing. Strategy: 🔄 Unchanged
    -- shipping_zip_code has 40.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "shipping_city",
        "shipping_zip_code",
        "shipping_latitude",
        "shipping_longitude",
        "event_message",
        "shipping_province",
        "fulfillment_status",
        "is_deleted",
        "shipping_country_code",
        "estimated_delivery_at",
        "event_created_at",
        "event_id",
        "event_occurred_at",
        "event_updated_at",
        "fulfillment_id",
        "order_id",
        "shop_id"
    FROM "shopify_fulfillment_event_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_fulfillment_event_data_projected_renamed_cleaned_null_casted_missing_handled"