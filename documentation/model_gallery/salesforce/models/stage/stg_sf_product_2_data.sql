-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_product_2_data_projected" AS (
    -- Projection: Selecting 155 out of 156 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "last_referenced_date",
        "is_active",
        "description",
        "last_modified_date",
        "record_type_id",
        "product_code",
        "last_viewed_date",
        "is_deleted",
        "last_modified_by_id",
        "system_modstamp",
        "name",
        "id",
        "created_by_id",
        "created_date",
        "family",
        "max_volume_c",
        "min_volume_c",
        "request_name_c",
        "default_quantity_c",
        "account_c",
        "related_product_c",
        "picklist_value_c",
        "as_input_c",
        "as_output_c",
        "status_c",
        "number_of_quantity_installments",
        "number_of_revenue_installments",
        "quantity_installment_period",
        "quantity_schedule_type",
        "revenue_installment_period",
        "revenue_schedule_type",
        "connections_c",
        "event_volume_c",
        "roadmap_connections_c",
        "row_volume_c",
        "display_url",
        "external_data_source_id",
        "external_id",
        "quantity_unit_of_measure",
        "stock_keeping_unit",
        "features_c",
        "tier_3_price_c",
        "tier_2_price_c",
        "tier_4_price_c",
        "tier_1_price_c",
        "netsuite_conn_sync_in_progress_c",
        "netsuite_conn_celigo_update_c",
        "netsuite_conn_term_contract_pricing_type_c",
        "netsuite_conn_net_suite_id_c",
        "netsuite_conn_net_suite_sync_err_c",
        "netsuite_conn_push_to_net_suite_c",
        "netsuite_conn_item_category_c",
        "netsuite_conn_net_suite_item_type_c",
        "netsuite_conn_sub_type_c",
        "is_new_c",
        "product_metadata_c",
        "product_metadata_del_c",
        "sbqq_asset_amendment_behavior_c",
        "sbqq_asset_conversion_c",
        "sbqq_batch_quantity_c",
        "sbqq_billing_frequency_c",
        "sbqq_billing_type_c",
        "sbqq_block_pricing_field_c",
        "sbqq_charge_type_c",
        "sbqq_component_c",
        "sbqq_compound_discount_rate_c",
        "sbqq_configuration_event_c",
        "sbqq_configuration_field_set_c",
        "sbqq_configuration_fields_c",
        "sbqq_configuration_form_title_c",
        "sbqq_configuration_type_c",
        "sbqq_configuration_validator_c",
        "sbqq_configured_code_pattern_c",
        "sbqq_configured_description_pattern_c",
        "sbqq_cost_editable_c",
        "sbqq_cost_schedule_c",
        "sbqq_custom_configuration_page_c",
        "sbqq_custom_configuration_required_c",
        "sbqq_customer_community_availability_c",
        "sbqq_default_pricing_table_c",
        "sbqq_default_quantity_c",
        "sbqq_description_locked_c",
        "sbqq_discount_category_c",
        "sbqq_discount_schedule_c",
        "sbqq_dynamic_pricing_constraint_c",
        "sbqq_exclude_from_maintenance_c",
        "sbqq_exclude_from_opportunity_c",
        "sbqq_externally_configurable_c",
        "sbqq_generate_contracted_price_c",
        "sbqq_has_configuration_attributes_c",
        "sbqq_has_consumption_schedule_c",
        "sbqq_hidden_c",
        "sbqq_hide_price_in_search_results_c",
        "sbqq_include_in_maintenance_c",
        "sbqq_new_quote_group_c",
        "sbqq_non_discountable_c",
        "sbqq_non_partner_discountable_c",
        "sbqq_option_layout_c",
        "sbqq_option_selection_method_c",
        "sbqq_optional_c",
        "sbqq_price_editable_c",
        "sbqq_pricing_method_c",
        "sbqq_pricing_method_editable_c",
        "sbqq_product_picture_id_c",
        "sbqq_quantity_editable_c",
        "sbqq_quantity_scale_c",
        "sbqq_reconfiguration_disabled_c",
        "sbqq_renewal_product_c",
        "sbqq_sort_order_c",
        "sbqq_specifications_c",
        "sbqq_subscription_base_c",
        "sbqq_subscription_category_c",
        "sbqq_subscription_percent_c",
        "sbqq_subscription_pricing_c",
        "sbqq_subscription_target_c",
        "sbqq_subscription_term_c",
        "sbqq_subscription_type_c",
        "sbqq_tax_code_c",
        "sbqq_taxable_c",
        "sbqq_term_discount_level_c",
        "sbqq_term_discount_schedule_c",
        "sbqq_upgrade_credit_c",
        "sbqq_upgrade_ratio_c",
        "sbqq_upgrade_source_c",
        "sbqq_upgrade_target_c",
        "connector_type_c",
        "pbf_pro_type_discount_c",
        "dimension_c",
        "connector_status_c",
        "dimension_definition_c",
        "ava_sfcpq_tax_code_c",
        "paid_consumption_c",
        "is_complimentary_c",
        "product_external_id_c",
        "blng_billing_rule_c",
        "blng_revenue_recognition_rule_c",
        "blng_tax_rule_c",
        "deployment_date_c",
        "do_not_prorate_c",
        "celigo_sfnsio_netsuite_id_c",
        "sbqq_enable_large_configuration_c",
        "sbqq_pricing_guidance_c",
        "celigo_sfnsio_item_pricing_type_c",
        "celigo_sfnsio_test_mode_record_c",
        "celigo_sfnsio_celigo_last_modified_date_c",
        "celigo_sfnsio_net_suite_record_c",
        "celigo_sfnsio_skip_export_to_net_suite_c",
        "celigo_sfnsio_net_suite_item_type_c",
        "celigo_sfnsio_net_suite_id_c",
        "promo_code_c",
        "product_category_c",
        "product_source_c",
        "non_recurring_c",
        "is_archived",
        "_fivetran_active"
    FROM "sf_product_2_data"
),

