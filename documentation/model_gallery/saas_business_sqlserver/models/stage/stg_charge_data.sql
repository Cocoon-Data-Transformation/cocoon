-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:44:47.550699+00:00
WITH 
"charge_data_projected" AS (
    -- Projection: Selecting 53 out of 54 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "amount_refunded",
        "application",
        "application_fee_amount",
        "balance_transaction_id",
        "bank_account_id",
        "captured",
        "card_id",
        "connected_account_id",
        "created",
        "currency",
        "customer_id",
        "description",
        "destination",
        "failure_code",
        "failure_message",
        "fraud_details_stripe_report",
        "fraud_details_user_report",
        "invoice_id",
        "livemode",
        "metadata",
        "on_behalf_of",
        "outcome_network_status",
        "outcome_reason",
        "outcome_risk_level",
        "outcome_risk_score",
        "outcome_seller_message",
        "outcome_type",
        "paid",
        "payment_intent_id",
        "receipt_email",
        "receipt_number",
        "receipt_url",
        "refunded",
        "shipping_address_city",
        "shipping_address_country",
        "shipping_address_line_1",
        "shipping_address_line_2",
        "shipping_address_postal_code",
        "shipping_address_state",
        "shipping_carrier",
        "shipping_name",
        "shipping_phone",
        "shipping_tracking_number",
        "source_id",
        "source_transfer",
        "statement_descriptor",
        "status",
        "transfer_data_destination",
        "transfer_group",
        "transfer_id",
        "calculated_statement_descriptor"
    FROM "MyAppDB"."dbo"."charge_data"
),

"charge_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> charge_id
    -- amount -> amount_cents
    -- amount_refunded -> refunded_cents
    -- application_fee_amount -> app_fee_cents
    -- captured -> is_captured
    -- created -> created_at
    -- fraud_details_stripe_report -> stripe_fraud_report
    -- fraud_details_user_report -> user_fraud_report
    -- livemode -> is_live
    -- outcome_network_status -> network_status
    -- outcome_risk_level -> risk_level
    -- outcome_risk_score -> risk_score
    -- outcome_seller_message -> seller_message
    -- paid -> is_paid
    -- receipt_email -> hashed_receipt_email
    -- refunded -> is_refunded
    -- shipping_address_city -> shipping_city
    -- shipping_address_country -> shipping_country
    -- shipping_address_line_1 -> shipping_address_line1
    -- shipping_address_line_2 -> shipping_address_line2
    -- shipping_address_postal_code -> shipping_postal_code
    -- shipping_address_state -> shipping_state
    -- shipping_name -> shipping_recipient_name
    -- status -> payment_status
    -- transfer_data_destination -> transfer_destination
    SELECT 
        "id" AS "charge_id",
        "amount" AS "amount_cents",
        "amount_refunded" AS "refunded_cents",
        "application",
        "application_fee_amount" AS "app_fee_cents",
        "balance_transaction_id",
        "bank_account_id",
        "captured" AS "is_captured",
        "card_id",
        "connected_account_id",
        "created" AS "created_at",
        "currency",
        "customer_id",
        "description",
        "destination",
        "failure_code",
        "failure_message",
        "fraud_details_stripe_report" AS "stripe_fraud_report",
        "fraud_details_user_report" AS "user_fraud_report",
        "invoice_id",
        "livemode" AS "is_live",
        "metadata",
        "on_behalf_of",
        "outcome_network_status" AS "network_status",
        "outcome_reason",
        "outcome_risk_level" AS "risk_level",
        "outcome_risk_score" AS "risk_score",
        "outcome_seller_message" AS "seller_message",
        "outcome_type",
        "paid" AS "is_paid",
        "payment_intent_id",
        "receipt_email" AS "hashed_receipt_email",
        "receipt_number",
        "receipt_url",
        "refunded" AS "is_refunded",
        "shipping_address_city" AS "shipping_city",
        "shipping_address_country" AS "shipping_country",
        "shipping_address_line_1" AS "shipping_address_line1",
        "shipping_address_line_2" AS "shipping_address_line2",
        "shipping_address_postal_code" AS "shipping_postal_code",
        "shipping_address_state" AS "shipping_state",
        "shipping_carrier",
        "shipping_name" AS "shipping_recipient_name",
        "shipping_phone",
        "shipping_tracking_number",
        "source_id",
        "source_transfer",
        "statement_descriptor",
        "status" AS "payment_status",
        "transfer_data_destination" AS "transfer_destination",
        "transfer_group",
        "transfer_id",
        "calculated_statement_descriptor"
    FROM "charge_data_projected"
),

