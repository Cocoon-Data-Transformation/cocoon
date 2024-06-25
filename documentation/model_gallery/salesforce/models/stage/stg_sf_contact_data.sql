-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_contact_data_removeWideColumns" AS (
    -- Remove wide columns with pattern. The regex and columns are:
    -- ^bizible_\d+_.*_(ft|lc)_c$: bizible_2_ad_campaign_name_ft_c, bizible_2_ad_campaign_name_lc_c, bizible_2_landing_page_ft_c, bizible_2_landing_page_lc_c, bizible_2_marketing_channel_ft_c, bizible_2_marketing_channel_lc_c, bizible_2_touchpoint_date_ft_c, bizible_2_touchpoint_date_lc_c, bizible_2_touchpoint_source_ft_c, bizible_2_touchpoint_source_lc_c
    -- ^cloudingo_agent_\w+_c$: cloudingo_agent_ces_c, cloudingo_agent_mar_c, cloudingo_agent_mas_c, cloudingo_agent_mav_c, cloudingo_agent_mrdi_c, cloudingo_agent_mtz_c, cloudingo_agent_oar_c, cloudingo_agent_oas_c, cloudingo_agent_oav_c, cloudingo_agent_ordi_c ...
    -- ^engagio_.*_c$: engagio_department_c, engagio_engagement_minutes_last_3_months_c, engagio_engagement_minutes_last_7_days_c, engagio_first_engagement_date_c, engagio_intent_minutes_last_30_days_c, engagio_role_c
    -- ^es_app_es.*_c$: es_app_escreated_timestamp_c, es_app_esecid_c, es_app_esenriched_c, es_app_esenriched_timestamp_c, es_app_esintent_aggregate_score_c, es_app_esintent_timestamp_c, es_app_esintent_topics_c, es_app_esoverall_fit_score_c, es_app_essource_c
    -- ^fivetran_.*_c$: fivetran_account_association_date_c, fivetran_account_id_c, fivetran_account_user_role_s_c, fivetran_user_id_c
    -- ^mkto_71_contact_.*$: mkto_71_contact_acquisition_date_c, mkto_71_contact_acquisition_program_c, mkto_71_contact_acquisition_program_id_c, mkto_71_contact_inferred_city_c, mkto_71_contact_inferred_company_c, mkto_71_contact_inferred_country_c, mkto_71_contact_inferred_metropolitan_a_c, mkto_71_contact_inferred_phone_area_cod_c, mkto_71_contact_inferred_postal_code_c, mkto_71_contact_inferred_state_region_c ...
    -- ^mkto_si_.*$: mkto_si_hide_date_c, mkto_si_last_interesting_moment_date_c, mkto_si_last_interesting_moment_desc_c, mkto_si_last_interesting_moment_source_c, mkto_si_last_interesting_moment_type_c, mkto_si_mkto_lead_score_c, mkto_si_priority_c, mkto_si_relative_score_value_c, mkto_si_urgency_value_c
    -- ^rh_2_\w+_test_c$: rh_2_currency_test_c, rh_2_integer_test_c
    -- ^sales_loft_1_most_recent_.*$: sales_loft_1_most_recent_cadence_name_c, sales_loft_1_most_recent_cadence_next_step_due_date_c, sales_loft_1_most_recent_last_completed_step_c
    -- ^utm_.*_c$: utm_campaign_c, utm_content_c, utm_id_c, utm_medium_c, utm_source_c, utm_term_c
    SELECT 
        "_fivetran_active",
        "_fivetran_synced",
        "account_id",
        "act_on_lead_score_c",
        "active_relationship_c",
        "adgroupid_c",
        "allbound_id_c",
        "analytics_id_c",
        "assistant_name",
        "assistant_phone",
        "attempting_contact_date_time_c",
        "attended_event_c",
        "automation_tracking_c",
        "avatar_c",
        "behavioral_score_c",
        "beta_connector_interest_c",
        "bill_to_contact_hidden_c",
        "birthdate",
        "bizible_2_bizible_id_c",
        "bt_stripe_default_payment_gateway_c",
        "bt_stripe_default_payment_method_c",
        "bt_stripe_gender_c",
        "bt_stripe_languages_c",
        "bt_stripe_level_c",
        "bt_stripe_maiden_name_c",
        "bt_stripe_personal_id_number_c",
        "bt_stripe_personal_id_number_encrypted_c",
        "bt_stripe_personal_id_type_c",
        "bt_stripe_ssn_last_4_c",
        "bt_stripe_ssn_last_4_encrypted_c",
        "campaignid_c",
        "cbit_clearbit_c",
        "cbit_clearbit_ready_c",
        "cbit_created_by_clearbit_c",
        "celigo_sfnsio_net_suite_id_c",
        "celigo_sfnsio_net_suite_record_c",
        "celigo_sfnsio_net_suite_sync_error_c",
        "celigo_sfnsio_skip_export_to_net_suite_c",
        "celigo_sfnsio_test_mode_record_c",
        "city_c",
        "clarus_date_c",
        "clarus_editor_c",
        "clarus_notes_c",
        "clarus_project_c",
        "clarus_status_c",
        "clearbit_role_c",
        "clearbit_seniority_c",
        "clearbit_sub_role_c",
        "company_c",
        "competitor_c",
        "contact_holdover_c",
        "contact_owners_manager_stamped_c",
        "contact_stage_c",
        "contact_status_c",
        "contact_type_c",
        "contacts_domain_exists_c",
        "country_c",
        "country_code_c",
        "created_at_c",
        "created_by_id",
        "created_by_role_c",
        "created_date",
        "creative_c",
        "csi_code_c",
        "demographic_score_c",
        "department",
        "description",
        "device_c",
        "direct_office_c",
        "dnb_contact_phone_c",
        "dnb_email_c",
        "dnb_email_deliverability_score_c",
        "dnb_job_title_c",
        "dnb_phone_accuracy_score_c",
        "dnb_primary_address_city_c",
        "dnb_primary_address_country_region_code_c",
        "dnb_primary_address_postal_code_c",
        "dnb_primary_address_state_province_abbre_c",
        "dnb_primary_address_state_province_c",
        "dnboptimizer_dn_bcontact_record_c",
        "do_not_call",
        "do_not_route_lead_c",
        "do_not_sync_marketo_c",
        "do_not_sync_reason_marketo_c",
        "dozisf_zoom_info_company_id_c",
        "dozisf_zoom_info_first_updated_c",
        "dozisf_zoom_info_id_c",
        "dozisf_zoom_info_last_updated_c",
        "drift_cql_c",
        "email",
        "email_bounced_c",
        "email_bounced_date",
        "email_bounced_reason",
        "email_opt_in_double_c",
        "email_opt_in_explicit_c",
        "email_opt_in_implicit_c",
        "email_opt_out_date_time_c",
        "email_quality_unknown_c",
        "enrichment_request_c",
        "es_seniority_c",
        "fax",
        "first_activity_after_mql_changed_c",
        "first_activity_after_mql_date_c",
        "first_manual_activity_after_mql_date_c",
        "first_mql_date_c",
        "first_name",
        "free_trial_email_confirmed_date_c",
        "gclid_c",
        "gdpr_opt_in_explicit_c",
        "has_opted_out_of_email",
        "has_opted_out_of_fax",
        "historical_contact_status_c",
        "home_phone",
        "hot_contact_c",
        "hvr_update_c",
        "i_sell_avention_id_c",
        "id",
        "individual_id",
        "ironclad_workflow_c",
        "is_deleted",
        "is_email_bounced",
        "is_emea_event_routing_c",
        "is_eu_resident_c",
        "jigsaw",
        "jigsaw_contact_id",
        "job_function_c",
        "job_level_c",
        "keyword_c",
        "last_activity_date",
        "last_ae_activity_owner_c",
        "last_bdr_activity_owner_c",
        "last_curequest_date",
        "last_cuupdate_date",
        "last_manual_ae_activity_date_c",
        "last_manual_bdr_activity_date_c",
        "last_marketing_interesting_moment_date_c",
        "last_modified_by_id",
        "last_modified_date",
        "last_name",
        "last_referenced_date",
        "last_sales_activity_date_time_c",
        "last_sdr_activity_date_c",
        "last_sdr_activity_owner_c",
        "last_viewed_date",
        "lead_source",
        "lean_data_ld_segment_c",
        "lean_data_manual_route_trigger_c",
        "lean_data_matched_buyer_persona_c",
        "lean_data_modified_score_c",
        "lean_data_router_completion_date_time_c",
        "lean_data_routing_action_c",
        "lean_data_status_info_c",
        "lean_data_tag_c",
        "leandata_contact_owner_override_c",
        "legacy_hvr_id_c",
        "lid_linked_in_company_id_c",
        "lid_linked_in_member_token_c",
        "linked_in_url_c",
        "mailing_city",
        "mailing_country",
        "mailing_country_code",
        "mailing_geocode_accuracy",
        "mailing_latitude",
        "mailing_longitude",
        "mailing_postal_code",
        "mailing_state",
        "mailing_state_code",
        "mailing_street",
        "marketing_connector_interest_c",
        "marketing_process_c",
        "master_record_id",
        "matchtype_c",
        "mc_4_sf_mc_subscriber_c",
        "meta_data_create_date_c",
        "mobile_phone",
        "mql_date_c",
        "mql_date_changed_c",
        "mql_reason_c",
        "name",
        "netsuite_conn_celigo_update_c",
        "netsuite_conn_net_suite_id_c",
        "netsuite_conn_net_suite_sync_err_c",
        "netsuite_conn_push_to_net_suite_c",
        "netsuite_conn_pushed_from_opportunity_c",
        "netsuite_conn_sync_in_progress_c",
        "network_c",
        "no_geo_data_c",
        "no_longer_at_company_c",
        "notes_c",
        "old_lead_source_c",
        "old_lead_source_detail_c",
        "opp_handoff_ae_c",
        "opportunity_c",
        "original_utm_campaign_c",
        "original_utm_content_c",
        "original_utm_medium_c",
        "original_utm_source_c",
        "original_utm_term_c",
        "other_city",
        "other_country",
        "other_geocode_accuracy",
        "other_latitude",
        "other_longitude",
        "other_phone",
        "other_postal_code",
        "other_state",
        "other_street",
        "owner_id",
        "partner_company_c",
        "partner_contact_c",
        "partner_contact_deprecate_c",
        "partner_rep_email_c",
        "partner_rep_name_c",
        "partner_territory_c",
        "pbf_startup_certify_eligibility_c",
        "pbf_startup_primary_role_c",
        "persona_c",
        "phone",
        "phone_extension_c",
        "phone_number_catch_all_c",
        "photo_url",
        "pi_campaign_c",
        "pi_comments_c",
        "pi_conversion_date_c",
        "pi_conversion_object_name_c",
        "pi_conversion_object_type_c",
        "pi_created_date_c",
        "pi_first_activity_c",
        "pi_first_search_term_c",
        "pi_first_search_type_c",
        "pi_first_touch_url_c",
        "pi_grade_c",
        "pi_last_activity_c",
        "pi_needs_score_synced_c",
        "pi_notes_c",
        "pi_pardot_hard_bounced_c",
        "pi_pardot_last_scored_at_c",
        "pi_score_c",
        "pi_url_c",
        "pi_utm_campaign_c",
        "pi_utm_content_c",
        "pi_utm_medium_c",
        "pi_utm_source_c",
        "pi_utm_term_c",
        "potential_fivetran_use_case_c",
        "primary_se_c",
        "promotion_id_c",
        "recent_marketing_campaign_status_c",
        "referral_account_c",
        "referral_contact_c",
        "referral_exists_c",
        "referral_first_name_c",
        "referral_last_name_c",
        "region_c",
        "reports_to_id",
        "rh_2_describe_c",
        "routed_from_manual_bdr_ae_activity_c",
        "sales_email_opt_out_c",
        "sales_email_opt_out_date_time_c",
        "salesloft_cadence_trigger_c",
        "salesloft_owner_c",
        "salesloft_owner_sf_c",
        "salutation",
        "secondary_email_c",
        "self_service_routing_c",
        "source_detail_c",
        "source_last_lead_source_c",
        "source_last_lead_source_category_c",
        "source_last_lead_source_detail_c",
        "state_c",
        "state_code_c",
        "system_modstamp",
        "technical_contact_c",
        "title",
        "to_be_deleted_salesloft_backfill_c",
        "trial_contact_start_date_c",
        "unique_email_c",
        "unqualified_reason_c",
        "user_activity_logged_by_c",
        "user_gems_has_changed_job_c",
        "user_gems_is_a_user_gem_c",
        "user_gems_past_account_c",
        "user_gems_past_company_c",
        "user_gems_past_contact_c",
        "user_gems_past_title_c",
        "user_gems_ug_created_by_ug_c",
        "user_gems_ug_current_infos_c",
        "user_gems_ug_past_infos_c",
        "user_gems_user_gems_id_c",
        "username_c",
        "verified_c",
        "zoominfo_technologies_c"
    FROM "sf_contact_data"
),