"sf_product_2_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- system_modstamp -> last_modified_at
    -- name -> product_name
    -- id -> product_id
    -- family -> product_family
    -- max_volume_c -> max_volume
    -- min_volume_c -> min_volume
    -- request_name_c -> request_name
    -- account_c -> account_id
    -- related_product_c -> related_product_id
    -- picklist_value_c -> custom_picklist_value
    -- as_input_c -> accounting_system_input
    -- as_output_c -> accounting_system_output
    -- status_c -> product_status
    -- number_of_quantity_installments -> quantity_installments
    -- number_of_revenue_installments -> revenue_installments
    -- connections_c -> connection_count
    -- event_volume_c -> event_volume
    -- roadmap_connections_c -> roadmap_connections
    -- row_volume_c -> row_volume
    -- quantity_unit_of_measure -> quantity_unit
    -- features_c -> product_features
    -- tier_3_price_c -> tier_3_price
    -- tier_2_price_c -> tier_2_price
    -- tier_4_price_c -> tier_4_price
    -- tier_1_price_c -> tier_1_price
    -- netsuite_conn_sync_in_progress_c -> netsuite_sync_in_progress
    -- netsuite_conn_celigo_update_c -> netsuite_celigo_update
    -- netsuite_conn_term_contract_pricing_type_c -> netsuite_contract_pricing_type
    -- netsuite_conn_net_suite_id_c -> netsuite_id
    -- netsuite_conn_net_suite_sync_err_c -> netsuite_sync_error
    -- netsuite_conn_push_to_net_suite_c -> push_to_netsuite
    -- netsuite_conn_item_category_c -> netsuite_item_category
    -- netsuite_conn_net_suite_item_type_c -> netsuite_item_type
    -- netsuite_conn_sub_type_c -> netsuite_subtype
    -- is_new_c -> is_new
    -- product_metadata_c -> product_metadata
    -- product_metadata_del_c -> deleted_product_metadata
    -- sbqq_asset_amendment_behavior_c -> asset_amendment_behavior
    -- sbqq_asset_conversion_c -> asset_conversion
    -- sbqq_batch_quantity_c -> batch_quantity
    -- sbqq_billing_frequency_c -> billing_frequency
    -- sbqq_billing_type_c -> billing_type
    -- sbqq_block_pricing_field_c -> block_pricing_field
    -- sbqq_charge_type_c -> charge_type
    -- sbqq_component_c -> is_component
    -- sbqq_compound_discount_rate_c -> compound_discount_rate
    -- sbqq_configuration_event_c -> configuration_event
    -- sbqq_configuration_field_set_c -> configuration_field_set
    -- sbqq_configuration_fields_c -> configuration_fields
    -- sbqq_configuration_form_title_c -> configuration_form_title
    -- sbqq_configuration_type_c -> configuration_type
    -- sbqq_configuration_validator_c -> configuration_validator
    -- sbqq_configured_code_pattern_c -> configured_code_pattern
    -- sbqq_configured_description_pattern_c -> configured_description_pattern
    -- sbqq_cost_editable_c -> is_cost_editable
    -- sbqq_cost_schedule_c -> cost_schedule
    -- sbqq_custom_configuration_page_c -> custom_configuration_page
    -- sbqq_custom_configuration_required_c -> is_custom_configuration_required
    -- sbqq_customer_community_availability_c -> customer_community_availability
    -- sbqq_default_pricing_table_c -> default_pricing_table
    -- sbqq_description_locked_c -> is_description_locked
    -- sbqq_discount_category_c -> discount_category
    -- sbqq_discount_schedule_c -> discount_schedule
    -- sbqq_dynamic_pricing_constraint_c -> dynamic_pricing_constraint
    -- sbqq_exclude_from_maintenance_c -> exclude_from_maintenance
    -- sbqq_exclude_from_opportunity_c -> exclude_from_opportunity
    -- sbqq_externally_configurable_c -> is_externally_configurable
    -- sbqq_generate_contracted_price_c -> generate_contracted_price
    -- sbqq_has_configuration_attributes_c -> has_configuration_attributes
    -- sbqq_has_consumption_schedule_c -> has_consumption_schedule
    -- sbqq_hidden_c -> is_hidden
    -- sbqq_hide_price_in_search_results_c -> hide_price_in_search_results
    -- sbqq_include_in_maintenance_c -> include_in_maintenance
    -- sbqq_new_quote_group_c -> create_new_quote_group
    -- sbqq_non_discountable_c -> is_non_discountable
    -- sbqq_non_partner_discountable_c -> is_non_partner_discountable
    -- sbqq_option_layout_c -> option_layout
    -- sbqq_option_selection_method_c -> option_selection_method
    -- sbqq_optional_c -> is_optional
    -- sbqq_price_editable_c -> is_price_editable
    -- sbqq_pricing_method_c -> pricing_method
    -- sbqq_pricing_method_editable_c -> is_pricing_method_editable
    -- sbqq_product_picture_id_c -> product_picture_id
    -- sbqq_quantity_editable_c -> is_quantity_editable
    -- sbqq_quantity_scale_c -> quantity_scale
    -- sbqq_reconfiguration_disabled_c -> is_reconfiguration_disabled
    -- sbqq_renewal_product_c -> renewal_product
    -- sbqq_sort_order_c -> sort_order
    -- sbqq_specifications_c -> specifications
    -- sbqq_subscription_base_c -> subscription_base
    -- sbqq_subscription_category_c -> subscription_category
    -- sbqq_subscription_percent_c -> subscription_percent
    -- sbqq_subscription_pricing_c -> subscription_pricing_model
    -- sbqq_subscription_target_c -> subscription_target
    -- sbqq_subscription_term_c -> subscription_term
    -- sbqq_subscription_type_c -> subscription_type
    -- sbqq_tax_code_c -> tax_code
    -- sbqq_taxable_c -> is_taxable
    -- sbqq_term_discount_level_c -> term_discount_level
    -- sbqq_term_discount_schedule_c -> term_discount_schedule
    -- sbqq_upgrade_credit_c -> upgrade_credit
    -- sbqq_upgrade_ratio_c -> upgrade_ratio
    -- sbqq_upgrade_source_c -> upgrade_source
    -- sbqq_upgrade_target_c -> upgrade_target
    -- connector_type_c -> connector_type
    -- pbf_pro_type_discount_c -> pro_type_discount
    -- dimension_c -> dimension
    -- connector_status_c -> connector_status
    -- dimension_definition_c -> dimension_definition
    -- ava_sfcpq_tax_code_c -> avalara_tax_code
    -- paid_consumption_c -> paid_consumption
    -- is_complimentary_c -> is_complimentary
    -- product_external_id_c -> external_product_id
    -- blng_billing_rule_c -> billing_rule_id
    -- blng_revenue_recognition_rule_c -> revenue_recognition_rule_id
    -- blng_tax_rule_c -> tax_rule_id
    -- deployment_date_c -> deployment_date
    -- do_not_prorate_c -> is_proration_disabled
    -- celigo_sfnsio_netsuite_id_c -> celigo_netsuite_id_alt
    -- sbqq_enable_large_configuration_c -> enable_large_configuration
    -- sbqq_pricing_guidance_c -> pricing_guidance
    -- celigo_sfnsio_item_pricing_type_c -> celigo_pricing_type
    -- celigo_sfnsio_test_mode_record_c -> is_test_mode_record
    -- celigo_sfnsio_celigo_last_modified_date_c -> celigo_last_modified_date
    -- celigo_sfnsio_net_suite_record_c -> celigo_netsuite_record
    -- celigo_sfnsio_skip_export_to_net_suite_c -> skip_netsuite_export
    -- celigo_sfnsio_net_suite_item_type_c -> celigo_netsuite_item_type
    -- celigo_sfnsio_net_suite_id_c -> celigo_netsuite_id
    -- promo_code_c -> promo_code
    -- product_category_c -> product_category
    -- product_source_c -> product_source
    -- non_recurring_c -> is_non_recurring
    -- _fivetran_active -> is_fivetran_active
    SELECT 
        "last_referenced_date",
        "is_active",
        "description",
        "last_modified_date",
        "record_type_id",
        "product_code",
        "last_viewed_date",
        "is_deleted",
        "last_modified_by_id",
        "system_modstamp" AS "last_modified_at",
        "name" AS "product_name",
        "id" AS "product_id",
        "created_by_id",
        "created_date",
        "family" AS "product_family",
        "max_volume_c" AS "max_volume",
        "min_volume_c" AS "min_volume",
        "request_name_c" AS "request_name",
        "default_quantity_c",
        "account_c" AS "account_id",
        "related_product_c" AS "related_product_id",
        "picklist_value_c" AS "custom_picklist_value",
        "as_input_c" AS "accounting_system_input",
        "as_output_c" AS "accounting_system_output",
        "status_c" AS "product_status",
        "number_of_quantity_installments" AS "quantity_installments",
        "number_of_revenue_installments" AS "revenue_installments",
        "quantity_installment_period",
        "quantity_schedule_type",
        "revenue_installment_period",
        "revenue_schedule_type",
        "connections_c" AS "connection_count",
        "event_volume_c" AS "event_volume",
        "roadmap_connections_c" AS "roadmap_connections",
        "row_volume_c" AS "row_volume",
        "display_url",
        "external_data_source_id",
        "external_id",
        "quantity_unit_of_measure" AS "quantity_unit",
        "stock_keeping_unit",
        "features_c" AS "product_features",
        "tier_3_price_c" AS "tier_3_price",
        "tier_2_price_c" AS "tier_2_price",
        "tier_4_price_c" AS "tier_4_price",
        "tier_1_price_c" AS "tier_1_price",
        "netsuite_conn_sync_in_progress_c" AS "netsuite_sync_in_progress",
        "netsuite_conn_celigo_update_c" AS "netsuite_celigo_update",
        "netsuite_conn_term_contract_pricing_type_c" AS "netsuite_contract_pricing_type",
        "netsuite_conn_net_suite_id_c" AS "netsuite_id",
        "netsuite_conn_net_suite_sync_err_c" AS "netsuite_sync_error",
        "netsuite_conn_push_to_net_suite_c" AS "push_to_netsuite",
        "netsuite_conn_item_category_c" AS "netsuite_item_category",
        "netsuite_conn_net_suite_item_type_c" AS "netsuite_item_type",
        "netsuite_conn_sub_type_c" AS "netsuite_subtype",
        "is_new_c" AS "is_new",
        "product_metadata_c" AS "product_metadata",
        "product_metadata_del_c" AS "deleted_product_metadata",
        "sbqq_asset_amendment_behavior_c" AS "asset_amendment_behavior",
        "sbqq_asset_conversion_c" AS "asset_conversion",
        "sbqq_batch_quantity_c" AS "batch_quantity",
        "sbqq_billing_frequency_c" AS "billing_frequency",
        "sbqq_billing_type_c" AS "billing_type",
        "sbqq_block_pricing_field_c" AS "block_pricing_field",
        "sbqq_charge_type_c" AS "charge_type",
        "sbqq_component_c" AS "is_component",
        "sbqq_compound_discount_rate_c" AS "compound_discount_rate",
        "sbqq_configuration_event_c" AS "configuration_event",
        "sbqq_configuration_field_set_c" AS "configuration_field_set",
        "sbqq_configuration_fields_c" AS "configuration_fields",
        "sbqq_configuration_form_title_c" AS "configuration_form_title",
        "sbqq_configuration_type_c" AS "configuration_type",
        "sbqq_configuration_validator_c" AS "configuration_validator",
        "sbqq_configured_code_pattern_c" AS "configured_code_pattern",
        "sbqq_configured_description_pattern_c" AS "configured_description_pattern",
        "sbqq_cost_editable_c" AS "is_cost_editable",
        "sbqq_cost_schedule_c" AS "cost_schedule",
        "sbqq_custom_configuration_page_c" AS "custom_configuration_page",
        "sbqq_custom_configuration_required_c" AS "is_custom_configuration_required",
        "sbqq_customer_community_availability_c" AS "customer_community_availability",
        "sbqq_default_pricing_table_c" AS "default_pricing_table",
        "sbqq_default_quantity_c",
        "sbqq_description_locked_c" AS "is_description_locked",
        "sbqq_discount_category_c" AS "discount_category",
        "sbqq_discount_schedule_c" AS "discount_schedule",
        "sbqq_dynamic_pricing_constraint_c" AS "dynamic_pricing_constraint",
        "sbqq_exclude_from_maintenance_c" AS "exclude_from_maintenance",
        "sbqq_exclude_from_opportunity_c" AS "exclude_from_opportunity",
        "sbqq_externally_configurable_c" AS "is_externally_configurable",
        "sbqq_generate_contracted_price_c" AS "generate_contracted_price",
        "sbqq_has_configuration_attributes_c" AS "has_configuration_attributes",
        "sbqq_has_consumption_schedule_c" AS "has_consumption_schedule",
        "sbqq_hidden_c" AS "is_hidden",
        "sbqq_hide_price_in_search_results_c" AS "hide_price_in_search_results",
        "sbqq_include_in_maintenance_c" AS "include_in_maintenance",
        "sbqq_new_quote_group_c" AS "create_new_quote_group",
        "sbqq_non_discountable_c" AS "is_non_discountable",
        "sbqq_non_partner_discountable_c" AS "is_non_partner_discountable",
        "sbqq_option_layout_c" AS "option_layout",
        "sbqq_option_selection_method_c" AS "option_selection_method",
        "sbqq_optional_c" AS "is_optional",
        "sbqq_price_editable_c" AS "is_price_editable",
        "sbqq_pricing_method_c" AS "pricing_method",
        "sbqq_pricing_method_editable_c" AS "is_pricing_method_editable",
        "sbqq_product_picture_id_c" AS "product_picture_id",
        "sbqq_quantity_editable_c" AS "is_quantity_editable",
        "sbqq_quantity_scale_c" AS "quantity_scale",
        "sbqq_reconfiguration_disabled_c" AS "is_reconfiguration_disabled",
        "sbqq_renewal_product_c" AS "renewal_product",
        "sbqq_sort_order_c" AS "sort_order",
        "sbqq_specifications_c" AS "specifications",
        "sbqq_subscription_base_c" AS "subscription_base",
        "sbqq_subscription_category_c" AS "subscription_category",
        "sbqq_subscription_percent_c" AS "subscription_percent",
        "sbqq_subscription_pricing_c" AS "subscription_pricing_model",
        "sbqq_subscription_target_c" AS "subscription_target",
        "sbqq_subscription_term_c" AS "subscription_term",
        "sbqq_subscription_type_c" AS "subscription_type",
        "sbqq_tax_code_c" AS "tax_code",
        "sbqq_taxable_c" AS "is_taxable",
        "sbqq_term_discount_level_c" AS "term_discount_level",
        "sbqq_term_discount_schedule_c" AS "term_discount_schedule",
        "sbqq_upgrade_credit_c" AS "upgrade_credit",
        "sbqq_upgrade_ratio_c" AS "upgrade_ratio",
        "sbqq_upgrade_source_c" AS "upgrade_source",
        "sbqq_upgrade_target_c" AS "upgrade_target",
        "connector_type_c" AS "connector_type",
        "pbf_pro_type_discount_c" AS "pro_type_discount",
        "dimension_c" AS "dimension",
        "connector_status_c" AS "connector_status",
        "dimension_definition_c" AS "dimension_definition",
        "ava_sfcpq_tax_code_c" AS "avalara_tax_code",
        "paid_consumption_c" AS "paid_consumption",
        "is_complimentary_c" AS "is_complimentary",
        "product_external_id_c" AS "external_product_id",
        "blng_billing_rule_c" AS "billing_rule_id",
        "blng_revenue_recognition_rule_c" AS "revenue_recognition_rule_id",
        "blng_tax_rule_c" AS "tax_rule_id",
        "deployment_date_c" AS "deployment_date",
        "do_not_prorate_c" AS "is_proration_disabled",
        "celigo_sfnsio_netsuite_id_c" AS "celigo_netsuite_id_alt",
        "sbqq_enable_large_configuration_c" AS "enable_large_configuration",
        "sbqq_pricing_guidance_c" AS "pricing_guidance",
        "celigo_sfnsio_item_pricing_type_c" AS "celigo_pricing_type",
        "celigo_sfnsio_test_mode_record_c" AS "is_test_mode_record",
        "celigo_sfnsio_celigo_last_modified_date_c" AS "celigo_last_modified_date",
        "celigo_sfnsio_net_suite_record_c" AS "celigo_netsuite_record",
        "celigo_sfnsio_skip_export_to_net_suite_c" AS "skip_netsuite_export",
        "celigo_sfnsio_net_suite_item_type_c" AS "celigo_netsuite_item_type",
        "celigo_sfnsio_net_suite_id_c" AS "celigo_netsuite_id",
        "promo_code_c" AS "promo_code",
        "product_category_c" AS "product_category",
        "product_source_c" AS "product_source",
        "non_recurring_c" AS "is_non_recurring",
        "is_archived",
        "_fivetran_active" AS "is_fivetran_active"
    FROM "sf_product_2_data_projected"
),

