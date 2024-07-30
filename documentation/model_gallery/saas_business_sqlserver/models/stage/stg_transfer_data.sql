-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 03:20:51.719318+00:00
WITH 
"transfer_data_projected" AS (
    -- Projection: Selecting 17 out of 18 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "amount_reversed",
        "balance_transaction_id",
        "created",
        "currency",
        "description",
        "destination",
        "destination_payment",
        "destination_payment_id",
        "livemode",
        "metadata",
        "reversed",
        "source_transaction",
        "source_transaction_id",
        "source_type",
        "transfer_group"
    FROM "MyAppDB"."dbo"."transfer_data"
),

"transfer_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payout_id
    -- amount -> amount_cents
    -- amount_reversed -> amount_reversed_cents
    -- created -> created_at
    -- currency -> currency_code
    -- destination -> destination_bank_account_id
    -- destination_payment -> destination_payment_details
    -- livemode -> is_live
    -- reversed -> is_reversed
    -- source_transaction -> source_transaction_details
    SELECT 
        "id" AS "payout_id",
        "amount" AS "amount_cents",
        "amount_reversed" AS "amount_reversed_cents",
        "balance_transaction_id",
        "created" AS "created_at",
        "currency" AS "currency_code",
        "description",
        "destination" AS "destination_bank_account_id",
        "destination_payment" AS "destination_payment_details",
        "destination_payment_id",
        "livemode" AS "is_live",
        "metadata",
        "reversed" AS "is_reversed",
        "source_transaction" AS "source_transaction_details",
        "source_transaction_id",
        "source_type",
        "transfer_group"
    FROM "transfer_data_projected"
),

"transfer_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to DATETIME
    -- destination_payment_details: from FLOAT to VARCHAR
    -- destination_payment_id: from FLOAT to VARCHAR
    -- is_live: from VARCHAR to BOOLEAN
    -- is_reversed: from VARCHAR to BOOLEAN
    -- metadata: from VARCHAR to JSON
    -- source_transaction_details: from FLOAT to VARCHAR
    -- source_transaction_id: from FLOAT to VARCHAR
    -- transfer_group: from FLOAT to VARCHAR
    SELECT
        "payout_id",
        "amount_cents",
        "amount_reversed_cents",
        "balance_transaction_id",
        "currency_code",
        "description",
        "destination_bank_account_id",
        "source_type",
        CAST("created_at" AS DATETIME) 
        AS "created_at",
        CAST("destination_payment_details" AS VARCHAR) 
        AS "destination_payment_details",
        CAST("destination_payment_id" AS VARCHAR) 
        AS "destination_payment_id",
        CAST("is_live" AS BIT) 
        AS "is_live",
        CASE WHEN "is_reversed" = '0' THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END 
        AS "is_reversed",
        "metadata" 
        AS "metadata",
        CAST("source_transaction_details" AS VARCHAR) 
        AS "source_transaction_details",
        CAST("source_transaction_id" AS VARCHAR) 
        AS "source_transaction_id",
        CAST("transfer_group" AS VARCHAR) 
        AS "transfer_group"
    FROM "transfer_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "transfer_data_projected_renamed_casted"