"sf_contact_data_removeWideColumns_projected" AS (
    -- Projection: Selecting 291 out of 292 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "account_id",
        "act_on_lead_score_c",
        "active_relationship_c",
        "adgroupid_c",
        "allbound_id_c",
        "analytics_id_c",
        "assistant_name",
        "assistant_phone",
        "attempting_contact_date_time_c",
        "attended_event_c",
        "automation_tracking_c",
        "avatar_c",
        "behavioral_score_c",
        "beta_connector_interest_c",
        "bill_to_contact_hidden_c",
        "birthdate",
        "bizible_2_bizible_id_c",
        "bt_stripe_default_payment_gateway_c",
        "bt_stripe_default_payment_method_c",
        "bt_stripe_gender_c",
        "bt_stripe_languages_c",
        "bt_stripe_level_c",
        "bt_stripe_maiden_name_c",
        "bt_stripe_personal_id_number_c",
        "bt_stripe_personal_id_number_encrypted_c",
        "bt_stripe_personal_id_type_c",
        "bt_stripe_ssn_last_4_c",
        "bt_stripe_ssn_last_4_encrypted_c",
        "campaignid_c",
        "cbit_clearbit_c",
        "cbit_clearbit_ready_c",
        "cbit_created_by_clearbit_c",
        "celigo_sfnsio_net_suite_id_c",
        "celigo_sfnsio_net_suite_record_c",
        "celigo_sfnsio_net_suite_sync_error_c",
        "celigo_sfnsio_skip_export_to_net_suite_c",
        "celigo_sfnsio_test_mode_record_c",
        "city_c",
        "clarus_date_c",
        "clarus_editor_c",
        "clarus_notes_c",
        "clarus_project_c",
        "clarus_status_c",
        "clearbit_role_c",
        "clearbit_seniority_c",
        "clearbit_sub_role_c",
        "company_c",
        "competitor_c",
        "contact_holdover_c",
        "contact_owners_manager_stamped_c",
        "contact_stage_c",
        "contact_status_c",
        "contact_type_c",
        "contacts_domain_exists_c",
        "country_c",
        "country_code_c",
        "created_at_c",
        "created_by_id",
        "created_by_role_c",
        "created_date",
        "creative_c",
        "csi_code_c",
        "demographic_score_c",
        "department",
        "description",
        "device_c",
        "direct_office_c",
        "dnb_contact_phone_c",
        "dnb_email_c",
        "dnb_email_deliverability_score_c",
        "dnb_job_title_c",
        "dnb_phone_accuracy_score_c",
        "dnb_primary_address_city_c",
        "dnb_primary_address_country_region_code_c",
        "dnb_primary_address_postal_code_c",
        "dnb_primary_address_state_province_abbre_c",
        "dnb_primary_address_state_province_c",
        "dnboptimizer_dn_bcontact_record_c",
        "do_not_call",
        "do_not_route_lead_c",
        "do_not_sync_marketo_c",
        "do_not_sync_reason_marketo_c",
        "dozisf_zoom_info_company_id_c",
        "dozisf_zoom_info_first_updated_c",
        "dozisf_zoom_info_id_c",
        "dozisf_zoom_info_last_updated_c",
        "drift_cql_c",
        "email",
        "email_bounced_c",
        "email_bounced_date",
        "email_bounced_reason",
        "email_opt_in_double_c",
        "email_opt_in_explicit_c",
        "email_opt_in_implicit_c",
        "email_opt_out_date_time_c",
        "email_quality_unknown_c",
        "enrichment_request_c",
        "es_seniority_c",
        "fax",
        "first_activity_after_mql_changed_c",
        "first_activity_after_mql_date_c",
        "first_manual_activity_after_mql_date_c",
        "first_mql_date_c",
        "first_name",
        "free_trial_email_confirmed_date_c",
        "gclid_c",
        "gdpr_opt_in_explicit_c",
        "has_opted_out_of_email",
        "has_opted_out_of_fax",
        "historical_contact_status_c",
        "home_phone",
        "hot_contact_c",
        "hvr_update_c",
        "i_sell_avention_id_c",
        "id",
        "individual_id",
        "ironclad_workflow_c",
        "is_deleted",
        "is_email_bounced",
        "is_emea_event_routing_c",
        "is_eu_resident_c",
        "jigsaw",
        "jigsaw_contact_id",
        "job_function_c",
        "job_level_c",
        "keyword_c",
        "last_activity_date",
        "last_ae_activity_owner_c",
        "last_bdr_activity_owner_c",
        "last_curequest_date",
        "last_cuupdate_date",
        "last_manual_ae_activity_date_c",
        "last_manual_bdr_activity_date_c",
        "last_marketing_interesting_moment_date_c",
        "last_modified_by_id",
        "last_modified_date",
        "last_name",
        "last_referenced_date",
        "last_sales_activity_date_time_c",
        "last_sdr_activity_date_c",
        "last_sdr_activity_owner_c",
        "last_viewed_date",
        "lead_source",
        "lean_data_ld_segment_c",
        "lean_data_manual_route_trigger_c",
        "lean_data_matched_buyer_persona_c",
        "lean_data_modified_score_c",
        "lean_data_router_completion_date_time_c",
        "lean_data_routing_action_c",
        "lean_data_status_info_c",
        "lean_data_tag_c",
        "leandata_contact_owner_override_c",
        "legacy_hvr_id_c",
        "lid_linked_in_company_id_c",
        "lid_linked_in_member_token_c",
        "linked_in_url_c",
        "mailing_city",
        "mailing_country",
        "mailing_country_code",
        "mailing_geocode_accuracy",
        "mailing_latitude",
        "mailing_longitude",
        "mailing_postal_code",
        "mailing_state",
        "mailing_state_code",
        "mailing_street",
        "marketing_connector_interest_c",
        "marketing_process_c",
        "master_record_id",
        "matchtype_c",
        "mc_4_sf_mc_subscriber_c",
        "meta_data_create_date_c",
        "mobile_phone",
        "mql_date_c",
        "mql_date_changed_c",
        "mql_reason_c",
        "name",
        "netsuite_conn_celigo_update_c",
        "netsuite_conn_net_suite_id_c",
        "netsuite_conn_net_suite_sync_err_c",
        "netsuite_conn_push_to_net_suite_c",
        "netsuite_conn_pushed_from_opportunity_c",
        "netsuite_conn_sync_in_progress_c",
        "network_c",
        "no_geo_data_c",
        "no_longer_at_company_c",
        "notes_c",
        "old_lead_source_c",
        "old_lead_source_detail_c",
        "opp_handoff_ae_c",
        "opportunity_c",
        "original_utm_campaign_c",
        "original_utm_content_c",
        "original_utm_medium_c",
        "original_utm_source_c",
        "original_utm_term_c",
        "other_city",
        "other_country",
        "other_geocode_accuracy",
        "other_latitude",
        "other_longitude",
        "other_phone",
        "other_postal_code",
        "other_state",
        "other_street",
        "owner_id",
        "partner_company_c",
        "partner_contact_c",
        "partner_contact_deprecate_c",
        "partner_rep_email_c",
        "partner_rep_name_c",
        "partner_territory_c",
        "pbf_startup_certify_eligibility_c",
        "pbf_startup_primary_role_c",
        "persona_c",
        "phone",
        "phone_extension_c",
        "phone_number_catch_all_c",
        "photo_url",
        "pi_campaign_c",
        "pi_comments_c",
        "pi_conversion_date_c",
        "pi_conversion_object_name_c",
        "pi_conversion_object_type_c",
        "pi_created_date_c",
        "pi_first_activity_c",
        "pi_first_search_term_c",
        "pi_first_search_type_c",
        "pi_first_touch_url_c",
        "pi_grade_c",
        "pi_last_activity_c",
        "pi_needs_score_synced_c",
        "pi_notes_c",
        "pi_pardot_hard_bounced_c",
        "pi_pardot_last_scored_at_c",
        "pi_score_c",
        "pi_url_c",
        "pi_utm_campaign_c",
        "pi_utm_content_c",
        "pi_utm_medium_c",
        "pi_utm_source_c",
        "pi_utm_term_c",
        "potential_fivetran_use_case_c",
        "primary_se_c",
        "promotion_id_c",
        "recent_marketing_campaign_status_c",
        "referral_account_c",
        "referral_contact_c",
        "referral_exists_c",
        "referral_first_name_c",
        "referral_last_name_c",
        "region_c",
        "reports_to_id",
        "rh_2_describe_c",
        "routed_from_manual_bdr_ae_activity_c",
        "sales_email_opt_out_c",
        "sales_email_opt_out_date_time_c",
        "salesloft_cadence_trigger_c",
        "salesloft_owner_c",
        "salesloft_owner_sf_c",
        "salutation",
        "secondary_email_c",
        "self_service_routing_c",
        "source_detail_c",
        "source_last_lead_source_c",
        "source_last_lead_source_category_c",
        "source_last_lead_source_detail_c",
        "state_c",
        "state_code_c",
        "system_modstamp",
        "technical_contact_c",
        "title",
        "to_be_deleted_salesloft_backfill_c",
        "trial_contact_start_date_c",
        "unique_email_c",
        "unqualified_reason_c",
        "user_activity_logged_by_c",
        "user_gems_has_changed_job_c",
        "user_gems_is_a_user_gem_c",
        "user_gems_past_account_c",
        "user_gems_past_company_c",
        "user_gems_past_contact_c",
        "user_gems_past_title_c",
        "user_gems_ug_created_by_ug_c",
        "user_gems_ug_current_infos_c",
        "user_gems_ug_past_infos_c",
        "user_gems_user_gems_id_c",
        "username_c",
        "verified_c",
        "zoominfo_technologies_c"
    FROM "sf_contact_data_removeWideColumns"
),