"sf_product_2_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from DECIMAL to VARCHAR
    -- accounting_system_input: from DECIMAL to VARCHAR
    -- accounting_system_output: from DECIMAL to VARCHAR
    -- avalara_tax_code: from DECIMAL to VARCHAR
    -- batch_quantity: from DECIMAL to VARCHAR
    -- celigo_last_modified_date: from VARCHAR to TIMESTAMP
    -- celigo_netsuite_id: from DECIMAL to VARCHAR
    -- celigo_netsuite_id_alt: from DECIMAL to VARCHAR
    -- celigo_netsuite_item_type: from DECIMAL to VARCHAR
    -- celigo_netsuite_record: from DECIMAL to VARCHAR
    -- celigo_pricing_type: from DECIMAL to VARCHAR
    -- compound_discount_rate: from DECIMAL to VARCHAR
    -- configuration_event: from DECIMAL to VARCHAR
    -- configuration_field_set: from DECIMAL to VARCHAR
    -- configuration_fields: from DECIMAL to VARCHAR
    -- configuration_form_title: from DECIMAL to VARCHAR
    -- configuration_type: from DECIMAL to VARCHAR
    -- configuration_validator: from DECIMAL to VARCHAR
    -- configured_code_pattern: from DECIMAL to VARCHAR
    -- configured_description_pattern: from DECIMAL to VARCHAR
    -- connection_count: from DECIMAL to VARCHAR
    -- cost_schedule: from DECIMAL to VARCHAR
    -- created_date: from VARCHAR to TIMESTAMP
    -- custom_configuration_page: from DECIMAL to VARCHAR
    -- custom_picklist_value: from DECIMAL to VARCHAR
    -- customer_community_availability: from DECIMAL to VARCHAR
    -- default_pricing_table: from DECIMAL to VARCHAR
    -- default_quantity_c: from DECIMAL to VARCHAR
    -- deleted_product_metadata: from DECIMAL to VARCHAR
    -- deployment_date: from DECIMAL to DATE
    -- description: from DECIMAL to VARCHAR
    -- dimension_definition: from DECIMAL to VARCHAR
    -- discount_category: from DECIMAL to VARCHAR
    -- discount_schedule: from DECIMAL to VARCHAR
    -- display_url: from DECIMAL to VARCHAR
    -- dynamic_pricing_constraint: from DECIMAL to VARCHAR
    -- event_volume: from DECIMAL to VARCHAR
    -- external_data_source_id: from DECIMAL to VARCHAR
    -- external_id: from DECIMAL to VARCHAR
    -- generate_contracted_price: from DECIMAL to VARCHAR
    -- is_fivetran_active: from DECIMAL to VARCHAR
    -- last_modified_at: from VARCHAR to TIMESTAMP
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- last_referenced_date: from DECIMAL to TIMESTAMP
    -- last_viewed_date: from DECIMAL to TIMESTAMP
    -- max_volume: from DECIMAL to VARCHAR
    -- min_volume: from DECIMAL to VARCHAR
    -- netsuite_contract_pricing_type: from DECIMAL to VARCHAR
    -- netsuite_id: from DECIMAL to VARCHAR
    -- netsuite_item_category: from DECIMAL to VARCHAR
    -- option_layout: from DECIMAL to VARCHAR
    -- paid_consumption: from DECIMAL to VARCHAR
    -- pricing_guidance: from DECIMAL to VARCHAR
    -- product_category: from DECIMAL to VARCHAR
    -- product_code: from INT to VARCHAR
    -- product_features: from DECIMAL to VARCHAR
    -- product_metadata: from DECIMAL to VARCHAR
    -- product_picture_id: from DECIMAL to VARCHAR
    -- product_source: from DECIMAL to VARCHAR
    -- product_status: from DECIMAL to VARCHAR
    -- promo_code: from DECIMAL to VARCHAR
    -- quantity_installment_period: from DECIMAL to VARCHAR
    -- quantity_installments: from DECIMAL to VARCHAR
    -- quantity_scale: from DECIMAL to VARCHAR
    -- quantity_schedule_type: from DECIMAL to VARCHAR
    -- quantity_unit: from DECIMAL to VARCHAR
    -- related_product_id: from DECIMAL to VARCHAR
    -- renewal_product: from DECIMAL to VARCHAR
    -- request_name: from DECIMAL to VARCHAR
    -- revenue_installment_period: from DECIMAL to VARCHAR
    -- revenue_installments: from DECIMAL to VARCHAR
    -- revenue_schedule_type: from DECIMAL to VARCHAR
    -- roadmap_connections: from DECIMAL to VARCHAR
    -- row_volume: from DECIMAL to VARCHAR
    -- sbqq_default_quantity_c: from INT to DECIMAL
    -- sort_order: from DECIMAL to VARCHAR
    -- specifications: from DECIMAL to VARCHAR
    -- stock_keeping_unit: from DECIMAL to VARCHAR
    -- subscription_category: from DECIMAL to VARCHAR
    -- subscription_percent: from DECIMAL to VARCHAR
    -- subscription_target: from DECIMAL to VARCHAR
    -- tax_code: from DECIMAL to VARCHAR
    -- term_discount_level: from DECIMAL to VARCHAR
    -- term_discount_schedule: from DECIMAL to VARCHAR
    -- tier_1_price: from DECIMAL to VARCHAR
    -- tier_2_price: from DECIMAL to VARCHAR
    -- tier_3_price: from DECIMAL to VARCHAR
    -- upgrade_source: from DECIMAL to VARCHAR
    -- upgrade_target: from DECIMAL to VARCHAR
    SELECT
        "is_active",
        "record_type_id",
        "is_deleted",
        "last_modified_by_id",
        "product_name",
        "product_id",
        "created_by_id",
        "product_family",
        "tier_4_price",
        "netsuite_sync_in_progress",
        "netsuite_celigo_update",
        "netsuite_sync_error",
        "push_to_netsuite",
        "netsuite_item_type",
        "netsuite_subtype",
        "is_new",
        "asset_amendment_behavior",
        "asset_conversion",
        "billing_frequency",
        "billing_type",
        "block_pricing_field",
        "charge_type",
        "is_component",
        "is_cost_editable",
        "is_custom_configuration_required",
        "is_description_locked",
        "exclude_from_maintenance",
        "exclude_from_opportunity",
        "is_externally_configurable",
        "has_configuration_attributes",
        "has_consumption_schedule",
        "is_hidden",
        "hide_price_in_search_results",
        "include_in_maintenance",
        "create_new_quote_group",
        "is_non_discountable",
        "is_non_partner_discountable",
        "option_selection_method",
        "is_optional",
        "is_price_editable",
        "pricing_method",
        "is_pricing_method_editable",
        "is_quantity_editable",
        "is_reconfiguration_disabled",
        "subscription_base",
        "subscription_pricing_model",
        "subscription_term",
        "subscription_type",
        "is_taxable",
        "upgrade_credit",
        "upgrade_ratio",
        "connector_type",
        "pro_type_discount",
        "dimension",
        "connector_status",
        "is_complimentary",
        "external_product_id",
        "billing_rule_id",
        "revenue_recognition_rule_id",
        "tax_rule_id",
        "is_proration_disabled",
        "enable_large_configuration",
        "is_test_mode_record",
        "skip_netsuite_export",
        "is_non_recurring",
        "is_archived",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("accounting_system_input" AS VARCHAR) AS "accounting_system_input",
        CAST("accounting_system_output" AS VARCHAR) AS "accounting_system_output",
        CAST("avalara_tax_code" AS VARCHAR) AS "avalara_tax_code",
        CAST("batch_quantity" AS VARCHAR) AS "batch_quantity",
        CAST("celigo_last_modified_date" AS TIMESTAMP) AS "celigo_last_modified_date",
        CAST("celigo_netsuite_id" AS VARCHAR) AS "celigo_netsuite_id",
        CAST("celigo_netsuite_id_alt" AS VARCHAR) AS "celigo_netsuite_id_alt",
        CAST("celigo_netsuite_item_type" AS VARCHAR) AS "celigo_netsuite_item_type",
        CAST("celigo_netsuite_record" AS VARCHAR) AS "celigo_netsuite_record",
        CAST("celigo_pricing_type" AS VARCHAR) AS "celigo_pricing_type",
        CAST("compound_discount_rate" AS VARCHAR) AS "compound_discount_rate",
        CAST("configuration_event" AS VARCHAR) AS "configuration_event",
        CAST("configuration_field_set" AS VARCHAR) AS "configuration_field_set",
        CAST("configuration_fields" AS VARCHAR) AS "configuration_fields",
        CAST("configuration_form_title" AS VARCHAR) AS "configuration_form_title",
        CAST("configuration_type" AS VARCHAR) AS "configuration_type",
        CAST("configuration_validator" AS VARCHAR) AS "configuration_validator",
        CAST("configured_code_pattern" AS VARCHAR) AS "configured_code_pattern",
        CAST("configured_description_pattern" AS VARCHAR) AS "configured_description_pattern",
        CAST("connection_count" AS VARCHAR) AS "connection_count",
        CAST("cost_schedule" AS VARCHAR) AS "cost_schedule",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("custom_configuration_page" AS VARCHAR) AS "custom_configuration_page",
        CAST("custom_picklist_value" AS VARCHAR) AS "custom_picklist_value",
        CAST("customer_community_availability" AS VARCHAR) AS "customer_community_availability",
        CAST("default_pricing_table" AS VARCHAR) AS "default_pricing_table",
        CAST("default_quantity_c" AS VARCHAR) AS "default_quantity_c",
        CAST("deleted_product_metadata" AS VARCHAR) AS "deleted_product_metadata",
        CAST("deployment_date" AS DATE) AS "deployment_date",
        CAST("description" AS VARCHAR) AS "description",
        CAST("dimension_definition" AS VARCHAR) AS "dimension_definition",
        CAST("discount_category" AS VARCHAR) AS "discount_category",
        CAST("discount_schedule" AS VARCHAR) AS "discount_schedule",
        CAST("display_url" AS VARCHAR) AS "display_url",
        CAST("dynamic_pricing_constraint" AS VARCHAR) AS "dynamic_pricing_constraint",
        CAST("event_volume" AS VARCHAR) AS "event_volume",
        CAST("external_data_source_id" AS VARCHAR) AS "external_data_source_id",
        CAST("external_id" AS VARCHAR) AS "external_id",
        CAST("generate_contracted_price" AS VARCHAR) AS "generate_contracted_price",
        CAST("is_fivetran_active" AS VARCHAR) AS "is_fivetran_active",
        CAST("last_modified_at" AS TIMESTAMP) AS "last_modified_at",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("last_referenced_date" AS TIMESTAMP) AS "last_referenced_date",
        CAST("last_viewed_date" AS TIMESTAMP) AS "last_viewed_date",
        CAST("max_volume" AS VARCHAR) AS "max_volume",
        CAST("min_volume" AS VARCHAR) AS "min_volume",
        CAST("netsuite_contract_pricing_type" AS VARCHAR) AS "netsuite_contract_pricing_type",
        CAST("netsuite_id" AS VARCHAR) AS "netsuite_id",
        CAST("netsuite_item_category" AS VARCHAR) AS "netsuite_item_category",
        CAST("option_layout" AS VARCHAR) AS "option_layout",
        CAST("paid_consumption" AS VARCHAR) AS "paid_consumption",
        CAST("pricing_guidance" AS VARCHAR) AS "pricing_guidance",
        CAST("product_category" AS VARCHAR) AS "product_category",
        CAST("product_code" AS VARCHAR) AS "product_code",
        CAST("product_features" AS VARCHAR) AS "product_features",
        CAST("product_metadata" AS VARCHAR) AS "product_metadata",
        CAST("product_picture_id" AS VARCHAR) AS "product_picture_id",
        CAST("product_source" AS VARCHAR) AS "product_source",
        CAST("product_status" AS VARCHAR) AS "product_status",
        CAST("promo_code" AS VARCHAR) AS "promo_code",
        CAST("quantity_installment_period" AS VARCHAR) AS "quantity_installment_period",
        CAST("quantity_installments" AS VARCHAR) AS "quantity_installments",
        CAST("quantity_scale" AS VARCHAR) AS "quantity_scale",
        CAST("quantity_schedule_type" AS VARCHAR) AS "quantity_schedule_type",
        CAST("quantity_unit" AS VARCHAR) AS "quantity_unit",
        CAST("related_product_id" AS VARCHAR) AS "related_product_id",
        CAST("renewal_product" AS VARCHAR) AS "renewal_product",
        CAST("request_name" AS VARCHAR) AS "request_name",
        CAST("revenue_installment_period" AS VARCHAR) AS "revenue_installment_period",
        CAST("revenue_installments" AS VARCHAR) AS "revenue_installments",
        CAST("revenue_schedule_type" AS VARCHAR) AS "revenue_schedule_type",
        CAST("roadmap_connections" AS VARCHAR) AS "roadmap_connections",
        CAST("row_volume" AS VARCHAR) AS "row_volume",
        CAST("sbqq_default_quantity_c" AS DECIMAL) AS "sbqq_default_quantity_c",
        CAST("sort_order" AS VARCHAR) AS "sort_order",
        CAST("specifications" AS VARCHAR) AS "specifications",
        CAST("stock_keeping_unit" AS VARCHAR) AS "stock_keeping_unit",
        CAST("subscription_category" AS VARCHAR) AS "subscription_category",
        CAST("subscription_percent" AS VARCHAR) AS "subscription_percent",
        CAST("subscription_target" AS VARCHAR) AS "subscription_target",
        CAST("tax_code" AS VARCHAR) AS "tax_code",
        CAST("term_discount_level" AS VARCHAR) AS "term_discount_level",
        CAST("term_discount_schedule" AS VARCHAR) AS "term_discount_schedule",
        CAST("tier_1_price" AS VARCHAR) AS "tier_1_price",
        CAST("tier_2_price" AS VARCHAR) AS "tier_2_price",
        CAST("tier_3_price" AS VARCHAR) AS "tier_3_price",
        CAST("upgrade_source" AS VARCHAR) AS "upgrade_source",
        CAST("upgrade_target" AS VARCHAR) AS "upgrade_target"
    FROM "sf_product_2_data_projected_renamed"
),

