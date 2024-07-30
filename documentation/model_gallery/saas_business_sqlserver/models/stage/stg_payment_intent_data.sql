-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:45:55.395843+00:00
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
    FROM "MyAppDB"."dbo"."payment_intent_data"
),

"payment_intent_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payment_intent_id
    -- created -> created_at
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
        "amount",
        "amount_capturable",
        "amount_received",
        "application",
        "application_fee_amount",
        "canceled_at",
        "cancellation_reason",
        "capture_method",
        "confirmation_method",
        "created" AS "created_at",
        "currency",
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
    -- application_fee_amount: from FLOAT to INT
    -- canceled_at: from VARCHAR to DATETIME
    -- cancellation_reason: from FLOAT to VARCHAR
    -- created_at: from VARCHAR to DATETIME
    -- decline_code: from FLOAT to VARCHAR
    -- error_charge_id: from FLOAT to VARCHAR
    -- error_code: from FLOAT to VARCHAR
    -- error_doc_url: from FLOAT to VARCHAR
    -- error_message: from FLOAT to VARCHAR
    -- error_param: from FLOAT to VARCHAR
    -- error_source_id: from FLOAT to VARCHAR
    -- error_type: from FLOAT to VARCHAR
    -- is_live: from VARCHAR to BOOLEAN
    -- on_behalf_of: from FLOAT to VARCHAR
    -- source_id: from FLOAT to VARCHAR
    -- statement_descriptor: from FLOAT to VARCHAR
    -- transfer_destination: from FLOAT to VARCHAR
    -- transfer_group: from FLOAT to VARCHAR
    SELECT
        "payment_intent_id",
        "amount",
        "amount_capturable",
        "amount_received",
        "application",
        "capture_method",
        "confirmation_method",
        "currency",
        "customer_id",
        "description",
        "payment_method_id",
        "receipt_email",
        "status",
        CAST("application_fee_amount" AS INT) 
        AS "application_fee_amount",
        CAST("canceled_at" AS DATETIME) 
        AS "canceled_at",
        CAST("cancellation_reason" AS VARCHAR) 
        AS "cancellation_reason",
        CAST("created_at" AS DATETIME) 
        AS "created_at",
        CAST("decline_code" AS VARCHAR) 
        AS "decline_code",
        CAST("error_charge_id" AS VARCHAR) 
        AS "error_charge_id",
        CAST("error_code" AS VARCHAR) 
        AS "error_code",
        CAST("error_doc_url" AS VARCHAR) 
        AS "error_doc_url",
        CAST("error_message" AS VARCHAR(MAX)) 
        AS "error_message",
        CAST("error_param" AS VARCHAR) 
        AS "error_param",
        CAST("error_source_id" AS VARCHAR) 
        AS "error_source_id",
        CAST("error_type" AS VARCHAR) 
        AS "error_type",
        CAST("is_live" AS BIT) 
        AS "is_live",
        CAST("on_behalf_of" AS VARCHAR) 
        AS "on_behalf_of",
        CAST("source_id" AS VARCHAR) 
        AS "source_id",
        CAST("statement_descriptor" AS VARCHAR(255)) 
        AS "statement_descriptor",
        CAST("transfer_destination" AS VARCHAR) 
        AS "transfer_destination",
        CAST("transfer_group" AS VARCHAR) 
        AS "transfer_group"
    FROM "payment_intent_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "payment_intent_data_projected_renamed_casted"