"sf_contact_data_removeWideColumns_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- act_on_lead_score_c -> act_on_lead_score
    -- active_relationship_c -> is_relationship_active
    -- adgroupid_c -> ad_group_id
    -- allbound_id_c -> allbound_id
    -- analytics_id_c -> analytics_id
    -- attempting_contact_date_time_c -> last_contact_attempt
    -- attended_event_c -> has_attended_event
    -- automation_tracking_c -> automation_tracking
    -- avatar_c -> avatar_url
    -- behavioral_score_c -> behavioral_score
    -- beta_connector_interest_c -> beta_connector_interest
    -- bill_to_contact_hidden_c -> is_billing_contact_hidden
    -- bizible_2_bizible_id_c -> bizible_id
    -- bt_stripe_default_payment_gateway_c -> stripe_default_gateway
    -- bt_stripe_default_payment_method_c -> stripe_default_payment_method
    -- bt_stripe_gender_c -> stripe_gender
    -- bt_stripe_languages_c -> stripe_languages
    -- bt_stripe_level_c -> stripe_customer_level
    -- bt_stripe_maiden_name_c -> stripe_maiden_name
    -- bt_stripe_personal_id_number_c -> stripe_personal_id_number
    -- bt_stripe_personal_id_number_encrypted_c -> stripe_encrypted_personal_id
    -- bt_stripe_personal_id_type_c -> stripe_personal_id_type
    -- bt_stripe_ssn_last_4_c -> stripe_ssn_last_4
    -- bt_stripe_ssn_last_4_encrypted_c -> stripe_encrypted_ssn_last_4
    -- campaignid_c -> campaign_id
    -- cbit_clearbit_c -> clearbit_id
    -- cbit_clearbit_ready_c -> clearbit_data_ready
    -- cbit_created_by_clearbit_c -> created_by_clearbit
    -- celigo_sfnsio_net_suite_id_c -> netsuite_id
    -- celigo_sfnsio_net_suite_record_c -> netsuite_record
    -- celigo_sfnsio_skip_export_to_net_suite_c -> skip_netsuite_export
    -- celigo_sfnsio_test_mode_record_c -> test_mode_record
    -- city_c -> city
    -- clarus_date_c -> clarus_date
    -- clarus_editor_c -> clarus_editor
    -- clarus_notes_c -> clarus_notes
    -- clarus_project_c -> clarus_project
    -- clarus_status_c -> clarus_status
    -- clearbit_role_c -> clearbit_role
    -- clearbit_seniority_c -> clearbit_seniority
    -- clearbit_sub_role_c -> clearbit_sub_role
    -- company_c -> company
    -- competitor_c -> is_competitor
    -- contact_holdover_c -> contact_holdover
    -- contact_owners_manager_stamped_c -> contact_owner_manager
    -- contact_stage_c -> contact_stage
    -- contact_status_c -> contact_status
    -- contact_type_c -> contact_type
    -- contacts_domain_exists_c -> domain_exists
    -- country_c -> country
    -- country_code_c -> country_code
    -- created_at_c -> created_at
    -- created_by_role_c -> created_by_role
    -- creative_c -> creative_id
    -- csi_code_c -> csi_code
    -- demographic_score_c -> demographic_score
    -- device_c -> device_type
    -- direct_office_c -> direct_office
    -- dnb_contact_phone_c -> dnb_contact_phone
    -- dnb_email_c -> dnb_email
    -- dnb_email_deliverability_score_c -> dnb_email_deliverability_score
    -- dnb_job_title_c -> dnb_job_title
    -- dnb_phone_accuracy_score_c -> dnb_phone_accuracy_score
    -- dnb_primary_address_city_c -> dnb_primary_city
    -- dnb_primary_address_country_region_code_c -> dnb_primary_country_code
    -- dnb_primary_address_postal_code_c -> dnb_primary_postal_code
    -- dnb_primary_address_state_province_abbre_c -> dnb_primary_state_abbr
    -- dnb_primary_address_state_province_c -> dnb_primary_state
    -- dnboptimizer_dn_bcontact_record_c -> dnb_optimizer_contact_id
    -- do_not_route_lead_c -> do_not_route_lead
    -- do_not_sync_marketo_c -> do_not_sync_marketo
    -- do_not_sync_reason_marketo_c -> marketo_sync_block_reason
    -- dozisf_zoom_info_company_id_c -> zoominfo_company_id
    -- dozisf_zoom_info_first_updated_c -> zoominfo_first_updated
    -- dozisf_zoom_info_id_c -> zoominfo_contact_id
    -- dozisf_zoom_info_last_updated_c -> zoominfo_last_updated
    -- drift_cql_c -> drift_cql
    -- email_bounced_c -> email_bounced
    -- email_bounced_date -> email_bounce_date
    -- email_bounced_reason -> email_bounce_reason
    -- email_opt_in_double_c -> email_double_opt_in
    -- email_opt_in_explicit_c -> email_explicit_opt_in
    -- email_opt_in_implicit_c -> email_implicit_opt_in
    -- email_opt_out_date_time_c -> email_opt_out_timestamp
    -- email_quality_unknown_c -> email_quality_unknown
    -- enrichment_request_c -> data_enrichment_request
    -- es_seniority_c -> seniority_level
    -- fax -> fax_number
    -- first_activity_after_mql_changed_c -> first_activity_post_mql
    -- first_activity_after_mql_date_c -> first_activity_post_mql_date
    -- first_manual_activity_after_mql_date_c -> first_manual_activity_post_mql_date
    -- first_mql_date_c -> first_mql_date
    -- free_trial_email_confirmed_date_c -> free_trial_confirmation_date
    -- gclid_c -> google_click_id
    -- gdpr_opt_in_explicit_c -> gdpr_explicit_opt_in
    -- has_opted_out_of_email -> email_opt_out
    -- has_opted_out_of_fax -> fax_opt_out
    -- historical_contact_status_c -> historical_contact_status
    -- home_phone -> home_phone_number
    -- hot_contact_c -> is_hot_contact
    -- hvr_update_c -> hvr_update
    -- i_sell_avention_id_c -> isell_avention_id
    -- id -> contact_id
    -- ironclad_workflow_c -> ironclad_workflow_status
    -- is_emea_event_routing_c -> is_emea_event_routing
    -- is_eu_resident_c -> is_eu_resident
    -- jigsaw -> jigsaw_data
    -- job_function_c -> job_function
    -- job_level_c -> job_level
    -- keyword_c -> keywords
    -- last_ae_activity_owner_c -> last_ae_activity_owner
    -- last_bdr_activity_owner_c -> last_bdr_activity_owner
    -- last_curequest_date -> last_customer_request_date
    -- last_cuupdate_date -> last_customer_update_date
    -- last_manual_ae_activity_date_c -> last_manual_ae_activity_date
    -- last_manual_bdr_activity_date_c -> last_manual_bdr_activity_date
    -- last_marketing_interesting_moment_date_c -> last_marketing_moment_date
    -- last_sales_activity_date_time_c -> last_sales_activity_datetime
    -- last_sdr_activity_date_c -> last_sdr_activity_date
    -- last_sdr_activity_owner_c -> last_sdr_activity_owner
    -- lean_data_ld_segment_c -> lean_data_segment
    -- lean_data_manual_route_trigger_c -> lean_data_manual_route_trigger
    -- lean_data_matched_buyer_persona_c -> lean_data_matched_buyer_persona
    -- lean_data_modified_score_c -> lean_data_modified_score
    -- lean_data_router_completion_date_time_c -> lean_data_routing_completion_datetime
    -- lean_data_routing_action_c -> lean_data_routing_action
    -- lean_data_status_info_c -> leandata_status
    -- lean_data_tag_c -> leandata_tag
    -- leandata_contact_owner_override_c -> leandata_owner_override
    -- legacy_hvr_id_c -> legacy_hvr_id
    -- lid_linked_in_company_id_c -> linkedin_company_id
    -- lid_linked_in_member_token_c -> linkedin_member_token
    -- linked_in_url_c -> linkedin_url
    -- marketing_connector_interest_c -> marketing_connector_interest
    -- marketing_process_c -> marketing_process_status
    -- matchtype_c -> match_type
    -- mc_4_sf_mc_subscriber_c -> marketing_cloud_subscriber
    -- meta_data_create_date_c -> metadata_creation_date
    -- mql_date_c -> mql_date
    -- mql_date_changed_c -> mql_date_changed
    -- mql_reason_c -> mql_reason
    -- netsuite_conn_celigo_update_c -> netsuite_celigo_update
    -- netsuite_conn_net_suite_id_c -> netsuite_connection_id
    -- netsuite_conn_push_to_net_suite_c -> push_to_netsuite
    -- netsuite_conn_pushed_from_opportunity_c -> pushed_from_opportunity
    -- netsuite_conn_sync_in_progress_c -> netsuite_sync_in_progress
    -- network_c -> professional_network
    -- no_geo_data_c -> no_geo_data
    -- no_longer_at_company_c -> no_longer_at_company
    -- notes_c -> contact_notes
    -- old_lead_source_c -> previous_lead_source
    -- old_lead_source_detail_c -> previous_lead_source_details
    -- opp_handoff_ae_c -> opportunity_handoff_ae
    -- opportunity_c -> associated_opportunity
    -- original_utm_campaign_c -> original_utm_campaign
    -- original_utm_content_c -> original_utm_content
    -- original_utm_medium_c -> original_utm_medium
    -- original_utm_source_c -> original_utm_source
    -- original_utm_term_c -> original_utm_term
    -- other_city -> secondary_city
    -- other_country -> secondary_country
    -- other_geocode_accuracy -> secondary_geocode_accuracy
    -- other_latitude -> secondary_latitude
    -- other_longitude -> secondary_longitude
    -- other_phone -> secondary_phone
    -- other_postal_code -> secondary_postal_code
    -- other_state -> secondary_state
    -- other_street -> secondary_street
    -- partner_company_c -> partner_company
    -- partner_contact_c -> partner_contact
    -- partner_contact_deprecate_c -> deprecated_partner_contact
    -- partner_rep_email_c -> partner_rep_email
    -- partner_rep_name_c -> partner_rep_name
    -- partner_territory_c -> partner_territory
    -- pbf_startup_certify_eligibility_c -> startup_certification_eligibility
    -- pbf_startup_primary_role_c -> startup_primary_role
    -- persona_c -> customer_persona
    -- phone_extension_c -> phone_extension
    -- phone_number_catch_all_c -> additional_phone_numbers
    -- pi_campaign_c -> marketing_campaign
    -- pi_comments_c -> comments
    -- pi_conversion_date_c -> conversion_date
    -- pi_conversion_object_name_c -> conversion_object_name
    -- pi_conversion_object_type_c -> conversion_object_type
    -- pi_first_activity_c -> first_activity
    -- pi_first_search_term_c -> first_search_term
    -- pi_first_search_type_c -> first_search_type
    -- pi_first_touch_url_c -> first_touch_url
    -- pi_grade_c -> lead_grade
    -- pi_last_activity_c -> last_activity
    -- pi_needs_score_synced_c -> needs_score_sync
    -- pi_notes_c -> notes
    -- pi_pardot_hard_bounced_c -> email_hard_bounced
    -- pi_pardot_last_scored_at_c -> last_scored_at
    -- pi_score_c -> lead_score
    -- pi_url_c -> associated_url
    -- pi_utm_campaign_c -> utm_campaign
    -- pi_utm_content_c -> utm_content
    -- pi_utm_medium_c -> utm_medium
    -- pi_utm_source_c -> utm_source
    -- pi_utm_term_c -> utm_term
    -- potential_fivetran_use_case_c -> fivetran_use_case
    -- primary_se_c -> primary_sales_engineer
    -- promotion_id_c -> promotion_id
    -- recent_marketing_campaign_status_c -> recent_campaign_status
    -- referral_account_c -> referral_account
    -- referral_contact_c -> referral_contact
    -- referral_exists_c -> has_referral
    -- referral_first_name_c -> referral_first_name
    -- referral_last_name_c -> referral_last_name
    -- region_c -> region
    -- rh_2_describe_c -> custom_description
    -- routed_from_manual_bdr_ae_activity_c -> manual_routing
    -- sales_email_opt_out_c -> sales_email_opt_out
    -- sales_email_opt_out_date_time_c -> sales_email_opt_out_datetime
    -- salesloft_cadence_trigger_c -> salesloft_cadence_trigger
    -- salesloft_owner_c -> salesloft_owner
    -- salesloft_owner_sf_c -> salesloft_owner_sf_id
    -- secondary_email_c -> secondary_email
    -- self_service_routing_c -> self_service_routing
    -- source_detail_c -> source_detail
    -- source_last_lead_source_c -> last_lead_source
    -- source_last_lead_source_category_c -> last_lead_source_category
    -- source_last_lead_source_detail_c -> last_lead_source_detail
    -- state_c -> state
    -- state_code_c -> state_code
    -- system_modstamp -> last_modified_timestamp
    -- technical_contact_c -> is_technical_contact
    -- title -> job_title
    -- to_be_deleted_salesloft_backfill_c -> delete_salesloft_data
    -- trial_contact_start_date_c -> trial_start_date
    -- unique_email_c -> email_address
    -- unqualified_reason_c -> unqualified_reason
    -- user_activity_logged_by_c -> activity_logged_by
    -- user_gems_has_changed_job_c -> has_changed_job
    -- user_gems_is_a_user_gem_c -> is_user_gem
    -- user_gems_past_account_c -> past_account
    -- user_gems_past_company_c -> past_company
    -- user_gems_past_contact_c -> past_contact_info
    -- user_gems_past_title_c -> past_job_title
    -- user_gems_ug_created_by_ug_c -> created_by_user_gems
    -- user_gems_ug_current_infos_c -> current_user_gems_info
    -- user_gems_ug_past_infos_c -> past_user_gems_info
    -- user_gems_user_gems_id_c -> user_gems_id
    -- username_c -> username
    -- verified_c -> is_verified
    -- zoominfo_technologies_c -> used_technologies
    SELECT 
        "_fivetran_active" AS "is_active",
        "account_id",
        "act_on_lead_score_c" AS "act_on_lead_score",
        "active_relationship_c" AS "is_relationship_active",
        "adgroupid_c" AS "ad_group_id",
        "allbound_id_c" AS "allbound_id",
        "analytics_id_c" AS "analytics_id",
        "assistant_name",
        "assistant_phone",
        "attempting_contact_date_time_c" AS "last_contact_attempt",
        "attended_event_c" AS "has_attended_event",
        "automation_tracking_c" AS "automation_tracking",
        "avatar_c" AS "avatar_url",
        "behavioral_score_c" AS "behavioral_score",
        "beta_connector_interest_c" AS "beta_connector_interest",
        "bill_to_contact_hidden_c" AS "is_billing_contact_hidden",
        "birthdate",
        "bizible_2_bizible_id_c" AS "bizible_id",
        "bt_stripe_default_payment_gateway_c" AS "stripe_default_gateway",
        "bt_stripe_default_payment_method_c" AS "stripe_default_payment_method",
        "bt_stripe_gender_c" AS "stripe_gender",
        "bt_stripe_languages_c" AS "stripe_languages",
        "bt_stripe_level_c" AS "stripe_customer_level",
        "bt_stripe_maiden_name_c" AS "stripe_maiden_name",
        "bt_stripe_personal_id_number_c" AS "stripe_personal_id_number",
        "bt_stripe_personal_id_number_encrypted_c" AS "stripe_encrypted_personal_id",
        "bt_stripe_personal_id_type_c" AS "stripe_personal_id_type",
        "bt_stripe_ssn_last_4_c" AS "stripe_ssn_last_4",
        "bt_stripe_ssn_last_4_encrypted_c" AS "stripe_encrypted_ssn_last_4",
        "campaignid_c" AS "campaign_id",
        "cbit_clearbit_c" AS "clearbit_id",
        "cbit_clearbit_ready_c" AS "clearbit_data_ready",
        "cbit_created_by_clearbit_c" AS "created_by_clearbit",
        "celigo_sfnsio_net_suite_id_c" AS "netsuite_id",
        "celigo_sfnsio_net_suite_record_c" AS "netsuite_record",
        "celigo_sfnsio_net_suite_sync_error_c",
        "celigo_sfnsio_skip_export_to_net_suite_c" AS "skip_netsuite_export",
        "celigo_sfnsio_test_mode_record_c" AS "test_mode_record",
        "city_c" AS "city",
        "clarus_date_c" AS "clarus_date",
        "clarus_editor_c" AS "clarus_editor",
        "clarus_notes_c" AS "clarus_notes",
        "clarus_project_c" AS "clarus_project",
        "clarus_status_c" AS "clarus_status",
        "clearbit_role_c" AS "clearbit_role",
        "clearbit_seniority_c" AS "clearbit_seniority",
        "clearbit_sub_role_c" AS "clearbit_sub_role",
        "company_c" AS "company",
        "competitor_c" AS "is_competitor",
        "contact_holdover_c" AS "contact_holdover",
        "contact_owners_manager_stamped_c" AS "contact_owner_manager",
        "contact_stage_c" AS "contact_stage",
        "contact_status_c" AS "contact_status",
        "contact_type_c" AS "contact_type",
        "contacts_domain_exists_c" AS "domain_exists",
        "country_c" AS "country",
        "country_code_c" AS "country_code",
        "created_at_c" AS "created_at",
        "created_by_id",
        "created_by_role_c" AS "created_by_role",
        "created_date",
        "creative_c" AS "creative_id",
        "csi_code_c" AS "csi_code",
        "demographic_score_c" AS "demographic_score",
        "department",
        "description",
        "device_c" AS "device_type",
        "direct_office_c" AS "direct_office",
        "dnb_contact_phone_c" AS "dnb_contact_phone",
        "dnb_email_c" AS "dnb_email",
        "dnb_email_deliverability_score_c" AS "dnb_email_deliverability_score",
        "dnb_job_title_c" AS "dnb_job_title",
        "dnb_phone_accuracy_score_c" AS "dnb_phone_accuracy_score",
        "dnb_primary_address_city_c" AS "dnb_primary_city",
        "dnb_primary_address_country_region_code_c" AS "dnb_primary_country_code",
        "dnb_primary_address_postal_code_c" AS "dnb_primary_postal_code",
        "dnb_primary_address_state_province_abbre_c" AS "dnb_primary_state_abbr",
        "dnb_primary_address_state_province_c" AS "dnb_primary_state",
        "dnboptimizer_dn_bcontact_record_c" AS "dnb_optimizer_contact_id",
        "do_not_call",
        "do_not_route_lead_c" AS "do_not_route_lead",
        "do_not_sync_marketo_c" AS "do_not_sync_marketo",
        "do_not_sync_reason_marketo_c" AS "marketo_sync_block_reason",
        "dozisf_zoom_info_company_id_c" AS "zoominfo_company_id",
        "dozisf_zoom_info_first_updated_c" AS "zoominfo_first_updated",
        "dozisf_zoom_info_id_c" AS "zoominfo_contact_id",
        "dozisf_zoom_info_last_updated_c" AS "zoominfo_last_updated",
        "drift_cql_c" AS "drift_cql",
        "email",
        "email_bounced_c" AS "email_bounced",
        "email_bounced_date" AS "email_bounce_date",
        "email_bounced_reason" AS "email_bounce_reason",
        "email_opt_in_double_c" AS "email_double_opt_in",
        "email_opt_in_explicit_c" AS "email_explicit_opt_in",
        "email_opt_in_implicit_c" AS "email_implicit_opt_in",
        "email_opt_out_date_time_c" AS "email_opt_out_timestamp",
        "email_quality_unknown_c" AS "email_quality_unknown",
        "enrichment_request_c" AS "data_enrichment_request",
        "es_seniority_c" AS "seniority_level",
        "fax" AS "fax_number",
        "first_activity_after_mql_changed_c" AS "first_activity_post_mql",
        "first_activity_after_mql_date_c" AS "first_activity_post_mql_date",
        "first_manual_activity_after_mql_date_c" AS "first_manual_activity_post_mql_date",
        "first_mql_date_c" AS "first_mql_date",
        "first_name",
        "free_trial_email_confirmed_date_c" AS "free_trial_confirmation_date",
        "gclid_c" AS "google_click_id",
        "gdpr_opt_in_explicit_c" AS "gdpr_explicit_opt_in",
        "has_opted_out_of_email" AS "email_opt_out",
        "has_opted_out_of_fax" AS "fax_opt_out",
        "historical_contact_status_c" AS "historical_contact_status",
        "home_phone" AS "home_phone_number",
        "hot_contact_c" AS "is_hot_contact",
        "hvr_update_c" AS "hvr_update",
        "i_sell_avention_id_c" AS "isell_avention_id",
        "id" AS "contact_id",
        "individual_id",
        "ironclad_workflow_c" AS "ironclad_workflow_status",
        "is_deleted",
        "is_email_bounced",
        "is_emea_event_routing_c" AS "is_emea_event_routing",
        "is_eu_resident_c" AS "is_eu_resident",
        "jigsaw" AS "jigsaw_data",
        "jigsaw_contact_id",
        "job_function_c" AS "job_function",
        "job_level_c" AS "job_level",
        "keyword_c" AS "keywords",
        "last_activity_date",
        "last_ae_activity_owner_c" AS "last_ae_activity_owner",
        "last_bdr_activity_owner_c" AS "last_bdr_activity_owner",
        "last_curequest_date" AS "last_customer_request_date",
        "last_cuupdate_date" AS "last_customer_update_date",
        "last_manual_ae_activity_date_c" AS "last_manual_ae_activity_date",
        "last_manual_bdr_activity_date_c" AS "last_manual_bdr_activity_date",
        "last_marketing_interesting_moment_date_c" AS "last_marketing_moment_date",
        "last_modified_by_id",
        "last_modified_date",
        "last_name",
        "last_referenced_date",
        "last_sales_activity_date_time_c" AS "last_sales_activity_datetime",
        "last_sdr_activity_date_c" AS "last_sdr_activity_date",
        "last_sdr_activity_owner_c" AS "last_sdr_activity_owner",
        "last_viewed_date",
        "lead_source",
        "lean_data_ld_segment_c" AS "lean_data_segment",
        "lean_data_manual_route_trigger_c" AS "lean_data_manual_route_trigger",
        "lean_data_matched_buyer_persona_c" AS "lean_data_matched_buyer_persona",
        "lean_data_modified_score_c" AS "lean_data_modified_score",
        "lean_data_router_completion_date_time_c" AS "lean_data_routing_completion_datetime",
        "lean_data_routing_action_c" AS "lean_data_routing_action",
        "lean_data_status_info_c" AS "leandata_status",
        "lean_data_tag_c" AS "leandata_tag",
        "leandata_contact_owner_override_c" AS "leandata_owner_override",
        "legacy_hvr_id_c" AS "legacy_hvr_id",
        "lid_linked_in_company_id_c" AS "linkedin_company_id",
        "lid_linked_in_member_token_c" AS "linkedin_member_token",
        "linked_in_url_c" AS "linkedin_url",
        "mailing_city",
        "mailing_country",
        "mailing_country_code",
        "mailing_geocode_accuracy",
        "mailing_latitude",
        "mailing_longitude",
        "mailing_postal_code",
        "mailing_state",
        "mailing_state_code",
        "mailing_street",
        "marketing_connector_interest_c" AS "marketing_connector_interest",
        "marketing_process_c" AS "marketing_process_status",
        "master_record_id",
        "matchtype_c" AS "match_type",
        "mc_4_sf_mc_subscriber_c" AS "marketing_cloud_subscriber",
        "meta_data_create_date_c" AS "metadata_creation_date",
        "mobile_phone",
        "mql_date_c" AS "mql_date",
        "mql_date_changed_c" AS "mql_date_changed",
        "mql_reason_c" AS "mql_reason",
        "name",
        "netsuite_conn_celigo_update_c" AS "netsuite_celigo_update",
        "netsuite_conn_net_suite_id_c" AS "netsuite_connection_id",
        "netsuite_conn_net_suite_sync_err_c",
        "netsuite_conn_push_to_net_suite_c" AS "push_to_netsuite",
        "netsuite_conn_pushed_from_opportunity_c" AS "pushed_from_opportunity",
        "netsuite_conn_sync_in_progress_c" AS "netsuite_sync_in_progress",
        "network_c" AS "professional_network",
        "no_geo_data_c" AS "no_geo_data",
        "no_longer_at_company_c" AS "no_longer_at_company",
        "notes_c" AS "contact_notes",
        "old_lead_source_c" AS "previous_lead_source",
        "old_lead_source_detail_c" AS "previous_lead_source_details",
        "opp_handoff_ae_c" AS "opportunity_handoff_ae",
        "opportunity_c" AS "associated_opportunity",
        "original_utm_campaign_c" AS "original_utm_campaign",
        "original_utm_content_c" AS "original_utm_content",
        "original_utm_medium_c" AS "original_utm_medium",
        "original_utm_source_c" AS "original_utm_source",
        "original_utm_term_c" AS "original_utm_term",
        "other_city" AS "secondary_city",
        "other_country" AS "secondary_country",
        "other_geocode_accuracy" AS "secondary_geocode_accuracy",
        "other_latitude" AS "secondary_latitude",
        "other_longitude" AS "secondary_longitude",
        "other_phone" AS "secondary_phone",
        "other_postal_code" AS "secondary_postal_code",
        "other_state" AS "secondary_state",
        "other_street" AS "secondary_street",
        "owner_id",
        "partner_company_c" AS "partner_company",
        "partner_contact_c" AS "partner_contact",
        "partner_contact_deprecate_c" AS "deprecated_partner_contact",
        "partner_rep_email_c" AS "partner_rep_email",
        "partner_rep_name_c" AS "partner_rep_name",
        "partner_territory_c" AS "partner_territory",
        "pbf_startup_certify_eligibility_c" AS "startup_certification_eligibility",
        "pbf_startup_primary_role_c" AS "startup_primary_role",
        "persona_c" AS "customer_persona",
        "phone",
        "phone_extension_c" AS "phone_extension",
        "phone_number_catch_all_c" AS "additional_phone_numbers",
        "photo_url",
        "pi_campaign_c" AS "marketing_campaign",
        "pi_comments_c" AS "comments",
        "pi_conversion_date_c" AS "conversion_date",
        "pi_conversion_object_name_c" AS "conversion_object_name",
        "pi_conversion_object_type_c" AS "conversion_object_type",
        "pi_created_date_c",
        "pi_first_activity_c" AS "first_activity",
        "pi_first_search_term_c" AS "first_search_term",
        "pi_first_search_type_c" AS "first_search_type",
        "pi_first_touch_url_c" AS "first_touch_url",
        "pi_grade_c" AS "lead_grade",
        "pi_last_activity_c" AS "last_activity",
        "pi_needs_score_synced_c" AS "needs_score_sync",
        "pi_notes_c" AS "notes",
        "pi_pardot_hard_bounced_c" AS "email_hard_bounced",
        "pi_pardot_last_scored_at_c" AS "last_scored_at",
        "pi_score_c" AS "lead_score",
        "pi_url_c" AS "associated_url",
        "pi_utm_campaign_c" AS "utm_campaign",
        "pi_utm_content_c" AS "utm_content",
        "pi_utm_medium_c" AS "utm_medium",
        "pi_utm_source_c" AS "utm_source",
        "pi_utm_term_c" AS "utm_term",
        "potential_fivetran_use_case_c" AS "fivetran_use_case",
        "primary_se_c" AS "primary_sales_engineer",
        "promotion_id_c" AS "promotion_id",
        "recent_marketing_campaign_status_c" AS "recent_campaign_status",
        "referral_account_c" AS "referral_account",
        "referral_contact_c" AS "referral_contact",
        "referral_exists_c" AS "has_referral",
        "referral_first_name_c" AS "referral_first_name",
        "referral_last_name_c" AS "referral_last_name",
        "region_c" AS "region",
        "reports_to_id",
        "rh_2_describe_c" AS "custom_description",
        "routed_from_manual_bdr_ae_activity_c" AS "manual_routing",
        "sales_email_opt_out_c" AS "sales_email_opt_out",
        "sales_email_opt_out_date_time_c" AS "sales_email_opt_out_datetime",
        "salesloft_cadence_trigger_c" AS "salesloft_cadence_trigger",
        "salesloft_owner_c" AS "salesloft_owner",
        "salesloft_owner_sf_c" AS "salesloft_owner_sf_id",
        "salutation",
        "secondary_email_c" AS "secondary_email",
        "self_service_routing_c" AS "self_service_routing",
        "source_detail_c" AS "source_detail",
        "source_last_lead_source_c" AS "last_lead_source",
        "source_last_lead_source_category_c" AS "last_lead_source_category",
        "source_last_lead_source_detail_c" AS "last_lead_source_detail",
        "state_c" AS "state",
        "state_code_c" AS "state_code",
        "system_modstamp" AS "last_modified_timestamp",
        "technical_contact_c" AS "is_technical_contact",
        "title" AS "job_title",
        "to_be_deleted_salesloft_backfill_c" AS "delete_salesloft_data",
        "trial_contact_start_date_c" AS "trial_start_date",
        "unique_email_c" AS "email_address",
        "unqualified_reason_c" AS "unqualified_reason",
        "user_activity_logged_by_c" AS "activity_logged_by",
        "user_gems_has_changed_job_c" AS "has_changed_job",
        "user_gems_is_a_user_gem_c" AS "is_user_gem",
        "user_gems_past_account_c" AS "past_account",
        "user_gems_past_company_c" AS "past_company",
        "user_gems_past_contact_c" AS "past_contact_info",
        "user_gems_past_title_c" AS "past_job_title",
        "user_gems_ug_created_by_ug_c" AS "created_by_user_gems",
        "user_gems_ug_current_infos_c" AS "current_user_gems_info",
        "user_gems_ug_past_infos_c" AS "past_user_gems_info",
        "user_gems_user_gems_id_c" AS "user_gems_id",
        "username_c" AS "username",
        "verified_c" AS "is_verified",
        "zoominfo_technologies_c" AS "used_technologies"
    FROM "sf_contact_data_removeWideColumns_projected"
),