"sf_product_2_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 89 columns with unacceptable missing values
    -- account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- accounting_system_input has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- accounting_system_output has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- avalara_tax_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- batch_quantity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- celigo_netsuite_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- celigo_netsuite_id_alt has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- celigo_netsuite_item_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- celigo_netsuite_record has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- celigo_pricing_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- compound_discount_rate has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configuration_event has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configuration_field_set has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configuration_fields has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configuration_form_title has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configuration_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configuration_validator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configured_code_pattern has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- configured_description_pattern has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- connection_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_configuration_page has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_picklist_value has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_community_availability has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- default_pricing_table has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- default_quantity_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- deleted_product_metadata has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- deployment_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dimension_definition has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- discount_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- discount_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- display_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dynamic_pricing_constraint has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- event_volume has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_data_source_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- generate_contracted_price has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_fivetran_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_non_recurring has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- max_volume has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- min_volume has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- netsuite_contract_pricing_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- netsuite_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- netsuite_item_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- netsuite_sync_error has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- option_layout has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- paid_consumption has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pricing_guidance has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_family has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- product_features has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_metadata has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_picture_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- promo_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_installment_period has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_installments has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_scale has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_schedule_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_unit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- related_product_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- renewal_product has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- request_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- revenue_installment_period has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- revenue_installments has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- revenue_schedule_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- roadmap_connections has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- row_volume has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sort_order has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- specifications has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- stock_keeping_unit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subscription_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subscription_percent has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subscription_target has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- term_discount_level has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- term_discount_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tier_1_price has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tier_2_price has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tier_3_price has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tier_4_price has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- upgrade_credit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- upgrade_ratio has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- upgrade_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- upgrade_target has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_active",
        "record_type_id",
        "is_deleted",
        "last_modified_by_id",
        "product_name",
        "product_id",
        "created_by_id",
        "product_family",
        "netsuite_sync_in_progress",
        "netsuite_celigo_update",
        "netsuite_sync_error",
        "push_to_netsuite",
        "netsuite_item_type",
        "netsuite_subtype",
        "is_new",
        "asset_amendment_behavior",
        "asset_conversion",
        "billing_frequency",
        "billing_type",
        "block_pricing_field",
        "charge_type",
        "is_component",
        "is_cost_editable",
        "is_custom_configuration_required",
        "is_description_locked",
        "exclude_from_maintenance",
        "exclude_from_opportunity",
        "is_externally_configurable",
        "has_configuration_attributes",
        "has_consumption_schedule",
        "is_hidden",
        "hide_price_in_search_results",
        "include_in_maintenance",
        "create_new_quote_group",
        "is_non_discountable",
        "is_non_partner_discountable",
        "option_selection_method",
        "is_optional",
        "is_price_editable",
        "pricing_method",
        "is_pricing_method_editable",
        "is_quantity_editable",
        "is_reconfiguration_disabled",
        "subscription_base",
        "subscription_pricing_model",
        "subscription_term",
        "subscription_type",
        "is_taxable",
        "connector_type",
        "pro_type_discount",
        "dimension",
        "connector_status",
        "is_complimentary",
        "external_product_id",
        "billing_rule_id",
        "revenue_recognition_rule_id",
        "tax_rule_id",
        "is_proration_disabled",
        "enable_large_configuration",
        "is_test_mode_record",
        "skip_netsuite_export",
        "is_non_recurring",
        "is_archived",
        "celigo_last_modified_date",
        "created_date",
        "last_modified_at",
        "last_modified_date",
        "product_code",
        "sbqq_default_quantity_c"
    FROM "sf_product_2_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_product_2_data_projected_renamed_casted_missing_handled"