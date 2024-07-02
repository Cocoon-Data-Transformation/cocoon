-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completedorder_renamed" AS (
    -- Rename: Renaming columns
    -- order_id -> transaction_id
    -- account_id -> customer_account_id
    -- bank_to -> recipient_bank_code
    -- account_to -> recipient_account_number
    -- amount -> transaction_amount
    -- k_symbol -> payment_type
    SELECT 
        "order_id" AS "transaction_id",
        "account_id" AS "customer_account_id",
        "bank_to" AS "recipient_bank_code",
        "account_to" AS "recipient_account_number",
        "amount" AS "transaction_amount",
        "k_symbol" AS "payment_type"
    FROM "completedorder"
),

"completedorder_renamed_casted" AS (
    -- Column Type Casting: 
    -- recipient_account_number: from INT to VARCHAR
    -- transaction_id: from INT to VARCHAR
    SELECT
        "customer_account_id",
        "recipient_bank_code",
        "transaction_amount",
        "payment_type",
        CAST("recipient_account_number" AS VARCHAR) AS "recipient_account_number",
        CAST("transaction_id" AS VARCHAR) AS "transaction_id"
    FROM "completedorder_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "completedorder_renamed_casted"