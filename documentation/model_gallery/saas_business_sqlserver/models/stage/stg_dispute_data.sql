-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:45:17.168781+00:00
WITH 
"dispute_data_projected" AS (
    -- Projection: Selecting 43 out of 44 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "balance_transaction",
        "charge_id",
        "connected_account_id",
        "created",
        "currency",
        "evidence_access_activity_log",
        "evidence_billing_address",
        "evidence_cancellation_policy",
        "evidence_cancellation_policy_disclosure",
        "evidence_cancellation_rebuttal",
        "evidence_customer_communication",
        "evidence_customer_email_address",
        "evidence_customer_name",
        "evidence_customer_purchase_ip",
        "evidence_customer_signature",
        "evidence_details_due_by",
        "evidence_details_has_evidence",
        "evidence_details_past_due",
        "evidence_details_submission_count",
        "evidence_duplicate_charge_documentation",
        "evidence_duplicate_charge_explanation",
        "evidence_duplicate_charge_id",
        "evidence_product_description",
        "evidence_receipt",
        "evidence_refund_policy",
        "evidence_refund_policy_disclosure",
        "evidence_refund_refusal_explanation",
        "evidence_service_date",
        "evidence_service_documentation",
        "evidence_shipping_address",
        "evidence_shipping_carrier",
        "evidence_shipping_date",
        "evidence_shipping_documentation",
        "evidence_shipping_tracking_number",
        "evidence_uncategorized_file",
        "evidence_uncategorized_text",
        "is_charge_refundable",
        "livemode",
        "metadata",
        "reason",
        "status"
    FROM "MyAppDB"."dbo"."dispute_data"
),

"dispute_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> dispute_id
    -- amount -> amount_cents
    -- balance_transaction -> balance_transaction_id
    -- created -> created_at
    -- currency -> currency_code
    -- evidence_details_due_by -> evidence_due_by
    -- evidence_details_has_evidence -> has_evidence
    -- evidence_details_past_due -> evidence_past_due
    -- evidence_details_submission_count -> evidence_submission_count
    -- evidence_receipt -> evidence_receipt_id
    -- evidence_service_documentation -> service_evidence_docs
    -- evidence_shipping_address -> shipping_address_evidence
    -- evidence_shipping_carrier -> shipping_carrier_evidence
    -- evidence_shipping_date -> shipping_date_evidence
    -- evidence_shipping_documentation -> shipping_docs_evidence
    -- evidence_shipping_tracking_number -> tracking_number_evidence
    -- evidence_uncategorized_file -> uncategorized_file_evidence
    -- evidence_uncategorized_text -> uncategorized_text_evidence
    -- reason -> dispute_reason
    -- status -> dispute_status
    SELECT 
        "id" AS "dispute_id",
        "amount" AS "amount_cents",
        "balance_transaction" AS "balance_transaction_id",
        "charge_id",
        "connected_account_id",
        "created" AS "created_at",
        "currency" AS "currency_code",
        "evidence_access_activity_log",
        "evidence_billing_address",
        "evidence_cancellation_policy",
        "evidence_cancellation_policy_disclosure",
        "evidence_cancellation_rebuttal",
        "evidence_customer_communication",
        "evidence_customer_email_address",
        "evidence_customer_name",
        "evidence_customer_purchase_ip",
        "evidence_customer_signature",
        "evidence_details_due_by" AS "evidence_due_by",
        "evidence_details_has_evidence" AS "has_evidence",
        "evidence_details_past_due" AS "evidence_past_due",
        "evidence_details_submission_count" AS "evidence_submission_count",
        "evidence_duplicate_charge_documentation",
        "evidence_duplicate_charge_explanation",
        "evidence_duplicate_charge_id",
        "evidence_product_description",
        "evidence_receipt" AS "evidence_receipt_id",
        "evidence_refund_policy",
        "evidence_refund_policy_disclosure",
        "evidence_refund_refusal_explanation",
        "evidence_service_date",
        "evidence_service_documentation" AS "service_evidence_docs",
        "evidence_shipping_address" AS "shipping_address_evidence",
        "evidence_shipping_carrier" AS "shipping_carrier_evidence",
        "evidence_shipping_date" AS "shipping_date_evidence",
        "evidence_shipping_documentation" AS "shipping_docs_evidence",
        "evidence_shipping_tracking_number" AS "tracking_number_evidence",
        "evidence_uncategorized_file" AS "uncategorized_file_evidence",
        "evidence_uncategorized_text" AS "uncategorized_text_evidence",
        "is_charge_refundable",
        "livemode",
        "metadata",
        "reason" AS "dispute_reason",
        "status" AS "dispute_status"
    FROM "dispute_data_projected"
),

"dispute_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- evidence_customer_purchase_ip: The problem is that the IP address 68.1.21.555 is invalid because the last octet (555) is outside the valid range of 0-255 for IP addresses. The correct value should have the last octet within this range. Since we don't have additional information about what the correct last octet should be, we'll replace it with a placeholder value within the valid range.
    SELECT
        "dispute_id",
        "amount_cents",
        "balance_transaction_id",
        "charge_id",
        "connected_account_id",
        "created_at",
        "currency_code",
        "evidence_access_activity_log",
        "evidence_billing_address",
        "evidence_cancellation_policy",
        "evidence_cancellation_policy_disclosure",
        "evidence_cancellation_rebuttal",
        "evidence_customer_communication",
        "evidence_customer_email_address",
        "evidence_customer_name",
        CASE
            WHEN "evidence_customer_purchase_ip" = '68.1.21.555' THEN '68.1.21.255'
            ELSE "evidence_customer_purchase_ip"
        END AS "evidence_customer_purchase_ip",
        "evidence_customer_signature",
        "evidence_due_by",
        "has_evidence",
        "evidence_past_due",
        "evidence_submission_count",
        "evidence_duplicate_charge_documentation",
        "evidence_duplicate_charge_explanation",
        "evidence_duplicate_charge_id",
        "evidence_product_description",
        "evidence_receipt_id",
        "evidence_refund_policy",
        "evidence_refund_policy_disclosure",
        "evidence_refund_refusal_explanation",
        "evidence_service_date",
        "service_evidence_docs",
        "shipping_address_evidence",
        "shipping_carrier_evidence",
        "shipping_date_evidence",
        "shipping_docs_evidence",
        "tracking_number_evidence",
        "uncategorized_file_evidence",
        "uncategorized_text_evidence",
        "is_charge_refundable",
        "livemode",
        "metadata",
        "dispute_reason",
        "dispute_status"
    FROM "dispute_data_projected_renamed"
),

"dispute_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- connected_account_id: from FLOAT to VARCHAR
    -- created_at: from VARCHAR to DATETIME
    -- evidence_access_activity_log: from FLOAT to VARCHAR
    -- evidence_cancellation_policy: from FLOAT to VARCHAR
    -- evidence_cancellation_policy_disclosure: from FLOAT to VARCHAR
    -- evidence_cancellation_rebuttal: from FLOAT to VARCHAR
    -- evidence_customer_communication: from FLOAT to VARCHAR
    -- evidence_customer_signature: from FLOAT to VARCHAR
    -- evidence_due_by: from VARCHAR to DATETIME
    -- evidence_duplicate_charge_documentation: from FLOAT to VARCHAR
    -- evidence_duplicate_charge_explanation: from FLOAT to VARCHAR
    -- evidence_duplicate_charge_id: from FLOAT to VARCHAR
    -- evidence_past_due: from VARCHAR to BOOLEAN
    -- evidence_product_description: from FLOAT to VARCHAR
    -- evidence_refund_policy: from FLOAT to VARCHAR
    -- evidence_refund_policy_disclosure: from FLOAT to VARCHAR
    -- evidence_refund_refusal_explanation: from FLOAT to VARCHAR
    -- evidence_service_date: from FLOAT to DATE
    -- has_evidence: from VARCHAR to BOOLEAN
    -- is_charge_refundable: from VARCHAR to BOOLEAN
    -- livemode: from VARCHAR to BOOLEAN
    -- metadata: from VARCHAR to JSON
    -- service_evidence_docs: from FLOAT to VARCHAR
    -- shipping_address_evidence: from FLOAT to VARCHAR
    -- shipping_carrier_evidence: from FLOAT to VARCHAR
    -- shipping_date_evidence: from FLOAT to DATE
    -- shipping_docs_evidence: from FLOAT to VARCHAR
    -- tracking_number_evidence: from FLOAT to VARCHAR
    -- uncategorized_file_evidence: from FLOAT to BINARY
    -- uncategorized_text_evidence: from FLOAT to VARCHAR
    SELECT
        "dispute_id",
        "amount_cents",
        "balance_transaction_id",
        "charge_id",
        "currency_code",
        "evidence_billing_address",
        "evidence_customer_email_address",
        "evidence_customer_name",
        "evidence_customer_purchase_ip",
        "evidence_submission_count",
        "evidence_receipt_id",
        "dispute_reason",
        "dispute_status",
        CAST("connected_account_id" AS VARCHAR) 
        AS "connected_account_id",
        CAST("created_at" AS DATETIME) 
        AS "created_at",
        CAST("evidence_access_activity_log" AS VARCHAR) 
        AS "evidence_access_activity_log",
        CAST("evidence_cancellation_policy" AS VARCHAR) 
        AS "evidence_cancellation_policy",
        CAST("evidence_cancellation_policy_disclosure" AS VARCHAR(MAX)) 
        AS "evidence_cancellation_policy_disclosure",
        CAST("evidence_cancellation_rebuttal" AS VARCHAR(255)) 
        AS "evidence_cancellation_rebuttal",
        CAST("evidence_customer_communication" AS VARCHAR) 
        AS "evidence_customer_communication",
        CAST("evidence_customer_signature" AS VARCHAR) 
        AS "evidence_customer_signature",
        CONVERT(DATETIME, LEFT("evidence_due_by", 23), 126) 
        AS "evidence_due_by",
        CAST("evidence_duplicate_charge_documentation" AS VARCHAR) 
        AS "evidence_duplicate_charge_documentation",
        CAST("evidence_duplicate_charge_explanation" AS VARCHAR(255)) 
        AS "evidence_duplicate_charge_explanation",
        CAST("evidence_duplicate_charge_id" AS VARCHAR) 
        AS "evidence_duplicate_charge_id",
        CAST("evidence_past_due" AS BIT) 
        AS "evidence_past_due",
        CAST("evidence_product_description" AS VARCHAR) 
        AS "evidence_product_description",
        CAST("evidence_refund_policy" AS VARCHAR) 
        AS "evidence_refund_policy",
        CAST("evidence_refund_policy_disclosure" AS VARCHAR) 
        AS "evidence_refund_policy_disclosure",
        CAST("evidence_refund_refusal_explanation" AS VARCHAR) 
        AS "evidence_refund_refusal_explanation",
        CAST(CONVERT(VARCHAR(23), "evidence_service_date", 121) AS DATE) 
        AS "evidence_service_date",
        CASE WHEN "has_evidence" = '0' THEN 0 ELSE 1 END 
        AS "has_evidence",
        CAST("is_charge_refundable" AS BIT) 
        AS "is_charge_refundable",
        CAST("livemode" AS BIT) 
        AS "livemode",
        "metadata" 
        AS "metadata",
        CAST("service_evidence_docs" AS VARCHAR(MAX)) 
        AS "service_evidence_docs",
        CAST("shipping_address_evidence" AS VARCHAR) 
        AS "shipping_address_evidence",
        CAST("shipping_carrier_evidence" AS VARCHAR(255)) 
        AS "shipping_carrier_evidence",
        "shipping_date_evidence" 
        AS "shipping_date_evidence",
        CAST("shipping_docs_evidence" AS VARCHAR) 
        AS "shipping_docs_evidence",
        CAST("tracking_number_evidence" AS VARCHAR) 
        AS "tracking_number_evidence",
        CAST("uncategorized_file_evidence" AS BINARY) 
        AS "uncategorized_file_evidence",
        CAST("uncategorized_text_evidence" AS VARCHAR) 
        AS "uncategorized_text_evidence"
    FROM "dispute_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "dispute_data_projected_renamed_cleaned_casted"