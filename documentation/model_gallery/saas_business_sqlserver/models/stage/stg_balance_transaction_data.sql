-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:44:25.074354+00:00
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
    FROM "MyAppDB"."dbo"."balance_transaction_data"
),

"balance_transaction_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> transaction_id
    -- amount -> amount_cents
    -- available_on -> available_date
    -- created -> creation_datetime
    -- currency -> currency_code
    -- fee -> fee_cents
    -- net -> net_amount_cents
    -- source -> source_id
    -- type -> transaction_type
    SELECT 
        "id" AS "transaction_id",
        "amount" AS "amount_cents",
        "available_on" AS "available_date",
        "connected_account_id",
        "created" AS "creation_datetime",
        "currency" AS "currency_code",
        "description",
        "exchange_rate",
        "fee" AS "fee_cents",
        "net" AS "net_amount_cents",
        "source" AS "source_id",
        "status",
        "type" AS "transaction_type",
        "payout_id"
    FROM "balance_transaction_data_projected"
),

"balance_transaction_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- available_date: from VARCHAR to DATETIME
    -- connected_account_id: from FLOAT to VARCHAR
    -- creation_datetime: from VARCHAR to DATETIME
    -- exchange_rate: from FLOAT to DECIMAL
    SELECT
        "transaction_id",
        "amount_cents",
        "currency_code",
        "description",
        "fee_cents",
        "net_amount_cents",
        "source_id",
        "status",
        "transaction_type",
        "payout_id",
        CAST("available_date" AS DATETIME) 
        AS "available_date",
        CAST("connected_account_id" AS VARCHAR) 
        AS "connected_account_id",
        CAST("creation_datetime" AS DATETIME) 
        AS "creation_datetime",
        CAST("exchange_rate" AS DECIMAL(18, 6)) 
        AS "exchange_rate"
    FROM "balance_transaction_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "balance_transaction_data_projected_renamed_casted"