"sf_contact_data_removeWideColumns_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- contact_status: The problem is that 'Aemping Conac' appears to be a typo or misspelling. It's not a recognizable phrase or status in English. The most likely intended phrase is "Attempting Contact". This would be a logical status for a contact column, indicating that an attempt to reach out to someone is being made. 
    -- first_name: The problem is that 'x' is not a typical first name and appears to be a placeholder or anonymized value. In data anonymization, 'x' is often used to replace actual names to protect privacy. The correct value would depend on the purpose of the dataset and privacy requirements. If maintaining anonymity is crucial, 'x' could be kept. If more meaningful placeholders are desired, options like 'Anonymous' or leaving it as an empty string could be considered. 
    -- last_name: The problem is that 'G' is indeed an unusual value for a last name, as it's a single letter. This could be due to various reasons: 1. It might be an abbreviation of a longer last name. 2. It could be a data entry error where only the first letter of the last name was recorded. 3. In some rare cases, it might actually be a person's full last name. Without more context or additional data, it's difficult to determine the correct full last name.  Given the limited information, the best approach is to keep the value as is, since changing it without more information could introduce errors. 
    -- lead_source: The problem is that both values in the lead_source column are unusual. 'oominfo' is likely a typo for 'ZoomInfo', a popular B2B contact database. 'Vendor Lis' appears to be an incomplete entry, probably meant to be 'Vendor List'. The correct values should be 'ZoomInfo' and 'Vendor List' respectively. 
    -- lean_data_routing_action: The problem is that both values in the column contain spelling errors and inconsistencies. 'convered' is a misspelling of 'converted', and 'accoun' is missing the final 't'. The correct values should be 'converted' and 'converted - new account'. Since 'convered' is the most frequent value, we'll use 'converted' as the standard form. 
    -- mailing_country: The problem is that 'Unied Saes' is a misspelling of 'United States' with missing letters. The correct value should be 'United States'. 
    -- name: The problem is that 'Jerome' and 'Jerome Powell' are inconsistent representations of the same person. The correct value should be the full name 'Jerome Powell', which is more informative and consistent with the format of 'Janet Yellen'. 
    -- photo_url: The problem is that all the values in the photo_url column contain a typo: 'phoo' instead of 'photo' in the file path. This is consistent across all values, indicating it's likely a systematic error. The correct values should have 'photo' instead of 'phoo' in the path. 
    -- marketing_campaign: The problem is a typo in the only value present in the marketing_campaign column. 'Salesforce Creaed' is misspelled and should be 'Salesforce Created'. This appears to be the only value in the column, so we'll correct the spelling. 
    -- associated_url: The problem is that the URL protocol prefix 'hp://' is incorrect. The correct protocol prefix for a web URL should be 'http://' or 'https://'. In this case, it's likely that the 'tt' was accidentally omitted from 'http://'. The correct value should use the 'http://' protocol prefix. 
    -- source_detail: The problem is that 'ryProspec' appears to be a truncated or misspelled word with atypical capitalization. It's likely that this is a shortened version of "DairyProspector" or "DairyProspects", which could be a source for dairy industry information. Without additional context or other values in the column, it's difficult to determine the exact intended full form. However, we can standardize the capitalization to make it more consistent. 
    -- job_title: The problem is that all job titles contain misspellings. The correct values should be: 'Data Science Director' instead of 'Daa Science Direcor', 'Director, Business Insights & Strategy' instead of 'Direcor, Business Insighs & Sraegy', and 'Marketing Director' instead of 'Markeing Direcor'. These corrections fix the typos in each job title. 
    SELECT
        "is_active",
        "account_id",
        "act_on_lead_score",
        "is_relationship_active",
        "ad_group_id",
        "allbound_id",
        "analytics_id",
        "assistant_name",
        "assistant_phone",
        "last_contact_attempt",
        "has_attended_event",
        "automation_tracking",
        "avatar_url",
        "behavioral_score",
        "beta_connector_interest",
        "is_billing_contact_hidden",
        "birthdate",
        "bizible_id",
        "stripe_default_gateway",
        "stripe_default_payment_method",
        "stripe_gender",
        "stripe_languages",
        "stripe_customer_level",
        "stripe_maiden_name",
        "stripe_personal_id_number",
        "stripe_encrypted_personal_id",
        "stripe_personal_id_type",
        "stripe_ssn_last_4",
        "stripe_encrypted_ssn_last_4",
        "campaign_id",
        "clearbit_id",
        "clearbit_data_ready",
        "created_by_clearbit",
        "netsuite_id",
        "netsuite_record",
        "celigo_sfnsio_net_suite_sync_error_c",
        "skip_netsuite_export",
        "test_mode_record",
        "city",
        "clarus_date",
        "clarus_editor",
        "clarus_notes",
        "clarus_project",
        "clarus_status",
        "clearbit_role",
        "clearbit_seniority",
        "clearbit_sub_role",
        "company",
        "is_competitor",
        "contact_holdover",
        "contact_owner_manager",
        "contact_stage",
        CASE
            WHEN "contact_status" = 'Aemping Conac' THEN 'Attempting Contact'
            ELSE "contact_status"
        END AS "contact_status",
        "contact_type",
        "domain_exists",
        "country",
        "country_code",
        "created_at",
        "created_by_id",
        "created_by_role",
        "created_date",
        "creative_id",
        "csi_code",
        "demographic_score",
        "department",
        "description",
        "device_type",
        "direct_office",
        "dnb_contact_phone",
        "dnb_email",
        "dnb_email_deliverability_score",
        "dnb_job_title",
        "dnb_phone_accuracy_score",
        "dnb_primary_city",
        "dnb_primary_country_code",
        "dnb_primary_postal_code",
        "dnb_primary_state_abbr",
        "dnb_primary_state",
        "dnb_optimizer_contact_id",
        "do_not_call",
        "do_not_route_lead",
        "do_not_sync_marketo",
        "marketo_sync_block_reason",
        "zoominfo_company_id",
        "zoominfo_first_updated",
        "zoominfo_contact_id",
        "zoominfo_last_updated",
        "drift_cql",
        "email",
        "email_bounced",
        "email_bounce_date",
        "email_bounce_reason",
        "email_double_opt_in",
        "email_explicit_opt_in",
        "email_implicit_opt_in",
        "email_opt_out_timestamp",
        "email_quality_unknown",
        "data_enrichment_request",
        "seniority_level",
        "fax_number",
        "first_activity_post_mql",
        "first_activity_post_mql_date",
        "first_manual_activity_post_mql_date",
        "first_mql_date",
        CASE
            WHEN "first_name" = 'x' THEN ''
            ELSE "first_name"
        END AS "first_name",
        "free_trial_confirmation_date",
        "google_click_id",
        "gdpr_explicit_opt_in",
        "email_opt_out",
        "fax_opt_out",
        "historical_contact_status",
        "home_phone_number",
        "is_hot_contact",
        "hvr_update",
        "isell_avention_id",
        "contact_id",
        "individual_id",
        "ironclad_workflow_status",
        "is_deleted",
        "is_email_bounced",
        "is_emea_event_routing",
        "is_eu_resident",
        "jigsaw_data",
        "jigsaw_contact_id",
        "job_function",
        "job_level",
        "keywords",
        "last_activity_date",
        "last_ae_activity_owner",
        "last_bdr_activity_owner",
        "last_customer_request_date",
        "last_customer_update_date",
        "last_manual_ae_activity_date",
        "last_manual_bdr_activity_date",
        "last_marketing_moment_date",
        "last_modified_by_id",
        "last_modified_date",
        "last_name",
        "last_referenced_date",
        "last_sales_activity_datetime",
        "last_sdr_activity_date",
        "last_sdr_activity_owner",
        "last_viewed_date",
        CASE
            WHEN "lead_source" = 'oominfo' THEN 'ZoomInfo'
            WHEN "lead_source" = 'Vendor Lis' THEN 'Vendor List'
            ELSE "lead_source"
        END AS "lead_source",
        "lean_data_segment",
        "lean_data_manual_route_trigger",
        "lean_data_matched_buyer_persona",
        "lean_data_modified_score",
        "lean_data_routing_completion_datetime",
        CASE
            WHEN "lean_data_routing_action" = 'convered' THEN 'converted'
            WHEN "lean_data_routing_action" = 'convered - new accoun' THEN 'converted - new account'
            ELSE "lean_data_routing_action"
        END AS "lean_data_routing_action",
        "leandata_status",
        "leandata_tag",
        "leandata_owner_override",
        "legacy_hvr_id",
        "linkedin_company_id",
        "linkedin_member_token",
        "linkedin_url",
        "mailing_city",
        CASE
            WHEN "mailing_country" = 'Unied Saes' THEN 'United States'
            ELSE "mailing_country"
        END AS "mailing_country",
        "mailing_country_code",
        "mailing_geocode_accuracy",
        "mailing_latitude",
        "mailing_longitude",
        "mailing_postal_code",
        "mailing_state",
        "mailing_state_code",
        "mailing_street",
        "marketing_connector_interest",
        "marketing_process_status",
        "master_record_id",
        "match_type",
        "marketing_cloud_subscriber",
        "metadata_creation_date",
        "mobile_phone",
        "mql_date",
        "mql_date_changed",
        "mql_reason",
        CASE
            WHEN "name" = 'Jerome' THEN 'Jerome Powell'
            ELSE "name"
        END AS "name",
        "netsuite_celigo_update",
        "netsuite_connection_id",
        "netsuite_conn_net_suite_sync_err_c",
        "push_to_netsuite",
        "pushed_from_opportunity",
        "netsuite_sync_in_progress",
        "professional_network",
        "no_geo_data",
        "no_longer_at_company",
        "contact_notes",
        "previous_lead_source",
        "previous_lead_source_details",
        "opportunity_handoff_ae",
        "associated_opportunity",
        "original_utm_campaign",
        "original_utm_content",
        "original_utm_medium",
        "original_utm_source",
        "original_utm_term",
        "secondary_city",
        "secondary_country",
        "secondary_geocode_accuracy",
        "secondary_latitude",
        "secondary_longitude",
        "secondary_phone",
        "secondary_postal_code",
        "secondary_state",
        "secondary_street",
        "owner_id",
        "partner_company",
        "partner_contact",
        "deprecated_partner_contact",
        "partner_rep_email",
        "partner_rep_name",
        "partner_territory",
        "startup_certification_eligibility",
        "startup_primary_role",
        "customer_persona",
        "phone",
        "phone_extension",
        "additional_phone_numbers",
        CASE
            WHEN "photo_url" = '/services/images/phoo/0031G00000q9jPQAQ' THEN '/services/images/photo/0031G00000q9jPQAQ'
            WHEN "photo_url" = '/services/images/phoo/0031G00000qAfq1QAC' THEN '/services/images/photo/0031G00000qAfq1QAC'
            WHEN "photo_url" = '/services/images/phoo/0031G00000rfAvuQAE' THEN '/services/images/photo/0031G00000rfAvuQAE'
            ELSE "photo_url"
        END AS "photo_url",
        CASE
            WHEN "marketing_campaign" = 'Salesforce Creaed' THEN 'Salesforce Created'
            ELSE "marketing_campaign"
        END AS "marketing_campaign",
        "comments",
        "conversion_date",
        "conversion_object_name",
        "conversion_object_type",
        "pi_created_date_c",
        "first_activity",
        "first_search_term",
        "first_search_type",
        "first_touch_url",
        "lead_grade",
        "last_activity",
        "needs_score_sync",
        "notes",
        "email_hard_bounced",
        "last_scored_at",
        "lead_score",
        CASE
            WHEN "associated_url" = 'hp://pi.pardo.com/prospec/read?id=396093715' THEN 'http://pi.pardo.com/prospec/read?id=396093715'
            ELSE "associated_url"
        END AS "associated_url",
        "utm_campaign",
        "utm_content",
        "utm_medium",
        "utm_source",
        "utm_term",
        "fivetran_use_case",
        "primary_sales_engineer",
        "promotion_id",
        "recent_campaign_status",
        "referral_account",
        "referral_contact",
        "has_referral",
        "referral_first_name",
        "referral_last_name",
        "region",
        "reports_to_id",
        "custom_description",
        "manual_routing",
        "sales_email_opt_out",
        "sales_email_opt_out_datetime",
        "salesloft_cadence_trigger",
        "salesloft_owner",
        "salesloft_owner_sf_id",
        "salutation",
        "secondary_email",
        "self_service_routing",
        CASE
            WHEN "source_detail" = 'ryProspec' THEN 'RyProspec'
            ELSE "source_detail"
        END AS "source_detail",
        "last_lead_source",
        "last_lead_source_category",
        "last_lead_source_detail",
        "state",
        "state_code",
        "last_modified_timestamp",
        "is_technical_contact",
        CASE
            WHEN "job_title" = 'Daa Science Direcor' THEN 'Data Science Director'
            WHEN "job_title" = 'Direcor, Business Insighs & Sraegy' THEN 'Director, Business Insights & Strategy'
            WHEN "job_title" = 'Markeing Direcor' THEN 'Marketing Director'
            ELSE "job_title"
        END AS "job_title",
        "delete_salesloft_data",
        "trial_start_date",
        "email_address",
        "unqualified_reason",
        "activity_logged_by",
        "has_changed_job",
        "is_user_gem",
        "past_account",
        "past_company",
        "past_contact_info",
        "past_job_title",
        "created_by_user_gems",
        "current_user_gems_info",
        "past_user_gems_info",
        "user_gems_id",
        "username",
        "is_verified",
        "used_technologies"
    FROM "sf_contact_data_removeWideColumns_projected_renamed"
),

"sf_contact_data_removeWideColumns_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- first_name: ['']
    SELECT 
        CASE
            WHEN "first_name" = '' THEN NULL
            ELSE "first_name"
        END AS "first_name",
        "associated_url",
        "is_hot_contact",
        "secondary_latitude",
        "lean_data_manual_route_trigger",
        "original_utm_campaign",
        "contact_stage",
        "referral_last_name",
        "utm_source",
        "mailing_country",
        "mailing_latitude",
        "mailing_longitude",
        "username",
        "is_billing_contact_hidden",
        "birthdate",
        "account_id",
        "individual_id",
        "lean_data_matched_buyer_persona",
        "dnb_contact_phone",
        "drift_cql",
        "domain_exists",
        "first_manual_activity_post_mql_date",
        "last_customer_request_date",
        "legacy_hvr_id",
        "csi_code",
        "conversion_date",
        "celigo_sfnsio_net_suite_sync_error_c",
        "keywords",
        "last_modified_timestamp",
        "dnb_optimizer_contact_id",
        "country_code",
        "last_activity_date",
        "match_type",
        "pushed_from_opportunity",
        "dnb_email_deliverability_score",
        "last_lead_source_category",
        "data_enrichment_request",
        "ad_group_id",
        "mobile_phone",
        "test_mode_record",
        "last_viewed_date",
        "master_record_id",
        "isell_avention_id",
        "phone_extension",
        "hvr_update",
        "self_service_routing",
        "no_geo_data",
        "direct_office",
        "partner_rep_email",
        "clearbit_seniority",
        "linkedin_company_id",
        "stripe_languages",
        "dnb_phone_accuracy_score",
        "clarus_date",
        "mailing_street",
        "salesloft_owner_sf_id",
        "zoominfo_first_updated",
        "contact_owner_manager",
        "is_eu_resident",
        "beta_connector_interest",
        "original_utm_source",
        "last_lead_source_detail",
        "device_type",
        "department",
        "original_utm_medium",
        "user_gems_id",
        "last_name",
        "mailing_country_code",
        "created_by_id",
        "netsuite_connection_id",
        "photo_url",
        "past_company",
        "clearbit_id",
        "first_activity_post_mql_date",
        "lean_data_routing_completion_datetime",
        "partner_rep_name",
        "referral_account",
        "city",
        "source_detail",
        "partner_territory",
        "salutation",
        "linkedin_member_token",
        "assistant_name",
        "last_ae_activity_owner",
        "secondary_email",
        "email_quality_unknown",
        "activity_logged_by",
        "campaign_id",
        "primary_sales_engineer",
        "last_marketing_moment_date",
        "automation_tracking",
        "last_customer_update_date",
        "has_referral",
        "utm_term",
        "email_explicit_opt_in",
        "notes",
        "sales_email_opt_out_datetime",
        "stripe_personal_id_type",
        "past_account",
        "last_lead_source",
        "is_emea_event_routing",
        "lean_data_modified_score",
        "secondary_postal_code",
        "startup_primary_role",
        "skip_netsuite_export",
        "created_at",
        "fivetran_use_case",
        "job_function",
        "contact_notes",
        "dnb_primary_postal_code",
        "email_bounced",
        "email_opt_out_timestamp",
        "utm_medium",
        "last_sdr_activity_owner",
        "email",
        "customer_persona",
        "last_modified_by_id",
        "lean_data_segment",
        "is_verified",
        "professional_network",
        "referral_contact",
        "past_job_title",
        "netsuite_conn_net_suite_sync_err_c",
        "zoominfo_company_id",
        "dnb_email",
        "jigsaw_data",
        "last_scored_at",
        "lean_data_routing_action",
        "mql_date",
        "stripe_default_gateway",
        "no_longer_at_company",
        "creative_id",
        "previous_lead_source",
        "fax_opt_out",
        "deprecated_partner_contact",
        "salesloft_cadence_trigger",
        "is_active",
        "push_to_netsuite",
        "previous_lead_source_details",
        "region",
        "behavioral_score",
        "salesloft_owner",
        "email_bounce_date",
        "mailing_geocode_accuracy",
        "assistant_phone",
        "stripe_ssn_last_4",
        "dnb_primary_state",
        "past_contact_info",
        "is_technical_contact",
        "current_user_gems_info",
        "created_by_role",
        "dnb_primary_city",
        "mql_reason",
        "clearbit_role",
        "used_technologies",
        "mailing_city",
        "original_utm_term",
        "utm_content",
        "allbound_id",
        "analytics_id",
        "contact_holdover",
        "description",
        "is_email_bounced",
        "first_activity_post_mql",
        "dnb_job_title",
        "partner_company",
        "clarus_project",
        "marketing_connector_interest",
        "first_touch_url",
        "first_activity",
        "home_phone_number",
        "last_modified_date",
        "opportunity_handoff_ae",
        "stripe_customer_level",
        "last_activity",
        "needs_score_sync",
        "state",
        "netsuite_id",
        "clearbit_sub_role",
        "pi_created_date_c",
        "fax_number",
        "is_competitor",
        "secondary_phone",
        "is_user_gem",
        "additional_phone_numbers",
        "is_relationship_active",
        "zoominfo_contact_id",
        "stripe_default_payment_method",
        "do_not_route_lead",
        "last_sdr_activity_date",
        "past_user_gems_info",
        "startup_certification_eligibility",
        "zoominfo_last_updated",
        "lead_source",
        "sales_email_opt_out",
        "email_address",
        "clearbit_data_ready",
        "has_attended_event",
        "phone",
        "email_hard_bounced",
        "lead_grade",
        "mailing_postal_code",
        "secondary_longitude",
        "marketo_sync_block_reason",
        "linkedin_url",
        "associated_opportunity",
        "secondary_city",
        "email_implicit_opt_in",
        "last_bdr_activity_owner",
        "comments",
        "job_title",
        "last_sales_activity_datetime",
        "email_opt_out",
        "leandata_status",
        "manual_routing",
        "created_by_clearbit",
        "promotion_id",
        "leandata_tag",
        "clarus_notes",
        "stripe_maiden_name",
        "last_referenced_date",
        "name",
        "unqualified_reason",
        "company",
        "ironclad_workflow_status",
        "mailing_state",
        "mailing_state_code",
        "email_bounce_reason",
        "stripe_encrypted_ssn_last_4",
        "marketing_cloud_subscriber",
        "delete_salesloft_data",
        "last_manual_bdr_activity_date",
        "clarus_editor",
        "contact_type",
        "first_search_type",
        "secondary_state",
        "netsuite_celigo_update",
        "email_double_opt_in",
        "bizible_id",
        "jigsaw_contact_id",
        "recent_campaign_status",
        "owner_id",
        "referral_first_name",
        "state_code",
        "gdpr_explicit_opt_in",
        "google_click_id",
        "secondary_street",
        "marketing_process_status",
        "avatar_url",
        "mql_date_changed",
        "historical_contact_status",
        "job_level",
        "original_utm_content",
        "partner_contact",
        "leandata_owner_override",
        "dnb_primary_state_abbr",
        "secondary_country",
        "last_contact_attempt",
        "stripe_encrypted_personal_id",
        "is_deleted",
        "netsuite_sync_in_progress",
        "last_manual_ae_activity_date",
        "contact_status",
        "free_trial_confirmation_date",
        "dnb_primary_country_code",
        "first_mql_date",
        "conversion_object_name",
        "netsuite_record",
        "act_on_lead_score",
        "created_by_user_gems",
        "utm_campaign",
        "do_not_call",
        "lead_score",
        "country",
        "custom_description",
        "has_changed_job",
        "metadata_creation_date",
        "conversion_object_type",
        "stripe_personal_id_number",
        "stripe_gender",
        "demographic_score",
        "do_not_sync_marketo",
        "secondary_geocode_accuracy",
        "marketing_campaign",
        "clarus_status",
        "first_search_term",
        "contact_id",
        "reports_to_id",
        "created_date",
        "seniority_level",
        "trial_start_date"
    FROM "sf_contact_data_removeWideColumns_projected_renamed_cleaned"
),

