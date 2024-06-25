-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_abandoned_checkout_data_removeWideColumns" AS (
    -- Remove wide columns with pattern. The regex and columns are:
    -- ^shipping_address_.*$: shipping_address_address_0, shipping_address_address_1, shipping_address_city, shipping_address_company, shipping_address_country, shipping_address_country_code, shipping_address_first_name, shipping_address_id, shipping_address_is_default, shipping_address_last_name ...
    -- ^shipping_rate_.*$: shipping_rate_id, shipping_rate_price, shipping_rate_title
    -- ^note_attribute_.*$: note_attribute_email_client_id, note_attribute_google_client_id, note_attribute_littledata_updated_at, note_attribute_segment_client_id
    -- ^total_.*$: total_discounts, total_duties, total_line_items_price, total_price, total_tax, total_weight
    SELECT 
        "_fivetran_deleted",
        "_fivetran_synced",
        "abandoned_checkout_url",
        "applied_discount_amount",
        "applied_discount_applicable",
        "applied_discount_description",
        "applied_discount_non_applicable_reason",
        "applied_discount_title",
        "applied_discount_value",
        "applied_discount_value_type",
        "billing_address_address_0",
        "billing_address_address_1",
        "billing_address_city",
        "billing_address_company",
        "billing_address_country",
        "billing_address_country_code",
        "billing_address_first_name",
        "billing_address_id",
        "billing_address_is_default",
        "billing_address_last_name",
        "billing_address_latitude",
        "billing_address_longitude",
        "billing_address_name",
        "billing_address_phone",
        "billing_address_province",
        "billing_address_province_code",
        "billing_address_zip",
        "buyer_accepts_marketing",
        "cart_token",
        "closed_at",
        "completed_at",
        "created_at",
        "credit_card_first_name",
        "credit_card_last_name",
        "credit_card_month",
        "credit_card_number",
        "credit_card_verification_value",
        "credit_card_year",
        "currency",
        "customer_id",
        "customer_locale",
        "device_id",
        "email",
        "gateway",
        "id",
        "landing_site_base_url",
        "location_id",
        "name",
        "note",
        "note_attributes",
        "phone",
        "presentment_currency",
        "referring_site",
        "shipping_line",
        "source",
        "source_identifier",
        "source_name",
        "source_url",
        "subtotal_price",
        "taxes_included",
        "token",
        "updated_at",
        "user_id"
    FROM "shopify_abandoned_checkout_data"
),

"shopify_abandoned_checkout_data_removeWideColumns_projected" AS (
    -- Projection: Selecting 62 out of 63 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_deleted",
        "abandoned_checkout_url",
        "applied_discount_amount",
        "applied_discount_applicable",
        "applied_discount_description",
        "applied_discount_non_applicable_reason",
        "applied_discount_title",
        "applied_discount_value",
        "applied_discount_value_type",
        "billing_address_address_0",
        "billing_address_address_1",
        "billing_address_city",
        "billing_address_company",
        "billing_address_country",
        "billing_address_country_code",
        "billing_address_first_name",
        "billing_address_id",
        "billing_address_is_default",
        "billing_address_last_name",
        "billing_address_latitude",
        "billing_address_longitude",
        "billing_address_name",
        "billing_address_phone",
        "billing_address_province",
        "billing_address_province_code",
        "billing_address_zip",
        "buyer_accepts_marketing",
        "cart_token",
        "closed_at",
        "completed_at",
        "created_at",
        "credit_card_first_name",
        "credit_card_last_name",
        "credit_card_month",
        "credit_card_number",
        "credit_card_verification_value",
        "credit_card_year",
        "currency",
        "customer_id",
        "customer_locale",
        "device_id",
        "email",
        "gateway",
        "id",
        "landing_site_base_url",
        "location_id",
        "name",
        "note",
        "note_attributes",
        "phone",
        "presentment_currency",
        "referring_site",
        "shipping_line",
        "source",
        "source_identifier",
        "source_name",
        "source_url",
        "subtotal_price",
        "taxes_included",
        "token",
        "updated_at",
        "user_id"
    FROM "shopify_abandoned_checkout_data_removeWideColumns"
),