"charge_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_fee_cents: from FLOAT to INT
    -- balance_transaction_id: from FLOAT to VARCHAR
    -- bank_account_id: from FLOAT to VARCHAR
    -- connected_account_id: from FLOAT to VARCHAR
    -- created_at: from VARCHAR to DATETIME
    -- destination: from FLOAT to VARCHAR
    -- invoice_id: from FLOAT to VARCHAR
    -- is_captured: from VARCHAR to BOOLEAN
    -- is_live: from VARCHAR to BOOLEAN
    -- is_paid: from VARCHAR to BOOLEAN
    -- is_refunded: from VARCHAR to BOOLEAN
    -- metadata: from VARCHAR to JSON
    -- on_behalf_of: from FLOAT to VARCHAR
    -- receipt_number: from FLOAT to VARCHAR
    -- receipt_url: from FLOAT to VARCHAR
    -- shipping_address_line1: from FLOAT to VARCHAR
    -- shipping_address_line2: from FLOAT to VARCHAR
    -- shipping_carrier: from FLOAT to VARCHAR
    -- shipping_city: from FLOAT to VARCHAR
    -- shipping_country: from FLOAT to VARCHAR
    -- shipping_phone: from FLOAT to VARCHAR
    -- shipping_postal_code: from FLOAT to VARCHAR
    -- shipping_recipient_name: from FLOAT to VARCHAR
    -- shipping_state: from FLOAT to VARCHAR
    -- shipping_tracking_number: from FLOAT to VARCHAR
    -- source_id: from FLOAT to VARCHAR
    -- source_transfer: from FLOAT to VARCHAR
    -- statement_descriptor: from FLOAT to VARCHAR
    -- stripe_fraud_report: from FLOAT to JSON
    -- transfer_destination: from FLOAT to VARCHAR
    -- transfer_group: from FLOAT to VARCHAR
    -- transfer_id: from FLOAT to VARCHAR
    -- user_fraud_report: from FLOAT to JSON
    SELECT
        "charge_id",
        "amount_cents",
        "refunded_cents",
        "application",
        "card_id",
        "currency",
        "customer_id",
        "description",
        "failure_code",
        "failure_message",
        "network_status",
        "outcome_reason",
        "risk_level",
        "risk_score",
        "seller_message",
        "outcome_type",
        "payment_intent_id",
        "hashed_receipt_email",
        "payment_status",
        "calculated_statement_descriptor",
        CAST("app_fee_cents" AS INT) 
        AS "app_fee_cents",
        CAST("balance_transaction_id" AS VARCHAR) 
        AS "balance_transaction_id",
        CAST("bank_account_id" AS VARCHAR) 
        AS "bank_account_id",
        CAST("connected_account_id" AS VARCHAR) 
        AS "connected_account_id",
        CAST("created_at" AS DATETIME) 
        AS "created_at",
        CAST("destination" AS VARCHAR) 
        AS "destination",
        CAST("invoice_id" AS VARCHAR) 
        AS "invoice_id",
        CASE WHEN "is_captured" = '0' THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END 
        AS "is_captured",
        CAST("is_live" AS BIT) 
        AS "is_live",
        CASE WHEN "is_paid" = '0' THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END 
        AS "is_paid",
        CAST("is_refunded" AS BIT) 
        AS "is_refunded",
        "metadata" 
        AS "metadata",
        CAST("on_behalf_of" AS VARCHAR) 
        AS "on_behalf_of",
        CAST("receipt_number" AS VARCHAR) 
        AS "receipt_number",
        CAST("receipt_url" AS VARCHAR(MAX)) 
        AS "receipt_url",
        CAST("shipping_address_line1" AS VARCHAR(255)) 
        AS "shipping_address_line1",
        CAST("shipping_address_line2" AS VARCHAR) 
        AS "shipping_address_line2",
        CAST("shipping_carrier" AS VARCHAR) 
        AS "shipping_carrier",
        CAST("shipping_city" AS VARCHAR) 
        AS "shipping_city",
        CAST("shipping_country" AS VARCHAR) 
        AS "shipping_country",
        CAST("shipping_phone" AS VARCHAR) 
        AS "shipping_phone",
        CAST("shipping_postal_code" AS VARCHAR) 
        AS "shipping_postal_code",
        CAST("shipping_recipient_name" AS VARCHAR) 
        AS "shipping_recipient_name",
        CAST("shipping_state" AS VARCHAR) 
        AS "shipping_state",
        CAST("shipping_tracking_number" AS VARCHAR) 
        AS "shipping_tracking_number",
        CAST("source_id" AS VARCHAR) 
        AS "source_id",
        CAST("source_transfer" AS VARCHAR) 
        AS "source_transfer",
        CAST("statement_descriptor" AS VARCHAR(255)) 
        AS "statement_descriptor",
        CAST("stripe_fraud_report" AS NVARCHAR(MAX)) 
        AS "stripe_fraud_report",
        CAST("transfer_destination" AS VARCHAR) 
        AS "transfer_destination",
        CAST("transfer_group" AS VARCHAR) 
        AS "transfer_group",
        CAST("transfer_id" AS VARCHAR) 
        AS "transfer_id",
        CAST("user_fraud_report" AS NVARCHAR(MAX)) 
        AS "user_fraud_report"
    FROM "charge_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "charge_data_projected_renamed_casted"