"sf_contact_data_removeWideColumns_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- act_on_lead_score: from DECIMAL to INT
    -- activity_logged_by: from DECIMAL to VARCHAR
    -- ad_group_id: from DECIMAL to VARCHAR
    -- additional_phone_numbers: from DECIMAL to VARCHAR
    -- allbound_id: from DECIMAL to VARCHAR
    -- analytics_id: from DECIMAL to VARCHAR
    -- assistant_name: from DECIMAL to VARCHAR
    -- assistant_phone: from DECIMAL to VARCHAR
    -- associated_opportunity: from DECIMAL to VARCHAR
    -- automation_tracking: from DECIMAL to VARCHAR
    -- avatar_url: from DECIMAL to VARCHAR
    -- behavioral_score: from DECIMAL to INT
    -- beta_connector_interest: from DECIMAL to BOOLEAN
    -- birthdate: from DECIMAL to DATE
    -- bizible_id: from DECIMAL to VARCHAR
    -- campaign_id: from DECIMAL to VARCHAR
    -- celigo_sfnsio_net_suite_sync_error_c: from DECIMAL to VARCHAR
    -- city: from DECIMAL to VARCHAR
    -- clarus_date: from DECIMAL to DATE
    -- clarus_editor: from DECIMAL to VARCHAR
    -- clarus_notes: from DECIMAL to VARCHAR
    -- clarus_project: from DECIMAL to VARCHAR
    -- clarus_status: from DECIMAL to VARCHAR
    -- clearbit_role: from DECIMAL to VARCHAR
    -- clearbit_seniority: from DECIMAL to VARCHAR
    -- clearbit_sub_role: from DECIMAL to VARCHAR
    -- comments: from DECIMAL to VARCHAR
    -- company: from DECIMAL to VARCHAR
    -- contact_holdover: from DECIMAL to VARCHAR
    -- contact_notes: from DECIMAL to VARCHAR
    -- contact_owner_manager: from DECIMAL to VARCHAR
    -- contact_stage: from DECIMAL to VARCHAR
    -- contact_type: from DECIMAL to VARCHAR
    -- conversion_date: from DECIMAL to DATE
    -- conversion_object_name: from DECIMAL to VARCHAR
    -- conversion_object_type: from DECIMAL to VARCHAR
    -- country: from DECIMAL to VARCHAR
    -- country_code: from DECIMAL to VARCHAR
    -- created_at: from DECIMAL to TIMESTAMP
    -- created_by_role: from DECIMAL to VARCHAR
    -- created_by_user_gems: from DECIMAL to VARCHAR
    -- created_date: from VARCHAR to TIMESTAMP
    -- creative_id: from DECIMAL to VARCHAR
    -- csi_code: from DECIMAL to VARCHAR
    -- current_user_gems_info: from DECIMAL to VARCHAR
    -- custom_description: from DECIMAL to VARCHAR
    -- customer_persona: from DECIMAL to VARCHAR
    -- data_enrichment_request: from DECIMAL to VARCHAR
    -- delete_salesloft_data: from DECIMAL to VARCHAR
    -- demographic_score: from DECIMAL to VARCHAR
    -- department: from DECIMAL to VARCHAR
    -- deprecated_partner_contact: from DECIMAL to VARCHAR
    -- device_type: from DECIMAL to VARCHAR
    -- direct_office: from DECIMAL to VARCHAR
    -- dnb_contact_phone: from DECIMAL to VARCHAR
    -- dnb_email: from DECIMAL to VARCHAR
    -- dnb_job_title: from DECIMAL to VARCHAR
    -- dnb_optimizer_contact_id: from DECIMAL to VARCHAR
    -- dnb_primary_city: from DECIMAL to VARCHAR
    -- dnb_primary_country_code: from DECIMAL to VARCHAR
    -- dnb_primary_postal_code: from DECIMAL to VARCHAR
    -- dnb_primary_state: from DECIMAL to VARCHAR
    -- dnb_primary_state_abbr: from DECIMAL to VARCHAR
    -- do_not_sync_marketo: from DECIMAL to BOOLEAN
    -- domain_exists: from DECIMAL to BOOLEAN
    -- drift_cql: from DECIMAL to VARCHAR
    -- email_address: from DECIMAL to VARCHAR
    -- email_bounce_date: from DECIMAL to DATE
    -- email_bounce_reason: from DECIMAL to VARCHAR
    -- email_double_opt_in: from DECIMAL to BOOLEAN
    -- email_explicit_opt_in: from DECIMAL to BOOLEAN
    -- email_implicit_opt_in: from DECIMAL to BOOLEAN
    -- email_opt_out_timestamp: from DECIMAL to TIMESTAMP
    -- fax_number: from DECIMAL to VARCHAR
    -- fax_opt_out: from DECIMAL to BOOLEAN
    -- first_activity: from DECIMAL to TIMESTAMP
    -- first_activity_post_mql: from DECIMAL to TIMESTAMP
    -- first_activity_post_mql_date: from DECIMAL to DATE
    -- first_manual_activity_post_mql_date: from DECIMAL to DATE
    -- first_mql_date: from DECIMAL to DATE
    -- first_search_term: from DECIMAL to VARCHAR
    -- first_search_type: from DECIMAL to VARCHAR
    -- first_touch_url: from DECIMAL to VARCHAR
    -- fivetran_use_case: from DECIMAL to VARCHAR
    -- free_trial_confirmation_date: from DECIMAL to DATE
    -- gdpr_explicit_opt_in: from DECIMAL to BOOLEAN
    -- google_click_id: from DECIMAL to VARCHAR
    -- has_attended_event: from DECIMAL to BOOLEAN
    -- has_changed_job: from DECIMAL to BOOLEAN
    -- has_referral: from DECIMAL to BOOLEAN
    -- historical_contact_status: from DECIMAL to VARCHAR
    -- home_phone_number: from DECIMAL to VARCHAR
    -- hvr_update: from DECIMAL to TIMESTAMP
    -- individual_id: from DECIMAL to UUID
    -- ironclad_workflow_status: from DECIMAL to VARCHAR
    -- is_active: from DECIMAL to BOOLEAN
    -- is_billing_contact_hidden: from DECIMAL to BOOLEAN
    -- is_competitor: from DECIMAL to BOOLEAN
    -- is_deleted: from DECIMAL to BOOLEAN
    -- is_emea_event_routing: from DECIMAL to BOOLEAN
    -- is_hot_contact: from DECIMAL to BOOLEAN
    -- is_relationship_active: from DECIMAL to BOOLEAN
    -- is_technical_contact: from DECIMAL to BOOLEAN
    -- is_user_gem: from DECIMAL to BOOLEAN
    -- is_verified: from DECIMAL to BOOLEAN
    -- isell_avention_id: from DECIMAL to VARCHAR
    -- jigsaw_contact_id: from DECIMAL to VARCHAR
    -- jigsaw_data: from DECIMAL to JSON
    -- job_function: from DECIMAL to VARCHAR
    -- job_level: from DECIMAL to VARCHAR
    -- keywords: from DECIMAL to ARRAY
    -- last_activity: from DECIMAL to VARCHAR
    -- last_activity_date: from DECIMAL to DATE
    -- last_ae_activity_owner: from DECIMAL to VARCHAR
    -- last_bdr_activity_owner: from DECIMAL to VARCHAR
    -- last_contact_attempt: from DECIMAL to DATE
    -- last_customer_request_date: from DECIMAL to DATE
    -- last_customer_update_date: from DECIMAL to DATE
    -- last_lead_source: from DECIMAL to VARCHAR
    -- last_lead_source_category: from DECIMAL to VARCHAR
    -- last_lead_source_detail: from DECIMAL to VARCHAR
    -- last_manual_ae_activity_date: from DECIMAL to DATE
    -- last_manual_bdr_activity_date: from DECIMAL to DATE
    -- last_marketing_moment_date: from DECIMAL to DATE
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- last_modified_timestamp: from VARCHAR to TIMESTAMP
    -- last_referenced_date: from DECIMAL to DATE
    -- last_sales_activity_datetime: from DECIMAL to TIMESTAMP
    -- last_scored_at: from DECIMAL to TIMESTAMP
    -- last_sdr_activity_date: from DECIMAL to DATE
    -- last_sdr_activity_owner: from DECIMAL to VARCHAR
    -- last_viewed_date: from DECIMAL to DATE
    -- lead_grade: from DECIMAL to VARCHAR
    -- lead_score: from DECIMAL to INT
    -- lean_data_manual_route_trigger: from DECIMAL to VARCHAR
    -- lean_data_matched_buyer_persona: from DECIMAL to VARCHAR
    -- lean_data_modified_score: from DECIMAL to INT
    -- lean_data_routing_completion_datetime: from DECIMAL to TIMESTAMP
    -- lean_data_segment: from DECIMAL to VARCHAR
    -- leandata_owner_override: from DECIMAL to VARCHAR
    -- leandata_status: from DECIMAL to VARCHAR
    -- leandata_tag: from DECIMAL to VARCHAR
    -- legacy_hvr_id: from DECIMAL to VARCHAR
    -- linkedin_company_id: from DECIMAL to VARCHAR
    -- linkedin_member_token: from DECIMAL to VARCHAR
    -- linkedin_url: from DECIMAL to VARCHAR
    -- mailing_geocode_accuracy: from DECIMAL to VARCHAR
    -- mailing_postal_code: from DECIMAL to VARCHAR
    -- manual_routing: from DECIMAL to VARCHAR
    -- marketing_cloud_subscriber: from DECIMAL to VARCHAR
    -- marketing_connector_interest: from DECIMAL to VARCHAR
    -- marketing_process_status: from DECIMAL to VARCHAR
    -- marketo_sync_block_reason: from DECIMAL to VARCHAR
    -- master_record_id: from DECIMAL to VARCHAR
    -- match_type: from DECIMAL to VARCHAR
    -- metadata_creation_date: from DECIMAL to TIMESTAMP
    -- mobile_phone: from DECIMAL to VARCHAR
    -- mql_date: from DECIMAL to DATE
    -- mql_date_changed: from DECIMAL to DATE
    -- mql_reason: from DECIMAL to VARCHAR
    -- netsuite_conn_net_suite_sync_err_c: from DECIMAL to VARCHAR
    -- netsuite_connection_id: from DECIMAL to VARCHAR
    -- netsuite_id: from DECIMAL to VARCHAR
    -- netsuite_record: from DECIMAL to VARCHAR
    -- no_geo_data: from DECIMAL to BOOLEAN
    -- notes: from DECIMAL to VARCHAR
    -- opportunity_handoff_ae: from DECIMAL to VARCHAR
    -- original_utm_campaign: from DECIMAL to VARCHAR
    -- original_utm_content: from DECIMAL to VARCHAR
    -- original_utm_medium: from DECIMAL to VARCHAR
    -- original_utm_source: from DECIMAL to VARCHAR
    -- original_utm_term: from DECIMAL to VARCHAR
    -- partner_company: from DECIMAL to VARCHAR
    -- partner_contact: from DECIMAL to VARCHAR
    -- partner_rep_email: from DECIMAL to VARCHAR
    -- partner_rep_name: from DECIMAL to VARCHAR
    -- partner_territory: from DECIMAL to VARCHAR
    -- past_account: from DECIMAL to VARCHAR
    -- past_company: from DECIMAL to VARCHAR
    -- past_contact_info: from DECIMAL to VARCHAR
    -- past_job_title: from DECIMAL to VARCHAR
    -- past_user_gems_info: from DECIMAL to VARCHAR
    -- phone_extension: from DECIMAL to VARCHAR
    -- pi_created_date_c: from VARCHAR to TIMESTAMP
    -- previous_lead_source: from DECIMAL to VARCHAR
    -- previous_lead_source_details: from DECIMAL to VARCHAR
    -- primary_sales_engineer: from DECIMAL to VARCHAR
    -- professional_network: from DECIMAL to VARCHAR
    -- promotion_id: from DECIMAL to VARCHAR
    -- recent_campaign_status: from DECIMAL to VARCHAR
    -- referral_account: from DECIMAL to VARCHAR
    -- referral_contact: from DECIMAL to VARCHAR
    -- referral_first_name: from DECIMAL to VARCHAR
    -- referral_last_name: from DECIMAL to VARCHAR
    -- region: from DECIMAL to VARCHAR
    -- reports_to_id: from DECIMAL to VARCHAR
    -- sales_email_opt_out: from DECIMAL to BOOLEAN
    -- sales_email_opt_out_datetime: from DECIMAL to TIMESTAMP
    -- salesloft_cadence_trigger: from DECIMAL to VARCHAR
    -- salesloft_owner: from DECIMAL to VARCHAR
    -- salesloft_owner_sf_id: from DECIMAL to VARCHAR
    -- salutation: from DECIMAL to VARCHAR
    -- secondary_city: from DECIMAL to VARCHAR
    -- secondary_country: from DECIMAL to VARCHAR
    -- secondary_email: from DECIMAL to VARCHAR
    -- secondary_geocode_accuracy: from DECIMAL to VARCHAR
    -- secondary_phone: from DECIMAL to VARCHAR
    -- secondary_postal_code: from DECIMAL to VARCHAR
    -- secondary_state: from DECIMAL to VARCHAR
    -- secondary_street: from DECIMAL to VARCHAR
    -- self_service_routing: from DECIMAL to VARCHAR
    -- seniority_level: from DECIMAL to VARCHAR
    -- skip_netsuite_export: from DECIMAL to BOOLEAN
    -- startup_certification_eligibility: from DECIMAL to VARCHAR
    -- startup_primary_role: from DECIMAL to VARCHAR
    -- state: from DECIMAL to VARCHAR
    -- state_code: from DECIMAL to VARCHAR
    -- stripe_customer_level: from DECIMAL to VARCHAR
    -- stripe_default_gateway: from DECIMAL to VARCHAR
    -- stripe_default_payment_method: from DECIMAL to VARCHAR
    -- stripe_encrypted_personal_id: from DECIMAL to VARCHAR
    -- stripe_encrypted_ssn_last_4: from DECIMAL to VARCHAR
    -- stripe_gender: from DECIMAL to VARCHAR
    -- stripe_languages: from DECIMAL to VARCHAR
    -- stripe_maiden_name: from DECIMAL to VARCHAR
    -- stripe_personal_id_number: from DECIMAL to VARCHAR
    -- stripe_personal_id_type: from DECIMAL to VARCHAR
    -- stripe_ssn_last_4: from DECIMAL to VARCHAR
    -- test_mode_record: from DECIMAL to BOOLEAN
    -- trial_start_date: from DECIMAL to DATE
    -- unqualified_reason: from DECIMAL to VARCHAR
    -- used_technologies: from DECIMAL to ARRAY
    -- user_gems_id: from DECIMAL to UUID
    -- username: from DECIMAL to VARCHAR
    -- utm_campaign: from DECIMAL to VARCHAR
    -- utm_content: from DECIMAL to VARCHAR
    -- utm_medium: from DECIMAL to VARCHAR
    -- utm_source: from DECIMAL to VARCHAR
    -- utm_term: from DECIMAL to VARCHAR
    -- zoominfo_company_id: from DECIMAL to VARCHAR
    -- zoominfo_contact_id: from DECIMAL to VARCHAR
    -- zoominfo_first_updated: from DECIMAL to TIMESTAMP
    -- zoominfo_last_updated: from DECIMAL to TIMESTAMP
    SELECT
        "first_name",
        "associated_url",
        "secondary_latitude",
        "mailing_country",
        "mailing_latitude",
        "mailing_longitude",
        "account_id",
        "pushed_from_opportunity",
        "dnb_email_deliverability_score",
        "dnb_phone_accuracy_score",
        "mailing_street",
        "is_eu_resident",
        "last_name",
        "mailing_country_code",
        "created_by_id",
        "photo_url",
        "clearbit_id",
        "source_detail",
        "email_quality_unknown",
        "email_bounced",
        "email",
        "last_modified_by_id",
        "lean_data_routing_action",
        "no_longer_at_company",
        "push_to_netsuite",
        "mailing_city",
        "description",
        "is_email_bounced",
        "needs_score_sync",
        "do_not_route_lead",
        "lead_source",
        "clearbit_data_ready",
        "phone",
        "email_hard_bounced",
        "secondary_longitude",
        "job_title",
        "email_opt_out",
        "created_by_clearbit",
        "name",
        "mailing_state",
        "mailing_state_code",
        "netsuite_celigo_update",
        "owner_id",
        "netsuite_sync_in_progress",
        "contact_status",
        "do_not_call",
        "marketing_campaign",
        "contact_id",
        CAST("act_on_lead_score" AS INT) AS "act_on_lead_score",
        CAST("activity_logged_by" AS VARCHAR) AS "activity_logged_by",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        CAST("additional_phone_numbers" AS VARCHAR) AS "additional_phone_numbers",
        CAST("allbound_id" AS VARCHAR) AS "allbound_id",
        CAST("analytics_id" AS VARCHAR) AS "analytics_id",
        CAST("assistant_name" AS VARCHAR) AS "assistant_name",
        CAST("assistant_phone" AS VARCHAR) AS "assistant_phone",
        CAST("associated_opportunity" AS VARCHAR) AS "associated_opportunity",
        CAST("automation_tracking" AS VARCHAR) AS "automation_tracking",
        CAST("avatar_url" AS VARCHAR) AS "avatar_url",
        CAST("behavioral_score" AS INT) AS "behavioral_score",
        CAST("beta_connector_interest" AS BOOLEAN) AS "beta_connector_interest",
        CAST("birthdate" AS DATE) AS "birthdate",
        CAST("bizible_id" AS VARCHAR) AS "bizible_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("celigo_sfnsio_net_suite_sync_error_c" AS VARCHAR) AS "celigo_sfnsio_net_suite_sync_error_c",
        CAST("city" AS VARCHAR) AS "city",
        CAST("clarus_date" AS DATE) AS "clarus_date",
        CAST("clarus_editor" AS VARCHAR) AS "clarus_editor",
        CAST("clarus_notes" AS VARCHAR) AS "clarus_notes",
        CAST("clarus_project" AS VARCHAR) AS "clarus_project",
        CAST("clarus_status" AS VARCHAR) AS "clarus_status",
        CAST("clearbit_role" AS VARCHAR) AS "clearbit_role",
        CAST("clearbit_seniority" AS VARCHAR) AS "clearbit_seniority",
        CAST("clearbit_sub_role" AS VARCHAR) AS "clearbit_sub_role",
        CAST("comments" AS VARCHAR) AS "comments",
        CAST("company" AS VARCHAR) AS "company",
        CAST("contact_holdover" AS VARCHAR) AS "contact_holdover",
        CAST("contact_notes" AS VARCHAR) AS "contact_notes",
        CAST("contact_owner_manager" AS VARCHAR) AS "contact_owner_manager",
        CAST("contact_stage" AS VARCHAR) AS "contact_stage",
        CAST("contact_type" AS VARCHAR) AS "contact_type",
        CAST("conversion_date" AS DATE) AS "conversion_date",
        CAST("conversion_object_name" AS VARCHAR) AS "conversion_object_name",
        CAST("conversion_object_type" AS VARCHAR) AS "conversion_object_type",
        CAST("country" AS VARCHAR) AS "country",
        CAST("country_code" AS VARCHAR) AS "country_code",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("created_by_role" AS VARCHAR) AS "created_by_role",
        CAST("created_by_user_gems" AS VARCHAR) AS "created_by_user_gems",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("creative_id" AS VARCHAR) AS "creative_id",
        CAST("csi_code" AS VARCHAR) AS "csi_code",
        CAST("current_user_gems_info" AS VARCHAR) AS "current_user_gems_info",
        CAST("custom_description" AS VARCHAR) AS "custom_description",
        CAST("customer_persona" AS VARCHAR) AS "customer_persona",
        CAST("data_enrichment_request" AS VARCHAR) AS "data_enrichment_request",
        CAST("delete_salesloft_data" AS VARCHAR) AS "delete_salesloft_data",
        CAST("demographic_score" AS VARCHAR) AS "demographic_score",
        CAST("department" AS VARCHAR) AS "department",
        CAST("deprecated_partner_contact" AS VARCHAR) AS "deprecated_partner_contact",
        CAST("device_type" AS VARCHAR) AS "device_type",
        CAST("direct_office" AS VARCHAR) AS "direct_office",
        CAST("dnb_contact_phone" AS VARCHAR) AS "dnb_contact_phone",
        CAST("dnb_email" AS VARCHAR) AS "dnb_email",
        CAST("dnb_job_title" AS VARCHAR) AS "dnb_job_title",
        CAST("dnb_optimizer_contact_id" AS VARCHAR) AS "dnb_optimizer_contact_id",
        CAST("dnb_primary_city" AS VARCHAR) AS "dnb_primary_city",
        CAST("dnb_primary_country_code" AS VARCHAR) AS "dnb_primary_country_code",
        CAST("dnb_primary_postal_code" AS VARCHAR) AS "dnb_primary_postal_code",
        CAST("dnb_primary_state" AS VARCHAR) AS "dnb_primary_state",
        CAST("dnb_primary_state_abbr" AS VARCHAR) AS "dnb_primary_state_abbr",
        CAST("do_not_sync_marketo" AS BOOLEAN) AS "do_not_sync_marketo",
        CAST("domain_exists" AS BOOLEAN) AS "domain_exists",
        CAST("drift_cql" AS VARCHAR) AS "drift_cql",
        CAST("email_address" AS VARCHAR) AS "email_address",
        CAST("email_bounce_date" AS DATE) AS "email_bounce_date",
        CAST("email_bounce_reason" AS VARCHAR) AS "email_bounce_reason",
        CAST("email_double_opt_in" AS BOOLEAN) AS "email_double_opt_in",
        CAST("email_explicit_opt_in" AS BOOLEAN) AS "email_explicit_opt_in",
        CAST("email_implicit_opt_in" AS BOOLEAN) AS "email_implicit_opt_in",
        CAST("email_opt_out_timestamp" AS TIMESTAMP) AS "email_opt_out_timestamp",
        CAST("fax_number" AS VARCHAR) AS "fax_number",
        CAST("fax_opt_out" AS BOOLEAN) AS "fax_opt_out",
        CAST("first_activity" AS TIMESTAMP) AS "first_activity",
        CAST("first_activity_post_mql" AS TIMESTAMP) AS "first_activity_post_mql",
        CAST("first_activity_post_mql_date" AS DATE) AS "first_activity_post_mql_date",
        CAST("first_manual_activity_post_mql_date" AS DATE) AS "first_manual_activity_post_mql_date",
        CAST("first_mql_date" AS DATE) AS "first_mql_date",
        CAST("first_search_term" AS VARCHAR) AS "first_search_term",
        CAST("first_search_type" AS VARCHAR) AS "first_search_type",
        CAST("first_touch_url" AS VARCHAR) AS "first_touch_url",
        CAST("fivetran_use_case" AS VARCHAR) AS "fivetran_use_case",
        CAST("free_trial_confirmation_date" AS DATE) AS "free_trial_confirmation_date",
        CAST("gdpr_explicit_opt_in" AS BOOLEAN) AS "gdpr_explicit_opt_in",
        CAST("google_click_id" AS VARCHAR) AS "google_click_id",
        CAST("has_attended_event" AS BOOLEAN) AS "has_attended_event",
        CAST("has_changed_job" AS BOOLEAN) AS "has_changed_job",
        CAST("has_referral" AS BOOLEAN) AS "has_referral",
        CAST("historical_contact_status" AS VARCHAR) AS "historical_contact_status",
        CAST("home_phone_number" AS VARCHAR) AS "home_phone_number",
        CAST("hvr_update" AS TIMESTAMP) AS "hvr_update",
        CAST("individual_id" AS UUID) AS "individual_id",
        CAST("ironclad_workflow_status" AS VARCHAR) AS "ironclad_workflow_status",
        CAST("is_active" AS BOOLEAN) AS "is_active",
        CAST("is_billing_contact_hidden" AS BOOLEAN) AS "is_billing_contact_hidden",
        CAST("is_competitor" AS BOOLEAN) AS "is_competitor",
        CAST("is_deleted" AS BOOLEAN) AS "is_deleted",
        CAST("is_emea_event_routing" AS BOOLEAN) AS "is_emea_event_routing",
        CAST("is_hot_contact" AS BOOLEAN) AS "is_hot_contact",
        CAST("is_relationship_active" AS BOOLEAN) AS "is_relationship_active",
        CAST("is_technical_contact" AS BOOLEAN) AS "is_technical_contact",
        CAST("is_user_gem" AS BOOLEAN) AS "is_user_gem",
        CAST("is_verified" AS BOOLEAN) AS "is_verified",
        CAST("isell_avention_id" AS VARCHAR) AS "isell_avention_id",
        CAST("jigsaw_contact_id" AS VARCHAR) AS "jigsaw_contact_id",
        CAST("jigsaw_data" AS JSON) AS "jigsaw_data",
        CAST("job_function" AS VARCHAR) AS "job_function",
        CAST("job_level" AS VARCHAR) AS "job_level",
        STRING_SPLIT("keywords", ',') AS "keywords",
        CAST("last_activity" AS VARCHAR) AS "last_activity",
        CAST("last_activity_date" AS DATE) AS "last_activity_date",
        CAST("last_ae_activity_owner" AS VARCHAR) AS "last_ae_activity_owner",
        CAST("last_bdr_activity_owner" AS VARCHAR) AS "last_bdr_activity_owner",
        CAST("last_contact_attempt" AS DATE) AS "last_contact_attempt",
        CAST("last_customer_request_date" AS DATE) AS "last_customer_request_date",
        CAST("last_customer_update_date" AS DATE) AS "last_customer_update_date",
        CAST("last_lead_source" AS VARCHAR) AS "last_lead_source",
        CAST("last_lead_source_category" AS VARCHAR) AS "last_lead_source_category",
        CAST("last_lead_source_detail" AS VARCHAR) AS "last_lead_source_detail",
        CAST("last_manual_ae_activity_date" AS DATE) AS "last_manual_ae_activity_date",
        CAST("last_manual_bdr_activity_date" AS DATE) AS "last_manual_bdr_activity_date",
        CAST("last_marketing_moment_date" AS DATE) AS "last_marketing_moment_date",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("last_modified_timestamp" AS TIMESTAMP) AS "last_modified_timestamp",
        CAST("last_referenced_date" AS DATE) AS "last_referenced_date",
        CAST("last_sales_activity_datetime" AS TIMESTAMP) AS "last_sales_activity_datetime",
        CAST("last_scored_at" AS TIMESTAMP) AS "last_scored_at",
        CAST("last_sdr_activity_date" AS DATE) AS "last_sdr_activity_date",
        CAST("last_sdr_activity_owner" AS VARCHAR) AS "last_sdr_activity_owner",
        CAST("last_viewed_date" AS DATE) AS "last_viewed_date",
        CAST("lead_grade" AS VARCHAR) AS "lead_grade",
        CAST("lead_score" AS INT) AS "lead_score",
        CAST("lean_data_manual_route_trigger" AS VARCHAR) AS "lean_data_manual_route_trigger",
        CAST("lean_data_matched_buyer_persona" AS VARCHAR) AS "lean_data_matched_buyer_persona",
        CAST("lean_data_modified_score" AS INT) AS "lean_data_modified_score",
        CAST("lean_data_routing_completion_datetime" AS TIMESTAMP) AS "lean_data_routing_completion_datetime",
        CAST("lean_data_segment" AS VARCHAR) AS "lean_data_segment",
        CAST("leandata_owner_override" AS VARCHAR) AS "leandata_owner_override",
        CAST("leandata_status" AS VARCHAR) AS "leandata_status",
        CAST("leandata_tag" AS VARCHAR) AS "leandata_tag",
        CAST("legacy_hvr_id" AS VARCHAR) AS "legacy_hvr_id",
        CAST("linkedin_company_id" AS VARCHAR) AS "linkedin_company_id",
        CAST("linkedin_member_token" AS VARCHAR) AS "linkedin_member_token",
        CAST("linkedin_url" AS VARCHAR) AS "linkedin_url",
        CAST("mailing_geocode_accuracy" AS VARCHAR) AS "mailing_geocode_accuracy",
        CAST("mailing_postal_code" AS VARCHAR) AS "mailing_postal_code",
        CAST("manual_routing" AS VARCHAR) AS "manual_routing",
        CAST("marketing_cloud_subscriber" AS VARCHAR) AS "marketing_cloud_subscriber",
        CAST("marketing_connector_interest" AS VARCHAR) AS "marketing_connector_interest",
        CAST("marketing_process_status" AS VARCHAR) AS "marketing_process_status",
        CAST("marketo_sync_block_reason" AS VARCHAR) AS "marketo_sync_block_reason",
        CAST("master_record_id" AS VARCHAR) AS "master_record_id",
        CAST("match_type" AS VARCHAR) AS "match_type",
        CAST("metadata_creation_date" AS TIMESTAMP) AS "metadata_creation_date",
        CAST("mobile_phone" AS VARCHAR) AS "mobile_phone",
        CAST("mql_date" AS DATE) AS "mql_date",
        CAST("mql_date_changed" AS DATE) AS "mql_date_changed",
        CAST("mql_reason" AS VARCHAR) AS "mql_reason",
        CAST("netsuite_conn_net_suite_sync_err_c" AS VARCHAR) AS "netsuite_conn_net_suite_sync_err_c",
        CAST("netsuite_connection_id" AS VARCHAR) AS "netsuite_connection_id",
        CAST("netsuite_id" AS VARCHAR) AS "netsuite_id",
        CAST("netsuite_record" AS VARCHAR) AS "netsuite_record",
        CAST("no_geo_data" AS BOOLEAN) AS "no_geo_data",
        CAST("notes" AS VARCHAR) AS "notes",
        CAST("opportunity_handoff_ae" AS VARCHAR) AS "opportunity_handoff_ae",
        CAST("original_utm_campaign" AS VARCHAR) AS "original_utm_campaign",
        CAST("original_utm_content" AS VARCHAR) AS "original_utm_content",
        CAST("original_utm_medium" AS VARCHAR) AS "original_utm_medium",
        CAST("original_utm_source" AS VARCHAR) AS "original_utm_source",
        CAST("original_utm_term" AS VARCHAR) AS "original_utm_term",
        CAST("partner_company" AS VARCHAR) AS "partner_company",
        CAST("partner_contact" AS VARCHAR) AS "partner_contact",
        CAST("partner_rep_email" AS VARCHAR) AS "partner_rep_email",
        CAST("partner_rep_name" AS VARCHAR) AS "partner_rep_name",
        CAST("partner_territory" AS VARCHAR) AS "partner_territory",
        CAST("past_account" AS VARCHAR) AS "past_account",
        CAST("past_company" AS VARCHAR) AS "past_company",
        CAST("past_contact_info" AS VARCHAR) AS "past_contact_info",
        CAST("past_job_title" AS VARCHAR) AS "past_job_title",
        CAST("past_user_gems_info" AS VARCHAR) AS "past_user_gems_info",
        CAST("phone_extension" AS VARCHAR) AS "phone_extension",
        CAST("pi_created_date_c" AS TIMESTAMP) AS "pi_created_date_c",
        CAST("previous_lead_source" AS VARCHAR) AS "previous_lead_source",
        CAST("previous_lead_source_details" AS VARCHAR) AS "previous_lead_source_details",
        CAST("primary_sales_engineer" AS VARCHAR) AS "primary_sales_engineer",
        CAST("professional_network" AS VARCHAR) AS "professional_network",
        CAST("promotion_id" AS VARCHAR) AS "promotion_id",
        CAST("recent_campaign_status" AS VARCHAR) AS "recent_campaign_status",
        CAST("referral_account" AS VARCHAR) AS "referral_account",
        CAST("referral_contact" AS VARCHAR) AS "referral_contact",
        CAST("referral_first_name" AS VARCHAR) AS "referral_first_name",
        CAST("referral_last_name" AS VARCHAR) AS "referral_last_name",
        CAST("region" AS VARCHAR) AS "region",
        CAST("reports_to_id" AS VARCHAR) AS "reports_to_id",
        CAST("sales_email_opt_out" AS BOOLEAN) AS "sales_email_opt_out",
        CAST("sales_email_opt_out_datetime" AS TIMESTAMP) AS "sales_email_opt_out_datetime",
        CAST("salesloft_cadence_trigger" AS VARCHAR) AS "salesloft_cadence_trigger",
        CAST("salesloft_owner" AS VARCHAR) AS "salesloft_owner",
        CAST("salesloft_owner_sf_id" AS VARCHAR) AS "salesloft_owner_sf_id",
        CAST("salutation" AS VARCHAR) AS "salutation",
        CAST("secondary_city" AS VARCHAR) AS "secondary_city",
        CAST("secondary_country" AS VARCHAR) AS "secondary_country",
        CAST("secondary_email" AS VARCHAR) AS "secondary_email",
        CAST("secondary_geocode_accuracy" AS VARCHAR) AS "secondary_geocode_accuracy",
        CAST("secondary_phone" AS VARCHAR) AS "secondary_phone",
        CAST("secondary_postal_code" AS VARCHAR) AS "secondary_postal_code",
        CAST("secondary_state" AS VARCHAR) AS "secondary_state",
        CAST("secondary_street" AS VARCHAR) AS "secondary_street",
        CAST("self_service_routing" AS VARCHAR) AS "self_service_routing",
        CAST("seniority_level" AS VARCHAR) AS "seniority_level",
        CAST("skip_netsuite_export" AS BOOLEAN) AS "skip_netsuite_export",
        CAST("startup_certification_eligibility" AS VARCHAR) AS "startup_certification_eligibility",
        CAST("startup_primary_role" AS VARCHAR) AS "startup_primary_role",
        CAST("state" AS VARCHAR) AS "state",
        CAST("state_code" AS VARCHAR) AS "state_code",
        CAST("stripe_customer_level" AS VARCHAR) AS "stripe_customer_level",
        CAST("stripe_default_gateway" AS VARCHAR) AS "stripe_default_gateway",
        CAST("stripe_default_payment_method" AS VARCHAR) AS "stripe_default_payment_method",
        CAST("stripe_encrypted_personal_id" AS VARCHAR) AS "stripe_encrypted_personal_id",
        CAST("stripe_encrypted_ssn_last_4" AS VARCHAR) AS "stripe_encrypted_ssn_last_4",
        CAST("stripe_gender" AS VARCHAR) AS "stripe_gender",
        CAST("stripe_languages" AS VARCHAR) AS "stripe_languages",
        CAST("stripe_maiden_name" AS VARCHAR) AS "stripe_maiden_name",
        CAST("stripe_personal_id_number" AS VARCHAR) AS "stripe_personal_id_number",
        CAST("stripe_personal_id_type" AS VARCHAR) AS "stripe_personal_id_type",
        CAST("stripe_ssn_last_4" AS VARCHAR) AS "stripe_ssn_last_4",
        CAST("test_mode_record" AS BOOLEAN) AS "test_mode_record",
        CAST("trial_start_date" AS DATE) AS "trial_start_date",
        CAST("unqualified_reason" AS VARCHAR) AS "unqualified_reason",
        CAST("used_technologies" AS VARCHAR[]) AS "used_technologies",
        CAST("user_gems_id" AS UUID) AS "user_gems_id",
        CAST("username" AS VARCHAR) AS "username",
        CAST("utm_campaign" AS VARCHAR) AS "utm_campaign",
        CAST("utm_content" AS VARCHAR) AS "utm_content",
        CAST("utm_medium" AS VARCHAR) AS "utm_medium",
        CAST("utm_source" AS VARCHAR) AS "utm_source",
        CAST("utm_term" AS VARCHAR) AS "utm_term",
        CAST("zoominfo_company_id" AS VARCHAR) AS "zoominfo_company_id",
        CAST("zoominfo_contact_id" AS VARCHAR) AS "zoominfo_contact_id",
        CAST("zoominfo_first_updated" AS TIMESTAMP) AS "zoominfo_first_updated",
        CAST("zoominfo_last_updated" AS TIMESTAMP) AS "zoominfo_last_updated"
    FROM "sf_contact_data_removeWideColumns_projected_renamed_cleaned_null"
),