"shopify_abandoned_checkout_data_removeWideColumns_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- abandoned_checkout_url -> recovery_url
    -- applied_discount_amount -> discount_amount
    -- applied_discount_applicable -> is_discount_applicable
    -- applied_discount_description -> discount_description
    -- applied_discount_non_applicable_reason -> discount_non_applicable_reason
    -- applied_discount_title -> discount_title
    -- applied_discount_value -> discount_value
    -- applied_discount_value_type -> discount_value_type
    -- billing_address_address_0 -> billing_address_line1
    -- billing_address_address_1 -> billing_address_line2
    -- billing_address_city -> billing_city
    -- billing_address_company -> billing_company
    -- billing_address_country -> billing_country
    -- billing_address_country_code -> billing_country_code
    -- billing_address_first_name -> billing_first_name
    -- billing_address_is_default -> is_default_billing_address
    -- billing_address_last_name -> billing_last_name
    -- billing_address_latitude -> billing_latitude
    -- billing_address_longitude -> billing_longitude
    -- billing_address_name -> billing_full_name
    -- billing_address_phone -> billing_phone
    -- billing_address_province -> billing_province
    -- billing_address_province_code -> billing_province_code
    -- billing_address_zip -> billing_zip
    -- buyer_accepts_marketing -> accepts_marketing
    -- created_at -> abandoned_at
    -- credit_card_first_name -> cc_first_name
    -- credit_card_last_name -> cc_last_name
    -- credit_card_month -> cc_exp_month
    -- credit_card_number -> cc_number
    -- credit_card_verification_value -> cc_cvv
    -- credit_card_year -> cc_exp_year
    -- gateway -> payment_gateway
    -- id -> checkout_id
    -- landing_site_base_url -> landing_page_url
    -- name -> order_number
    -- note -> order_notes
    -- note_attributes -> custom_attributes
    -- presentment_currency -> display_currency
    -- referring_site -> referral_source
    -- shipping_line -> shipping_details
    -- source -> checkout_source
    -- source_identifier -> source_id
    -- subtotal_price -> subtotal
    -- token -> checkout_token
    -- updated_at -> last_updated_at
    SELECT 
        "_fivetran_deleted" AS "is_deleted",
        "abandoned_checkout_url" AS "recovery_url",
        "applied_discount_amount" AS "discount_amount",
        "applied_discount_applicable" AS "is_discount_applicable",
        "applied_discount_description" AS "discount_description",
        "applied_discount_non_applicable_reason" AS "discount_non_applicable_reason",
        "applied_discount_title" AS "discount_title",
        "applied_discount_value" AS "discount_value",
        "applied_discount_value_type" AS "discount_value_type",
        "billing_address_address_0" AS "billing_address_line1",
        "billing_address_address_1" AS "billing_address_line2",
        "billing_address_city" AS "billing_city",
        "billing_address_company" AS "billing_company",
        "billing_address_country" AS "billing_country",
        "billing_address_country_code" AS "billing_country_code",
        "billing_address_first_name" AS "billing_first_name",
        "billing_address_id",
        "billing_address_is_default" AS "is_default_billing_address",
        "billing_address_last_name" AS "billing_last_name",
        "billing_address_latitude" AS "billing_latitude",
        "billing_address_longitude" AS "billing_longitude",
        "billing_address_name" AS "billing_full_name",
        "billing_address_phone" AS "billing_phone",
        "billing_address_province" AS "billing_province",
        "billing_address_province_code" AS "billing_province_code",
        "billing_address_zip" AS "billing_zip",
        "buyer_accepts_marketing" AS "accepts_marketing",
        "cart_token",
        "closed_at",
        "completed_at",
        "created_at" AS "abandoned_at",
        "credit_card_first_name" AS "cc_first_name",
        "credit_card_last_name" AS "cc_last_name",
        "credit_card_month" AS "cc_exp_month",
        "credit_card_number" AS "cc_number",
        "credit_card_verification_value" AS "cc_cvv",
        "credit_card_year" AS "cc_exp_year",
        "currency",
        "customer_id",
        "customer_locale",
        "device_id",
        "email",
        "gateway" AS "payment_gateway",
        "id" AS "checkout_id",
        "landing_site_base_url" AS "landing_page_url",
        "location_id",
        "name" AS "order_number",
        "note" AS "order_notes",
        "note_attributes" AS "custom_attributes",
        "phone",
        "presentment_currency" AS "display_currency",
        "referring_site" AS "referral_source",
        "shipping_line" AS "shipping_details",
        "source" AS "checkout_source",
        "source_identifier" AS "source_id",
        "source_name",
        "source_url",
        "subtotal_price" AS "subtotal",
        "taxes_included",
        "token" AS "checkout_token",
        "updated_at" AS "last_updated_at",
        "user_id"
    FROM "shopify_abandoned_checkout_data_removeWideColumns_projected"
),

"shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_address_line2: The problem is that 'village' is too generic and lacks specific information for an address line 2. Typically, address line 2 should contain more specific details like apartment numbers, suite numbers, or building names. The value 'village' doesn't provide any meaningful information in this context. The correct value in this case should be an empty string, as there's no specific information to include. 
    -- billing_city: The problem is that 'daytona Beach' is not properly capitalized. City names should have their first letters capitalized. The correct value should be 'Daytona Beach'. 
    -- billing_country: The problem is that 'Florida' is a state in the United States, not a country, and it appears in a column named 'billing_country'. The correct value should be the country that Florida is part of, which is the United States of America (USA). 
    -- billing_first_name: The problem is that 'ohio' is a state name, not a typical first name for billing information. This column should contain personal first names. Since we don't have any additional information about the correct first name for this entry, we can't map it to a valid name. The correct value should be an empty string to indicate missing data. 
    -- billing_full_name: The problem is that 'hi' is not a valid full name for billing purposes. A full name typically consists of at least a first name and a last name. The value 'hi' appears to be a greeting or placeholder rather than an actual name. For billing purposes, we need accurate and complete customer information. Since there are no valid names provided, we should map this meaningless value to an empty string. 
    -- billing_province: The problem is that 'Healdsburg' is a city name, not a province or state. For a billing_province column, we would expect to see state or province names. Since Healdsburg is a city in California, the correct value should be the state abbreviation 'CA' for California. 
    SELECT
        "is_deleted",
        "recovery_url",
        "discount_amount",
        "is_discount_applicable",
        "discount_description",
        "discount_non_applicable_reason",
        "discount_title",
        "discount_value",
        "discount_value_type",
        "billing_address_line1",
        CASE
            WHEN "billing_address_line2" = 'village' THEN ''
            ELSE "billing_address_line2"
        END AS "billing_address_line2",
        CASE
            WHEN "billing_city" = 'daytona Beach' THEN 'Daytona Beach'
            ELSE "billing_city"
        END AS "billing_city",
        "billing_company",
        CASE
            WHEN "billing_country" = 'Florida' THEN 'USA'
            ELSE "billing_country"
        END AS "billing_country",
        "billing_country_code",
        CASE
            WHEN "billing_first_name" = 'ohio' THEN ''
            ELSE "billing_first_name"
        END AS "billing_first_name",
        "billing_address_id",
        "is_default_billing_address",
        "billing_last_name",
        "billing_latitude",
        "billing_longitude",
        CASE
            WHEN "billing_full_name" = 'hi' THEN ''
            ELSE "billing_full_name"
        END AS "billing_full_name",
        "billing_phone",
        CASE
            WHEN "billing_province" = 'Healdsburg' THEN 'CA'
            ELSE "billing_province"
        END AS "billing_province",
        "billing_province_code",
        "billing_zip",
        "accepts_marketing",
        "cart_token",
        "closed_at",
        "completed_at",
        "abandoned_at",
        "cc_first_name",
        "cc_last_name",
        "cc_exp_month",
        "cc_number",
        "cc_cvv",
        "cc_exp_year",
        "currency",
        "customer_id",
        "customer_locale",
        "device_id",
        "email",
        "payment_gateway",
        "checkout_id",
        "landing_page_url",
        "location_id",
        "order_number",
        "order_notes",
        "custom_attributes",
        "phone",
        "display_currency",
        "referral_source",
        "shipping_details",
        "checkout_source",
        "source_id",
        "source_name",
        "source_url",
        "subtotal",
        "taxes_included",
        "checkout_token",
        "last_updated_at",
        "user_id"
    FROM "shopify_abandoned_checkout_data_removeWideColumns_projected_renamed"
),

"shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- billing_address_line2: ['']
    -- billing_first_name: ['']
    -- billing_full_name: ['']
    SELECT 
        CASE
            WHEN "billing_address_line2" = '' THEN NULL
            ELSE "billing_address_line2"
        END AS "billing_address_line2",
        CASE
            WHEN "billing_first_name" = '' THEN NULL
            ELSE "billing_first_name"
        END AS "billing_first_name",
        CASE
            WHEN "billing_full_name" = '' THEN NULL
            ELSE "billing_full_name"
        END AS "billing_full_name",
        "phone",
        "cc_last_name",
        "currency",
        "display_currency",
        "cc_exp_month",
        "billing_latitude",
        "billing_zip",
        "completed_at",
        "cc_exp_year",
        "payment_gateway",
        "shipping_details",
        "billing_address_id",
        "accepts_marketing",
        "billing_address_line1",
        "billing_country",
        "discount_description",
        "customer_locale",
        "email",
        "checkout_token",
        "billing_company",
        "discount_non_applicable_reason",
        "order_notes",
        "cc_number",
        "device_id",
        "location_id",
        "is_default_billing_address",
        "discount_amount",
        "abandoned_at",
        "user_id",
        "discount_value_type",
        "last_updated_at",
        "taxes_included",
        "checkout_source",
        "customer_id",
        "order_number",
        "landing_page_url",
        "billing_province_code",
        "discount_title",
        "is_deleted",
        "source_url",
        "referral_source",
        "billing_country_code",
        "recovery_url",
        "source_name",
        "billing_longitude",
        "billing_phone",
        "closed_at",
        "cc_cvv",
        "source_id",
        "is_discount_applicable",
        "discount_value",
        "cc_first_name",
        "checkout_id",
        "cart_token",
        "billing_city",
        "custom_attributes",
        "subtotal",
        "billing_province",
        "billing_last_name"
    FROM "shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned"
),

"shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- abandoned_at: from VARCHAR to TIMESTAMP
    -- billing_address_id: from DECIMAL to VARCHAR
    -- billing_company: from DECIMAL to VARCHAR
    -- billing_phone: from DECIMAL to VARCHAR
    -- billing_zip: from DECIMAL to VARCHAR
    -- cc_cvv: from DECIMAL to VARCHAR
    -- cc_exp_month: from DECIMAL to VARCHAR
    -- cc_exp_year: from DECIMAL to VARCHAR
    -- cc_first_name: from DECIMAL to VARCHAR
    -- cc_last_name: from DECIMAL to VARCHAR
    -- cc_number: from DECIMAL to VARCHAR
    -- checkout_id: from INT to VARCHAR
    -- checkout_source: from DECIMAL to VARCHAR
    -- closed_at: from DECIMAL to TIMESTAMP
    -- completed_at: from DECIMAL to TIMESTAMP
    -- custom_attributes: from VARCHAR to JSON
    -- device_id: from DECIMAL to VARCHAR
    -- discount_description: from DECIMAL to VARCHAR
    -- discount_non_applicable_reason: from DECIMAL to VARCHAR
    -- discount_title: from DECIMAL to VARCHAR
    -- discount_value_type: from DECIMAL to VARCHAR
    -- is_default_billing_address: from DECIMAL to BOOLEAN
    -- is_deleted: from DECIMAL to BOOLEAN
    -- is_discount_applicable: from DECIMAL to BOOLEAN
    -- last_updated_at: from VARCHAR to TIMESTAMP
    -- location_id: from DECIMAL to VARCHAR
    -- order_notes: from DECIMAL to VARCHAR
    -- phone: from DECIMAL to VARCHAR
    -- shipping_details: from DECIMAL to JSON
    -- source_id: from DECIMAL to VARCHAR
    -- source_url: from DECIMAL to VARCHAR
    -- user_id: from DECIMAL to VARCHAR
    SELECT
        "billing_address_line2",
        "billing_first_name",
        "billing_full_name",
        "currency",
        "display_currency",
        "billing_latitude",
        "payment_gateway",
        "accepts_marketing",
        "billing_address_line1",
        "billing_country",
        "customer_locale",
        "email",
        "checkout_token",
        "discount_amount",
        "taxes_included",
        "customer_id",
        "order_number",
        "landing_page_url",
        "billing_province_code",
        "referral_source",
        "billing_country_code",
        "recovery_url",
        "source_name",
        "billing_longitude",
        "discount_value",
        "cart_token",
        "billing_city",
        "subtotal",
        "billing_province",
        "billing_last_name",
        CAST("abandoned_at" AS TIMESTAMP) AS "abandoned_at",
        CAST("billing_address_id" AS VARCHAR) AS "billing_address_id",
        CAST("billing_company" AS VARCHAR) AS "billing_company",
        CAST("billing_phone" AS VARCHAR) AS "billing_phone",
        CAST("billing_zip" AS VARCHAR) AS "billing_zip",
        CAST("cc_cvv" AS VARCHAR) AS "cc_cvv",
        CAST("cc_exp_month" AS VARCHAR) AS "cc_exp_month",
        CAST("cc_exp_year" AS VARCHAR) AS "cc_exp_year",
        CAST("cc_first_name" AS VARCHAR) AS "cc_first_name",
        CAST("cc_last_name" AS VARCHAR) AS "cc_last_name",
        CAST("cc_number" AS VARCHAR) AS "cc_number",
        CAST("checkout_id" AS VARCHAR) AS "checkout_id",
        CAST("checkout_source" AS VARCHAR) AS "checkout_source",
        CAST("closed_at" AS TIMESTAMP) AS "closed_at",
        CAST("completed_at" AS TIMESTAMP) AS "completed_at",
        CAST("custom_attributes" AS JSON) AS "custom_attributes",
        CAST("device_id" AS VARCHAR) AS "device_id",
        CAST("discount_description" AS VARCHAR) AS "discount_description",
        CAST("discount_non_applicable_reason" AS VARCHAR) AS "discount_non_applicable_reason",
        CAST("discount_title" AS VARCHAR) AS "discount_title",
        CAST("discount_value_type" AS VARCHAR) AS "discount_value_type",
        CAST("is_default_billing_address" AS BOOLEAN) AS "is_default_billing_address",
        CAST("is_deleted" AS BOOLEAN) AS "is_deleted",
        CAST("is_discount_applicable" AS BOOLEAN) AS "is_discount_applicable",
        CAST("last_updated_at" AS TIMESTAMP) AS "last_updated_at",
        CAST("location_id" AS VARCHAR) AS "location_id",
        CAST("order_notes" AS VARCHAR) AS "order_notes",
        CAST("phone" AS VARCHAR) AS "phone",
        CAST("shipping_details" AS JSON) AS "shipping_details",
        CAST("source_id" AS VARCHAR) AS "source_id",
        CAST("source_url" AS VARCHAR) AS "source_url",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned_null"
),

"shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 17 columns with unacceptable missing values
    -- checkout_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- closed_at has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- completed_at has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_attributes has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- device_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- display_currency has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- is_default_billing_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_deleted has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_discount_applicable has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- location_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- order_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_source has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- shipping_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "billing_address_line2",
        "billing_first_name",
        "billing_full_name",
        "currency",
        "display_currency",
        "billing_latitude",
        "payment_gateway",
        "accepts_marketing",
        "billing_address_line1",
        "billing_country",
        "customer_locale",
        "email",
        "checkout_token",
        "discount_amount",
        "taxes_included",
        "customer_id",
        "order_number",
        "landing_page_url",
        "billing_province_code",
        "referral_source",
        "billing_country_code",
        "recovery_url",
        "source_name",
        "billing_longitude",
        "discount_value",
        "cart_token",
        "billing_city",
        "subtotal",
        "billing_province",
        "billing_last_name",
        "abandoned_at",
        "billing_address_id",
        "billing_company",
        "billing_phone",
        "billing_zip",
        "cc_cvv",
        "cc_exp_month",
        "cc_exp_year",
        "cc_first_name",
        "cc_last_name",
        "cc_number",
        "checkout_id",
        "custom_attributes",
        "discount_description",
        "discount_non_applicable_reason",
        "discount_title",
        "discount_value_type",
        "last_updated_at"
    FROM "shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_abandoned_checkout_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled"