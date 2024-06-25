-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_order_data_removeWideColumns" AS (
    -- Remove wide columns with pattern. The regex and columns are:
    -- ^netsuite_conn_.*$: netsuite_conn_celigo_update_c, netsuite_conn_discount_total_c, netsuite_conn_document_id_c, netsuite_conn_net_suite_id_c, netsuite_conn_net_suite_order_date_c, netsuite_conn_net_suite_order_number_c, netsuite_conn_net_suite_order_status_c, netsuite_conn_net_suite_sync_err_c, netsuite_conn_opportunity_c, netsuite_conn_push_to_net_suite_c ...
    SELECT 
        "_fivetran_active",
        "_fivetran_synced",
        "account_id",
        "activated_by_id",
        "activated_date",
        "amend_with_rollover_spend_type_c",
        "amendment_type_c",
        "ava_sfcpq_ava_tax_message_c",
        "ava_sfcpq_entity_use_code_c",
        "ava_sfcpq_invoice_message_c",
        "ava_sfcpq_is_seller_importer_of_record_c",
        "ava_sfcpq_order_calculate_tax_c",
        "ava_sfcpq_sales_tax_amount_c",
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_geocode_accuracy",
        "billing_latitude",
        "billing_longitude",
        "billing_postal_code",
        "billing_state",
        "billing_state_code",
        "billing_street",
        "blng_bill_now_c",
        "blng_billing_account_c",
        "blng_billing_day_of_month_c",
        "blng_invoice_batch_c",
        "celigo_sfnsio_discount_total_net_suite_c",
        "celigo_sfnsio_net_suite_id_c",
        "celigo_sfnsio_net_suite_order_number_c",
        "celigo_sfnsio_net_suite_order_status_c",
        "celigo_sfnsio_net_suite_record_c",
        "celigo_sfnsio_ship_date_c",
        "celigo_sfnsio_skip_export_to_net_suite_c",
        "celigo_sfnsio_sub_total_net_suite_c",
        "celigo_sfnsio_tax_total_net_suite_c",
        "celigo_sfnsio_test_mode_record_c",
        "celigo_sfnsio_total_net_suite_c",
        "company_authorized_by_id",
        "contract_id",
        "created_by_id",
        "created_date",
        "credit_summary_c",
        "customer_authorized_by_id",
        "customer_spend_type_c",
        "description",
        "effective_date",
        "end_date",
        "evergreen_c",
        "id",
        "invoicing_type_c",
        "ironclad_workflow_c",
        "is_deleted",
        "is_hvr_legacy_order_c",
        "is_reduction_order",
        "last_modified_by_id",
        "last_modified_date",
        "last_referenced_date",
        "last_viewed_date",
        "legal_entity_c",
        "opportunity_id",
        "order_auto_activated_c",
        "order_number",
        "order_spend_type_c",
        "original_order_id",
        "owner_id",
        "prepaid_billing_frequency_c",
        "prepaid_order_c",
        "pricebook_2_id",
        "purchase_order_number_c",
        "purchase_summary_c",
        "sbqq_contracted_c",
        "sbqq_contracting_method_c",
        "sbqq_payment_term_c",
        "sbqq_price_calc_status_c",
        "sbqq_price_calc_status_message_c",
        "sbqq_quote_c",
        "sbqq_renewal_term_c",
        "sbqq_renewal_uplift_rate_c",
        "shipping_city",
        "shipping_country",
        "shipping_country_code",
        "shipping_geocode_accuracy",
        "shipping_latitude",
        "shipping_longitude",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street",
        "status",
        "status_code",
        "synced_to_net_suite_c",
        "system_modstamp",
        "total_amount",
        "type",
        "update_subscriptions_only_c"
    FROM "sf_order_data"
),

"sf_order_data_removeWideColumns_projected" AS (
    -- Projection: Selecting 95 out of 96 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "account_id",
        "activated_by_id",
        "activated_date",
        "amend_with_rollover_spend_type_c",
        "amendment_type_c",
        "ava_sfcpq_ava_tax_message_c",
        "ava_sfcpq_entity_use_code_c",
        "ava_sfcpq_invoice_message_c",
        "ava_sfcpq_is_seller_importer_of_record_c",
        "ava_sfcpq_order_calculate_tax_c",
        "ava_sfcpq_sales_tax_amount_c",
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_geocode_accuracy",
        "billing_latitude",
        "billing_longitude",
        "billing_postal_code",
        "billing_state",
        "billing_state_code",
        "billing_street",
        "blng_bill_now_c",
        "blng_billing_account_c",
        "blng_billing_day_of_month_c",
        "blng_invoice_batch_c",
        "celigo_sfnsio_discount_total_net_suite_c",
        "celigo_sfnsio_net_suite_id_c",
        "celigo_sfnsio_net_suite_order_number_c",
        "celigo_sfnsio_net_suite_order_status_c",
        "celigo_sfnsio_net_suite_record_c",
        "celigo_sfnsio_ship_date_c",
        "celigo_sfnsio_skip_export_to_net_suite_c",
        "celigo_sfnsio_sub_total_net_suite_c",
        "celigo_sfnsio_tax_total_net_suite_c",
        "celigo_sfnsio_test_mode_record_c",
        "celigo_sfnsio_total_net_suite_c",
        "company_authorized_by_id",
        "contract_id",
        "created_by_id",
        "created_date",
        "credit_summary_c",
        "customer_authorized_by_id",
        "customer_spend_type_c",
        "description",
        "effective_date",
        "end_date",
        "evergreen_c",
        "id",
        "invoicing_type_c",
        "ironclad_workflow_c",
        "is_deleted",
        "is_hvr_legacy_order_c",
        "is_reduction_order",
        "last_modified_by_id",
        "last_modified_date",
        "last_referenced_date",
        "last_viewed_date",
        "legal_entity_c",
        "opportunity_id",
        "order_auto_activated_c",
        "order_number",
        "order_spend_type_c",
        "original_order_id",
        "owner_id",
        "prepaid_billing_frequency_c",
        "prepaid_order_c",
        "pricebook_2_id",
        "purchase_order_number_c",
        "purchase_summary_c",
        "sbqq_contracted_c",
        "sbqq_contracting_method_c",
        "sbqq_payment_term_c",
        "sbqq_price_calc_status_c",
        "sbqq_price_calc_status_message_c",
        "sbqq_quote_c",
        "sbqq_renewal_term_c",
        "sbqq_renewal_uplift_rate_c",
        "shipping_city",
        "shipping_country",
        "shipping_country_code",
        "shipping_geocode_accuracy",
        "shipping_latitude",
        "shipping_longitude",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street",
        "status",
        "status_code",
        "synced_to_net_suite_c",
        "system_modstamp",
        "total_amount",
        "type",
        "update_subscriptions_only_c"
    FROM "sf_order_data_removeWideColumns"
),

"sf_order_data_removeWideColumns_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- activated_by_id -> activator_id
    -- activated_date -> activation_datetime
    -- amend_with_rollover_spend_type_c -> has_rollover_spend_amendment
    -- amendment_type_c -> amendment_type
    -- ava_sfcpq_ava_tax_message_c -> tax_calculation_status
    -- ava_sfcpq_entity_use_code_c -> entity_use_code
    -- ava_sfcpq_invoice_message_c -> invoice_message
    -- ava_sfcpq_is_seller_importer_of_record_c -> is_seller_importer_of_record
    -- ava_sfcpq_order_calculate_tax_c -> calculate_tax
    -- ava_sfcpq_sales_tax_amount_c -> sales_tax_amount
    -- blng_bill_now_c -> bill_immediately
    -- blng_billing_account_c -> billing_account_id
    -- blng_billing_day_of_month_c -> billing_day_of_month
    -- blng_invoice_batch_c -> invoice_batch_type
    -- celigo_sfnsio_discount_total_net_suite_c -> netsuite_discount_total
    -- celigo_sfnsio_net_suite_id_c -> netsuite_id
    -- celigo_sfnsio_net_suite_order_number_c -> netsuite_order_number
    -- celigo_sfnsio_net_suite_order_status_c -> netsuite_order_status
    -- celigo_sfnsio_net_suite_record_c -> netsuite_record_id
    -- celigo_sfnsio_ship_date_c -> ship_date
    -- celigo_sfnsio_skip_export_to_net_suite_c -> skip_netsuite_export
    -- celigo_sfnsio_sub_total_net_suite_c -> netsuite_subtotal
    -- celigo_sfnsio_tax_total_net_suite_c -> netsuite_tax_total
    -- celigo_sfnsio_test_mode_record_c -> is_test_mode
    -- celigo_sfnsio_total_net_suite_c -> netsuite_total
    -- company_authorized_by_id -> company_authorizer_id
    -- created_by_id -> creator_id
    -- credit_summary_c -> credit_summary
    -- customer_authorized_by_id -> customer_authorizer_id
    -- evergreen_c -> is_evergreen
    -- id -> order_id
    -- invoicing_type_c -> invoicing_type
    -- ironclad_workflow_c -> ironclad_workflow
    -- is_hvr_legacy_order_c -> is_hvr_legacy_order
    -- last_modified_by_id -> last_modifier_id
    -- legal_entity_c -> legal_entity_id
    -- order_auto_activated_c -> auto_activated_flag
    -- prepaid_billing_frequency_c -> prepaid_billing_frequency
    -- prepaid_order_c -> is_prepaid_order
    -- pricebook_2_id -> pricebook_id
    -- purchase_order_number_c -> purchase_order_number
    -- purchase_summary_c -> purchase_summary
    -- sbqq_contracted_c -> is_contracted
    -- sbqq_contracting_method_c -> contracting_method
    -- sbqq_payment_term_c -> payment_terms
    -- sbqq_price_calc_status_c -> price_calculation_status
    -- sbqq_price_calc_status_message_c -> price_calculation_message
    -- sbqq_quote_c -> quote_id
    -- sbqq_renewal_term_c -> renewal_term
    -- sbqq_renewal_uplift_rate_c -> renewal_uplift_rate
    -- status -> order_status
    -- status_code -> order_status_code
    -- synced_to_net_suite_c -> netsuite_sync_status
    -- system_modstamp -> last_modified_timestamp
    -- total_amount -> order_total
    -- type -> order_type
    -- update_subscriptions_only_c -> update_subscriptions_only
    SELECT 
        "_fivetran_active" AS "is_active",
        "account_id",
        "activated_by_id" AS "activator_id",
        "activated_date" AS "activation_datetime",
        "amend_with_rollover_spend_type_c" AS "has_rollover_spend_amendment",
        "amendment_type_c" AS "amendment_type",
        "ava_sfcpq_ava_tax_message_c" AS "tax_calculation_status",
        "ava_sfcpq_entity_use_code_c" AS "entity_use_code",
        "ava_sfcpq_invoice_message_c" AS "invoice_message",
        "ava_sfcpq_is_seller_importer_of_record_c" AS "is_seller_importer_of_record",
        "ava_sfcpq_order_calculate_tax_c" AS "calculate_tax",
        "ava_sfcpq_sales_tax_amount_c" AS "sales_tax_amount",
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_geocode_accuracy",
        "billing_latitude",
        "billing_longitude",
        "billing_postal_code",
        "billing_state",
        "billing_state_code",
        "billing_street",
        "blng_bill_now_c" AS "bill_immediately",
        "blng_billing_account_c" AS "billing_account_id",
        "blng_billing_day_of_month_c" AS "billing_day_of_month",
        "blng_invoice_batch_c" AS "invoice_batch_type",
        "celigo_sfnsio_discount_total_net_suite_c" AS "netsuite_discount_total",
        "celigo_sfnsio_net_suite_id_c" AS "netsuite_id",
        "celigo_sfnsio_net_suite_order_number_c" AS "netsuite_order_number",
        "celigo_sfnsio_net_suite_order_status_c" AS "netsuite_order_status",
        "celigo_sfnsio_net_suite_record_c" AS "netsuite_record_id",
        "celigo_sfnsio_ship_date_c" AS "ship_date",
        "celigo_sfnsio_skip_export_to_net_suite_c" AS "skip_netsuite_export",
        "celigo_sfnsio_sub_total_net_suite_c" AS "netsuite_subtotal",
        "celigo_sfnsio_tax_total_net_suite_c" AS "netsuite_tax_total",
        "celigo_sfnsio_test_mode_record_c" AS "is_test_mode",
        "celigo_sfnsio_total_net_suite_c" AS "netsuite_total",
        "company_authorized_by_id" AS "company_authorizer_id",
        "contract_id",
        "created_by_id" AS "creator_id",
        "created_date",
        "credit_summary_c" AS "credit_summary",
        "customer_authorized_by_id" AS "customer_authorizer_id",
        "customer_spend_type_c",
        "description",
        "effective_date",
        "end_date",
        "evergreen_c" AS "is_evergreen",
        "id" AS "order_id",
        "invoicing_type_c" AS "invoicing_type",
        "ironclad_workflow_c" AS "ironclad_workflow",
        "is_deleted",
        "is_hvr_legacy_order_c" AS "is_hvr_legacy_order",
        "is_reduction_order",
        "last_modified_by_id" AS "last_modifier_id",
        "last_modified_date",
        "last_referenced_date",
        "last_viewed_date",
        "legal_entity_c" AS "legal_entity_id",
        "opportunity_id",
        "order_auto_activated_c" AS "auto_activated_flag",
        "order_number",
        "order_spend_type_c",
        "original_order_id",
        "owner_id",
        "prepaid_billing_frequency_c" AS "prepaid_billing_frequency",
        "prepaid_order_c" AS "is_prepaid_order",
        "pricebook_2_id" AS "pricebook_id",
        "purchase_order_number_c" AS "purchase_order_number",
        "purchase_summary_c" AS "purchase_summary",
        "sbqq_contracted_c" AS "is_contracted",
        "sbqq_contracting_method_c" AS "contracting_method",
        "sbqq_payment_term_c" AS "payment_terms",
        "sbqq_price_calc_status_c" AS "price_calculation_status",
        "sbqq_price_calc_status_message_c" AS "price_calculation_message",
        "sbqq_quote_c" AS "quote_id",
        "sbqq_renewal_term_c" AS "renewal_term",
        "sbqq_renewal_uplift_rate_c" AS "renewal_uplift_rate",
        "shipping_city",
        "shipping_country",
        "shipping_country_code",
        "shipping_geocode_accuracy",
        "shipping_latitude",
        "shipping_longitude",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street",
        "status" AS "order_status",
        "status_code" AS "order_status_code",
        "synced_to_net_suite_c" AS "netsuite_sync_status",
        "system_modstamp" AS "last_modified_timestamp",
        "total_amount" AS "order_total",
        "type" AS "order_type",
        "update_subscriptions_only_c" AS "update_subscriptions_only"
    FROM "sf_order_data_removeWideColumns_projected"
),

