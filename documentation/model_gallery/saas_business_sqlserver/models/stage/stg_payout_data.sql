-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:46:03.638707+00:00
WITH 
"payout_data_projected" AS (
    -- Projection: Selecting 21 out of 22 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "arrival_date",
        "automatic",
        "balance_transaction_id",
        "connected_account_id",
        "created",
        "currency",
        "description",
        "destination_bank_account_id",
        "destination_card_id",
        "failure_balance_transaction_id",
        "failure_code",
        "failure_message",
        "livemode",
        "metadata",
        "method",
        "source_type",
        "statement_descriptor",
        "status",
        "type"
    FROM "MyAppDB"."dbo"."payout_data"
),

"payout_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payout_id
    -- amount -> amount_cents
    -- automatic -> is_automatic
    -- created -> created_at
    -- currency -> currency_code
    -- livemode -> is_live
    -- method -> payout_method
    -- status -> payout_status
    -- type -> destination_type
    SELECT 
        "id" AS "payout_id",
        "amount" AS "amount_cents",
        "arrival_date",
        "automatic" AS "is_automatic",
        "balance_transaction_id",
        "connected_account_id",
        "created" AS "created_at",
        "currency" AS "currency_code",
        "description",
        "destination_bank_account_id",
        "destination_card_id",
        "failure_balance_transaction_id",
        "failure_code",
        "failure_message",
        "livemode" AS "is_live",
        "metadata",
        "method" AS "payout_method",
        "source_type",
        "statement_descriptor",
        "status" AS "payout_status",
        "type" AS "destination_type"
    FROM "payout_data_projected"
),

"payout_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- arrival_date: from VARCHAR to DATE
    -- connected_account_id: from FLOAT to VARCHAR
    -- created_at: from VARCHAR to DATETIME
    -- destination_card_id: from FLOAT to VARCHAR
    -- failure_balance_transaction_id: from FLOAT to VARCHAR
    -- failure_code: from FLOAT to VARCHAR
    -- failure_message: from FLOAT to VARCHAR
    -- is_automatic: from VARCHAR to BOOLEAN
    -- is_live: from VARCHAR to BOOLEAN
    -- metadata: from VARCHAR to JSON
    -- statement_descriptor: from FLOAT to VARCHAR
    SELECT
        "payout_id",
        "amount_cents",
        "balance_transaction_id",
        "currency_code",
        "description",
        "destination_bank_account_id",
        "payout_method",
        "source_type",
        "payout_status",
        "destination_type",
        CAST("arrival_date" AS DATE) 
        AS "arrival_date",
        CAST("connected_account_id" AS VARCHAR) 
        AS "connected_account_id",
        CAST("created_at" AS DATETIME) 
        AS "created_at",
        CAST("destination_card_id" AS VARCHAR) 
        AS "destination_card_id",
        CAST("failure_balance_transaction_id" AS VARCHAR) 
        AS "failure_balance_transaction_id",
        CAST("failure_code" AS VARCHAR) 
        AS "failure_code",
        CAST("failure_message" AS VARCHAR(MAX)) 
        AS "failure_message",
        CAST("is_automatic" AS BIT) 
        AS "is_automatic",
        CAST("is_live" AS BIT) 
        AS "is_live",
        "metadata" 
        AS "metadata",
        CAST("statement_descriptor" AS VARCHAR(255)) 
        AS "statement_descriptor"
    FROM "payout_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "payout_data_projected_renamed_casted"