-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "dispute_data"
),

"dispute_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> dispute_id
    -- amount -> disputed_amount
    -- balance_transaction -> dispute_transaction_id
    -- created -> dispute_created_at
    -- evidence_access_activity_log -> evidence_access_log
    -- evidence_cancellation_policy_disclosure -> evidence_cancellation_disclosure
    -- evidence_customer_email_address -> evidence_customer_email
    -- evidence_customer_purchase_ip -> evidence_purchase_ip
    -- evidence_details_due_by -> evidence_due_date
    -- evidence_details_has_evidence -> has_evidence
    -- evidence_details_past_due -> evidence_past_due
    -- evidence_details_submission_count -> evidence_submission_count
    -- evidence_duplicate_charge_documentation -> evidence_duplicate_charge_docs
    -- evidence_refund_policy_disclosure -> evidence_refund_disclosure
    -- evidence_refund_refusal_explanation -> evidence_refund_refusal_reason
    -- evidence_shipping_address -> evidence_address
    -- evidence_shipping_carrier -> evidence_carrier
    -- evidence_shipping_date -> evidence_ship_date
    -- evidence_shipping_documentation -> evidence_ship_docs
    -- evidence_shipping_tracking_number -> evidence_tracking
    -- evidence_uncategorized_file -> evidence_misc_file
    -- evidence_uncategorized_text -> evidence_misc_text
    -- is_charge_refundable -> is_refundable
    -- livemode -> is_live
    -- metadata -> additional_data
    -- reason -> dispute_reason
    -- status -> dispute_status
    SELECT 
        "id" AS "dispute_id",
        "amount" AS "disputed_amount",
        "balance_transaction" AS "dispute_transaction_id",
        "charge_id",
        "connected_account_id",
        "created" AS "dispute_created_at",
        "currency",
        "evidence_access_activity_log" AS "evidence_access_log",
        "evidence_billing_address",
        "evidence_cancellation_policy",
        "evidence_cancellation_policy_disclosure" AS "evidence_cancellation_disclosure",
        "evidence_cancellation_rebuttal",
        "evidence_customer_communication",
        "evidence_customer_email_address" AS "evidence_customer_email",
        "evidence_customer_name",
        "evidence_customer_purchase_ip" AS "evidence_purchase_ip",
        "evidence_customer_signature",
        "evidence_details_due_by" AS "evidence_due_date",
        "evidence_details_has_evidence" AS "has_evidence",
        "evidence_details_past_due" AS "evidence_past_due",
        "evidence_details_submission_count" AS "evidence_submission_count",
        "evidence_duplicate_charge_documentation" AS "evidence_duplicate_charge_docs",
        "evidence_duplicate_charge_explanation",
        "evidence_duplicate_charge_id",
        "evidence_product_description",
        "evidence_receipt",
        "evidence_refund_policy",
        "evidence_refund_policy_disclosure" AS "evidence_refund_disclosure",
        "evidence_refund_refusal_explanation" AS "evidence_refund_refusal_reason",
        "evidence_service_date",
        "evidence_service_documentation",
        "evidence_shipping_address" AS "evidence_address",
        "evidence_shipping_carrier" AS "evidence_carrier",
        "evidence_shipping_date" AS "evidence_ship_date",
        "evidence_shipping_documentation" AS "evidence_ship_docs",
        "evidence_shipping_tracking_number" AS "evidence_tracking",
        "evidence_uncategorized_file" AS "evidence_misc_file",
        "evidence_uncategorized_text" AS "evidence_misc_text",
        "is_charge_refundable" AS "is_refundable",
        "livemode" AS "is_live",
        "metadata" AS "additional_data",
        "reason" AS "dispute_reason",
        "status" AS "dispute_status"
    FROM "dispute_data_projected"
),

