-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:44:39.231928+00:00
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
    FROM "MyAppDB"."dbo"."card_data"
),

"card_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payment_method_id
    -- address_city -> billing_city
    -- address_country -> billing_country
    -- address_line_1 -> billing_address_line_1
    -- address_line_2 -> billing_address_line_2
    -- address_state -> billing_state
    -- address_zip -> billing_zip
    -- address_zip_check -> zip_check
    -- brand -> card_brand
    -- country -> issuer_country
    -- created -> creation_date
    -- exp_month -> expiration_month
    -- exp_year -> expiration_year
    -- fingerprint -> card_fingerprint
    -- funding -> funding_type
    -- last_4 -> last_4_digits
    -- name -> cardholder_name
    -- network -> payment_network
    SELECT 
        "id" AS "payment_method_id",
        "account_id",
        "address_city" AS "billing_city",
        "address_country" AS "billing_country",
        "address_line_1" AS "billing_address_line_1",
        "address_line_1_check",
        "address_line_2" AS "billing_address_line_2",
        "address_state" AS "billing_state",
        "address_zip" AS "billing_zip",
        "address_zip_check" AS "zip_check",
        "brand" AS "card_brand",
        "connected_account_id",
        "country" AS "issuer_country",
        "created" AS "creation_date",
        "currency",
        "customer_id",
        "cvc_check",
        "dynamic_last_4",
        "exp_month" AS "expiration_month",
        "exp_year" AS "expiration_year",
        "fingerprint" AS "card_fingerprint",
        "funding" AS "funding_type",
        "is_deleted",
        "last_4" AS "last_4_digits",
        "name" AS "cardholder_name",
        "network" AS "payment_network",
        "recipient",
        "tokenization_method",
        "metadata"
    FROM "card_data_projected"
),

"card_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- card_brand: The problem is that the value '553f65f270c86a4a05c964dc20e8cc70' is not a recognizable card brand name. It appears to be a hash or encrypted value, which is not appropriate for a card_brand column. Card brand columns typically contain names like Visa, Mastercard, American Express, etc. Since we don't have any information about what this value represents or what the correct card brand should be, we can't map it to a specific brand. The best approach is to map it to an empty string to indicate that the card brand is unknown or not provided.
    SELECT
        "payment_method_id",
        "account_id",
        "billing_city",
        "billing_country",
        "billing_address_line_1",
        "address_line_1_check",
        "billing_address_line_2",
        "billing_state",
        "billing_zip",
        "zip_check",
        CASE
            WHEN "card_brand" = '553f65f270c86a4a05c964dc20e8cc70' THEN NULL
            ELSE "card_brand"
        END AS "card_brand",
        "connected_account_id",
        "issuer_country",
        "creation_date",
        "currency",
        "customer_id",
        "cvc_check",
        "dynamic_last_4",
        "expiration_month",
        "expiration_year",
        "card_fingerprint",
        "funding_type",
        "is_deleted",
        "last_4_digits",
        "cardholder_name",
        "payment_network",
        "recipient",
        "tokenization_method",
        "metadata"
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
        "billing_state",
        "connected_account_id",
        "billing_address_line_1",
        "recipient",
        "account_id",
        "cardholder_name",
        "billing_address_line_2",
        "customer_id",
        "address_line_1_check",
        "currency",
        "payment_network",
        "expiration_year",
        "card_brand",
        "tokenization_method",
        "cvc_check",
        "creation_date",
        "dynamic_last_4",
        "billing_country",
        "card_fingerprint",
        "expiration_month",
        "payment_method_id",
        "zip_check",
        "billing_city",
        "is_deleted",
        "last_4_digits",
        "funding_type",
        "issuer_country",
        "billing_zip"
    FROM "card_data_projected_renamed_cleaned"
),

"card_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_id: from FLOAT to VARCHAR
    -- address_line_1_check: from FLOAT to VARCHAR
    -- billing_address_line_1: from FLOAT to VARCHAR
    -- billing_address_line_2: from FLOAT to VARCHAR
    -- billing_city: from FLOAT to VARCHAR
    -- billing_country: from FLOAT to VARCHAR
    -- billing_state: from FLOAT to VARCHAR
    -- billing_zip: from FLOAT to VARCHAR
    -- cardholder_name: from FLOAT to VARCHAR
    -- connected_account_id: from FLOAT to VARCHAR
    -- creation_date: from VARCHAR to DATETIME
    -- customer_id: from FLOAT to VARCHAR
    -- dynamic_last_4: from FLOAT to VARCHAR
    -- is_deleted: from VARCHAR to BOOLEAN
    -- last_4_digits: from INT to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- recipient: from FLOAT to VARCHAR
    -- tokenization_method: from FLOAT to VARCHAR
    -- zip_check: from FLOAT to VARCHAR
    SELECT
        "currency",
        "payment_network",
        "expiration_year",
        "card_brand",
        "cvc_check",
        "card_fingerprint",
        "expiration_month",
        "payment_method_id",
        "funding_type",
        "issuer_country",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("address_line_1_check" AS VARCHAR) 
        AS "address_line_1_check",
        CAST("billing_address_line_1" AS VARCHAR) 
        AS "billing_address_line_1",
        CAST("billing_address_line_2" AS VARCHAR) 
        AS "billing_address_line_2",
        CAST("billing_city" AS VARCHAR(255)) 
        AS "billing_city",
        CAST("billing_country" AS VARCHAR) 
        AS "billing_country",
        CAST("billing_state" AS VARCHAR) 
        AS "billing_state",
        CAST("billing_zip" AS VARCHAR) 
        AS "billing_zip",
        CAST("cardholder_name" AS VARCHAR) 
        AS "cardholder_name",
        CAST("connected_account_id" AS VARCHAR) 
        AS "connected_account_id",
        CAST("creation_date" AS DATETIME) 
        AS "creation_date",
        CAST("customer_id" AS VARCHAR) 
        AS "customer_id",
        CAST("dynamic_last_4" AS VARCHAR) 
        AS "dynamic_last_4",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CAST("last_4_digits" AS VARCHAR) 
        AS "last_4_digits",
        "metadata" 
        AS "metadata",
        CAST("recipient" AS VARCHAR) 
        AS "recipient",
        CAST("tokenization_method" AS VARCHAR) 
        AS "tokenization_method",
        CAST("zip_check" AS VARCHAR) 
        AS "zip_check"
    FROM "card_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "card_data_projected_renamed_cleaned_null_casted"