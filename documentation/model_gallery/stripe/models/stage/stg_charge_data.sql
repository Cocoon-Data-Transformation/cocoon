-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "charge_data"
),

"charge_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> charge_id
    -- amount -> amount_cents
    -- amount_refunded -> refunded_cents
    -- application_fee_amount -> app_fee_amount
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
    -- shipping_address_line_1 -> shipping_address_1
    -- shipping_address_line_2 -> shipping_address_2
    -- shipping_address_postal_code -> shipping_postal_code
    -- shipping_address_state -> shipping_state
    -- shipping_name -> shipping_recipient_name
    -- status -> charge_status
    -- transfer_data_destination -> transfer_destination
    SELECT 
        "id" AS "charge_id",
        "amount" AS "amount_cents",
        "amount_refunded" AS "refunded_cents",
        "application",
        "application_fee_amount" AS "app_fee_amount",
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
        "shipping_address_line_1" AS "shipping_address_1",
        "shipping_address_line_2" AS "shipping_address_2",
        "shipping_address_postal_code" AS "shipping_postal_code",
        "shipping_address_state" AS "shipping_state",
        "shipping_carrier",
        "shipping_name" AS "shipping_recipient_name",
        "shipping_phone",
        "shipping_tracking_number",
        "source_id",
        "source_transfer",
        "statement_descriptor",
        "status" AS "charge_status",
        "transfer_data_destination" AS "transfer_destination",
        "transfer_group",
        "transfer_id",
        "calculated_statement_descriptor"
    FROM "charge_data_projected"
),

"charge_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_fee_amount: from DECIMAL to VARCHAR
    -- balance_transaction_id: from DECIMAL to VARCHAR
    -- bank_account_id: from DECIMAL to VARCHAR
    -- connected_account_id: from DECIMAL to VARCHAR
    -- created_at: from VARCHAR to TIMESTAMP
    -- destination: from DECIMAL to VARCHAR
    -- invoice_id: from DECIMAL to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- on_behalf_of: from DECIMAL to VARCHAR
    -- receipt_number: from DECIMAL to VARCHAR
    -- receipt_url: from DECIMAL to VARCHAR
    -- risk_score: from DECIMAL to VARCHAR
    -- shipping_address_1: from DECIMAL to VARCHAR
    -- shipping_address_2: from DECIMAL to VARCHAR
    -- shipping_carrier: from DECIMAL to VARCHAR
    -- shipping_city: from DECIMAL to VARCHAR
    -- shipping_country: from DECIMAL to VARCHAR
    -- shipping_phone: from DECIMAL to VARCHAR
    -- shipping_postal_code: from DECIMAL to VARCHAR
    -- shipping_recipient_name: from DECIMAL to VARCHAR
    -- shipping_state: from DECIMAL to VARCHAR
    -- shipping_tracking_number: from DECIMAL to VARCHAR
    -- source_id: from DECIMAL to VARCHAR
    -- source_transfer: from DECIMAL to VARCHAR
    -- statement_descriptor: from DECIMAL to VARCHAR
    -- stripe_fraud_report: from DECIMAL to VARCHAR
    -- transfer_destination: from DECIMAL to VARCHAR
    -- transfer_group: from DECIMAL to VARCHAR
    -- transfer_id: from DECIMAL to VARCHAR
    -- user_fraud_report: from DECIMAL to VARCHAR
    SELECT
        "charge_id",
        "amount_cents",
        "refunded_cents",
        "application",
        "is_captured",
        "card_id",
        "currency",
        "customer_id",
        "description",
        "failure_code",
        "failure_message",
        "is_live",
        "network_status",
        "outcome_reason",
        "risk_level",
        "seller_message",
        "outcome_type",
        "is_paid",
        "payment_intent_id",
        "hashed_receipt_email",
        "is_refunded",
        "charge_status",
        "calculated_statement_descriptor",
        CAST("app_fee_amount" AS VARCHAR) AS "app_fee_amount",
        CAST("balance_transaction_id" AS VARCHAR) AS "balance_transaction_id",
        CAST("bank_account_id" AS VARCHAR) AS "bank_account_id",
        CAST("connected_account_id" AS VARCHAR) AS "connected_account_id",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("destination" AS VARCHAR) AS "destination",
        CAST("invoice_id" AS VARCHAR) AS "invoice_id",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("on_behalf_of" AS VARCHAR) AS "on_behalf_of",
        CAST("receipt_number" AS VARCHAR) AS "receipt_number",
        CAST("receipt_url" AS VARCHAR) AS "receipt_url",
        CAST("risk_score" AS VARCHAR) AS "risk_score",
        CAST("shipping_address_1" AS VARCHAR) AS "shipping_address_1",
        CAST("shipping_address_2" AS VARCHAR) AS "shipping_address_2",
        CAST("shipping_carrier" AS VARCHAR) AS "shipping_carrier",
        CAST("shipping_city" AS VARCHAR) AS "shipping_city",
        CAST("shipping_country" AS VARCHAR) AS "shipping_country",
        CAST("shipping_phone" AS VARCHAR) AS "shipping_phone",
        CAST("shipping_postal_code" AS VARCHAR) AS "shipping_postal_code",
        CAST("shipping_recipient_name" AS VARCHAR) AS "shipping_recipient_name",
        CAST("shipping_state" AS VARCHAR) AS "shipping_state",
        CAST("shipping_tracking_number" AS VARCHAR) AS "shipping_tracking_number",
        CAST("source_id" AS VARCHAR) AS "source_id",
        CAST("source_transfer" AS VARCHAR) AS "source_transfer",
        CAST("statement_descriptor" AS VARCHAR) AS "statement_descriptor",
        CAST("stripe_fraud_report" AS VARCHAR) AS "stripe_fraud_report",
        CAST("transfer_destination" AS VARCHAR) AS "transfer_destination",
        CAST("transfer_group" AS VARCHAR) AS "transfer_group",
        CAST("transfer_id" AS VARCHAR) AS "transfer_id",
        CAST("user_fraud_report" AS VARCHAR) AS "user_fraud_report"
    FROM "charge_data_projected_renamed"
),

"charge_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 16 columns with unacceptable missing values
    -- app_fee_amount has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- application has 93.75 percent missing. Strategy: 🗑️ Drop Column
    -- balance_transaction_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bank_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- connected_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- destination has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- on_behalf_of has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- risk_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_transfer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statement_descriptor has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- stripe_fraud_report has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transfer_destination has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transfer_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transfer_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_fraud_report has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "charge_id",
        "amount_cents",
        "refunded_cents",
        "is_captured",
        "card_id",
        "currency",
        "customer_id",
        "description",
        "failure_code",
        "failure_message",
        "is_live",
        "network_status",
        "outcome_reason",
        "risk_level",
        "seller_message",
        "outcome_type",
        "is_paid",
        "payment_intent_id",
        "hashed_receipt_email",
        "is_refunded",
        "charge_status",
        "calculated_statement_descriptor",
        "created_at",
        "invoice_id",
        "metadata",
        "receipt_number",
        "receipt_url",
        "shipping_address_1",
        "shipping_address_2",
        "shipping_carrier",
        "shipping_city",
        "shipping_country",
        "shipping_phone",
        "shipping_postal_code",
        "shipping_recipient_name",
        "shipping_state",
        "shipping_tracking_number"
    FROM "charge_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "charge_data_projected_renamed_casted_missing_handled"