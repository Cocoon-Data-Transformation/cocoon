-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"refund_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "balance_transaction_id",
        "charge_id",
        "created",
        "currency",
        "description",
        "failure_balance_transaction_id",
        "failure_reason",
        "metadata",
        "reason",
        "receipt_number",
        "status"
    FROM "refund_data"
),

"refund_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> refund_id
    -- amount -> refund_amount_cents
    -- created -> refund_created_at
    -- description -> refund_description
    -- reason -> refund_reason
    -- status -> refund_status
    SELECT 
        "id" AS "refund_id",
        "amount" AS "refund_amount_cents",
        "balance_transaction_id",
        "charge_id",
        "created" AS "refund_created_at",
        "currency",
        "description" AS "refund_description",
        "failure_balance_transaction_id",
        "failure_reason",
        "metadata",
        "reason" AS "refund_reason",
        "receipt_number",
        "status" AS "refund_status"
    FROM "refund_data_projected"
),

"refund_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- failure_balance_transaction_id: from DECIMAL to VARCHAR
    -- failure_reason: from DECIMAL to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- refund_created_at: from VARCHAR to TIMESTAMP
    -- refund_description: from DECIMAL to VARCHAR
    SELECT
        "refund_id",
        "refund_amount_cents",
        "balance_transaction_id",
        "charge_id",
        "currency",
        "refund_reason",
        "receipt_number",
        "refund_status",
        CAST("failure_balance_transaction_id" AS VARCHAR) AS "failure_balance_transaction_id",
        CAST("failure_reason" AS VARCHAR) AS "failure_reason",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("refund_created_at" AS TIMESTAMP) AS "refund_created_at",
        CAST("refund_description" AS VARCHAR) AS "refund_description"
    FROM "refund_data_projected_renamed"
),

"refund_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- refund_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "refund_id",
        "refund_amount_cents",
        "balance_transaction_id",
        "charge_id",
        "currency",
        "refund_reason",
        "receipt_number",
        "refund_status",
        "failure_balance_transaction_id",
        "failure_reason",
        "metadata",
        "refund_created_at"
    FROM "refund_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "refund_data_projected_renamed_casted_missing_handled"