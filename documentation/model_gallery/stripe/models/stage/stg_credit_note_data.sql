-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"credit_note_data_projected" AS (
    -- Projection: Selecting 19 out of 20 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "created",
        "currency",
        "discount_amount",
        "subtotal",
        "total",
        "livemode",
        "memo",
        "metadata",
        "number",
        "pdf",
        "reason",
        "status",
        "type",
        "voided_at",
        "customer_balance_transaction_id",
        "invoice_id",
        "refund_id"
    FROM "credit_note_data"
),

"credit_note_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> credit_note_id
    -- amount -> credit_note_amount
    -- created -> creation_date
    -- livemode -> is_live
    -- number -> credit_note_number
    -- pdf -> pdf_url
    -- type -> credit_note_type
    -- voided_at -> void_date
    -- customer_balance_transaction_id -> balance_transaction_id
    SELECT 
        "id" AS "credit_note_id",
        "amount" AS "credit_note_amount",
        "created" AS "creation_date",
        "currency",
        "discount_amount",
        "subtotal",
        "total",
        "livemode" AS "is_live",
        "memo",
        "metadata",
        "number" AS "credit_note_number",
        "pdf" AS "pdf_url",
        "reason",
        "status",
        "type" AS "credit_note_type",
        "voided_at" AS "void_date",
        "customer_balance_transaction_id" AS "balance_transaction_id",
        "invoice_id",
        "refund_id"
    FROM "credit_note_data_projected"
),

"credit_note_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- balance_transaction_id: from DECIMAL to VARCHAR
    -- creation_date: from VARCHAR to TIMESTAMP
    -- credit_note_amount: from INT to DECIMAL
    -- discount_amount: from INT to DECIMAL
    -- memo: from DECIMAL to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- reason: from DECIMAL to VARCHAR
    -- subtotal: from INT to DECIMAL
    -- total: from INT to DECIMAL
    -- void_date: from DECIMAL to DATE
    SELECT
        "credit_note_id",
        "currency",
        "is_live",
        "credit_note_number",
        "pdf_url",
        "status",
        "credit_note_type",
        "invoice_id",
        "refund_id",
        CAST("balance_transaction_id" AS VARCHAR) AS "balance_transaction_id",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("credit_note_amount" AS DECIMAL) AS "credit_note_amount",
        CAST("discount_amount" AS DECIMAL) AS "discount_amount",
        CAST("memo" AS VARCHAR) AS "memo",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("reason" AS VARCHAR) AS "reason",
        CAST("subtotal" AS DECIMAL) AS "subtotal",
        CAST("total" AS DECIMAL) AS "total",
        CAST("void_date" AS DATE) AS "void_date"
    FROM "credit_note_data_projected_renamed"
),

"credit_note_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- balance_transaction_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- memo has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "credit_note_id",
        "currency",
        "is_live",
        "credit_note_number",
        "pdf_url",
        "status",
        "credit_note_type",
        "invoice_id",
        "refund_id",
        "creation_date",
        "credit_note_amount",
        "discount_amount",
        "metadata",
        "subtotal",
        "total",
        "void_date"
    FROM "credit_note_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "credit_note_data_projected_renamed_casted_missing_handled"