"dispute_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- evidence_purchase_ip: The problem is that the IP address 68.1.21.555 is not a valid IPv4 address. In IPv4, each octet (the numbers between the dots) can only range from 0 to 255. The last octet in this IP address is 555, which exceeds this range. The correct value should have the last octet within the valid range. 
    SELECT
        "dispute_id",
        "disputed_amount",
        "dispute_transaction_id",
        "charge_id",
        "connected_account_id",
        "dispute_created_at",
        "currency",
        "evidence_access_log",
        "evidence_billing_address",
        "evidence_cancellation_policy",
        "evidence_cancellation_disclosure",
        "evidence_cancellation_rebuttal",
        "evidence_customer_communication",
        "evidence_customer_email",
        "evidence_customer_name",
        CASE
            WHEN "evidence_purchase_ip" = '''68.1.21.555''' THEN '''68.1.21.255'''
            ELSE "evidence_purchase_ip"
        END AS "evidence_purchase_ip",
        "evidence_customer_signature",
        "evidence_due_date",
        "has_evidence",
        "evidence_past_due",
        "evidence_submission_count",
        "evidence_duplicate_charge_docs",
        "evidence_duplicate_charge_explanation",
        "evidence_duplicate_charge_id",
        "evidence_product_description",
        "evidence_receipt",
        "evidence_refund_policy",
        "evidence_refund_disclosure",
        "evidence_refund_refusal_reason",
        "evidence_service_date",
        "evidence_service_documentation",
        "evidence_address",
        "evidence_carrier",
        "evidence_ship_date",
        "evidence_ship_docs",
        "evidence_tracking",
        "evidence_misc_file",
        "evidence_misc_text",
        "is_refundable",
        "is_live",
        "additional_data",
        "dispute_reason",
        "dispute_status"
    FROM "dispute_data_projected_renamed"
),

