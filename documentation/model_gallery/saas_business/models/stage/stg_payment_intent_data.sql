-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"payment_intent_data_projected" AS (
    -- Projection: Selecting 31 out of 32 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "amount_capturable",
        "amount_received",
        "application",
        "application_fee_amount",
        "canceled_at",
        "cancellation_reason",
        "capture_method",
        "confirmation_method",
        "created",
        "currency",
        "customer_id",
        "description",
        "last_payment_error_charge_id",
        "last_payment_error_code",
        "last_payment_error_decline_code",
        "last_payment_error_doc_url",
        "last_payment_error_message",
        "last_payment_error_param",
        "last_payment_error_source_id",
        "last_payment_error_type",
        "livemode",
        "on_behalf_of",
        "payment_method_id",
        "receipt_email",
        "source_id",
        "statement_descriptor",
        "status",
        "transfer_data_destination",
        "transfer_group"
    FROM "payment_intent_data"
),

"payment_intent_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payment_intent_id
    -- amount -> amount_in_cents
    -- created -> created_at
    -- currency -> currency_code
    -- last_payment_error_charge_id -> error_charge_id
    -- last_payment_error_code -> error_code
    -- last_payment_error_decline_code -> decline_code
    -- last_payment_error_doc_url -> error_doc_url
    -- last_payment_error_message -> error_message
    -- last_payment_error_param -> error_param
    -- last_payment_error_source_id -> error_source_id
    -- last_payment_error_type -> error_type
    -- livemode -> is_live
    -- transfer_data_destination -> transfer_destination
    SELECT 
        "id" AS "payment_intent_id",
        "amount" AS "amount_in_cents",
        "amount_capturable",
        "amount_received",
        "application",
        "application_fee_amount",
        "canceled_at",
        "cancellation_reason",
        "capture_method",
        "confirmation_method",
        "created" AS "created_at",
        "currency" AS "currency_code",
        "customer_id",
        "description",
        "last_payment_error_charge_id" AS "error_charge_id",
        "last_payment_error_code" AS "error_code",
        "last_payment_error_decline_code" AS "decline_code",
        "last_payment_error_doc_url" AS "error_doc_url",
        "last_payment_error_message" AS "error_message",
        "last_payment_error_param" AS "error_param",
        "last_payment_error_source_id" AS "error_source_id",
        "last_payment_error_type" AS "error_type",
        "livemode" AS "is_live",
        "on_behalf_of",
        "payment_method_id",
        "receipt_email",
        "source_id",
        "statement_descriptor",
        "status",
        "transfer_data_destination" AS "transfer_destination",
        "transfer_group"
    FROM "payment_intent_data_projected"
),

"payment_intent_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- application_fee_amount: from DECIMAL to VARCHAR
    -- canceled_at: from VARCHAR to TIMESTAMP
    -- cancellation_reason: from DECIMAL to VARCHAR
    -- created_at: from VARCHAR to TIMESTAMP
    -- decline_code: from DECIMAL to VARCHAR
    -- error_charge_id: from DECIMAL to VARCHAR
    -- error_code: from DECIMAL to VARCHAR
    -- error_doc_url: from DECIMAL to VARCHAR
    -- error_message: from DECIMAL to VARCHAR
    -- error_param: from DECIMAL to VARCHAR
    -- error_source_id: from DECIMAL to VARCHAR
    -- error_type: from DECIMAL to VARCHAR
    -- on_behalf_of: from DECIMAL to VARCHAR
    -- source_id: from DECIMAL to VARCHAR
    -- statement_descriptor: from DECIMAL to VARCHAR
    -- transfer_destination: from DECIMAL to VARCHAR
    -- transfer_group: from DECIMAL to VARCHAR
    SELECT
        "payment_intent_id",
        "amount_in_cents",
        "amount_capturable",
        "amount_received",
        "application",
        "capture_method",
        "confirmation_method",
        "currency_code",
        "customer_id",
        "description",
        "is_live",
        "payment_method_id",
        "receipt_email",
        "status",
        CAST("application_fee_amount" AS VARCHAR) AS "application_fee_amount",
        CAST("canceled_at" AS TIMESTAMP) AS "canceled_at",
        CAST("cancellation_reason" AS VARCHAR) AS "cancellation_reason",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("decline_code" AS VARCHAR) AS "decline_code",
        CAST("error_charge_id" AS VARCHAR) AS "error_charge_id",
        CAST("error_code" AS VARCHAR) AS "error_code",
        CAST("error_doc_url" AS VARCHAR) AS "error_doc_url",
        CAST("error_message" AS VARCHAR) AS "error_message",
        CAST("error_param" AS VARCHAR) AS "error_param",
        CAST("error_source_id" AS VARCHAR) AS "error_source_id",
        CAST("error_type" AS VARCHAR) AS "error_type",
        CAST("on_behalf_of" AS VARCHAR) AS "on_behalf_of",
        CAST("source_id" AS VARCHAR) AS "source_id",
        CAST("statement_descriptor" AS VARCHAR) AS "statement_descriptor",
        CAST("transfer_destination" AS VARCHAR) AS "transfer_destination",
        CAST("transfer_group" AS VARCHAR) AS "transfer_group"
    FROM "payment_intent_data_projected_renamed"
),

"payment_intent_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 9 columns with unacceptable missing values
    -- application has 63.64 percent missing. Strategy: 🔄 Unchanged
    -- application_fee_amount has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_id has 36.36 percent missing. Strategy: 🔄 Unchanged
    -- on_behalf_of has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- receipt_email has 63.64 percent missing. Strategy: 🔄 Unchanged
    -- source_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statement_descriptor has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transfer_destination has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transfer_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "payment_intent_id",
        "amount_in_cents",
        "amount_capturable",
        "amount_received",
        "application",
        "capture_method",
        "confirmation_method",
        "currency_code",
        "customer_id",
        "description",
        "is_live",
        "payment_method_id",
        "receipt_email",
        "status",
        "canceled_at",
        "cancellation_reason",
        "created_at",
        "decline_code",
        "error_charge_id",
        "error_code",
        "error_doc_url",
        "error_message",
        "error_param",
        "error_source_id",
        "error_type"
    FROM "payment_intent_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "payment_intent_data_projected_renamed_casted_missing_handled"