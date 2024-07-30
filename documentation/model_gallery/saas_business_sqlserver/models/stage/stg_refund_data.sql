-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:46:12.534290+00:00
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
    FROM "MyAppDB"."dbo"."refund_data"
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
    -- failure_balance_transaction_id: from FLOAT to VARCHAR
    -- failure_reason: from FLOAT to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- refund_created_at: from VARCHAR to DATETIME
    -- refund_description: from FLOAT to VARCHAR
    SELECT
        "refund_id",
        "refund_amount_cents",
        "balance_transaction_id",
        "charge_id",
        "currency",
        "refund_reason",
        "receipt_number",
        "refund_status",
        CAST("failure_balance_transaction_id" AS VARCHAR) 
        AS "failure_balance_transaction_id",
        CAST("failure_reason" AS VARCHAR(MAX)) 
        AS "failure_reason",
        "metadata" 
        AS "metadata",
        CAST("refund_created_at" AS DATETIME) 
        AS "refund_created_at",
        CAST("refund_description" AS VARCHAR) 
        AS "refund_description"
    FROM "refund_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "refund_data_projected_renamed_casted"