"dispute_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- additional_data: from VARCHAR to JSON
    -- connected_account_id: from DECIMAL to VARCHAR
    -- dispute_created_at: from VARCHAR to TIMESTAMP
    -- disputed_amount: from INT to DECIMAL
    -- evidence_access_log: from DECIMAL to VARCHAR
    -- evidence_address: from DECIMAL to VARCHAR
    -- evidence_cancellation_disclosure: from DECIMAL to VARCHAR
    -- evidence_cancellation_policy: from DECIMAL to VARCHAR
    -- evidence_cancellation_rebuttal: from DECIMAL to VARCHAR
    -- evidence_carrier: from DECIMAL to VARCHAR
    -- evidence_customer_communication: from DECIMAL to VARCHAR
    -- evidence_customer_signature: from DECIMAL to VARCHAR
    -- evidence_due_date: from VARCHAR to TIMESTAMP
    -- evidence_duplicate_charge_docs: from DECIMAL to VARCHAR
    -- evidence_duplicate_charge_explanation: from DECIMAL to VARCHAR
    -- evidence_duplicate_charge_id: from DECIMAL to VARCHAR
    -- evidence_misc_file: from DECIMAL to VARCHAR
    -- evidence_misc_text: from DECIMAL to VARCHAR
    -- evidence_product_description: from DECIMAL to VARCHAR
    -- evidence_refund_disclosure: from DECIMAL to VARCHAR
    -- evidence_refund_policy: from DECIMAL to VARCHAR
    -- evidence_refund_refusal_reason: from DECIMAL to VARCHAR
    -- evidence_service_date: from DECIMAL to VARCHAR
    -- evidence_service_documentation: from DECIMAL to VARCHAR
    -- evidence_ship_date: from DECIMAL to VARCHAR
    -- evidence_ship_docs: from DECIMAL to VARCHAR
    -- evidence_tracking: from DECIMAL to VARCHAR
    SELECT
        "dispute_id",
        "dispute_transaction_id",
        "charge_id",
        "currency",
        "evidence_billing_address",
        "evidence_customer_email",
        "evidence_customer_name",
        "evidence_purchase_ip",
        "has_evidence",
        "evidence_past_due",
        "evidence_submission_count",
        "evidence_receipt",
        "is_refundable",
        "is_live",
        "dispute_reason",
        "dispute_status",
        CAST(TRIM("additional_data", '"') AS JSON) AS "additional_data",
        CAST("connected_account_id" AS VARCHAR) AS "connected_account_id",
        CAST("dispute_created_at" AS TIMESTAMP) AS "dispute_created_at",
        CAST("disputed_amount" AS DECIMAL) AS "disputed_amount",
        CAST("evidence_access_log" AS VARCHAR) AS "evidence_access_log",
        CAST("evidence_address" AS VARCHAR) AS "evidence_address",
        CAST("evidence_cancellation_disclosure" AS VARCHAR) AS "evidence_cancellation_disclosure",
        CAST("evidence_cancellation_policy" AS VARCHAR) AS "evidence_cancellation_policy",
        CAST("evidence_cancellation_rebuttal" AS VARCHAR) AS "evidence_cancellation_rebuttal",
        CAST("evidence_carrier" AS VARCHAR) AS "evidence_carrier",
        CAST("evidence_customer_communication" AS VARCHAR) AS "evidence_customer_communication",
        CAST("evidence_customer_signature" AS VARCHAR) AS "evidence_customer_signature",
        CAST("evidence_due_date" AS TIMESTAMP) AS "evidence_due_date",
        CAST("evidence_duplicate_charge_docs" AS VARCHAR) AS "evidence_duplicate_charge_docs",
        CAST("evidence_duplicate_charge_explanation" AS VARCHAR) AS "evidence_duplicate_charge_explanation",
        CAST("evidence_duplicate_charge_id" AS VARCHAR) AS "evidence_duplicate_charge_id",
        CAST("evidence_misc_file" AS VARCHAR) AS "evidence_misc_file",
        CAST("evidence_misc_text" AS VARCHAR) AS "evidence_misc_text",
        CAST("evidence_product_description" AS VARCHAR) AS "evidence_product_description",
        CAST("evidence_refund_disclosure" AS VARCHAR) AS "evidence_refund_disclosure",
        CAST("evidence_refund_policy" AS VARCHAR) AS "evidence_refund_policy",
        CAST("evidence_refund_refusal_reason" AS VARCHAR) AS "evidence_refund_refusal_reason",
        CAST("evidence_service_date" AS VARCHAR) AS "evidence_service_date",
        CAST("evidence_service_documentation" AS VARCHAR) AS "evidence_service_documentation",
        CAST("evidence_ship_date" AS VARCHAR) AS "evidence_ship_date",
        CAST("evidence_ship_docs" AS VARCHAR) AS "evidence_ship_docs",
        CAST("evidence_tracking" AS VARCHAR) AS "evidence_tracking"
    FROM "dispute_data_projected_renamed_cleaned"
),

"dispute_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 16 columns with unacceptable missing values
    -- additional_data has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- evidence_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_billing_address has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- evidence_customer_communication has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_customer_email has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- evidence_customer_name has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- evidence_misc_file has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_misc_text has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_product_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_purchase_ip has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- evidence_receipt has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- evidence_refund_disclosure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_refund_policy has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_refund_refusal_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_service_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- evidence_service_documentation has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "dispute_id",
        "dispute_transaction_id",
        "charge_id",
        "currency",
        "evidence_billing_address",
        "evidence_customer_email",
        "evidence_customer_name",
        "evidence_purchase_ip",
        "has_evidence",
        "evidence_past_due",
        "evidence_submission_count",
        "evidence_receipt",
        "is_refundable",
        "is_live",
        "dispute_reason",
        "dispute_status",
        "additional_data",
        "connected_account_id",
        "dispute_created_at",
        "disputed_amount",
        "evidence_access_log",
        "evidence_cancellation_disclosure",
        "evidence_cancellation_policy",
        "evidence_cancellation_rebuttal",
        "evidence_carrier",
        "evidence_customer_signature",
        "evidence_due_date",
        "evidence_duplicate_charge_docs",
        "evidence_duplicate_charge_explanation",
        "evidence_duplicate_charge_id",
        "evidence_ship_date",
        "evidence_ship_docs",
        "evidence_tracking"
    FROM "dispute_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "dispute_data_projected_renamed_cleaned_casted_missing_handled"