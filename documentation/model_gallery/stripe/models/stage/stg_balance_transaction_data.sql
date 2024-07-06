-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"balance_transaction_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "available_on",
        "connected_account_id",
        "created",
        "currency",
        "description",
        "exchange_rate",
        "fee",
        "net",
        "source",
        "status",
        "type",
        "payout_id"
    FROM "balance_transaction_data"
),

"balance_transaction_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> transaction_id
    -- amount -> transaction_amount_cents
    -- available_on -> funds_available_date
    -- created -> transaction_created_at
    -- currency -> currency_code
    -- description -> transaction_description
    -- fee -> fee_amount_cents
    -- net -> net_amount_cents
    -- source -> transaction_source_id
    -- status -> transaction_status
    -- type -> transaction_type
    SELECT 
        "id" AS "transaction_id",
        "amount" AS "transaction_amount_cents",
        "available_on" AS "funds_available_date",
        "connected_account_id",
        "created" AS "transaction_created_at",
        "currency" AS "currency_code",
        "description" AS "transaction_description",
        "exchange_rate",
        "fee" AS "fee_amount_cents",
        "net" AS "net_amount_cents",
        "source" AS "transaction_source_id",
        "status" AS "transaction_status",
        "type" AS "transaction_type",
        "payout_id"
    FROM "balance_transaction_data_projected"
),

"balance_transaction_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- connected_account_id: from DECIMAL to VARCHAR
    -- funds_available_date: from VARCHAR to DATE
    -- transaction_created_at: from VARCHAR to TIMESTAMP
    SELECT
        "transaction_id",
        "transaction_amount_cents",
        "currency_code",
        "transaction_description",
        "exchange_rate",
        "fee_amount_cents",
        "net_amount_cents",
        "transaction_source_id",
        "transaction_status",
        "transaction_type",
        "payout_id",
        CAST("connected_account_id" AS VARCHAR) AS "connected_account_id",
        CAST("funds_available_date" AS DATE) AS "funds_available_date",
        CAST("transaction_created_at" AS TIMESTAMP) AS "transaction_created_at"
    FROM "balance_transaction_data_projected_renamed"
),

"balance_transaction_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- exchange_rate has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payout_id has 22.22 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "transaction_id",
        "transaction_amount_cents",
        "currency_code",
        "transaction_description",
        "fee_amount_cents",
        "net_amount_cents",
        "transaction_source_id",
        "transaction_status",
        "transaction_type",
        "payout_id",
        "connected_account_id",
        "funds_available_date",
        "transaction_created_at"
    FROM "balance_transaction_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "balance_transaction_data_projected_renamed_casted_missing_handled"