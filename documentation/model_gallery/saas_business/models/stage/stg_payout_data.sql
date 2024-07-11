-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "payout_data"
),

"payout_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payout_id
    -- amount -> payout_amount_cents
    -- arrival_date -> estimated_arrival_date
    -- automatic -> is_automatic
    -- created -> creation_timestamp
    -- currency -> currency_code
    -- failure_balance_transaction_id -> failure_transaction_id
    -- livemode -> is_live_mode
    -- method -> payout_method
    -- status -> payout_status
    -- type -> destination_type
    SELECT 
        "id" AS "payout_id",
        "amount" AS "payout_amount_cents",
        "arrival_date" AS "estimated_arrival_date",
        "automatic" AS "is_automatic",
        "balance_transaction_id",
        "connected_account_id",
        "created" AS "creation_timestamp",
        "currency" AS "currency_code",
        "description",
        "destination_bank_account_id",
        "destination_card_id",
        "failure_balance_transaction_id" AS "failure_transaction_id",
        "failure_code",
        "failure_message",
        "livemode" AS "is_live_mode",
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
    -- connected_account_id: from DECIMAL to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- destination_card_id: from DECIMAL to VARCHAR
    -- estimated_arrival_date: from VARCHAR to DATE
    -- failure_code: from DECIMAL to VARCHAR
    -- failure_message: from DECIMAL to VARCHAR
    -- failure_transaction_id: from DECIMAL to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- statement_descriptor: from DECIMAL to VARCHAR
    SELECT
        "payout_id",
        "payout_amount_cents",
        "is_automatic",
        "balance_transaction_id",
        "currency_code",
        "description",
        "destination_bank_account_id",
        "is_live_mode",
        "payout_method",
        "source_type",
        "payout_status",
        "destination_type",
        CAST("connected_account_id" AS VARCHAR) AS "connected_account_id",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("destination_card_id" AS VARCHAR) AS "destination_card_id",
        CAST("estimated_arrival_date" AS DATE) AS "estimated_arrival_date",
        CAST("failure_code" AS VARCHAR) AS "failure_code",
        CAST("failure_message" AS VARCHAR) AS "failure_message",
        CAST("failure_transaction_id" AS VARCHAR) AS "failure_transaction_id",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("statement_descriptor" AS VARCHAR) AS "statement_descriptor"
    FROM "payout_data_projected_renamed"
),

"payout_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- statement_descriptor has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "payout_id",
        "payout_amount_cents",
        "is_automatic",
        "balance_transaction_id",
        "currency_code",
        "description",
        "destination_bank_account_id",
        "is_live_mode",
        "payout_method",
        "source_type",
        "payout_status",
        "destination_type",
        "connected_account_id",
        "creation_timestamp",
        "destination_card_id",
        "estimated_arrival_date",
        "failure_code",
        "failure_message",
        "failure_transaction_id",
        "metadata"
    FROM "payout_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "payout_data_projected_renamed_casted_missing_handled"