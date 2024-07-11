-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "fee_data"
),

"fee_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- balance_transaction_id -> transaction_id
    -- index_ -> group_index
    -- amount -> amount_cents
    -- currency -> currency_code
    -- description -> category_hash
    -- type -> type_hash
    SELECT 
        "balance_transaction_id" AS "transaction_id",
        "index_" AS "group_index",
        "amount" AS "amount_cents",
        "application",
        "connected_account_id",
        "currency" AS "currency_code",
        "description" AS "category_hash",
        "type" AS "type_hash"
    FROM "fee_data_projected"
),

"fee_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- application: from DECIMAL to VARCHAR
    -- connected_account_id: from DECIMAL to VARCHAR
    SELECT
        "transaction_id",
        "group_index",
        "amount_cents",
        "currency_code",
        "category_hash",
        "type_hash",
        CAST("application" AS VARCHAR) AS "application",
        CAST("connected_account_id" AS VARCHAR) AS "connected_account_id"
    FROM "fee_data_projected_renamed"
),

"fee_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- application has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- connected_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "transaction_id",
        "group_index",
        "amount_cents",
        "currency_code",
        "category_hash",
        "type_hash"
    FROM "fee_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "fee_data_projected_renamed_casted_missing_handled"