"sf_contact_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 221 columns with unacceptable missing values
    -- account_id has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- act_on_lead_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- activity_logged_by has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ad_group_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- additional_phone_numbers has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- allbound_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- analytics_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- assistant_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- assistant_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- associated_opportunity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- associated_url has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- automation_tracking has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- avatar_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- behavioral_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- beta_connector_interest has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- birthdate has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- campaign_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- celigo_sfnsio_net_suite_sync_error_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_editor has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_project has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- comments has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contact_holdover has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contact_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contact_owner_manager has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contact_stage has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contact_status has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- contact_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- conversion_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- conversion_object_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- conversion_object_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- created_at has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- created_by_id has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- created_by_role has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- created_by_user_gems has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- creative_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- csi_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- current_user_gems_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_persona has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_enrichment_request has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- delete_salesloft_data has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- demographic_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- department has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- deprecated_partner_contact has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- description has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- device_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- direct_office has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_contact_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_email_deliverability_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_job_title has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_optimizer_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_phone_accuracy_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_primary_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_primary_country_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_primary_postal_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_primary_state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_primary_state_abbr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- do_not_sync_marketo has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- domain_exists has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- drift_cql has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- email_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_bounced has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- email_double_opt_in has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_explicit_opt_in has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_implicit_opt_in has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_quality_unknown has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- fax_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_activity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_search_term has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_search_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_touch_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fivetran_use_case has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- gdpr_explicit_opt_in has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- google_click_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- historical_contact_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- home_phone_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- hvr_update has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- individual_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ironclad_workflow_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_deleted has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_email_bounced has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- is_emea_event_routing has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_eu_resident has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- is_relationship_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_user_gem has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_verified has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- isell_avention_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- jigsaw_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- jigsaw_data has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- job_function has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- job_level has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- job_title has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- keywords has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_activity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_ae_activity_owner has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_bdr_activity_owner has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_lead_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_lead_source_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_lead_source_detail has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_manual_ae_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_manual_bdr_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_marketing_moment_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_modified_by_id has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- last_name has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_sales_activity_datetime has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_scored_at has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_source has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- lean_data_manual_route_trigger has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lean_data_matched_buyer_persona has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lean_data_modified_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lean_data_routing_completion_datetime has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lean_data_segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- leandata_owner_override has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- leandata_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- leandata_tag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legacy_hvr_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- linkedin_company_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- linkedin_member_token has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- linkedin_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mailing_city has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_country has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_country_code has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_geocode_accuracy has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mailing_latitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mailing_longitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mailing_postal_code has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_street has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- manual_routing has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_campaign has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- marketing_cloud_subscriber has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_connector_interest has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_process_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketo_sync_block_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- master_record_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- match_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- metadata_creation_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mobile_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- name has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- needs_score_sync has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- netsuite_celigo_update has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- netsuite_conn_net_suite_sync_err_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- netsuite_connection_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- netsuite_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- netsuite_record has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- no_geo_data has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opportunity_handoff_ae has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_campaign has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_content has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_medium has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_term has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- owner_id has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- partner_company has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_contact has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_rep_email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_rep_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_territory has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- past_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- past_company has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- past_contact_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- past_job_title has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- past_user_gems_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- phone has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- photo_url has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- previous_lead_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- previous_lead_source_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- primary_sales_engineer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- professional_network has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- promotion_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- recent_campaign_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_contact has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_first_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_last_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- region has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reports_to_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_email_opt_out has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_email_opt_out_datetime has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- salesloft_cadence_trigger has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- salesloft_owner has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- salesloft_owner_sf_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- salutation has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- self_service_routing has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- seniority_level has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- skip_netsuite_export has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_detail has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- startup_certification_eligibility has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- startup_primary_role has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- test_mode_record has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- trial_start_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- unqualified_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- used_technologies has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_gems_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- username has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_campaign has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_content has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_medium has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_term has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_company_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_first_updated has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_last_updated has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "associated_url",
        "secondary_latitude",
        "mailing_country",
        "account_id",
        "pushed_from_opportunity",
        "mailing_street",
        "is_eu_resident",
        "last_name",
        "mailing_country_code",
        "created_by_id",
        "photo_url",
        "clearbit_id",
        "source_detail",
        "email_quality_unknown",
        "email_bounced",
        "email",
        "last_modified_by_id",
        "lean_data_routing_action",
        "no_longer_at_company",
        "push_to_netsuite",
        "mailing_city",
        "description",
        "is_email_bounced",
        "needs_score_sync",
        "do_not_route_lead",
        "lead_source",
        "clearbit_data_ready",
        "phone",
        "email_hard_bounced",
        "secondary_longitude",
        "job_title",
        "email_opt_out",
        "created_by_clearbit",
        "name",
        "mailing_state",
        "mailing_state_code",
        "netsuite_celigo_update",
        "owner_id",
        "netsuite_sync_in_progress",
        "contact_status",
        "do_not_call",
        "marketing_campaign",
        "contact_id",
        "clearbit_role",
        "clearbit_seniority",
        "clearbit_sub_role",
        "created_date",
        "email_bounce_date",
        "email_bounce_reason",
        "email_opt_out_timestamp",
        "fax_opt_out",
        "first_activity_post_mql",
        "first_activity_post_mql_date",
        "first_manual_activity_post_mql_date",
        "first_mql_date",
        "free_trial_confirmation_date",
        "has_attended_event",
        "has_changed_job",
        "has_referral",
        "is_billing_contact_hidden",
        "is_competitor",
        "is_hot_contact",
        "is_technical_contact",
        "last_contact_attempt",
        "last_customer_request_date",
        "last_customer_update_date",
        "last_modified_date",
        "last_modified_timestamp",
        "last_sdr_activity_date",
        "last_sdr_activity_owner",
        "lead_grade",
        "lead_score",
        "mailing_postal_code",
        "mql_date",
        "mql_date_changed",
        "mql_reason",
        "phone_extension",
        "pi_created_date_c",
        "secondary_city",
        "secondary_country",
        "secondary_email",
        "secondary_geocode_accuracy",
        "secondary_phone",
        "secondary_postal_code",
        "secondary_state",
        "secondary_street",
        "stripe_customer_level",
        "stripe_default_gateway",
        "stripe_default_payment_method",
        "stripe_encrypted_personal_id",
        "stripe_encrypted_ssn_last_4",
        "stripe_gender",
        "stripe_languages",
        "stripe_maiden_name",
        "stripe_personal_id_number",
        "stripe_personal_id_type",
        "stripe_ssn_last_4"
    FROM "sf_contact_data_removeWideColumns_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_contact_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled"