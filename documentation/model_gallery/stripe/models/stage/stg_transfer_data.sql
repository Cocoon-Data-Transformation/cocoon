-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "transfer_data"
),

"transfer_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payout_id
    -- amount -> payout_amount_cents
    -- amount_reversed -> reversed_amount_cents
    -- created -> payout_created_at
    -- description -> payout_description
    -- destination -> destination_bank_account_id
    -- livemode -> is_live_mode
    -- reversed -> is_reversed
    -- source_type -> payment_source_type
    SELECT 
        "id" AS "payout_id",
        "amount" AS "payout_amount_cents",
        "amount_reversed" AS "reversed_amount_cents",
        "balance_transaction_id",
        "created" AS "payout_created_at",
        "currency",
        "description" AS "payout_description",
        "destination" AS "destination_bank_account_id",
        "destination_payment",
        "destination_payment_id",
        "livemode" AS "is_live_mode",
        "metadata",
        "reversed" AS "is_reversed",
        "source_transaction",
        "source_transaction_id",
        "source_type" AS "payment_source_type",
        "transfer_group"
    FROM "transfer_data_projected"
),

"transfer_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- destination_payment: from DECIMAL to VARCHAR
    -- destination_payment_id: from DECIMAL to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- payout_created_at: from VARCHAR to TIMESTAMP
    -- source_transaction: from DECIMAL to VARCHAR
    -- source_transaction_id: from DECIMAL to VARCHAR
    -- transfer_group: from DECIMAL to VARCHAR
    SELECT
        "payout_id",
        "payout_amount_cents",
        "reversed_amount_cents",
        "balance_transaction_id",
        "currency",
        "payout_description",
        "destination_bank_account_id",
        "is_live_mode",
        "is_reversed",
        "payment_source_type",
        CAST("destination_payment" AS VARCHAR) AS "destination_payment",
        CAST("destination_payment_id" AS VARCHAR) AS "destination_payment_id",
        CAST(TRIM("metadata", '"') AS JSON) AS "metadata",
        CAST("payout_created_at" AS TIMESTAMP) AS "payout_created_at",
        CAST("source_transaction" AS VARCHAR) AS "source_transaction",
        CAST("source_transaction_id" AS VARCHAR) AS "source_transaction_id",
        CAST("transfer_group" AS VARCHAR) AS "transfer_group"
    FROM "transfer_data_projected_renamed"
),

"transfer_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- metadata has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- source_transaction has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_transaction_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transfer_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "payout_id",
        "payout_amount_cents",
        "reversed_amount_cents",
        "balance_transaction_id",
        "currency",
        "payout_description",
        "destination_bank_account_id",
        "is_live_mode",
        "is_reversed",
        "payment_source_type",
        "destination_payment",
        "destination_payment_id",
        "metadata",
        "payout_created_at"
    FROM "transfer_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "transfer_data_projected_renamed_casted_missing_handled"