"sf_order_data_removeWideColumns_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_city: The problem is that 'New York' and 'New York, NY' are redundant representations of the same city. The correct values should be consistent in format. Since 'New York' is more frequent and aligns with the format of other cities (no state abbreviation), it should be the standard format. 
    -- billing_postal_code: The problem is that 'USA' is not a valid postal code, but rather a country name. Postal codes in the USA typically consist of 5 digits, sometimes followed by a hyphen and 4 more digits. The value '55555' appears to be a valid US postal code format, while 'USA' is clearly incorrect. Since we don't have enough information to determine the correct postal code for entries marked 'USA', the best approach is to map these to an empty string, indicating missing data. 
    -- billing_state: The problem is that the billing_state column contains a mix of state names, state abbreviations, and even a ZIP code, which is inconsistent and incorrect for a state field. The correct values should be full state names. 'Florida' and 'New York' are already correct. 'MD' is an abbreviation that should be expanded to 'Maryland'. The ZIP code '55555-1502' is not a state at all and should be removed or replaced with the correct state if that information is available elsewhere. 
    -- billing_street: The problem is that '123 Ave' appears to be a placeholder or dummy address rather than a real street address. This is likely used as a default value or for testing purposes. In a real dataset, we would expect to see a variety of unique street addresses. The correct approach would be to leave this field blank or null until a real address is provided. 
    SELECT
        "is_active",
        "account_id",
        "activator_id",
        "activation_datetime",
        "has_rollover_spend_amendment",
        "amendment_type",
        "tax_calculation_status",
        "entity_use_code",
        "invoice_message",
        "is_seller_importer_of_record",
        "calculate_tax",
        "sales_tax_amount",
        CASE
            WHEN "billing_city" = 'New York, NY' THEN 'New York'
            ELSE "billing_city"
        END AS "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_geocode_accuracy",
        "billing_latitude",
        "billing_longitude",
        CASE
            WHEN "billing_postal_code" = 'USA' THEN ''
            ELSE "billing_postal_code"
        END AS "billing_postal_code",
        CASE
            WHEN "billing_state" = '55555-1502' THEN ''
            WHEN "billing_state" = 'MD' THEN 'Maryland'
            ELSE "billing_state"
        END AS "billing_state",
        "billing_state_code",
        CASE
            WHEN "billing_street" = '123 Ave' THEN ''
            ELSE "billing_street"
        END AS "billing_street",
        "bill_immediately",
        "billing_account_id",
        "billing_day_of_month",
        "invoice_batch_type",
        "netsuite_discount_total",
        "netsuite_id",
        "netsuite_order_number",
        "netsuite_order_status",
        "netsuite_record_id",
        "ship_date",
        "skip_netsuite_export",
        "netsuite_subtotal",
        "netsuite_tax_total",
        "is_test_mode",
        "netsuite_total",
        "company_authorizer_id",
        "contract_id",
        "creator_id",
        "created_date",
        "credit_summary",
        "customer_authorizer_id",
        "customer_spend_type_c",
        "description",
        "effective_date",
        "end_date",
        "is_evergreen",
        "order_id",
        "invoicing_type",
        "ironclad_workflow",
        "is_deleted",
        "is_hvr_legacy_order",
        "is_reduction_order",
        "last_modifier_id",
        "last_modified_date",
        "last_referenced_date",
        "last_viewed_date",
        "legal_entity_id",
        "opportunity_id",
        "auto_activated_flag",
        "order_number",
        "order_spend_type_c",
        "original_order_id",
        "owner_id",
        "prepaid_billing_frequency",
        "is_prepaid_order",
        "pricebook_id",
        "purchase_order_number",
        "purchase_summary",
        "is_contracted",
        "contracting_method",
        "payment_terms",
        "price_calculation_status",
        "price_calculation_message",
        "quote_id",
        "renewal_term",
        "renewal_uplift_rate",
        "shipping_city",
        "shipping_country",
        "shipping_country_code",
        "shipping_geocode_accuracy",
        "shipping_latitude",
        "shipping_longitude",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street",
        "order_status",
        "order_status_code",
        "netsuite_sync_status",
        "last_modified_timestamp",
        "order_total",
        "order_type",
        "update_subscriptions_only"
    FROM "sf_order_data_removeWideColumns_projected_renamed"
),

"sf_order_data_removeWideColumns_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- billing_postal_code: ['']
    -- billing_state: ['']
    -- billing_street: ['']
    SELECT 
        CASE
            WHEN "billing_postal_code" = '' THEN NULL
            ELSE "billing_postal_code"
        END AS "billing_postal_code",
        CASE
            WHEN "billing_state" = '' THEN NULL
            ELSE "billing_state"
        END AS "billing_state",
        CASE
            WHEN "billing_street" = '' THEN NULL
            ELSE "billing_street"
        END AS "billing_street",
        "is_prepaid_order",
        "account_id",
        "order_number",
        "effective_date",
        "renewal_uplift_rate",
        "netsuite_discount_total",
        "netsuite_id",
        "billing_country",
        "order_spend_type_c",
        "description",
        "pricebook_id",
        "calculate_tax",
        "invoicing_type",
        "update_subscriptions_only",
        "last_referenced_date",
        "billing_account_id",
        "shipping_state",
        "netsuite_total",
        "renewal_term",
        "last_modifier_id",
        "tax_calculation_status",
        "end_date",
        "entity_use_code",
        "order_status",
        "order_id",
        "shipping_country",
        "owner_id",
        "billing_city",
        "billing_country_code",
        "billing_state_code",
        "ironclad_workflow",
        "prepaid_billing_frequency",
        "is_hvr_legacy_order",
        "customer_spend_type_c",
        "amendment_type",
        "is_test_mode",
        "opportunity_id",
        "shipping_country_code",
        "invoice_batch_type",
        "billing_longitude",
        "payment_terms",
        "order_status_code",
        "order_total",
        "credit_summary",
        "billing_geocode_accuracy",
        "shipping_street",
        "last_modified_date",
        "creator_id",
        "billing_latitude",
        "original_order_id",
        "legal_entity_id",
        "company_authorizer_id",
        "activation_datetime",
        "netsuite_sync_status",
        "shipping_city",
        "shipping_longitude",
        "contract_id",
        "netsuite_order_number",
        "bill_immediately",
        "is_contracted",
        "shipping_postal_code",
        "created_date",
        "ship_date",
        "shipping_latitude",
        "is_active",
        "quote_id",
        "is_deleted",
        "has_rollover_spend_amendment",
        "sales_tax_amount",
        "price_calculation_status",
        "shipping_geocode_accuracy",
        "last_viewed_date",
        "invoice_message",
        "shipping_state_code",
        "purchase_summary",
        "skip_netsuite_export",
        "netsuite_record_id",
        "contracting_method",
        "activator_id",
        "auto_activated_flag",
        "last_modified_timestamp",
        "netsuite_subtotal",
        "price_calculation_message",
        "purchase_order_number",
        "netsuite_tax_total",
        "is_seller_importer_of_record",
        "netsuite_order_status",
        "billing_day_of_month",
        "customer_authorizer_id",
        "is_reduction_order",
        "is_evergreen",
        "order_type"
    FROM "sf_order_data_removeWideColumns_projected_renamed_cleaned"
),

