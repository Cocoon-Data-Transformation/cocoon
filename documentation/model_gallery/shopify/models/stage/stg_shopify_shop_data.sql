-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_shop_data_projected" AS (
    -- Projection: Selecting 56 out of 57 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "address_1",
        "address_2",
        "auto_configure_tax_inclusivity",
        "checkout_api_supported",
        "city",
        "cookie_consent_level",
        "country",
        "country_code",
        "country_name",
        "county_taxes",
        "created_at",
        "currency",
        "customer_email",
        "domain_",
        "eligible_for_card_reader_giveaway",
        "eligible_for_payments",
        "email",
        "enabled_presentment_currencies",
        "force_ssl",
        "google_apps_domain",
        "google_apps_login_enabled",
        "has_discounts",
        "has_gift_cards",
        "has_storefront",
        "iana_timezone",
        "latitude",
        "longitude",
        "money_format",
        "money_in_emails_format",
        "money_with_currency_format",
        "money_with_currency_in_emails_format",
        "multi_location_enabled",
        "myshopify_domain",
        "name",
        "password_enabled",
        "phone",
        "plan_display_name",
        "plan_name",
        "pre_launch_enabled",
        "primary_locale",
        "primary_location_id",
        "province",
        "province_code",
        "requires_extra_payments_agreement",
        "setup_required",
        "shop_owner",
        "source",
        "tax_shipping",
        "taxes_included",
        "timezone",
        "updated_at",
        "visitor_tracking_consent_preference",
        "weight_unit",
        "zip"
    FROM "shopify_shop_data"
),

"shopify_shop_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> shop_id
    -- _fivetran_deleted -> is_deleted
    -- address_1 -> primary_address
    -- address_2 -> secondary_address
    -- auto_configure_tax_inclusivity -> auto_tax_inclusivity
    -- checkout_api_supported -> checkout_api_support
    -- country -> country_code
    -- country_code -> iso_country_code
    -- county_taxes -> county_taxes_applied
    -- created_at -> creation_timestamp
    -- currency -> primary_currency
    -- customer_email -> customer_contact_email
    -- domain_ -> shop_domain
    -- eligible_for_card_reader_giveaway -> card_reader_promo_eligible
    -- eligible_for_payments -> payment_processing_eligible
    -- email -> owner_email
    -- enabled_presentment_currencies -> enabled_currencies
    -- force_ssl -> ssl_enforced
    -- has_discounts -> discounts_offered
    -- has_gift_cards -> gift_cards_offered
    -- has_storefront -> storefront_active
    -- iana_timezone -> shop_timezone
    -- money_in_emails_format -> email_currency_format
    -- money_with_currency_in_emails_format -> email_currency_display_format
    -- myshopify_domain -> shopify_domain
    -- name -> store_name
    -- password_enabled -> password_protection_enabled
    -- primary_locale -> primary_language
    -- province -> state_province
    -- province_code -> state_province_code
    -- requires_extra_payments_agreement -> extra_payment_agreement_required
    -- source -> creation_source
    -- tax_shipping -> tax_on_shipping
    -- updated_at -> last_updated
    -- visitor_tracking_consent_preference -> tracking_consent_preference
    -- zip -> postal_code
    SELECT 
        "id" AS "shop_id",
        "_fivetran_deleted" AS "is_deleted",
        "address_1" AS "primary_address",
        "address_2" AS "secondary_address",
        "auto_configure_tax_inclusivity" AS "auto_tax_inclusivity",
        "checkout_api_supported" AS "checkout_api_support",
        "city",
        "cookie_consent_level",
        "country" AS "country_code",
        "country_code" AS "iso_country_code",
        "country_name",
        "county_taxes" AS "county_taxes_applied",
        "created_at" AS "creation_timestamp",
        "currency" AS "primary_currency",
        "customer_email" AS "customer_contact_email",
        "domain_" AS "shop_domain",
        "eligible_for_card_reader_giveaway" AS "card_reader_promo_eligible",
        "eligible_for_payments" AS "payment_processing_eligible",
        "email" AS "owner_email",
        "enabled_presentment_currencies" AS "enabled_currencies",
        "force_ssl" AS "ssl_enforced",
        "google_apps_domain",
        "google_apps_login_enabled",
        "has_discounts" AS "discounts_offered",
        "has_gift_cards" AS "gift_cards_offered",
        "has_storefront" AS "storefront_active",
        "iana_timezone" AS "shop_timezone",
        "latitude",
        "longitude",
        "money_format",
        "money_in_emails_format" AS "email_currency_format",
        "money_with_currency_format",
        "money_with_currency_in_emails_format" AS "email_currency_display_format",
        "multi_location_enabled",
        "myshopify_domain" AS "shopify_domain",
        "name" AS "store_name",
        "password_enabled" AS "password_protection_enabled",
        "phone",
        "plan_display_name",
        "plan_name",
        "pre_launch_enabled",
        "primary_locale" AS "primary_language",
        "primary_location_id",
        "province" AS "state_province",
        "province_code" AS "state_province_code",
        "requires_extra_payments_agreement" AS "extra_payment_agreement_required",
        "setup_required",
        "shop_owner",
        "source" AS "creation_source",
        "tax_shipping" AS "tax_on_shipping",
        "taxes_included",
        "timezone",
        "updated_at" AS "last_updated",
        "visitor_tracking_consent_preference" AS "tracking_consent_preference",
        "weight_unit",
        "zip" AS "postal_code"
    FROM "shopify_shop_data_projected"
),

"shopify_shop_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- secondary_address: The problem is that '200th Floor' is an extremely unlikely value for a real address. Buildings with 200 floors are virtually non-existent, with the current tallest building in the world (Burj Khalifa) having only 163 floors. This value is likely either a data entry error or a placeholder/test value. The correct value would depend on the actual address, which we don't have information about. In the absence of correct information, it's best to map this to an empty string to indicate missing data. 
    SELECT
        "shop_id",
        "is_deleted",
        "primary_address",
        CASE
            WHEN "secondary_address" = '200th Floor' THEN ''
            ELSE "secondary_address"
        END AS "secondary_address",
        "auto_tax_inclusivity",
        "checkout_api_support",
        "city",
        "cookie_consent_level",
        "country_code",
        "iso_country_code",
        "country_name",
        "county_taxes_applied",
        "creation_timestamp",
        "primary_currency",
        "customer_contact_email",
        "shop_domain",
        "card_reader_promo_eligible",
        "payment_processing_eligible",
        "owner_email",
        "enabled_currencies",
        "ssl_enforced",
        "google_apps_domain",
        "google_apps_login_enabled",
        "discounts_offered",
        "gift_cards_offered",
        "storefront_active",
        "shop_timezone",
        "latitude",
        "longitude",
        "money_format",
        "email_currency_format",
        "money_with_currency_format",
        "email_currency_display_format",
        "multi_location_enabled",
        "shopify_domain",
        "store_name",
        "password_protection_enabled",
        "phone",
        "plan_display_name",
        "plan_name",
        "pre_launch_enabled",
        "primary_language",
        "primary_location_id",
        "state_province",
        "state_province_code",
        "extra_payment_agreement_required",
        "setup_required",
        "shop_owner",
        "creation_source",
        "tax_on_shipping",
        "taxes_included",
        "timezone",
        "last_updated",
        "tracking_consent_preference",
        "weight_unit",
        "postal_code"
    FROM "shopify_shop_data_projected_renamed"
),

"shopify_shop_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- secondary_address: ['']
    SELECT 
        CASE
            WHEN "secondary_address" = '' THEN NULL
            ELSE "secondary_address"
        END AS "secondary_address",
        "setup_required",
        "timezone",
        "ssl_enforced",
        "weight_unit",
        "county_taxes_applied",
        "plan_display_name",
        "primary_location_id",
        "gift_cards_offered",
        "cookie_consent_level",
        "enabled_currencies",
        "checkout_api_support",
        "google_apps_domain",
        "last_updated",
        "is_deleted",
        "payment_processing_eligible",
        "google_apps_login_enabled",
        "longitude",
        "creation_source",
        "discounts_offered",
        "shopify_domain",
        "country_name",
        "primary_address",
        "postal_code",
        "shop_timezone",
        "password_protection_enabled",
        "shop_domain",
        "storefront_active",
        "state_province_code",
        "owner_email",
        "iso_country_code",
        "multi_location_enabled",
        "primary_language",
        "tax_on_shipping",
        "money_with_currency_format",
        "auto_tax_inclusivity",
        "taxes_included",
        "primary_currency",
        "latitude",
        "phone",
        "shop_owner",
        "pre_launch_enabled",
        "city",
        "money_format",
        "plan_name",
        "email_currency_format",
        "store_name",
        "tracking_consent_preference",
        "card_reader_promo_eligible",
        "shop_id",
        "country_code",
        "customer_contact_email",
        "extra_payment_agreement_required",
        "email_currency_display_format",
        "creation_timestamp",
        "state_province"
    FROM "shopify_shop_data_projected_renamed_cleaned"
),

"shopify_shop_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- auto_tax_inclusivity: from DECIMAL to BOOLEAN
    -- creation_source: from DECIMAL to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- enabled_currencies: from VARCHAR to ARRAY
    -- google_apps_domain: from DECIMAL to VARCHAR
    -- google_apps_login_enabled: from DECIMAL to BOOLEAN
    -- last_updated: from VARCHAR to TIMESTAMP
    -- phone: from INT to VARCHAR
    -- postal_code: from INT to VARCHAR
    -- primary_location_id: from INT to VARCHAR
    -- tax_on_shipping: from DECIMAL to VARCHAR
    SELECT
        "secondary_address",
        "setup_required",
        "timezone",
        "ssl_enforced",
        "weight_unit",
        "county_taxes_applied",
        "plan_display_name",
        "gift_cards_offered",
        "cookie_consent_level",
        "checkout_api_support",
        "is_deleted",
        "payment_processing_eligible",
        "longitude",
        "discounts_offered",
        "shopify_domain",
        "country_name",
        "primary_address",
        "shop_timezone",
        "password_protection_enabled",
        "shop_domain",
        "storefront_active",
        "state_province_code",
        "owner_email",
        "iso_country_code",
        "multi_location_enabled",
        "primary_language",
        "money_with_currency_format",
        "taxes_included",
        "primary_currency",
        "latitude",
        "shop_owner",
        "pre_launch_enabled",
        "city",
        "money_format",
        "plan_name",
        "email_currency_format",
        "store_name",
        "tracking_consent_preference",
        "card_reader_promo_eligible",
        "shop_id",
        "country_code",
        "customer_contact_email",
        "extra_payment_agreement_required",
        "email_currency_display_format",
        "state_province",
        CAST("auto_tax_inclusivity" AS BOOLEAN) AS "auto_tax_inclusivity",
        CAST("creation_source" AS VARCHAR) AS "creation_source",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        from_json("enabled_currencies", '["VARCHAR"]') AS "enabled_currencies",
        CAST("google_apps_domain" AS VARCHAR) AS "google_apps_domain",
        CAST("google_apps_login_enabled" AS BOOLEAN) AS "google_apps_login_enabled",
        CAST("last_updated" AS TIMESTAMP) AS "last_updated",
        CAST("phone" AS VARCHAR) AS "phone",
        CAST("postal_code" AS VARCHAR) AS "postal_code",
        CAST("primary_location_id" AS VARCHAR) AS "primary_location_id",
        CAST("tax_on_shipping" AS VARCHAR) AS "tax_on_shipping"
    FROM "shopify_shop_data_projected_renamed_cleaned_null"
),

"shopify_shop_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- auto_tax_inclusivity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- creation_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- secondary_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "setup_required",
        "timezone",
        "ssl_enforced",
        "weight_unit",
        "county_taxes_applied",
        "plan_display_name",
        "gift_cards_offered",
        "cookie_consent_level",
        "checkout_api_support",
        "is_deleted",
        "payment_processing_eligible",
        "longitude",
        "discounts_offered",
        "shopify_domain",
        "country_name",
        "primary_address",
        "shop_timezone",
        "password_protection_enabled",
        "shop_domain",
        "storefront_active",
        "state_province_code",
        "owner_email",
        "iso_country_code",
        "multi_location_enabled",
        "primary_language",
        "money_with_currency_format",
        "taxes_included",
        "primary_currency",
        "latitude",
        "shop_owner",
        "pre_launch_enabled",
        "city",
        "money_format",
        "plan_name",
        "email_currency_format",
        "store_name",
        "tracking_consent_preference",
        "card_reader_promo_eligible",
        "shop_id",
        "country_code",
        "customer_contact_email",
        "extra_payment_agreement_required",
        "email_currency_display_format",
        "state_province",
        "creation_timestamp",
        "enabled_currencies",
        "google_apps_domain",
        "google_apps_login_enabled",
        "last_updated",
        "phone",
        "postal_code",
        "primary_location_id",
        "tax_on_shipping"
    FROM "shopify_shop_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_shop_data_projected_renamed_cleaned_null_casted_missing_handled"