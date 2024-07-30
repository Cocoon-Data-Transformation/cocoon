-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:45:18.582779+00:00
WITH 
"fee_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "balance_transaction_id",
        "index_",
        "amount",
        "application",
        "connected_account_id",
        "currency",
        "description",
        "type"
    FROM "MyAppDB"."dbo"."fee_data"
),

"fee_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- balance_transaction_id -> transaction_id
    -- index_ -> sequence_position
    -- amount -> fee_amount_cents
    -- application -> application_id
    -- currency -> currency_code
    -- description -> description_code
    -- type -> transaction_type_code
    SELECT 
        "balance_transaction_id" AS "transaction_id",
        "index_" AS "sequence_position",
        "amount" AS "fee_amount_cents",
        "application" AS "application_id",
        "connected_account_id",
        "currency" AS "currency_code",
        "description" AS "description_code",
        "type" AS "transaction_type_code"
    FROM "fee_data_projected"
),

"fee_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- transaction_type_code: The problem is that the transaction_type_code column contains a single value that appears to be a MD5 hash ('a63a12921d2c16182f640ee7d2875ec4') rather than a meaningful transaction type code. This hash-like string is unusual and inappropriate for a transaction type code, which typically would be a short, descriptive string or numeric code. Without additional context or information about the intended transaction types, it's impossible to determine the correct value. Therefore, the most appropriate action is to map this meaningless hash to an empty string, indicating that the true transaction type is unknown or undefined.
    SELECT
        "transaction_id",
        "sequence_position",
        "fee_amount_cents",
        "application_id",
        "connected_account_id",
        "currency_code",
        "description_code",
        CASE
            WHEN "transaction_type_code" = 'a63a12921d2c16182f640ee7d2875ec4' THEN NULL
            ELSE "transaction_type_code"
        END AS "transaction_type_code"
    FROM "fee_data_projected_renamed"
),

"fee_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- application_id: from FLOAT to VARCHAR
    -- connected_account_id: from FLOAT to VARCHAR
    SELECT
        "transaction_id",
        "sequence_position",
        "fee_amount_cents",
        "currency_code",
        "description_code",
        "transaction_type_code",
        CAST("application_id" AS VARCHAR) 
        AS "application_id",
        CAST("connected_account_id" AS VARCHAR) 
        AS "connected_account_id"
    FROM "fee_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "fee_data_projected_renamed_cleaned_casted"