"sf_order_data_removeWideColumns_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- activation_datetime: from VARCHAR to TIMESTAMP
    -- amendment_type: from DECIMAL to VARCHAR
    -- billing_country_code: from DECIMAL to VARCHAR
    -- billing_geocode_accuracy: from DECIMAL to VARCHAR
    -- billing_state_code: from DECIMAL to VARCHAR
    -- company_authorizer_id: from DECIMAL to VARCHAR
    -- contract_id: from DECIMAL to VARCHAR
    -- created_date: from VARCHAR to TIMESTAMP
    -- customer_authorizer_id: from DECIMAL to VARCHAR
    -- customer_spend_type_c: from DECIMAL to VARCHAR
    -- description: from DECIMAL to VARCHAR
    -- effective_date: from VARCHAR to TIMESTAMP
    -- end_date: from DECIMAL to DATE
    -- entity_use_code: from DECIMAL to VARCHAR
    -- invoice_message: from DECIMAL to VARCHAR
    -- ironclad_workflow: from DECIMAL to VARCHAR
    -- is_active: from DECIMAL to VARCHAR
    -- is_hvr_legacy_order: from DECIMAL to VARCHAR
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- last_modified_timestamp: from VARCHAR to TIMESTAMP
    -- last_referenced_date: from DECIMAL to VARCHAR
    -- last_viewed_date: from DECIMAL to VARCHAR
    -- netsuite_discount_total: from DECIMAL to VARCHAR
    -- netsuite_order_status: from DECIMAL to VARCHAR
    -- netsuite_subtotal: from DECIMAL to VARCHAR
    -- netsuite_tax_total: from DECIMAL to VARCHAR
    -- netsuite_total: from DECIMAL to VARCHAR
    -- opportunity_id: from DECIMAL to VARCHAR
    -- order_number: from INT to VARCHAR
    -- order_spend_type_c: from DECIMAL to VARCHAR
    -- original_order_id: from DECIMAL to VARCHAR
    -- price_calculation_message: from DECIMAL to VARCHAR
    -- purchase_order_number: from DECIMAL to VARCHAR
    -- purchase_summary: from DECIMAL to VARCHAR
    -- renewal_term: from DECIMAL to VARCHAR
    -- renewal_uplift_rate: from DECIMAL to VARCHAR
    -- sales_tax_amount: from DECIMAL to VARCHAR
    -- ship_date: from DECIMAL to DATE
    -- shipping_country_code: from DECIMAL to VARCHAR
    -- shipping_geocode_accuracy: from DECIMAL to VARCHAR
    -- shipping_postal_code: from INT to VARCHAR
    -- shipping_state_code: from DECIMAL to VARCHAR
    SELECT
        "billing_postal_code",
        "billing_state",
        "billing_street",
        "is_prepaid_order",
        "account_id",
        "netsuite_id",
        "billing_country",
        "pricebook_id",
        "calculate_tax",
        "invoicing_type",
        "update_subscriptions_only",
        "billing_account_id",
        "shipping_state",
        "last_modifier_id",
        "tax_calculation_status",
        "order_status",
        "order_id",
        "shipping_country",
        "owner_id",
        "billing_city",
        "prepaid_billing_frequency",
        "is_test_mode",
        "invoice_batch_type",
        "billing_longitude",
        "payment_terms",
        "order_status_code",
        "order_total",
        "credit_summary",
        "shipping_street",
        "creator_id",
        "billing_latitude",
        "legal_entity_id",
        "netsuite_sync_status",
        "shipping_city",
        "shipping_longitude",
        "netsuite_order_number",
        "bill_immediately",
        "is_contracted",
        "shipping_latitude",
        "quote_id",
        "is_deleted",
        "has_rollover_spend_amendment",
        "price_calculation_status",
        "skip_netsuite_export",
        "netsuite_record_id",
        "contracting_method",
        "activator_id",
        "auto_activated_flag",
        "is_seller_importer_of_record",
        "billing_day_of_month",
        "is_reduction_order",
        "is_evergreen",
        "order_type",
        CAST("activation_datetime" AS TIMESTAMP) AS "activation_datetime",
        CAST("amendment_type" AS VARCHAR) AS "amendment_type",
        CAST("billing_country_code" AS VARCHAR) AS "billing_country_code",
        CAST("billing_geocode_accuracy" AS VARCHAR) AS "billing_geocode_accuracy",
        CAST("billing_state_code" AS VARCHAR) AS "billing_state_code",
        CAST("company_authorizer_id" AS VARCHAR) AS "company_authorizer_id",
        CAST("contract_id" AS VARCHAR) AS "contract_id",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("customer_authorizer_id" AS VARCHAR) AS "customer_authorizer_id",
        CAST("customer_spend_type_c" AS VARCHAR) AS "customer_spend_type_c",
        CAST("description" AS VARCHAR) AS "description",
        CAST("effective_date" AS TIMESTAMP) AS "effective_date",
        CAST("end_date" AS DATE) AS "end_date",
        CAST("entity_use_code" AS VARCHAR) AS "entity_use_code",
        CAST("invoice_message" AS VARCHAR) AS "invoice_message",
        CAST("ironclad_workflow" AS VARCHAR) AS "ironclad_workflow",
        CAST("is_active" AS VARCHAR) AS "is_active",
        CAST("is_hvr_legacy_order" AS VARCHAR) AS "is_hvr_legacy_order",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("last_modified_timestamp" AS TIMESTAMP) AS "last_modified_timestamp",
        CAST("last_referenced_date" AS VARCHAR) AS "last_referenced_date",
        CAST("last_viewed_date" AS VARCHAR) AS "last_viewed_date",
        CAST("netsuite_discount_total" AS VARCHAR) AS "netsuite_discount_total",
        CAST("netsuite_order_status" AS VARCHAR) AS "netsuite_order_status",
        CAST("netsuite_subtotal" AS VARCHAR) AS "netsuite_subtotal",
        CAST("netsuite_tax_total" AS VARCHAR) AS "netsuite_tax_total",
        CAST("netsuite_total" AS VARCHAR) AS "netsuite_total",
        CAST("opportunity_id" AS VARCHAR) AS "opportunity_id",
        CAST("order_number" AS VARCHAR) AS "order_number",
        CAST("order_spend_type_c" AS VARCHAR) AS "order_spend_type_c",
        CAST("original_order_id" AS VARCHAR) AS "original_order_id",
        CAST("price_calculation_message" AS VARCHAR) AS "price_calculation_message",
        CAST("purchase_order_number" AS VARCHAR) AS "purchase_order_number",
        CAST("purchase_summary" AS VARCHAR) AS "purchase_summary",
        CAST("renewal_term" AS VARCHAR) AS "renewal_term",
        CAST("renewal_uplift_rate" AS VARCHAR) AS "renewal_uplift_rate",
        CAST("sales_tax_amount" AS VARCHAR) AS "sales_tax_amount",
        CAST("ship_date" AS DATE) AS "ship_date",
        CAST("shipping_country_code" AS VARCHAR) AS "shipping_country_code",
        CAST("shipping_geocode_accuracy" AS VARCHAR) AS "shipping_geocode_accuracy",
        CAST("shipping_postal_code" AS VARCHAR) AS "shipping_postal_code",
        CAST("shipping_state_code" AS VARCHAR) AS "shipping_state_code"
    FROM "sf_order_data_removeWideColumns_projected_renamed_cleaned_null"
),

