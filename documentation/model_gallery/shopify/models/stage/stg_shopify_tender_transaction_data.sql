-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_tender_transaction_data_projected" AS (
    -- Projection: Selecting 11 out of 12 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "currency",
        "order_id",
        "payment_details_credit_card_company",
        "payment_details_credit_card_number",
        "payment_method",
        "processed_at",
        "remote_reference",
        "test",
        "user_id"
    FROM "shopify_tender_transaction_data"
),

"shopify_tender_transaction_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> transaction_id
    -- amount -> transaction_amount
    -- payment_details_credit_card_company -> credit_card_company
    -- payment_details_credit_card_number -> masked_card_number
    -- processed_at -> processing_timestamp
    -- remote_reference -> external_reference
    -- test -> is_test_transaction
    SELECT 
        "id" AS "transaction_id",
        "amount" AS "transaction_amount",
        "currency",
        "order_id",
        "payment_details_credit_card_company" AS "credit_card_company",
        "payment_details_credit_card_number" AS "masked_card_number",
        "payment_method",
        "processed_at" AS "processing_timestamp",
        "remote_reference" AS "external_reference",
        "test" AS "is_test_transaction",
        "user_id"
    FROM "shopify_tender_transaction_data_projected"
),

"shopify_tender_transaction_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- credit_card_company: from DECIMAL to VARCHAR
    -- external_reference: from DECIMAL to VARCHAR
    -- masked_card_number: from DECIMAL to VARCHAR
    -- order_id: from INT to VARCHAR
    -- processing_timestamp: from VARCHAR to TIMESTAMP
    -- transaction_id: from INT to VARCHAR
    -- user_id: from DECIMAL to VARCHAR
    SELECT
        "transaction_amount",
        "currency",
        "payment_method",
        "is_test_transaction",
        CAST("credit_card_company" AS VARCHAR) AS "credit_card_company",
        CAST("external_reference" AS VARCHAR) AS "external_reference",
        CAST("masked_card_number" AS VARCHAR) AS "masked_card_number",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("processing_timestamp" AS TIMESTAMP) AS "processing_timestamp",
        CAST("transaction_id" AS VARCHAR) AS "transaction_id",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "shopify_tender_transaction_data_projected_renamed"
),

"shopify_tender_transaction_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- external_reference has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- masked_card_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "transaction_amount",
        "currency",
        "payment_method",
        "is_test_transaction",
        "credit_card_company",
        "order_id",
        "processing_timestamp",
        "transaction_id"
    FROM "shopify_tender_transaction_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_tender_transaction_data_projected_renamed_casted_missing_handled"