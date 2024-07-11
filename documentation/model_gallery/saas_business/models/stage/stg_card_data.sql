-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"card_data_projected" AS (
    -- Projection: Selecting 29 out of 30 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "account_id",
        "address_city",
        "address_country",
        "address_line_1",
        "address_line_1_check",
        "address_line_2",
        "address_state",
        "address_zip",
        "address_zip_check",
        "brand",
        "connected_account_id",
        "country",
        "created",
        "currency",
        "customer_id",
        "cvc_check",
        "dynamic_last_4",
        "exp_month",
        "exp_year",
        "fingerprint",
        "funding",
        "is_deleted",
        "last_4",
        "name",
        "network",
        "recipient",
        "tokenization_method",
        "metadata"
    FROM "card_data"
),

"card_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payment_method_id
    -- address_city -> billing_city
    -- address_country -> billing_country
    -- address_line_1 -> billing_address_line1
    -- address_line_1_check -> address_line1_verification
    -- address_line_2 -> billing_address_line2
    -- address_state -> billing_state
    -- address_zip -> billing_zip
    -- address_zip_check -> zip_verification
    -- brand -> card_brand
    -- country -> issuing_country
    -- created -> creation_datetime
    -- cvc_check -> cvc_verification
    -- dynamic_last_4 -> dynamic_last4_digits
    -- exp_month -> expiration_month
    -- exp_year -> expiration_year
    -- fingerprint -> card_fingerprint
    -- funding -> funding_type
    -- last_4 -> last4_digits
    -- name -> cardholder_name
    -- network -> payment_network
    -- recipient -> recipient_info
    SELECT 
        "id" AS "payment_method_id",
        "account_id",
        "address_city" AS "billing_city",
        "address_country" AS "billing_country",
        "address_line_1" AS "billing_address_line1",
        "address_line_1_check" AS "address_line1_verification",
        "address_line_2" AS "billing_address_line2",
        "address_state" AS "billing_state",
        "address_zip" AS "billing_zip",
        "address_zip_check" AS "zip_verification",
        "brand" AS "card_brand",
        "connected_account_id",
        "country" AS "issuing_country",
        "created" AS "creation_datetime",
        "currency",
        "customer_id",
        "cvc_check" AS "cvc_verification",
        "dynamic_last_4" AS "dynamic_last4_digits",
        "exp_month" AS "expiration_month",
        "exp_year" AS "expiration_year",
        "fingerprint" AS "card_fingerprint",
        "funding" AS "funding_type",
        "is_deleted",
        "last_4" AS "last4_digits",
        "name" AS "cardholder_name",
        "network" AS "payment_network",
        "recipient" AS "recipient_info",
        "tokenization_method",
        "metadata"
    FROM "card_data_projected"
),

"card_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- card_brand: The problem is that the card_brand column contains a value that appears to be a hash or encrypted string ('553f65f270c86a4a05c964dc20e8cc70') instead of an actual card brand name. This is unusual because card brands are typically recognizable names like Visa, Mastercard, American Express, etc. The hash-like value doesn't provide any meaningful information about the card brand. Since we don't have enough information to determine the actual card brand, and the current value is not useful, the most appropriate action is to map this unusual value to an empty string. 
    -- metadata: The problem is that there are empty JSON objects ('{}') in the metadata column, which are inconsistent with the other entries. The correct values should all follow the pattern of having an "external_id" key with a string value. The empty JSON objects are likely placeholder entries or errors that should be corrected. 
    SELECT
        "payment_method_id",
        "account_id",
        "billing_city",
        "billing_country",
        "billing_address_line1",
        "address_line1_verification",
        "billing_address_line2",
        "billing_state",
        "billing_zip",
        "zip_verification",
        CASE
            WHEN "card_brand" = '''553f65f270c86a4a05c964dc20e8cc70''' THEN ''''
            ELSE "card_brand"
        END AS "card_brand",
        "connected_account_id",
        "issuing_country",
        "creation_datetime",
        "currency",
        "customer_id",
        "cvc_verification",
        "dynamic_last4_digits",
        "expiration_month",
        "expiration_year",
        "card_fingerprint",
        "funding_type",
        "is_deleted",
        "last4_digits",
        "cardholder_name",
        "payment_network",
        "recipient_info",
        "tokenization_method",
        CASE
            WHEN "metadata" = '''{}''' THEN '{"external_id":""}'
            ELSE "metadata"
        END AS "metadata"
    FROM "card_data_projected_renamed"
),

"card_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- metadata: ['{}']
    SELECT 
        CASE
            WHEN "metadata" = '{}' THEN NULL
            ELSE "metadata"
        END AS "metadata",
        "issuing_country",
        "billing_city",
        "expiration_year",
        "currency",
        "last4_digits",
        "payment_method_id",
        "address_line1_verification",
        "tokenization_method",
        "customer_id",
        "expiration_month",
        "billing_address_line1",
        "payment_network",
        "funding_type",
        "connected_account_id",
        "recipient_info",
        "dynamic_last4_digits",
        "zip_verification",
        "billing_zip",
        "creation_datetime",
        "account_id",
        "billing_address_line2",
        "cardholder_name",
        "billing_country",
        "card_brand",
        "is_deleted",
        "cvc_verification",
        "billing_state",
        "card_fingerprint"
    FROM "card_data_projected_renamed_cleaned"
),

"card_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_id: from DECIMAL to VARCHAR
    -- address_line1_verification: from DECIMAL to VARCHAR
    -- billing_address_line1: from DECIMAL to VARCHAR
    -- billing_address_line2: from DECIMAL to VARCHAR
    -- billing_city: from DECIMAL to VARCHAR
    -- billing_country: from DECIMAL to VARCHAR
    -- billing_state: from DECIMAL to VARCHAR
    -- billing_zip: from DECIMAL to VARCHAR
    -- cardholder_name: from DECIMAL to VARCHAR
    -- connected_account_id: from DECIMAL to VARCHAR
    -- creation_datetime: from VARCHAR to TIMESTAMP
    -- customer_id: from DECIMAL to VARCHAR
    -- dynamic_last4_digits: from DECIMAL to VARCHAR
    -- last4_digits: from INT to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- recipient_info: from DECIMAL to VARCHAR
    -- tokenization_method: from DECIMAL to VARCHAR
    -- zip_verification: from DECIMAL to VARCHAR
    SELECT
        "issuing_country",
        "expiration_year",
        "currency",
        "payment_method_id",
        "expiration_month",
        "payment_network",
        "funding_type",
        "card_brand",
        "is_deleted",
        "cvc_verification",
        "card_fingerprint",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("address_line1_verification" AS VARCHAR) AS "address_line1_verification",
        CAST("billing_address_line1" AS VARCHAR) AS "billing_address_line1",
        CAST("billing_address_line2" AS VARCHAR) AS "billing_address_line2",
        CAST("billing_city" AS VARCHAR) AS "billing_city",
        CAST("billing_country" AS VARCHAR) AS "billing_country",
        CAST("billing_state" AS VARCHAR) AS "billing_state",
        CAST("billing_zip" AS VARCHAR) AS "billing_zip",
        CAST("cardholder_name" AS VARCHAR) AS "cardholder_name",
        CAST("connected_account_id" AS VARCHAR) AS "connected_account_id",
        CAST("creation_datetime" AS TIMESTAMP) AS "creation_datetime",
        CAST("customer_id" AS VARCHAR) AS "customer_id",
        CAST("dynamic_last4_digits" AS VARCHAR) AS "dynamic_last4_digits",
        CAST("last4_digits" AS VARCHAR) AS "last4_digits",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("recipient_info" AS VARCHAR) AS "recipient_info",
        CAST("tokenization_method" AS VARCHAR) AS "tokenization_method",
        CAST("zip_verification" AS VARCHAR) AS "zip_verification"
    FROM "card_data_projected_renamed_cleaned_null"
),

"card_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 15 columns with unacceptable missing values
    -- account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_line1_verification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_address_line1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_address_line2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_zip has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cardholder_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- connected_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dynamic_last4_digits has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- recipient_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tokenization_method has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zip_verification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "issuing_country",
        "expiration_year",
        "currency",
        "payment_method_id",
        "expiration_month",
        "payment_network",
        "funding_type",
        "card_brand",
        "is_deleted",
        "cvc_verification",
        "card_fingerprint",
        "creation_datetime",
        "last4_digits",
        "metadata"
    FROM "card_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "card_data_projected_renamed_cleaned_null_casted_missing_handled"