"sf_order_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 28 columns with unacceptable missing values
    -- billing_country_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_postal_code has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- billing_state has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- billing_street has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_authorizer_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contract_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_authorizer_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_spend_type_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- entity_use_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ironclad_workflow has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opportunity_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- order_spend_type_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_order_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- price_calculation_message has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchase_order_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchase_summary has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- renewal_term has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- renewal_uplift_rate has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_tax_amount has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ship_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_country_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_geocode_accuracy has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_latitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_longitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_state_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "billing_postal_code",
        "billing_state",
        "is_prepaid_order",
        "account_id",
        "netsuite_id",
        "billing_country",
        "pricebook_id",
        "calculate_tax",
        "invoicing_type",
        "update_subscriptions_only",
        "billing_account_id",
        "shipping_state",
        "last_modifier_id",
        "tax_calculation_status",
        "order_status",
        "order_id",
        "shipping_country",
        "owner_id",
        "billing_city",
        "prepaid_billing_frequency",
        "is_test_mode",
        "invoice_batch_type",
        "billing_longitude",
        "payment_terms",
        "order_status_code",
        "order_total",
        "credit_summary",
        "shipping_street",
        "creator_id",
        "billing_latitude",
        "legal_entity_id",
        "netsuite_sync_status",
        "shipping_city",
        "netsuite_order_number",
        "bill_immediately",
        "is_contracted",
        "quote_id",
        "is_deleted",
        "has_rollover_spend_amendment",
        "price_calculation_status",
        "skip_netsuite_export",
        "netsuite_record_id",
        "contracting_method",
        "activator_id",
        "auto_activated_flag",
        "is_seller_importer_of_record",
        "billing_day_of_month",
        "is_reduction_order",
        "is_evergreen",
        "order_type",
        "activation_datetime",
        "amendment_type",
        "billing_geocode_accuracy",
        "billing_state_code",
        "created_date",
        "effective_date",
        "end_date",
        "invoice_message",
        "is_active",
        "is_hvr_legacy_order",
        "last_modified_date",
        "last_modified_timestamp",
        "netsuite_discount_total",
        "netsuite_order_status",
        "netsuite_subtotal",
        "netsuite_tax_total",
        "netsuite_total",
        "order_number",
        "shipping_postal_code"
    FROM "sf_order_data_removeWideColumns_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_order_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled"