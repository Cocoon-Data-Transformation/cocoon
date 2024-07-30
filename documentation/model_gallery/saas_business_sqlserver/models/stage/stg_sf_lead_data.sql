-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:33:31.112815+00:00
WITH 
"sf_lead_data_projected" AS (
    -- Projection: Selecting 381 out of 382 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "country",
        "email_bounced_reason",
        "email_bounced_date",
        "owner_id",
        "secondary_email_c",
        "lead_source",
        "converted_date",
        "last_modified_date",
        "master_record_id",
        "last_modified_by_id",
        "system_modstamp",
        "geocode_accuracy",
        "converted_contact_id",
        "up_region_c",
        "id",
        "photo_url",
        "state",
        "longitude",
        "last_referenced_date",
        "up_district_c",
        "last_activity_date",
        "country_code",
        "phone",
        "mc_4_sf_mc_subscriber_c",
        "name",
        "jigsaw_contact_id",
        "lead_source_detail_c",
        "created_by_id",
        "salutation",
        "is_converted",
        "state_code",
        "is_unread_by_owner",
        "status",
        "city",
        "latitude",
        "cbit_clearbit_c",
        "industry",
        "title",
        "last_viewed_date",
        "converted_opportunity_id",
        "is_deleted",
        "street",
        "company",
        "first_name",
        "email",
        "website",
        "last_name",
        "number_of_employees",
        "up_territory_c",
        "created_date",
        "gclid_c",
        "active_in_sequence_c",
        "postal_code",
        "cbit_clearbit_ready_c",
        "has_opted_out_of_email",
        "converted_salesforce_account_id",
        "mobile_phone",
        "calendly_created_c",
        "account_c",
        "all_connectors_c",
        "all_data_warehouses_c",
        "bi_tools_c",
        "competitors_c",
        "annual_revenue",
        "connectors_products_c",
        "contact_c",
        "data_warehouse_products_c",
        "notes_c",
        "timeframe_c",
        "account_all_products_c",
        "account_bi_tools_c",
        "account_data_warehouses_c",
        "opportunity_competitors_c",
        "opportunity_products_c",
        "description",
        "referral_account_c",
        "referral_contact_c",
        "volume_in_millions_c",
        "feature_requests_c",
        "lead_number_c",
        "demo_scheduled_by_calenderly_c",
        "to_delete_c",
        "bounced_email_c",
        "email_quality_c",
        "email_quality_catchall_c",
        "old_lead_source_c",
        "email_bounced_c",
        "old_lead_source_detail_c",
        "utm_medium_c",
        "utm_source_c",
        "utm_campaign_c",
        "utm_content_c",
        "utm_term_c",
        "act_on_lead_score_c",
        "cbit_created_by_clearbit_c",
        "fivetran_user_id_c",
        "geo_state_acton_c",
        "actoncountry_c",
        "actoncity_c",
        "actoncountrycode_c",
        "actonpostalcode_c",
        "actonreferrer_c",
        "actonstate_c",
        "geo_city_c",
        "geo_country_c",
        "geo_country_code_c",
        "geo_postal_code_c",
        "geo_state_c",
        "company_type_c",
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
        "fax",
        "region_c",
        "competitor_c",
        "source_detail_c",
        "fivetran_account_stage_c",
        "fivetran_account_id_c",
        "lean_data_router_status_c",
        "lean_data_matched_lead_c",
        "lean_data_routing_action_c",
        "lean_data_search_index_c",
        "lean_data_reporting_matched_account_c",
        "lean_data_reporting_timestamp_c",
        "lean_data_ld_segment_c",
        "lean_data_marketing_sys_created_date_c",
        "lean_data_matched_account_c",
        "lean_data_a_2_b_account_c",
        "lean_data_search_c",
        "lean_data_routing_status_c",
        "lean_data_a_2_b_group_c",
        "lean_data_matched_buyer_persona_c",
        "lean_data_tag_c",
        "lean_data_status_info_c",
        "lean_data_modified_score_c",
        "do_not_route_lead_c",
        "partner_type_c",
        "allbound_id_c",
        "lid_linked_in_company_id_c",
        "lid_linked_in_member_token_c",
        "lean_data_re_route_c",
        "sales_loft_1_most_recent_cadence_next_step_due_date_c",
        "sales_loft_1_most_recent_last_completed_step_c",
        "sales_loft_1_most_recent_cadence_name_c",
        "network_c",
        "matchtype_c",
        "device_c",
        "creative_c",
        "adgroupid_c",
        "keyword_c",
        "campaignid_c",
        "partner_rep_email_c",
        "partner_rep_name_c",
        "lead_type_c",
        "contact_stage_c",
        "original_utm_campaign_c",
        "original_utm_content_c",
        "original_utm_medium_c",
        "original_utm_source_c",
        "original_utm_term_c",
        "es_app_esalexa_rank_c",
        "es_app_esaudience_names_c",
        "es_app_escity_c",
        "es_app_escompany_phone_c",
        "es_app_escountry_c",
        "es_app_escreated_timestamp_c",
        "es_app_esecid_c",
        "es_app_esemployees_c",
        "es_app_esenriched_c",
        "es_app_esenriched_timestamp_c",
        "es_app_esfacebook_c",
        "es_app_esindustry_c",
        "es_app_esintent_aggregate_score_c",
        "es_app_esintent_timestamp_c",
        "es_app_esintent_topics_c",
        "es_app_eskeywords_c",
        "es_app_eslinked_in_c",
        "es_app_esoverall_fit_score_c",
        "es_app_esrevenue_c",
        "es_app_essource_c",
        "es_app_esstate_c",
        "es_app_esstreet_c",
        "es_app_estechnologies_c",
        "es_app_estwitter_c",
        "es_app_eszipcode_c",
        "marketing_prospect_routing_rules_c",
        "individual_id",
        "marketing_process_c",
        "automation_tracking_c",
        "user_gems_has_changed_job_c",
        "user_gems_linked_in_c",
        "email_opt_in_c",
        "email_opt_in_explicit_c",
        "email_opt_in_implicit_c",
        "gdpr_opt_in_explicit_c",
        "user_gems_is_a_user_gem_c",
        "user_gems_past_account_c",
        "user_gems_past_company_c",
        "user_gems_past_contact_c",
        "user_gems_past_title_c",
        "promotion_id_c",
        "previous_customer_c",
        "referral_contact_email_c",
        "referral_firstname_c",
        "referral_last_name_c",
        "mkto_71_lead_score_c",
        "mkto_71_acquisition_date_c",
        "mkto_71_acquisition_program_id_c",
        "mkto_acquisition_program_c",
        "mkto_71_inferred_city_c",
        "mkto_71_inferred_company_c",
        "mkto_71_inferred_country_c",
        "mkto_71_inferred_metropolitan_area_c",
        "mkto_71_inferred_phone_area_code_c",
        "mkto_71_inferred_postal_code_c",
        "mkto_71_inferred_state_region_c",
        "mkto_71_original_referrer_c",
        "mkto_71_original_search_engine_c",
        "mkto_71_original_search_phrase_c",
        "mkto_71_original_source_info_c",
        "mkto_71_original_source_type_c",
        "mkto_si_hide_date_c",
        "mkto_si_last_interesting_moment_date_c",
        "mkto_si_last_interesting_moment_desc_c",
        "mkto_si_last_interesting_moment_source_c",
        "mkto_si_last_interesting_moment_type_c",
        "mkto_si_msicontact_id_c",
        "mkto_si_priority_c",
        "mkto_si_relative_score_value_c",
        "mkto_si_urgency_value_c",
        "cloudingo_agent_ar_c",
        "cloudingo_agent_ardi_c",
        "cloudingo_agent_as_c",
        "cloudingo_agent_atz_c",
        "cloudingo_agent_av_c",
        "cloudingo_agent_les_c",
        "do_not_sync_marketo_c",
        "source_every_utm_campaign_c",
        "source_every_utm_content_c",
        "source_every_utm_medium_c",
        "source_every_utm_source_c",
        "source_every_utm_term_c",
        "source_first_utm_campaign_c",
        "source_first_utm_content_c",
        "source_first_utm_medium_c",
        "source_first_utm_source_c",
        "source_first_utm_term_c",
        "source_last_utm_campaign_c",
        "source_last_utm_content_c",
        "source_last_utm_medium_c",
        "source_last_utm_source_c",
        "source_last_utm_term_c",
        "direct_office_c",
        "city_c",
        "country_c",
        "state_c",
        "source_first_lead_source_category_c",
        "source_last_lead_source_c",
        "source_last_lead_source_category_c",
        "source_last_lead_source_detail_c",
        "source_every_lead_source_c",
        "source_every_lead_source_category_c",
        "source_every_lead_source_detail_c",
        "source_first_lead_source_c",
        "source_first_lead_source_detail_c",
        "behavioral_score_c",
        "demographic_score_c",
        "drift_cql_c",
        "unique_email_c",
        "is_emea_event_routing_c",
        "csi_code_c",
        "csi_description_c",
        "converted_date_time_c",
        "lead_created_date_time_reporting_c",
        "lead_iq_country_c",
        "lead_iq_employee_count_c",
        "lead_iq_employee_range_c",
        "lead_iq_state_c",
        "lead_iq_zip_code_c",
        "zoominfo_country_c",
        "zoominfo_employee_count_c",
        "zoominfo_state_c",
        "zoominfo_technologies_c",
        "zoominfo_zip_code_c",
        "attended_event_c",
        "mql_date_c",
        "user_gems_user_gems_id_c",
        "dozisf_zoom_info_company_id_c",
        "dozisf_zoom_info_first_updated_c",
        "dozisf_zoom_info_id_c",
        "dozisf_zoom_info_last_updated_c",
        "lean_data_manual_route_trigger_c",
        "first_mql_date_c",
        "fivetran_account_association_date_c",
        "fivetran_account_user_role_s_c",
        "mql_reason_c",
        "trial_contact_start_date_c",
        "enrichment_request_c",
        "meta_data_create_date_c",
        "clarus_date_c",
        "clarus_editor_c",
        "clarus_notes_c",
        "clarus_project_c",
        "clarus_status_c",
        "marketing_connector_interest_c",
        "recent_marketing_campaign_status_c",
        "salesloft_cadence_trigger_c",
        "datawarehouse_used_c",
        "contact_status_c",
        "leandata_contact_owner_override_c",
        "potential_fivetran_use_case_c",
        "bizible_2_account_c",
        "bizible_2_ad_campaign_name_ft_c",
        "bizible_2_ad_campaign_name_lc_c",
        "bizible_2_bizible_id_c",
        "bizible_2_landing_page_ft_c",
        "bizible_2_landing_page_lc_c",
        "bizible_2_marketing_channel_ft_c",
        "bizible_2_marketing_channel_lc_c",
        "bizible_2_touchpoint_date_ft_c",
        "bizible_2_touchpoint_date_lc_c",
        "bizible_2_touchpoint_source_ft_c",
        "bizible_2_touchpoint_source_lc_c",
        "sales_email_opt_out_c",
        "sales_email_opt_out_date_time_c",
        "bombora_app_bombora_surge_record_count_c",
        "bombora_app_bombora_last_date_time_updated_c",
        "bombora_app_bombora_total_composite_score_c",
        "linked_in_url_c",
        "beta_connector_interest_c",
        "user_gems_ug_past_infos_c",
        "user_gems_ug_current_infos_c",
        "user_gems_ug_created_by_ug_c",
        "free_trial_email_confirmed_date_c",
        "dnboptimizer_dn_bcontact_record_c",
        "dnboptimizer_dn_bcompany_record_c",
        "dnboptimizer_dnb_d_u_n_s_number_c",
        "i_sell_oskey_id_c",
        "verified_c",
        "email_opt_out_date_time_c",
        "pbf_startup_c",
        "pbf_startup_certify_eligibility_c",
        "engagio_intent_minutes_last_30_days_c",
        "engagio_engagement_minutes_last_3_months_c",
        "engagio_engagement_minutes_last_7_days_c",
        "engagio_matched_account_c",
        "engagio_first_engagement_date_c",
        "engagio_match_time_c",
        "engagio_department_c",
        "engagio_role_c",
        "legacy_hvr_id_c",
        "hvr_channel_c",
        "email_opt_in_double_c",
        "phone_number_catch_all_c",
        "contacts_domain_exists_c",
        "utm_id_c",
        "source_every_utm_id_c",
        "source_last_utm_id_c",
        "source_first_utm_id_c",
        "do_not_sync_reason_marketo_c",
        "_fivetran_active"
    FROM "MyAppDB"."dbo"."sf_lead_data"
),

"sf_lead_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- email_bounced_reason -> email_bounce_reason
    -- email_bounced_date -> email_bounce_date
    -- secondary_email_c -> secondary_email
    -- converted_date -> conversion_date
    -- system_modstamp -> system_modification_timestamp
    -- up_district_c -> district
    -- mc_4_sf_mc_subscriber_c -> marketing_cloud_subscriber
    -- status -> lead_status
    -- cbit_clearbit_c -> clearbit_status
    -- title -> job_title
    -- company -> company_name
    -- email -> email_address
    -- up_territory_c -> territory
    -- gclid_c -> google_click_id
    -- active_in_sequence_c -> is_active_in_sequence
    -- cbit_clearbit_ready_c -> is_clearbit_ready
    -- calendly_created_c -> is_calendly_created
    -- account_c -> associated_account
    -- all_connectors_c -> connector_status
    -- all_data_warehouses_c -> data_warehouses_used
    -- bi_tools_c -> bi_tools_used
    -- competitors_c -> competitors_considered
    -- connectors_products_c -> connector_products_interest
    -- contact_c -> primary_contact
    -- data_warehouse_products_c -> data_warehouse_products_interest
    -- timeframe_c -> decision_timeframe
    -- account_all_products_c -> account_products
    -- account_bi_tools_c -> account_bi_tools
    -- account_data_warehouses_c -> account_data_warehouses
    -- opportunity_competitors_c -> opportunity_competitors
    -- opportunity_products_c -> opportunity_products
    -- referral_account_c -> referral_account
    -- referral_contact_c -> referral_contact
    -- volume_in_millions_c -> volume_millions
    -- feature_requests_c -> feature_requests
    -- demo_scheduled_by_calenderly_c -> demo_scheduled_calendly
    -- to_delete_c -> flagged_for_deletion
    -- bounced_email_c -> email_bounced
    -- email_quality_c -> email_quality_score
    -- email_quality_catchall_c -> email_quality_catchall
    -- old_lead_source_c -> previous_lead_source
    -- email_bounced_c -> email_bounce_status
    -- old_lead_source_detail_c -> previous_lead_source_details
    -- act_on_lead_score_c -> acton_lead_score
    -- cbit_created_by_clearbit_c -> created_by_clearbit
    -- fivetran_user_id_c -> fivetran_user_id
    -- geo_state_acton_c -> acton_geo_state
    -- actoncountry_c -> acton_country
    -- actoncity_c -> acton_city
    -- actoncountrycode_c -> acton_country_code
    -- actonpostalcode_c -> acton_postal_code
    -- actonreferrer_c -> acton_referrer
    -- actonstate_c -> acton_state
    -- geo_city_c -> geo_city
    -- geo_country_c -> geo_country
    -- geo_country_code_c -> geo_country_code
    -- geo_postal_code_c -> geo_postal_code
    -- geo_state_c -> geo_state
    -- company_type_c -> company_type
    -- pi_campaign_c -> pardot_campaign
    -- pi_comments_c -> pardot_comments
    -- pi_conversion_date_c -> pardot_conversion_date
    -- pi_conversion_object_name_c -> pardot_conversion_object_name
    -- pi_conversion_object_type_c -> pardot_conversion_object_type
    -- pi_created_date_c -> pardot_created_date
    -- pi_first_activity_c -> pardot_first_activity
    -- pi_first_search_term_c -> pardot_first_search_term
    -- pi_first_search_type_c -> pardot_first_search_type
    -- pi_first_touch_url_c -> pardot_first_touch_url
    -- pi_grade_c -> pardot_grade
    -- pi_needs_score_synced_c -> score_sync_needed
    -- pi_pardot_hard_bounced_c -> pardot_hard_bounced
    -- pi_pardot_last_scored_at_c -> pardot_last_scored_date
    -- pi_url_c -> lead_url
    -- competitor_c -> is_competitor
    -- fivetran_account_stage_c -> fivetran_account_stage
    -- fivetran_account_id_c -> fivetran_account_id
    -- lean_data_router_status_c -> leandata_router_status
    -- lean_data_matched_lead_c -> leandata_matched_lead
    -- lean_data_routing_action_c -> leandata_routing_action
    -- lean_data_search_index_c -> leandata_search_index
    -- lean_data_reporting_matched_account_c -> leandata_matched_account_id
    -- lean_data_reporting_timestamp_c -> leandata_reporting_timestamp
    -- lean_data_ld_segment_c -> leandata_segment
    -- lean_data_marketing_sys_created_date_c -> marketing_system_creation_date
    -- lean_data_matched_account_c -> leandata_matched_account
    -- lean_data_a_2_b_account_c -> leandata_a2b_account
    -- lean_data_search_c -> leandata_search
    -- lean_data_routing_status_c -> leandata_routing_status
    -- lean_data_a_2_b_group_c -> leandata_a2b_group
    -- lean_data_matched_buyer_persona_c -> buyer_persona
    -- lean_data_tag_c -> leandata_tag
    -- lean_data_status_info_c -> leandata_status_info
    -- lean_data_modified_score_c -> leandata_modified_score
    -- do_not_route_lead_c -> do_not_route_lead
    -- partner_type_c -> partner_type
    -- allbound_id_c -> allbound_id
    -- lid_linked_in_company_id_c -> linkedin_company_id
    -- lid_linked_in_member_token_c -> linkedin_member_token
    -- lean_data_re_route_c -> leandata_reroute
    -- sales_loft_1_most_recent_cadence_next_step_due_date_c -> salesloft_next_step_due_date
    -- sales_loft_1_most_recent_last_completed_step_c -> salesloft_last_completed_step
    -- sales_loft_1_most_recent_cadence_name_c -> salesloft_recent_cadence_name
    -- network_c -> network
    -- matchtype_c -> match_type
    -- device_c -> device
    -- creative_c -> creative_id
    -- adgroupid_c -> ad_group_id
    -- keyword_c -> keyword
    -- campaignid_c -> campaign_id
    -- partner_rep_email_c -> partner_rep_email
    -- partner_rep_name_c -> partner_rep_name
    -- lead_type_c -> lead_type
    -- contact_stage_c -> contact_stage
    -- es_app_esalexa_rank_c -> alexa_rank
    -- es_app_esaudience_names_c -> target_audience
    -- es_app_escompany_phone_c -> company_phone
    -- es_app_escreated_timestamp_c -> lead_creation_time
    -- es_app_esecid_c -> company_id
    -- es_app_esenriched_c -> is_enriched
    -- es_app_esenriched_timestamp_c -> enrichment_time
    -- es_app_esfacebook_c -> facebook_url
    -- es_app_esintent_aggregate_score_c -> intent_score
    -- es_app_esintent_timestamp_c -> intent_update_time
    -- es_app_esintent_topics_c -> intent_topics
    -- es_app_eskeywords_c -> company_keywords
    -- es_app_esoverall_fit_score_c -> fit_score
    -- es_app_estechnologies_c -> tech_stack
    -- es_app_estwitter_c -> twitter_handle
    -- es_app_eszipcode_c -> zipcode
    -- marketing_prospect_routing_rules_c -> prospect_routing_rules
    -- marketing_process_c -> marketing_stage
    -- automation_tracking_c -> automation_tracking
    -- user_gems_has_changed_job_c -> job_change_flag
    -- user_gems_linked_in_c -> linkedin_profile_url
    -- email_opt_in_c -> email_opt_in
    -- email_opt_in_explicit_c -> explicit_email_opt_in
    -- email_opt_in_implicit_c -> implicit_email_opt_in
    -- gdpr_opt_in_explicit_c -> gdpr_consent
    -- user_gems_is_a_user_gem_c -> is_user_gem
    -- user_gems_past_account_c -> past_account
    -- user_gems_past_company_c -> past_company
    -- user_gems_past_contact_c -> past_contact
    -- user_gems_past_title_c -> past_job_title
    -- promotion_id_c -> promotion_id
    -- previous_customer_c -> is_previous_customer
    -- referral_contact_email_c -> referral_email
    -- referral_firstname_c -> referral_first_name
    -- referral_last_name_c -> referral_last_name
    -- mkto_71_acquisition_date_c -> acquisition_date
    -- mkto_71_acquisition_program_id_c -> acquisition_program_id
    -- mkto_acquisition_program_c -> acquisition_program_name
    -- mkto_71_inferred_city_c -> inferred_city
    -- mkto_71_inferred_company_c -> inferred_company
    -- mkto_71_inferred_country_c -> inferred_country
    -- mkto_71_inferred_metropolitan_area_c -> inferred_metro_area
    -- mkto_71_inferred_phone_area_code_c -> inferred_phone_area_code
    -- mkto_71_inferred_postal_code_c -> inferred_postal_code
    -- mkto_71_inferred_state_region_c -> inferred_state_region
    -- mkto_71_original_referrer_c -> original_referrer_url
    -- mkto_71_original_search_engine_c -> original_search_engine
    -- mkto_71_original_search_phrase_c -> original_search_phrase
    -- mkto_71_original_source_info_c -> original_source_info
    -- mkto_71_original_source_type_c -> original_source_type
    -- mkto_si_hide_date_c -> hide_date
    -- mkto_si_last_interesting_moment_date_c -> last_interesting_moment_date
    -- mkto_si_last_interesting_moment_desc_c -> last_interesting_moment_description
    -- mkto_si_last_interesting_moment_source_c -> last_interesting_moment_source
    -- mkto_si_last_interesting_moment_type_c -> last_interesting_moment_type
    -- mkto_si_msicontact_id_c -> contact_id
    -- mkto_si_priority_c -> lead_priority
    -- mkto_si_relative_score_value_c -> relative_score
    -- mkto_si_urgency_value_c -> urgency_value
    -- cloudingo_agent_ar_c -> cloudingo_agent_ar
    -- cloudingo_agent_ardi_c -> cloudingo_agent_ardi
    -- cloudingo_agent_as_c -> cloudingo_agent_as
    -- cloudingo_agent_atz_c -> cloudingo_agent_atz
    -- cloudingo_agent_av_c -> cloudingo_agent_av
    -- cloudingo_agent_les_c -> cloudingo_agent_les
    -- do_not_sync_marketo_c -> do_not_sync_marketo
    -- source_every_utm_campaign_c -> all_utm_campaigns
    -- source_every_utm_content_c -> all_utm_content
    -- source_every_utm_medium_c -> all_utm_mediums
    -- source_every_utm_source_c -> all_utm_sources
    -- source_every_utm_term_c -> all_utm_terms
    -- source_first_utm_campaign_c -> first_utm_campaign
    -- source_first_utm_content_c -> first_utm_content
    -- source_first_utm_medium_c -> first_utm_medium
    -- source_first_utm_source_c -> first_utm_source
    -- source_first_utm_term_c -> first_utm_term
    -- source_last_utm_campaign_c -> last_utm_campaign
    -- source_last_utm_content_c -> last_utm_content
    -- source_last_utm_medium_c -> last_utm_medium
    -- source_last_utm_source_c -> last_utm_source
    -- source_last_utm_term_c -> last_utm_term
    -- direct_office_c -> direct_office
    -- source_first_lead_source_category_c -> first_lead_source_category
    -- source_last_lead_source_c -> last_lead_source
    -- source_last_lead_source_category_c -> last_lead_source_category
    -- source_last_lead_source_detail_c -> last_lead_source_detail
    -- source_every_lead_source_c -> all_lead_sources
    -- source_every_lead_source_category_c -> all_lead_source_categories
    -- source_every_lead_source_detail_c -> all_lead_source_details
    -- source_first_lead_source_c -> first_lead_source
    -- source_first_lead_source_detail_c -> first_lead_source_detail
    -- behavioral_score_c -> behavioral_score
    -- demographic_score_c -> demographic_score
    -- drift_cql_c -> drift_cql_status
    -- unique_email_c -> unique_email
    -- is_emea_event_routing_c -> is_emea_event_routing
    -- csi_code_c -> csi_code
    -- csi_description_c -> csi_description
    -- converted_date_time_c -> conversion_datetime
    -- lead_created_date_time_reporting_c -> lead_creation_datetime
    -- lead_iq_country_c -> leadiq_country
    -- lead_iq_employee_count_c -> leadiq_employee_count
    -- lead_iq_employee_range_c -> leadiq_employee_range
    -- lead_iq_state_c -> leadiq_state
    -- lead_iq_zip_code_c -> leadiq_zip_code
    -- zoominfo_country_c -> zoominfo_country
    -- zoominfo_technologies_c -> company_technologies
    -- zoominfo_zip_code_c -> zip_code
    -- attended_event_c -> event_attendance
    -- mql_date_c -> mql_date
    -- user_gems_user_gems_id_c -> user_gems_id
    -- dozisf_zoom_info_company_id_c -> zoominfo_company_id
    -- dozisf_zoom_info_first_updated_c -> zoominfo_first_updated
    -- dozisf_zoom_info_id_c -> zoominfo_id
    -- dozisf_zoom_info_last_updated_c -> zoominfo_last_updated
    -- lean_data_manual_route_trigger_c -> manual_route_trigger
    -- first_mql_date_c -> first_mql_date
    -- fivetran_account_association_date_c -> fivetran_association_date
    -- fivetran_account_user_role_s_c -> fivetran_user_roles
    -- mql_reason_c -> mql_reason
    -- trial_contact_start_date_c -> trial_start_date
    -- enrichment_request_c -> enrichment_requested
    -- meta_data_create_date_c -> metadata_creation_date
    -- clarus_date_c -> clarus_date
    -- clarus_editor_c -> clarus_editor
    -- clarus_notes_c -> clarus_notes
    -- clarus_project_c -> clarus_project
    -- clarus_status_c -> clarus_status
    -- marketing_connector_interest_c -> marketing_connector_interest
    -- recent_marketing_campaign_status_c -> recent_campaign_status
    -- salesloft_cadence_trigger_c -> salesloft_cadence_trigger
    -- datawarehouse_used_c -> datawarehouse_usage
    -- contact_status_c -> contact_status
    -- leandata_contact_owner_override_c -> leandata_owner_override
    -- potential_fivetran_use_case_c -> fivetran_use_case
    -- bizible_2_account_c -> bizible_account
    -- bizible_2_ad_campaign_name_ft_c -> ad_campaign_name_first_touch
    -- bizible_2_ad_campaign_name_lc_c -> ad_campaign_name_last_touch
    -- bizible_2_bizible_id_c -> bizible_id
    -- bizible_2_landing_page_ft_c -> landing_page_first_touch
    -- bizible_2_landing_page_lc_c -> landing_page_last_touch
    -- bizible_2_marketing_channel_ft_c -> marketing_channel_first_touch
    -- bizible_2_marketing_channel_lc_c -> marketing_channel_last_touch
    -- bizible_2_touchpoint_date_ft_c -> touchpoint_date_first_touch
    -- bizible_2_touchpoint_date_lc_c -> touchpoint_date_last_touch
    -- bizible_2_touchpoint_source_ft_c -> touchpoint_source_first_touch
    -- bizible_2_touchpoint_source_lc_c -> touchpoint_source_last_touch
    -- sales_email_opt_out_c -> sales_email_opt_out
    -- sales_email_opt_out_date_time_c -> sales_email_opt_out_datetime
    -- bombora_app_bombora_surge_record_count_c -> bombora_surge_record_count
    -- bombora_app_bombora_last_date_time_updated_c -> bombora_last_updated
    -- bombora_app_bombora_total_composite_score_c -> bombora_composite_score
    -- beta_connector_interest_c -> beta_connector_interest
    -- user_gems_ug_past_infos_c -> user_gems_past_info
    -- user_gems_ug_current_infos_c -> user_gems_current_info
    -- user_gems_ug_created_by_ug_c -> created_by_user_gems
    -- free_trial_email_confirmed_date_c -> free_trial_email_confirmed_date
    -- dnboptimizer_dn_bcontact_record_c -> dnb_contact_record
    -- dnboptimizer_dn_bcompany_record_c -> dnb_company_record
    -- dnboptimizer_dnb_d_u_n_s_number_c -> duns_number
    -- i_sell_oskey_id_c -> isell_os_key_id
    -- verified_c -> verified
    -- email_opt_out_date_time_c -> email_opt_out_datetime
    -- pbf_startup_c -> is_startup
    -- pbf_startup_certify_eligibility_c -> startup_eligibility_certified
    -- engagio_intent_minutes_last_30_days_c -> intent_minutes_30d
    -- engagio_engagement_minutes_last_3_months_c -> engagement_minutes_3m
    -- engagio_engagement_minutes_last_7_days_c -> engagement_minutes_7d
    -- engagio_matched_account_c -> engagio_account_matched
    -- engagio_first_engagement_date_c -> first_engagement_date
    -- engagio_match_time_c -> engagio_match_time
    -- engagio_department_c -> department
    -- engagio_role_c -> role
    -- legacy_hvr_id_c -> legacy_hvr_id
    -- hvr_channel_c -> hvr_channel
    -- email_opt_in_double_c -> email_double_opt_in
    -- phone_number_catch_all_c -> phone_number
    -- contacts_domain_exists_c -> domain_exists
    -- utm_id_c -> utm_id
    -- source_every_utm_id_c -> all_utm_ids
    -- source_last_utm_id_c -> last_utm_id
    -- source_first_utm_id_c -> first_utm_id
    -- do_not_sync_reason_marketo_c -> marketo_sync_block_reason
    -- _fivetran_active -> is_fivetran_active
    SELECT 
        "country",
        "email_bounced_reason" AS "email_bounce_reason",
        "email_bounced_date" AS "email_bounce_date",
        "owner_id",
        "secondary_email_c" AS "secondary_email",
        "lead_source",
        "converted_date" AS "conversion_date",
        "last_modified_date",
        "master_record_id",
        "last_modified_by_id",
        "system_modstamp" AS "system_modification_timestamp",
        "geocode_accuracy",
        "converted_contact_id",
        "up_region_c",
        "id",
        "photo_url",
        "state",
        "longitude",
        "last_referenced_date",
        "up_district_c" AS "district",
        "last_activity_date",
        "country_code",
        "phone",
        "mc_4_sf_mc_subscriber_c" AS "marketing_cloud_subscriber",
        "name",
        "jigsaw_contact_id",
        "lead_source_detail_c",
        "created_by_id",
        "salutation",
        "is_converted",
        "state_code",
        "is_unread_by_owner",
        "status" AS "lead_status",
        "city",
        "latitude",
        "cbit_clearbit_c" AS "clearbit_status",
        "industry",
        "title" AS "job_title",
        "last_viewed_date",
        "converted_opportunity_id",
        "is_deleted",
        "street",
        "company" AS "company_name",
        "first_name",
        "email" AS "email_address",
        "website",
        "last_name",
        "number_of_employees",
        "up_territory_c" AS "territory",
        "created_date",
        "gclid_c" AS "google_click_id",
        "active_in_sequence_c" AS "is_active_in_sequence",
        "postal_code",
        "cbit_clearbit_ready_c" AS "is_clearbit_ready",
        "has_opted_out_of_email",
        "converted_salesforce_account_id",
        "mobile_phone",
        "calendly_created_c" AS "is_calendly_created",
        "account_c" AS "associated_account",
        "all_connectors_c" AS "connector_status",
        "all_data_warehouses_c" AS "data_warehouses_used",
        "bi_tools_c" AS "bi_tools_used",
        "competitors_c" AS "competitors_considered",
        "annual_revenue",
        "connectors_products_c" AS "connector_products_interest",
        "contact_c" AS "primary_contact",
        "data_warehouse_products_c" AS "data_warehouse_products_interest",
        "notes_c",
        "timeframe_c" AS "decision_timeframe",
        "account_all_products_c" AS "account_products",
        "account_bi_tools_c" AS "account_bi_tools",
        "account_data_warehouses_c" AS "account_data_warehouses",
        "opportunity_competitors_c" AS "opportunity_competitors",
        "opportunity_products_c" AS "opportunity_products",
        "description",
        "referral_account_c" AS "referral_account",
        "referral_contact_c" AS "referral_contact",
        "volume_in_millions_c" AS "volume_millions",
        "feature_requests_c" AS "feature_requests",
        "lead_number_c",
        "demo_scheduled_by_calenderly_c" AS "demo_scheduled_calendly",
        "to_delete_c" AS "flagged_for_deletion",
        "bounced_email_c" AS "email_bounced",
        "email_quality_c" AS "email_quality_score",
        "email_quality_catchall_c" AS "email_quality_catchall",
        "old_lead_source_c" AS "previous_lead_source",
        "email_bounced_c" AS "email_bounce_status",
        "old_lead_source_detail_c" AS "previous_lead_source_details",
        "utm_medium_c",
        "utm_source_c",
        "utm_campaign_c",
        "utm_content_c",
        "utm_term_c",
        "act_on_lead_score_c" AS "acton_lead_score",
        "cbit_created_by_clearbit_c" AS "created_by_clearbit",
        "fivetran_user_id_c" AS "fivetran_user_id",
        "geo_state_acton_c" AS "acton_geo_state",
        "actoncountry_c" AS "acton_country",
        "actoncity_c" AS "acton_city",
        "actoncountrycode_c" AS "acton_country_code",
        "actonpostalcode_c" AS "acton_postal_code",
        "actonreferrer_c" AS "acton_referrer",
        "actonstate_c" AS "acton_state",
        "geo_city_c" AS "geo_city",
        "geo_country_c" AS "geo_country",
        "geo_country_code_c" AS "geo_country_code",
        "geo_postal_code_c" AS "geo_postal_code",
        "geo_state_c" AS "geo_state",
        "company_type_c" AS "company_type",
        "pi_campaign_c" AS "pardot_campaign",
        "pi_comments_c" AS "pardot_comments",
        "pi_conversion_date_c" AS "pardot_conversion_date",
        "pi_conversion_object_name_c" AS "pardot_conversion_object_name",
        "pi_conversion_object_type_c" AS "pardot_conversion_object_type",
        "pi_created_date_c" AS "pardot_created_date",
        "pi_first_activity_c" AS "pardot_first_activity",
        "pi_first_search_term_c" AS "pardot_first_search_term",
        "pi_first_search_type_c" AS "pardot_first_search_type",
        "pi_first_touch_url_c" AS "pardot_first_touch_url",
        "pi_grade_c" AS "pardot_grade",
        "pi_last_activity_c",
        "pi_needs_score_synced_c" AS "score_sync_needed",
        "pi_notes_c",
        "pi_pardot_hard_bounced_c" AS "pardot_hard_bounced",
        "pi_pardot_last_scored_at_c" AS "pardot_last_scored_date",
        "pi_score_c",
        "pi_url_c" AS "lead_url",
        "pi_utm_campaign_c",
        "pi_utm_content_c",
        "pi_utm_medium_c",
        "pi_utm_source_c",
        "pi_utm_term_c",
        "fax",
        "region_c",
        "competitor_c" AS "is_competitor",
        "source_detail_c",
        "fivetran_account_stage_c" AS "fivetran_account_stage",
        "fivetran_account_id_c" AS "fivetran_account_id",
        "lean_data_router_status_c" AS "leandata_router_status",
        "lean_data_matched_lead_c" AS "leandata_matched_lead",
        "lean_data_routing_action_c" AS "leandata_routing_action",
        "lean_data_search_index_c" AS "leandata_search_index",
        "lean_data_reporting_matched_account_c" AS "leandata_matched_account_id",
        "lean_data_reporting_timestamp_c" AS "leandata_reporting_timestamp",
        "lean_data_ld_segment_c" AS "leandata_segment",
        "lean_data_marketing_sys_created_date_c" AS "marketing_system_creation_date",
        "lean_data_matched_account_c" AS "leandata_matched_account",
        "lean_data_a_2_b_account_c" AS "leandata_a2b_account",
        "lean_data_search_c" AS "leandata_search",
        "lean_data_routing_status_c" AS "leandata_routing_status",
        "lean_data_a_2_b_group_c" AS "leandata_a2b_group",
        "lean_data_matched_buyer_persona_c" AS "buyer_persona",
        "lean_data_tag_c" AS "leandata_tag",
        "lean_data_status_info_c" AS "leandata_status_info",
        "lean_data_modified_score_c" AS "leandata_modified_score",
        "do_not_route_lead_c" AS "do_not_route_lead",
        "partner_type_c" AS "partner_type",
        "allbound_id_c" AS "allbound_id",
        "lid_linked_in_company_id_c" AS "linkedin_company_id",
        "lid_linked_in_member_token_c" AS "linkedin_member_token",
        "lean_data_re_route_c" AS "leandata_reroute",
        "sales_loft_1_most_recent_cadence_next_step_due_date_c" AS "salesloft_next_step_due_date",
        "sales_loft_1_most_recent_last_completed_step_c" AS "salesloft_last_completed_step",
        "sales_loft_1_most_recent_cadence_name_c" AS "salesloft_recent_cadence_name",
        "network_c" AS "network",
        "matchtype_c" AS "match_type",
        "device_c" AS "device",
        "creative_c" AS "creative_id",
        "adgroupid_c" AS "ad_group_id",
        "keyword_c" AS "keyword",
        "campaignid_c" AS "campaign_id",
        "partner_rep_email_c" AS "partner_rep_email",
        "partner_rep_name_c" AS "partner_rep_name",
        "lead_type_c" AS "lead_type",
        "contact_stage_c" AS "contact_stage",
        "original_utm_campaign_c",
        "original_utm_content_c",
        "original_utm_medium_c",
        "original_utm_source_c",
        "original_utm_term_c",
        "es_app_esalexa_rank_c" AS "alexa_rank",
        "es_app_esaudience_names_c" AS "target_audience",
        "es_app_escity_c",
        "es_app_escompany_phone_c" AS "company_phone",
        "es_app_escountry_c",
        "es_app_escreated_timestamp_c" AS "lead_creation_time",
        "es_app_esecid_c" AS "company_id",
        "es_app_esemployees_c",
        "es_app_esenriched_c" AS "is_enriched",
        "es_app_esenriched_timestamp_c" AS "enrichment_time",
        "es_app_esfacebook_c" AS "facebook_url",
        "es_app_esindustry_c",
        "es_app_esintent_aggregate_score_c" AS "intent_score",
        "es_app_esintent_timestamp_c" AS "intent_update_time",
        "es_app_esintent_topics_c" AS "intent_topics",
        "es_app_eskeywords_c" AS "company_keywords",
        "es_app_eslinked_in_c",
        "es_app_esoverall_fit_score_c" AS "fit_score",
        "es_app_esrevenue_c",
        "es_app_essource_c",
        "es_app_esstate_c",
        "es_app_esstreet_c",
        "es_app_estechnologies_c" AS "tech_stack",
        "es_app_estwitter_c" AS "twitter_handle",
        "es_app_eszipcode_c" AS "zipcode",
        "marketing_prospect_routing_rules_c" AS "prospect_routing_rules",
        "individual_id",
        "marketing_process_c" AS "marketing_stage",
        "automation_tracking_c" AS "automation_tracking",
        "user_gems_has_changed_job_c" AS "job_change_flag",
        "user_gems_linked_in_c" AS "linkedin_profile_url",
        "email_opt_in_c" AS "email_opt_in",
        "email_opt_in_explicit_c" AS "explicit_email_opt_in",
        "email_opt_in_implicit_c" AS "implicit_email_opt_in",
        "gdpr_opt_in_explicit_c" AS "gdpr_consent",
        "user_gems_is_a_user_gem_c" AS "is_user_gem",
        "user_gems_past_account_c" AS "past_account",
        "user_gems_past_company_c" AS "past_company",
        "user_gems_past_contact_c" AS "past_contact",
        "user_gems_past_title_c" AS "past_job_title",
        "promotion_id_c" AS "promotion_id",
        "previous_customer_c" AS "is_previous_customer",
        "referral_contact_email_c" AS "referral_email",
        "referral_firstname_c" AS "referral_first_name",
        "referral_last_name_c" AS "referral_last_name",
        "mkto_71_lead_score_c",
        "mkto_71_acquisition_date_c" AS "acquisition_date",
        "mkto_71_acquisition_program_id_c" AS "acquisition_program_id",
        "mkto_acquisition_program_c" AS "acquisition_program_name",
        "mkto_71_inferred_city_c" AS "inferred_city",
        "mkto_71_inferred_company_c" AS "inferred_company",
        "mkto_71_inferred_country_c" AS "inferred_country",
        "mkto_71_inferred_metropolitan_area_c" AS "inferred_metro_area",
        "mkto_71_inferred_phone_area_code_c" AS "inferred_phone_area_code",
        "mkto_71_inferred_postal_code_c" AS "inferred_postal_code",
        "mkto_71_inferred_state_region_c" AS "inferred_state_region",
        "mkto_71_original_referrer_c" AS "original_referrer_url",
        "mkto_71_original_search_engine_c" AS "original_search_engine",
        "mkto_71_original_search_phrase_c" AS "original_search_phrase",
        "mkto_71_original_source_info_c" AS "original_source_info",
        "mkto_71_original_source_type_c" AS "original_source_type",
        "mkto_si_hide_date_c" AS "hide_date",
        "mkto_si_last_interesting_moment_date_c" AS "last_interesting_moment_date",
        "mkto_si_last_interesting_moment_desc_c" AS "last_interesting_moment_description",
        "mkto_si_last_interesting_moment_source_c" AS "last_interesting_moment_source",
        "mkto_si_last_interesting_moment_type_c" AS "last_interesting_moment_type",
        "mkto_si_msicontact_id_c" AS "contact_id",
        "mkto_si_priority_c" AS "lead_priority",
        "mkto_si_relative_score_value_c" AS "relative_score",
        "mkto_si_urgency_value_c" AS "urgency_value",
        "cloudingo_agent_ar_c" AS "cloudingo_agent_ar",
        "cloudingo_agent_ardi_c" AS "cloudingo_agent_ardi",
        "cloudingo_agent_as_c" AS "cloudingo_agent_as",
        "cloudingo_agent_atz_c" AS "cloudingo_agent_atz",
        "cloudingo_agent_av_c" AS "cloudingo_agent_av",
        "cloudingo_agent_les_c" AS "cloudingo_agent_les",
        "do_not_sync_marketo_c" AS "do_not_sync_marketo",
        "source_every_utm_campaign_c" AS "all_utm_campaigns",
        "source_every_utm_content_c" AS "all_utm_content",
        "source_every_utm_medium_c" AS "all_utm_mediums",
        "source_every_utm_source_c" AS "all_utm_sources",
        "source_every_utm_term_c" AS "all_utm_terms",
        "source_first_utm_campaign_c" AS "first_utm_campaign",
        "source_first_utm_content_c" AS "first_utm_content",
        "source_first_utm_medium_c" AS "first_utm_medium",
        "source_first_utm_source_c" AS "first_utm_source",
        "source_first_utm_term_c" AS "first_utm_term",
        "source_last_utm_campaign_c" AS "last_utm_campaign",
        "source_last_utm_content_c" AS "last_utm_content",
        "source_last_utm_medium_c" AS "last_utm_medium",
        "source_last_utm_source_c" AS "last_utm_source",
        "source_last_utm_term_c" AS "last_utm_term",
        "direct_office_c" AS "direct_office",
        "city_c",
        "country_c",
        "state_c",
        "source_first_lead_source_category_c" AS "first_lead_source_category",
        "source_last_lead_source_c" AS "last_lead_source",
        "source_last_lead_source_category_c" AS "last_lead_source_category",
        "source_last_lead_source_detail_c" AS "last_lead_source_detail",
        "source_every_lead_source_c" AS "all_lead_sources",
        "source_every_lead_source_category_c" AS "all_lead_source_categories",
        "source_every_lead_source_detail_c" AS "all_lead_source_details",
        "source_first_lead_source_c" AS "first_lead_source",
        "source_first_lead_source_detail_c" AS "first_lead_source_detail",
        "behavioral_score_c" AS "behavioral_score",
        "demographic_score_c" AS "demographic_score",
        "drift_cql_c" AS "drift_cql_status",
        "unique_email_c" AS "unique_email",
        "is_emea_event_routing_c" AS "is_emea_event_routing",
        "csi_code_c" AS "csi_code",
        "csi_description_c" AS "csi_description",
        "converted_date_time_c" AS "conversion_datetime",
        "lead_created_date_time_reporting_c" AS "lead_creation_datetime",
        "lead_iq_country_c" AS "leadiq_country",
        "lead_iq_employee_count_c" AS "leadiq_employee_count",
        "lead_iq_employee_range_c" AS "leadiq_employee_range",
        "lead_iq_state_c" AS "leadiq_state",
        "lead_iq_zip_code_c" AS "leadiq_zip_code",
        "zoominfo_country_c" AS "zoominfo_country",
        "zoominfo_employee_count_c",
        "zoominfo_state_c",
        "zoominfo_technologies_c" AS "company_technologies",
        "zoominfo_zip_code_c" AS "zip_code",
        "attended_event_c" AS "event_attendance",
        "mql_date_c" AS "mql_date",
        "user_gems_user_gems_id_c" AS "user_gems_id",
        "dozisf_zoom_info_company_id_c" AS "zoominfo_company_id",
        "dozisf_zoom_info_first_updated_c" AS "zoominfo_first_updated",
        "dozisf_zoom_info_id_c" AS "zoominfo_id",
        "dozisf_zoom_info_last_updated_c" AS "zoominfo_last_updated",
        "lean_data_manual_route_trigger_c" AS "manual_route_trigger",
        "first_mql_date_c" AS "first_mql_date",
        "fivetran_account_association_date_c" AS "fivetran_association_date",
        "fivetran_account_user_role_s_c" AS "fivetran_user_roles",
        "mql_reason_c" AS "mql_reason",
        "trial_contact_start_date_c" AS "trial_start_date",
        "enrichment_request_c" AS "enrichment_requested",
        "meta_data_create_date_c" AS "metadata_creation_date",
        "clarus_date_c" AS "clarus_date",
        "clarus_editor_c" AS "clarus_editor",
        "clarus_notes_c" AS "clarus_notes",
        "clarus_project_c" AS "clarus_project",
        "clarus_status_c" AS "clarus_status",
        "marketing_connector_interest_c" AS "marketing_connector_interest",
        "recent_marketing_campaign_status_c" AS "recent_campaign_status",
        "salesloft_cadence_trigger_c" AS "salesloft_cadence_trigger",
        "datawarehouse_used_c" AS "datawarehouse_usage",
        "contact_status_c" AS "contact_status",
        "leandata_contact_owner_override_c" AS "leandata_owner_override",
        "potential_fivetran_use_case_c" AS "fivetran_use_case",
        "bizible_2_account_c" AS "bizible_account",
        "bizible_2_ad_campaign_name_ft_c" AS "ad_campaign_name_first_touch",
        "bizible_2_ad_campaign_name_lc_c" AS "ad_campaign_name_last_touch",
        "bizible_2_bizible_id_c" AS "bizible_id",
        "bizible_2_landing_page_ft_c" AS "landing_page_first_touch",
        "bizible_2_landing_page_lc_c" AS "landing_page_last_touch",
        "bizible_2_marketing_channel_ft_c" AS "marketing_channel_first_touch",
        "bizible_2_marketing_channel_lc_c" AS "marketing_channel_last_touch",
        "bizible_2_touchpoint_date_ft_c" AS "touchpoint_date_first_touch",
        "bizible_2_touchpoint_date_lc_c" AS "touchpoint_date_last_touch",
        "bizible_2_touchpoint_source_ft_c" AS "touchpoint_source_first_touch",
        "bizible_2_touchpoint_source_lc_c" AS "touchpoint_source_last_touch",
        "sales_email_opt_out_c" AS "sales_email_opt_out",
        "sales_email_opt_out_date_time_c" AS "sales_email_opt_out_datetime",
        "bombora_app_bombora_surge_record_count_c" AS "bombora_surge_record_count",
        "bombora_app_bombora_last_date_time_updated_c" AS "bombora_last_updated",
        "bombora_app_bombora_total_composite_score_c" AS "bombora_composite_score",
        "linked_in_url_c",
        "beta_connector_interest_c" AS "beta_connector_interest",
        "user_gems_ug_past_infos_c" AS "user_gems_past_info",
        "user_gems_ug_current_infos_c" AS "user_gems_current_info",
        "user_gems_ug_created_by_ug_c" AS "created_by_user_gems",
        "free_trial_email_confirmed_date_c" AS "free_trial_email_confirmed_date",
        "dnboptimizer_dn_bcontact_record_c" AS "dnb_contact_record",
        "dnboptimizer_dn_bcompany_record_c" AS "dnb_company_record",
        "dnboptimizer_dnb_d_u_n_s_number_c" AS "duns_number",
        "i_sell_oskey_id_c" AS "isell_os_key_id",
        "verified_c" AS "verified",
        "email_opt_out_date_time_c" AS "email_opt_out_datetime",
        "pbf_startup_c" AS "is_startup",
        "pbf_startup_certify_eligibility_c" AS "startup_eligibility_certified",
        "engagio_intent_minutes_last_30_days_c" AS "intent_minutes_30d",
        "engagio_engagement_minutes_last_3_months_c" AS "engagement_minutes_3m",
        "engagio_engagement_minutes_last_7_days_c" AS "engagement_minutes_7d",
        "engagio_matched_account_c" AS "engagio_account_matched",
        "engagio_first_engagement_date_c" AS "first_engagement_date",
        "engagio_match_time_c" AS "engagio_match_time",
        "engagio_department_c" AS "department",
        "engagio_role_c" AS "role",
        "legacy_hvr_id_c" AS "legacy_hvr_id",
        "hvr_channel_c" AS "hvr_channel",
        "email_opt_in_double_c" AS "email_double_opt_in",
        "phone_number_catch_all_c" AS "phone_number",
        "contacts_domain_exists_c" AS "domain_exists",
        "utm_id_c" AS "utm_id",
        "source_every_utm_id_c" AS "all_utm_ids",
        "source_last_utm_id_c" AS "last_utm_id",
        "source_first_utm_id_c" AS "first_utm_id",
        "do_not_sync_reason_marketo_c" AS "marketo_sync_block_reason",
        "_fivetran_active" AS "is_fivetran_active"
    FROM "sf_lead_data_projected"
),

"sf_lead_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- name: The problem is that the name column contains only a single-letter value 'h', which is highly unusual for a name field. This likely indicates incomplete or placeholder data. In most cases, 'h' is not a valid name and doesn't provide any meaningful information. The correct values for a name field should be full names or at least first names or last names.
    -- is_converted: The problem is that the is_converted column appears to be a binary column (typically representing true/false or yes/no), but it only contains the value '1'. This is unusual because a binary column should normally have two distinct values, such as '0' and '1' or 'true' and 'false'. The absence of a second value (like '0' for "not converted") suggests that either all data points are converted (which is unlikely in most real-world scenarios), or that the "not converted" cases are missing or represented inconsistently. The correct values for a binary column should typically be '0' and '1', or 'false' and 'true'.
    -- company_name: The problem is that 'Z' is an unusually brief and non-descriptive company name. It's likely a placeholder or an error rather than a genuine company name. Without additional context or information about what this 'Z' might represent, it's difficult to map it to a correct value. In cases like this where we can't determine the actual company name, it's often best to replace it with an empty string or a null value to indicate missing data.
    -- first_name: The problem is that 'H' as a first name is highly unusual because it's just a single letter.  Typically, first names are full words or at least more than one letter.  This could be an abbreviation, initial, or data entry error.  Without more context or information about the intended full name,  it's difficult to determine the correct value.  In this case, we'll keep the value as is, but flag it for further investigation.
    -- email_quality_score: The problem is that the email_quality_score column only contains the value '0', which is unusual for a quality score. Typically, quality scores have a range of values to indicate different levels of quality. Without more context about the specific scoring system used, it's difficult to determine what the correct values should be. However, a common quality score range might be from 0 to 100, with 0 being the lowest quality and 100 being the highest.
    -- leandata_search_index: The problem is that the value 'geomecyvdvhj amazon' appears to be meaningless or corrupted data. It contains a random string 'geomecyvdvhj' followed by 'amazon', which doesn't seem to represent any valid search term or index. The correct value should be an empty string, as we cannot determine a meaningful replacement for this corrupted data.
    -- event_attendance: The problem is that all values in the event_attendance column are '0'. This is unusual because event attendance typically varies and should include positive integers. A value of '0' for all events suggests either a data entry error, a system default that wasn't updated, or potentially that the attendance wasn't actually recorded. The correct values should be the actual attendance numbers for each event, which would vary and be positive integers.
    -- fivetran_use_case: The problem is that 'Unknown' is the only value in the fivetran_use_case column, which indicates that no specific use cases are being recorded. This is unusual because typically, a use case column would contain various categories or descriptions of how the product or service is being utilized. Having only 'Unknown' as a value renders the column essentially meaningless. The correct values should ideally be specific use cases, but since we don't have that information, we can't map to correct values.
    SELECT
        "country",
        "email_bounce_reason",
        "email_bounce_date",
        "owner_id",
        "secondary_email",
        "lead_source",
        "conversion_date",
        "last_modified_date",
        "master_record_id",
        "last_modified_by_id",
        "system_modification_timestamp",
        "geocode_accuracy",
        "converted_contact_id",
        "up_region_c",
        "id",
        "photo_url",
        "state",
        "longitude",
        "last_referenced_date",
        "district",
        "last_activity_date",
        "country_code",
        "phone",
        "marketing_cloud_subscriber",
        CASE
            WHEN "name" = 'h' THEN NULL
            ELSE "name"
        END AS "name",
        "jigsaw_contact_id",
        "lead_source_detail_c",
        "created_by_id",
        "salutation",
        "is_converted",
        "state_code",
        "is_unread_by_owner",
        "lead_status",
        "city",
        "latitude",
        "clearbit_status",
        "industry",
        "job_title",
        "last_viewed_date",
        "converted_opportunity_id",
        "is_deleted",
        "street",
        CASE
            WHEN "company_name" = 'Z' THEN NULL
            ELSE "company_name"
        END AS "company_name",
        "first_name",
        "email_address",
        "website",
        "last_name",
        "number_of_employees",
        "territory",
        "created_date",
        "google_click_id",
        "is_active_in_sequence",
        "postal_code",
        "is_clearbit_ready",
        "has_opted_out_of_email",
        "converted_salesforce_account_id",
        "mobile_phone",
        "is_calendly_created",
        "associated_account",
        "connector_status",
        "data_warehouses_used",
        "bi_tools_used",
        "competitors_considered",
        "annual_revenue",
        "connector_products_interest",
        "primary_contact",
        "data_warehouse_products_interest",
        "notes_c",
        "decision_timeframe",
        "account_products",
        "account_bi_tools",
        "account_data_warehouses",
        "opportunity_competitors",
        "opportunity_products",
        "description",
        "referral_account",
        "referral_contact",
        "volume_millions",
        "feature_requests",
        "lead_number_c",
        "demo_scheduled_calendly",
        "flagged_for_deletion",
        "email_bounced",
        CASE
            WHEN "email_quality_score" = '0' THEN NULL
            ELSE "email_quality_score"
        END AS "email_quality_score",
        "email_quality_catchall",
        "previous_lead_source",
        "email_bounce_status",
        "previous_lead_source_details",
        "utm_medium_c",
        "utm_source_c",
        "utm_campaign_c",
        "utm_content_c",
        "utm_term_c",
        "acton_lead_score",
        "created_by_clearbit",
        "fivetran_user_id",
        "acton_geo_state",
        "acton_country",
        "acton_city",
        "acton_country_code",
        "acton_postal_code",
        "acton_referrer",
        "acton_state",
        "geo_city",
        "geo_country",
        "geo_country_code",
        "geo_postal_code",
        "geo_state",
        "company_type",
        "pardot_campaign",
        "pardot_comments",
        "pardot_conversion_date",
        "pardot_conversion_object_name",
        "pardot_conversion_object_type",
        "pardot_created_date",
        "pardot_first_activity",
        "pardot_first_search_term",
        "pardot_first_search_type",
        "pardot_first_touch_url",
        "pardot_grade",
        "pi_last_activity_c",
        "score_sync_needed",
        "pi_notes_c",
        "pardot_hard_bounced",
        "pardot_last_scored_date",
        "pi_score_c",
        "lead_url",
        "pi_utm_campaign_c",
        "pi_utm_content_c",
        "pi_utm_medium_c",
        "pi_utm_source_c",
        "pi_utm_term_c",
        "fax",
        "region_c",
        "is_competitor",
        "source_detail_c",
        "fivetran_account_stage",
        "fivetran_account_id",
        "leandata_router_status",
        "leandata_matched_lead",
        "leandata_routing_action",
        CASE
            WHEN "leandata_search_index" = 'geomecyvdvhj amazon' THEN NULL
            ELSE "leandata_search_index"
        END AS "leandata_search_index",
        "leandata_matched_account_id",
        "leandata_reporting_timestamp",
        "leandata_segment",
        "marketing_system_creation_date",
        "leandata_matched_account",
        "leandata_a2b_account",
        "leandata_search",
        "leandata_routing_status",
        "leandata_a2b_group",
        "buyer_persona",
        "leandata_tag",
        "leandata_status_info",
        "leandata_modified_score",
        "do_not_route_lead",
        "partner_type",
        "allbound_id",
        "linkedin_company_id",
        "linkedin_member_token",
        "leandata_reroute",
        "salesloft_next_step_due_date",
        "salesloft_last_completed_step",
        "salesloft_recent_cadence_name",
        "network",
        "match_type",
        "device",
        "creative_id",
        "ad_group_id",
        "keyword",
        "campaign_id",
        "partner_rep_email",
        "partner_rep_name",
        "lead_type",
        "contact_stage",
        "original_utm_campaign_c",
        "original_utm_content_c",
        "original_utm_medium_c",
        "original_utm_source_c",
        "original_utm_term_c",
        "alexa_rank",
        "target_audience",
        "es_app_escity_c",
        "company_phone",
        "es_app_escountry_c",
        "lead_creation_time",
        "company_id",
        "es_app_esemployees_c",
        "is_enriched",
        "enrichment_time",
        "facebook_url",
        "es_app_esindustry_c",
        "intent_score",
        "intent_update_time",
        "intent_topics",
        "company_keywords",
        "es_app_eslinked_in_c",
        "fit_score",
        "es_app_esrevenue_c",
        "es_app_essource_c",
        "es_app_esstate_c",
        "es_app_esstreet_c",
        "tech_stack",
        "twitter_handle",
        "zipcode",
        "prospect_routing_rules",
        "individual_id",
        "marketing_stage",
        "automation_tracking",
        "job_change_flag",
        "linkedin_profile_url",
        "email_opt_in",
        "explicit_email_opt_in",
        "implicit_email_opt_in",
        "gdpr_consent",
        "is_user_gem",
        "past_account",
        "past_company",
        "past_contact",
        "past_job_title",
        "promotion_id",
        "is_previous_customer",
        "referral_email",
        "referral_first_name",
        "referral_last_name",
        "mkto_71_lead_score_c",
        "acquisition_date",
        "acquisition_program_id",
        "acquisition_program_name",
        "inferred_city",
        "inferred_company",
        "inferred_country",
        "inferred_metro_area",
        "inferred_phone_area_code",
        "inferred_postal_code",
        "inferred_state_region",
        "original_referrer_url",
        "original_search_engine",
        "original_search_phrase",
        "original_source_info",
        "original_source_type",
        "hide_date",
        "last_interesting_moment_date",
        "last_interesting_moment_description",
        "last_interesting_moment_source",
        "last_interesting_moment_type",
        "contact_id",
        "lead_priority",
        "relative_score",
        "urgency_value",
        "cloudingo_agent_ar",
        "cloudingo_agent_ardi",
        "cloudingo_agent_as",
        "cloudingo_agent_atz",
        "cloudingo_agent_av",
        "cloudingo_agent_les",
        "do_not_sync_marketo",
        "all_utm_campaigns",
        "all_utm_content",
        "all_utm_mediums",
        "all_utm_sources",
        "all_utm_terms",
        "first_utm_campaign",
        "first_utm_content",
        "first_utm_medium",
        "first_utm_source",
        "first_utm_term",
        "last_utm_campaign",
        "last_utm_content",
        "last_utm_medium",
        "last_utm_source",
        "last_utm_term",
        "direct_office",
        "city_c",
        "country_c",
        "state_c",
        "first_lead_source_category",
        "last_lead_source",
        "last_lead_source_category",
        "last_lead_source_detail",
        "all_lead_sources",
        "all_lead_source_categories",
        "all_lead_source_details",
        "first_lead_source",
        "first_lead_source_detail",
        "behavioral_score",
        "demographic_score",
        "drift_cql_status",
        "unique_email",
        "is_emea_event_routing",
        "csi_code",
        "csi_description",
        "conversion_datetime",
        "lead_creation_datetime",
        "leadiq_country",
        "leadiq_employee_count",
        "leadiq_employee_range",
        "leadiq_state",
        "leadiq_zip_code",
        "zoominfo_country",
        "zoominfo_employee_count_c",
        "zoominfo_state_c",
        "company_technologies",
        "zip_code",
        CASE
            WHEN "event_attendance" = '0' THEN NULL
            ELSE "event_attendance"
        END AS "event_attendance",
        "mql_date",
        "user_gems_id",
        "zoominfo_company_id",
        "zoominfo_first_updated",
        "zoominfo_id",
        "zoominfo_last_updated",
        "manual_route_trigger",
        "first_mql_date",
        "fivetran_association_date",
        "fivetran_user_roles",
        "mql_reason",
        "trial_start_date",
        "enrichment_requested",
        "metadata_creation_date",
        "clarus_date",
        "clarus_editor",
        "clarus_notes",
        "clarus_project",
        "clarus_status",
        "marketing_connector_interest",
        "recent_campaign_status",
        "salesloft_cadence_trigger",
        "datawarehouse_usage",
        "contact_status",
        "leandata_owner_override",
        CASE
            WHEN "fivetran_use_case" = 'Unknown' THEN NULL
            ELSE "fivetran_use_case"
        END AS "fivetran_use_case",
        "bizible_account",
        "ad_campaign_name_first_touch",
        "ad_campaign_name_last_touch",
        "bizible_id",
        "landing_page_first_touch",
        "landing_page_last_touch",
        "marketing_channel_first_touch",
        "marketing_channel_last_touch",
        "touchpoint_date_first_touch",
        "touchpoint_date_last_touch",
        "touchpoint_source_first_touch",
        "touchpoint_source_last_touch",
        "sales_email_opt_out",
        "sales_email_opt_out_datetime",
        "bombora_surge_record_count",
        "bombora_last_updated",
        "bombora_composite_score",
        "linked_in_url_c",
        "beta_connector_interest",
        "user_gems_past_info",
        "user_gems_current_info",
        "created_by_user_gems",
        "free_trial_email_confirmed_date",
        "dnb_contact_record",
        "dnb_company_record",
        "duns_number",
        "isell_os_key_id",
        "verified",
        "email_opt_out_datetime",
        "is_startup",
        "startup_eligibility_certified",
        "intent_minutes_30d",
        "engagement_minutes_3m",
        "engagement_minutes_7d",
        "engagio_account_matched",
        "first_engagement_date",
        "engagio_match_time",
        "department",
        "role",
        "legacy_hvr_id",
        "hvr_channel",
        "email_double_opt_in",
        "phone_number",
        "domain_exists",
        "utm_id",
        "all_utm_ids",
        "last_utm_id",
        "first_utm_id",
        "marketo_sync_block_reason",
        "is_fivetran_active"
    FROM "sf_lead_data_projected_renamed"
),

"sf_lead_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_bi_tools: from FLOAT to VARCHAR
    -- account_data_warehouses: from FLOAT to VARCHAR
    -- account_products: from FLOAT to VARCHAR
    -- acquisition_date: from FLOAT to DATE
    -- acquisition_program_id: from FLOAT to VARCHAR
    -- acquisition_program_name: from FLOAT to VARCHAR
    -- acton_city: from FLOAT to VARCHAR
    -- acton_country: from FLOAT to VARCHAR
    -- acton_country_code: from FLOAT to VARCHAR
    -- acton_geo_state: from FLOAT to VARCHAR
    -- acton_lead_score: from FLOAT to INT
    -- acton_postal_code: from FLOAT to VARCHAR
    -- acton_referrer: from FLOAT to VARCHAR
    -- acton_state: from FLOAT to VARCHAR
    -- ad_campaign_name_first_touch: from FLOAT to VARCHAR
    -- ad_campaign_name_last_touch: from FLOAT to VARCHAR
    -- ad_group_id: from FLOAT to VARCHAR
    -- alexa_rank: from FLOAT to INT
    -- all_lead_source_categories: from FLOAT to VARCHAR
    -- all_lead_source_details: from FLOAT to VARCHAR
    -- all_lead_sources: from FLOAT to VARCHAR
    -- all_utm_campaigns: from FLOAT to VARCHAR
    -- all_utm_content: from FLOAT to VARCHAR
    -- all_utm_ids: from FLOAT to VARCHAR
    -- all_utm_mediums: from FLOAT to VARCHAR
    -- all_utm_sources: from FLOAT to VARCHAR
    -- all_utm_terms: from FLOAT to VARCHAR
    -- allbound_id: from FLOAT to VARCHAR
    -- annual_revenue: from INT to DECIMAL
    -- associated_account: from FLOAT to VARCHAR
    -- automation_tracking: from FLOAT to VARCHAR
    -- beta_connector_interest: from FLOAT to BOOLEAN
    -- bi_tools_used: from FLOAT to VARCHAR
    -- bizible_account: from FLOAT to VARCHAR
    -- bizible_id: from FLOAT to UNIQUEIDENTIFIER
    -- bombora_composite_score: from FLOAT to DECIMAL
    -- bombora_last_updated: from FLOAT to DATETIME
    -- bombora_surge_record_count: from FLOAT to INT
    -- buyer_persona: from FLOAT to VARCHAR
    -- campaign_id: from FLOAT to VARCHAR
    -- city: from FLOAT to VARCHAR
    -- city_c: from FLOAT to VARCHAR
    -- clarus_date: from FLOAT to DATE
    -- clarus_editor: from FLOAT to VARCHAR
    -- clarus_notes: from FLOAT to VARCHAR
    -- clarus_project: from FLOAT to VARCHAR
    -- clarus_status: from FLOAT to VARCHAR
    -- clearbit_status: from FLOAT to VARCHAR
    -- cloudingo_agent_ar: from FLOAT to VARCHAR
    -- cloudingo_agent_ardi: from FLOAT to VARCHAR
    -- cloudingo_agent_atz: from FLOAT to VARCHAR
    -- cloudingo_agent_av: from FLOAT to VARCHAR
    -- company_id: from FLOAT to UNIQUEIDENTIFIER
    -- company_keywords: from FLOAT to VARCHAR
    -- company_phone: from FLOAT to VARCHAR
    -- company_technologies: from FLOAT to VARCHAR
    -- company_type: from FLOAT to VARCHAR
    -- competitors_considered: from FLOAT to VARCHAR
    -- connector_products_interest: from FLOAT to VARCHAR
    -- connector_status: from FLOAT to VARCHAR
    -- contact_id: from FLOAT to VARCHAR
    -- contact_status: from FLOAT to VARCHAR
    -- conversion_date: from VARCHAR to DATETIME
    -- conversion_datetime: from VARCHAR to DATETIME
    -- converted_opportunity_id: from FLOAT to VARCHAR
    -- country: from FLOAT to VARCHAR
    -- country_c: from FLOAT to VARCHAR
    -- country_code: from FLOAT to VARCHAR
    -- created_by_clearbit: from VARCHAR to BOOLEAN
    -- created_by_user_gems: from VARCHAR to BOOLEAN
    -- created_date: from VARCHAR to DATETIME
    -- creative_id: from FLOAT to VARCHAR
    -- csi_code: from FLOAT to VARCHAR
    -- data_warehouse_products_interest: from FLOAT to VARCHAR
    -- data_warehouses_used: from FLOAT to VARCHAR
    -- datawarehouse_usage: from FLOAT to VARCHAR
    -- decision_timeframe: from FLOAT to VARCHAR
    -- demo_scheduled_calendly: from VARCHAR to BOOLEAN
    -- demographic_score: from FLOAT to DECIMAL
    -- department: from FLOAT to VARCHAR
    -- description: from FLOAT to VARCHAR
    -- device: from FLOAT to VARCHAR
    -- direct_office: from FLOAT to VARCHAR
    -- district: from FLOAT to VARCHAR
    -- dnb_company_record: from FLOAT to VARCHAR
    -- dnb_contact_record: from FLOAT to VARCHAR
    -- do_not_route_lead: from VARCHAR to BOOLEAN
    -- do_not_sync_marketo: from VARCHAR to BOOLEAN
    -- domain_exists: from FLOAT to BOOLEAN
    -- drift_cql_status: from FLOAT to VARCHAR
    -- duns_number: from FLOAT to VARCHAR
    -- email_bounce_date: from FLOAT to DATE
    -- email_bounce_reason: from FLOAT to VARCHAR
    -- email_bounce_status: from VARCHAR to BOOLEAN
    -- email_bounced: from FLOAT to BOOLEAN
    -- email_double_opt_in: from VARCHAR to BOOLEAN
    -- email_opt_in: from FLOAT to BOOLEAN
    -- email_opt_out_datetime: from FLOAT to DATETIME
    -- email_quality_catchall: from FLOAT to VARCHAR
    -- email_quality_score: from VARCHAR to INT
    -- engagement_minutes_3m: from FLOAT to INT
    -- engagement_minutes_7d: from FLOAT to INT
    -- engagio_account_matched: from FLOAT to BOOLEAN
    -- engagio_match_time: from FLOAT to DATETIME
    -- enrichment_requested: from VARCHAR to BOOLEAN
    -- enrichment_time: from FLOAT to DATETIME
    -- es_app_escity_c: from FLOAT to VARCHAR
    -- es_app_escountry_c: from FLOAT to VARCHAR
    -- es_app_esemployees_c: from FLOAT to INT
    -- es_app_esindustry_c: from FLOAT to VARCHAR
    -- es_app_eslinked_in_c: from FLOAT to VARCHAR
    -- es_app_esrevenue_c: from FLOAT to VARCHAR
    -- es_app_essource_c: from FLOAT to VARCHAR
    -- es_app_esstate_c: from FLOAT to VARCHAR
    -- es_app_esstreet_c: from FLOAT to VARCHAR
    -- event_attendance: from VARCHAR to BOOLEAN
    -- explicit_email_opt_in: from VARCHAR to BOOLEAN
    -- facebook_url: from FLOAT to VARCHAR
    -- fax: from FLOAT to VARCHAR
    -- feature_requests: from FLOAT to VARCHAR
    -- first_engagement_date: from FLOAT to DATE
    -- first_lead_source: from FLOAT to VARCHAR
    -- first_lead_source_category: from FLOAT to VARCHAR
    -- first_lead_source_detail: from FLOAT to VARCHAR
    -- first_mql_date: from FLOAT to DATE
    -- first_utm_campaign: from FLOAT to VARCHAR
    -- first_utm_content: from FLOAT to VARCHAR
    -- first_utm_id: from FLOAT to VARCHAR
    -- first_utm_medium: from FLOAT to VARCHAR
    -- first_utm_source: from FLOAT to VARCHAR
    -- first_utm_term: from FLOAT to VARCHAR
    -- fit_score: from FLOAT to DECIMAL
    -- fivetran_account_id: from FLOAT to VARCHAR
    -- fivetran_account_stage: from FLOAT to VARCHAR
    -- fivetran_association_date: from FLOAT to DATE
    -- fivetran_user_id: from FLOAT to VARCHAR
    -- fivetran_user_roles: from FLOAT to VARCHAR
    -- flagged_for_deletion: from VARCHAR to BOOLEAN
    -- free_trial_email_confirmed_date: from FLOAT to DATETIME
    -- gdpr_consent: from VARCHAR to BOOLEAN
    -- geo_city: from FLOAT to VARCHAR
    -- geo_country: from FLOAT to VARCHAR
    -- geo_country_code: from FLOAT to VARCHAR
    -- geo_postal_code: from FLOAT to VARCHAR
    -- geo_state: from FLOAT to VARCHAR
    -- geocode_accuracy: from FLOAT to VARCHAR
    -- google_click_id: from FLOAT to VARCHAR
    -- has_opted_out_of_email: from VARCHAR to BOOLEAN
    -- hide_date: from FLOAT to DATE
    -- hvr_channel: from FLOAT to VARCHAR
    -- implicit_email_opt_in: from VARCHAR to BOOLEAN
    -- individual_id: from FLOAT to VARCHAR
    -- inferred_city: from FLOAT to VARCHAR
    -- inferred_company: from FLOAT to VARCHAR
    -- inferred_country: from FLOAT to VARCHAR
    -- inferred_metro_area: from FLOAT to VARCHAR
    -- inferred_phone_area_code: from FLOAT to VARCHAR
    -- inferred_postal_code: from FLOAT to VARCHAR
    -- inferred_state_region: from FLOAT to VARCHAR
    -- intent_minutes_30d: from FLOAT to INT
    -- intent_score: from FLOAT to DECIMAL
    -- intent_topics: from FLOAT to VARCHAR
    -- intent_update_time: from FLOAT to DATETIME
    -- is_active_in_sequence: from VARCHAR to BOOLEAN
    -- is_calendly_created: from FLOAT to BOOLEAN
    -- is_clearbit_ready: from VARCHAR to BOOLEAN
    -- is_competitor: from VARCHAR to BOOLEAN
    -- is_converted: from VARCHAR to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_emea_event_routing: from VARCHAR to BOOLEAN
    -- is_enriched: from FLOAT to BOOLEAN
    -- is_fivetran_active: from FLOAT to BOOLEAN
    -- is_previous_customer: from FLOAT to BOOLEAN
    -- is_startup: from FLOAT to BOOLEAN
    -- is_unread_by_owner: from VARCHAR to BOOLEAN
    -- is_user_gem: from VARCHAR to BOOLEAN
    -- isell_os_key_id: from FLOAT to VARCHAR
    -- jigsaw_contact_id: from FLOAT to VARCHAR
    -- job_change_flag: from FLOAT to BOOLEAN
    -- job_title: from FLOAT to VARCHAR
    -- keyword: from FLOAT to VARCHAR
    -- landing_page_first_touch: from FLOAT to VARCHAR
    -- landing_page_last_touch: from FLOAT to VARCHAR
    -- last_activity_date: from FLOAT to DATETIME
    -- last_interesting_moment_date: from VARCHAR to DATETIME
    -- last_lead_source: from FLOAT to VARCHAR
    -- last_lead_source_category: from FLOAT to VARCHAR
    -- last_lead_source_detail: from FLOAT to VARCHAR
    -- last_modified_date: from VARCHAR to DATETIME
    -- last_referenced_date: from FLOAT to DATETIME
    -- last_utm_id: from FLOAT to VARCHAR
    -- last_viewed_date: from FLOAT to DATE
    -- latitude: from FLOAT to DECIMAL
    -- lead_creation_datetime: from VARCHAR to DATETIME
    -- lead_creation_time: from FLOAT to TIME
    -- lead_number_c: from INT to VARCHAR
    -- lead_source: from FLOAT to VARCHAR
    -- lead_source_detail_c: from FLOAT to VARCHAR
    -- lead_type: from FLOAT to VARCHAR
    -- lead_url: from FLOAT to VARCHAR
    -- leadiq_country: from FLOAT to VARCHAR
    -- leadiq_employee_count: from FLOAT to INT
    -- leadiq_employee_range: from FLOAT to VARCHAR
    -- leadiq_state: from FLOAT to VARCHAR
    -- leadiq_zip_code: from FLOAT to VARCHAR
    -- leandata_a2b_account: from FLOAT to VARCHAR
    -- leandata_a2b_group: from FLOAT to VARCHAR
    -- leandata_matched_account: from FLOAT to VARCHAR
    -- leandata_matched_lead: from FLOAT to BOOLEAN
    -- leandata_modified_score: from FLOAT to DECIMAL
    -- leandata_owner_override: from FLOAT to VARCHAR
    -- leandata_reporting_timestamp: from VARCHAR to DATETIME
    -- leandata_reroute: from FLOAT to BOOLEAN
    -- leandata_router_status: from FLOAT to VARCHAR
    -- leandata_search: from FLOAT to VARCHAR
    -- leandata_segment: from FLOAT to VARCHAR
    -- leandata_status_info: from FLOAT to VARCHAR
    -- leandata_tag: from FLOAT to VARCHAR
    -- legacy_hvr_id: from FLOAT to VARCHAR
    -- linked_in_url_c: from FLOAT to VARCHAR
    -- linkedin_company_id: from FLOAT to VARCHAR
    -- linkedin_member_token: from FLOAT to VARCHAR
    -- linkedin_profile_url: from FLOAT to VARCHAR
    -- longitude: from FLOAT to DECIMAL
    -- manual_route_trigger: from VARCHAR to BOOLEAN
    -- marketing_channel_first_touch: from FLOAT to VARCHAR
    -- marketing_channel_last_touch: from FLOAT to VARCHAR
    -- marketing_cloud_subscriber: from FLOAT to VARCHAR
    -- marketing_connector_interest: from FLOAT to VARCHAR
    -- marketing_stage: from FLOAT to VARCHAR
    -- marketing_system_creation_date: from FLOAT to DATETIME
    -- marketo_sync_block_reason: from FLOAT to VARCHAR
    -- master_record_id: from FLOAT to VARCHAR
    -- match_type: from FLOAT to VARCHAR
    -- metadata_creation_date: from VARCHAR to DATETIME
    -- mkto_71_lead_score_c: from FLOAT to VARCHAR
    -- mobile_phone: from FLOAT to VARCHAR
    -- mql_date: from FLOAT to DATE
    -- network: from FLOAT to VARCHAR
    -- notes_c: from FLOAT to VARCHAR
    -- number_of_employees: from FLOAT to INT
    -- opportunity_competitors: from FLOAT to VARCHAR
    -- opportunity_products: from FLOAT to VARCHAR
    -- original_referrer_url: from FLOAT to VARCHAR
    -- original_search_engine: from FLOAT to VARCHAR
    -- original_search_phrase: from FLOAT to VARCHAR
    -- original_source_info: from FLOAT to VARCHAR
    -- original_source_type: from FLOAT to VARCHAR
    -- original_utm_campaign_c: from FLOAT to VARCHAR
    -- original_utm_content_c: from FLOAT to VARCHAR
    -- original_utm_medium_c: from FLOAT to VARCHAR
    -- original_utm_source_c: from FLOAT to VARCHAR
    -- original_utm_term_c: from FLOAT to VARCHAR
    -- owner_id: from VARCHAR to UNIQUEIDENTIFIER
    -- pardot_campaign: from FLOAT to VARCHAR
    -- pardot_comments: from FLOAT to VARCHAR
    -- pardot_conversion_date: from FLOAT to DATETIME
    -- pardot_conversion_object_name: from FLOAT to VARCHAR
    -- pardot_conversion_object_type: from FLOAT to VARCHAR
    -- pardot_created_date: from FLOAT to DATETIME
    -- pardot_first_activity: from FLOAT to VARCHAR
    -- pardot_first_search_term: from FLOAT to VARCHAR
    -- pardot_first_search_type: from FLOAT to VARCHAR
    -- pardot_first_touch_url: from FLOAT to VARCHAR
    -- pardot_grade: from FLOAT to VARCHAR
    -- pardot_hard_bounced: from FLOAT to BOOLEAN
    -- pardot_last_scored_date: from FLOAT to DATETIME
    -- partner_rep_email: from FLOAT to VARCHAR
    -- partner_rep_name: from FLOAT to VARCHAR
    -- partner_type: from FLOAT to VARCHAR
    -- past_account: from FLOAT to VARCHAR
    -- past_company: from FLOAT to VARCHAR
    -- past_contact: from FLOAT to VARCHAR
    -- past_job_title: from FLOAT to VARCHAR
    -- phone: from FLOAT to VARCHAR
    -- phone_number: from FLOAT to VARCHAR
    -- pi_last_activity_c: from FLOAT to VARCHAR
    -- pi_notes_c: from FLOAT to VARCHAR
    -- pi_score_c: from FLOAT to VARCHAR
    -- pi_utm_campaign_c: from FLOAT to VARCHAR
    -- pi_utm_content_c: from FLOAT to VARCHAR
    -- pi_utm_medium_c: from FLOAT to VARCHAR
    -- pi_utm_source_c: from FLOAT to VARCHAR
    -- pi_utm_term_c: from FLOAT to VARCHAR
    -- postal_code: from FLOAT to VARCHAR
    -- previous_lead_source: from FLOAT to VARCHAR
    -- previous_lead_source_details: from FLOAT to VARCHAR
    -- primary_contact: from FLOAT to VARCHAR
    -- promotion_id: from FLOAT to VARCHAR
    -- recent_campaign_status: from FLOAT to VARCHAR
    -- referral_account: from FLOAT to VARCHAR
    -- referral_contact: from FLOAT to VARCHAR
    -- referral_email: from FLOAT to VARCHAR
    -- referral_first_name: from FLOAT to VARCHAR
    -- referral_last_name: from FLOAT to VARCHAR
    -- region_c: from FLOAT to VARCHAR
    -- relative_score: from FLOAT to DECIMAL
    -- role: from FLOAT to VARCHAR
    -- sales_email_opt_out: from VARCHAR to BOOLEAN
    -- sales_email_opt_out_datetime: from FLOAT to DATETIME
    -- salesloft_cadence_trigger: from FLOAT to VARCHAR
    -- salesloft_last_completed_step: from FLOAT to VARCHAR
    -- salesloft_next_step_due_date: from FLOAT to DATE
    -- salesloft_recent_cadence_name: from FLOAT to VARCHAR
    -- salutation: from FLOAT to VARCHAR
    -- score_sync_needed: from FLOAT to BOOLEAN
    -- secondary_email: from FLOAT to VARCHAR
    -- source_detail_c: from FLOAT to VARCHAR
    -- startup_eligibility_certified: from VARCHAR to BOOLEAN
    -- state: from FLOAT to VARCHAR
    -- state_c: from FLOAT to VARCHAR
    -- state_code: from FLOAT to VARCHAR
    -- street: from FLOAT to VARCHAR
    -- system_modification_timestamp: from VARCHAR to DATETIME
    -- target_audience: from FLOAT to VARCHAR
    -- tech_stack: from FLOAT to VARCHAR
    -- territory: from FLOAT to VARCHAR
    -- touchpoint_date_first_touch: from FLOAT to DATE
    -- touchpoint_date_last_touch: from FLOAT to DATE
    -- touchpoint_source_first_touch: from FLOAT to VARCHAR
    -- touchpoint_source_last_touch: from FLOAT to VARCHAR
    -- trial_start_date: from FLOAT to DATE
    -- twitter_handle: from FLOAT to VARCHAR
    -- unique_email: from FLOAT to VARCHAR
    -- up_region_c: from FLOAT to VARCHAR
    -- user_gems_current_info: from FLOAT to VARCHAR
    -- user_gems_id: from FLOAT to VARCHAR
    -- user_gems_past_info: from FLOAT to VARCHAR
    -- utm_campaign_c: from FLOAT to VARCHAR
    -- utm_content_c: from FLOAT to VARCHAR
    -- utm_id: from FLOAT to VARCHAR
    -- utm_medium_c: from FLOAT to VARCHAR
    -- utm_source_c: from FLOAT to VARCHAR
    -- utm_term_c: from FLOAT to VARCHAR
    -- verified: from VARCHAR to BOOLEAN
    -- volume_millions: from INT to DECIMAL
    -- website: from FLOAT to VARCHAR
    -- zip_code: from FLOAT to VARCHAR
    -- zipcode: from FLOAT to VARCHAR
    -- zoominfo_company_id: from FLOAT to VARCHAR
    -- zoominfo_country: from FLOAT to VARCHAR
    -- zoominfo_employee_count_c: from FLOAT to INT
    -- zoominfo_first_updated: from FLOAT to DATETIME
    -- zoominfo_id: from FLOAT to VARCHAR
    -- zoominfo_last_updated: from FLOAT to DATETIME
    -- zoominfo_state_c: from FLOAT to VARCHAR
    SELECT
        "last_modified_by_id",
        "converted_contact_id",
        "id",
        "photo_url",
        "name",
        "created_by_id",
        "lead_status",
        "industry",
        "company_name",
        "first_name",
        "email_address",
        "last_name",
        "converted_salesforce_account_id",
        "leandata_routing_action",
        "leandata_search_index",
        "leandata_matched_account_id",
        "leandata_routing_status",
        "contact_stage",
        "prospect_routing_rules",
        "last_interesting_moment_description",
        "last_interesting_moment_source",
        "last_interesting_moment_type",
        "lead_priority",
        "urgency_value",
        "cloudingo_agent_as",
        "cloudingo_agent_les",
        "last_utm_campaign",
        "last_utm_content",
        "last_utm_medium",
        "last_utm_source",
        "last_utm_term",
        "behavioral_score",
        "csi_description",
        "mql_reason",
        "fivetran_use_case",
        CAST("account_bi_tools" AS VARCHAR) 
        AS "account_bi_tools",
        CAST("account_data_warehouses" AS VARCHAR) 
        AS "account_data_warehouses",
        CAST("account_products" AS VARCHAR) 
        AS "account_products",
        CAST(DATEADD(DAY, FLOOR("acquisition_date"), '1900-01-01') AS DATE) 
        AS "acquisition_date",
        CAST("acquisition_program_id" AS VARCHAR) 
        AS "acquisition_program_id",
        CAST("acquisition_program_name" AS VARCHAR) 
        AS "acquisition_program_name",
        CAST("acton_city" AS VARCHAR) 
        AS "acton_city",
        CAST("acton_country" AS VARCHAR) 
        AS "acton_country",
        CAST("acton_country_code" AS VARCHAR) 
        AS "acton_country_code",
        CAST("acton_geo_state" AS VARCHAR) 
        AS "acton_geo_state",
        CAST("acton_lead_score" AS INT) 
        AS "acton_lead_score",
        CAST("acton_postal_code" AS VARCHAR) 
        AS "acton_postal_code",
        CAST("acton_referrer" AS VARCHAR(255)) 
        AS "acton_referrer",
        CAST("acton_state" AS VARCHAR) 
        AS "acton_state",
        CAST("ad_campaign_name_first_touch" AS VARCHAR) 
        AS "ad_campaign_name_first_touch",
        CAST("ad_campaign_name_last_touch" AS VARCHAR(255)) 
        AS "ad_campaign_name_last_touch",
        CAST("ad_group_id" AS VARCHAR) 
        AS "ad_group_id",
        CAST("alexa_rank" AS INT) 
        AS "alexa_rank",
        CAST("all_lead_source_categories" AS VARCHAR) 
        AS "all_lead_source_categories",
        CAST("all_lead_source_details" AS VARCHAR) 
        AS "all_lead_source_details",
        CAST("all_lead_sources" AS VARCHAR) 
        AS "all_lead_sources",
        CAST("all_utm_campaigns" AS VARCHAR) 
        AS "all_utm_campaigns",
        CAST("all_utm_content" AS VARCHAR) 
        AS "all_utm_content",
        CAST("all_utm_ids" AS VARCHAR) 
        AS "all_utm_ids",
        CAST("all_utm_mediums" AS VARCHAR) 
        AS "all_utm_mediums",
        CAST("all_utm_sources" AS VARCHAR) 
        AS "all_utm_sources",
        CAST("all_utm_terms" AS VARCHAR) 
        AS "all_utm_terms",
        CAST("allbound_id" AS VARCHAR) 
        AS "allbound_id",
        CAST("annual_revenue" AS DECIMAL) 
        AS "annual_revenue",
        CAST("associated_account" AS VARCHAR) 
        AS "associated_account",
        CAST("automation_tracking" AS VARCHAR) 
        AS "automation_tracking",
        CAST("beta_connector_interest" AS BIT) 
        AS "beta_connector_interest",
        CAST("bi_tools_used" AS VARCHAR) 
        AS "bi_tools_used",
        CAST("bizible_account" AS VARCHAR) 
        AS "bizible_account",
        CASE 
            WHEN "bizible_id" IS NOT NULL AND TRY_CONVERT(UNIQUEIDENTIFIER, CONVERT(VARCHAR(36), "bizible_id")) IS NOT NULL 
            THEN TRY_CONVERT(UNIQUEIDENTIFIER, CONVERT(VARCHAR(36), "bizible_id"))
            ELSE NULL 
        END 
        AS "bizible_id",
        CAST("bombora_composite_score" AS DECIMAL) 
        AS "bombora_composite_score",
        CAST(DATEADD(DAY, CAST("bombora_last_updated" AS INT), '1900-01-01') AS DATETIME) 
        AS "bombora_last_updated",
        CAST("bombora_surge_record_count" AS INT) 
        AS "bombora_surge_record_count",
        CAST("buyer_persona" AS VARCHAR) 
        AS "buyer_persona",
        CAST("campaign_id" AS VARCHAR) 
        AS "campaign_id",
        CAST("city" AS VARCHAR) 
        AS "city",
        CAST("city_c" AS VARCHAR) 
        AS "city_c",
        CAST(DATEADD(day, CAST("clarus_date" AS INT), '1900-01-01') AS DATE) 
        AS "clarus_date",
        CAST("clarus_editor" AS VARCHAR) 
        AS "clarus_editor",
        CAST("clarus_notes" AS VARCHAR) 
        AS "clarus_notes",
        CAST("clarus_project" AS VARCHAR) 
        AS "clarus_project",
        CAST("clarus_status" AS VARCHAR) 
        AS "clarus_status",
        CAST("clearbit_status" AS VARCHAR) 
        AS "clearbit_status",
        CAST("cloudingo_agent_ar" AS VARCHAR) 
        AS "cloudingo_agent_ar",
        CAST("cloudingo_agent_ardi" AS VARCHAR) 
        AS "cloudingo_agent_ardi",
        CAST("cloudingo_agent_atz" AS VARCHAR) 
        AS "cloudingo_agent_atz",
        CAST("cloudingo_agent_av" AS VARCHAR) 
        AS "cloudingo_agent_av",
        CONVERT(UNIQUEIDENTIFIER, NULLIF(LTRIM(RTRIM("company_id")), ''), 2) 
        AS "company_id",
        CAST("company_keywords" AS VARCHAR) 
        AS "company_keywords",
        CAST("company_phone" AS VARCHAR) 
        AS "company_phone",
        CAST("company_technologies" AS VARCHAR) 
        AS "company_technologies",
        CAST("company_type" AS VARCHAR) 
        AS "company_type",
        CAST("competitors_considered" AS VARCHAR) 
        AS "competitors_considered",
        CAST("connector_products_interest" AS VARCHAR) 
        AS "connector_products_interest",
        CAST("connector_status" AS VARCHAR) 
        AS "connector_status",
        CAST("contact_id" AS VARCHAR) 
        AS "contact_id",
        CAST("contact_status" AS VARCHAR) 
        AS "contact_status",
        CAST("conversion_date" AS DATETIME) 
        AS "conversion_date",
        CAST("conversion_datetime" AS DATETIME) 
        AS "conversion_datetime",
        CAST("converted_opportunity_id" AS VARCHAR) 
        AS "converted_opportunity_id",
        CAST("country" AS VARCHAR) 
        AS "country",
        CAST("country_c" AS VARCHAR) 
        AS "country_c",
        CAST("country_code" AS VARCHAR) 
        AS "country_code",
        CAST(CASE WHEN "created_by_clearbit" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "created_by_clearbit",
        CAST(CASE WHEN "created_by_user_gems" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "created_by_user_gems",
        CAST("created_date" AS DATETIME) 
        AS "created_date",
        CAST("creative_id" AS VARCHAR) 
        AS "creative_id",
        CAST("csi_code" AS VARCHAR) 
        AS "csi_code",
        CAST("data_warehouse_products_interest" AS VARCHAR) 
        AS "data_warehouse_products_interest",
        CAST("data_warehouses_used" AS VARCHAR) 
        AS "data_warehouses_used",
        CAST("datawarehouse_usage" AS VARCHAR) 
        AS "datawarehouse_usage",
        CAST("decision_timeframe" AS VARCHAR) 
        AS "decision_timeframe",
        CAST(CASE WHEN "demo_scheduled_calendly" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "demo_scheduled_calendly",
        CAST("demographic_score" AS DECIMAL) 
        AS "demographic_score",
        CAST("department" AS VARCHAR) 
        AS "department",
        CAST("description" AS VARCHAR) 
        AS "description",
        CAST("device" AS VARCHAR) 
        AS "device",
        CAST("direct_office" AS VARCHAR) 
        AS "direct_office",
        CAST("district" AS VARCHAR) 
        AS "district",
        CAST("dnb_company_record" AS VARCHAR) 
        AS "dnb_company_record",
        CAST("dnb_contact_record" AS VARCHAR) 
        AS "dnb_contact_record",
        CAST("do_not_route_lead" AS BIT) 
        AS "do_not_route_lead",
        CAST("do_not_sync_marketo" AS BIT) 
        AS "do_not_sync_marketo",
        CAST("domain_exists" AS BIT) 
        AS "domain_exists",
        CAST("drift_cql_status" AS VARCHAR) 
        AS "drift_cql_status",
        CAST("duns_number" AS VARCHAR) 
        AS "duns_number",
        CAST(DATEADD(day, CAST("email_bounce_date" AS INT), '1900-01-01') AS DATE) 
        AS "email_bounce_date",
        CAST("email_bounce_reason" AS VARCHAR(255)) 
        AS "email_bounce_reason",
        CASE WHEN "email_bounce_status" = '0' THEN 0 ELSE 1 END 
        AS "email_bounce_status",
        CAST("email_bounced" AS BIT) 
        AS "email_bounced",
        CAST("email_double_opt_in" AS BIT) 
        AS "email_double_opt_in",
        CAST("email_opt_in" AS BIT) 
        AS "email_opt_in",
        CAST(CONVERT(VARCHAR(50), "email_opt_out_datetime") AS DATETIME) 
        AS "email_opt_out_datetime",
        CAST("email_quality_catchall" AS VARCHAR) 
        AS "email_quality_catchall",
        CAST("email_quality_score" AS INT) 
        AS "email_quality_score",
        CAST("engagement_minutes_3m" AS INT) 
        AS "engagement_minutes_3m",
        CAST("engagement_minutes_7d" AS INT) 
        AS "engagement_minutes_7d",
        CAST("engagio_account_matched" AS BIT) 
        AS "engagio_account_matched",
        CAST(CAST("engagio_match_time" AS VARCHAR(50)) AS DATETIME) 
        AS "engagio_match_time",
        CAST(CASE WHEN "enrichment_requested" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "enrichment_requested",
        CONVERT(DATETIME, CONVERT(VARCHAR(33), "enrichment_time", 121)) 
        AS "enrichment_time",
        CAST("es_app_escity_c" AS VARCHAR) 
        AS "es_app_escity_c",
        CAST("es_app_escountry_c" AS VARCHAR) 
        AS "es_app_escountry_c",
        CAST("es_app_esemployees_c" AS INT) 
        AS "es_app_esemployees_c",
        CAST("es_app_esindustry_c" AS VARCHAR) 
        AS "es_app_esindustry_c",
        CAST("es_app_eslinked_in_c" AS VARCHAR) 
        AS "es_app_eslinked_in_c",
        CAST("es_app_esrevenue_c" AS VARCHAR) 
        AS "es_app_esrevenue_c",
        CAST("es_app_essource_c" AS VARCHAR) 
        AS "es_app_essource_c",
        CAST("es_app_esstate_c" AS VARCHAR) 
        AS "es_app_esstate_c",
        CAST("es_app_esstreet_c" AS VARCHAR) 
        AS "es_app_esstreet_c",
        CAST("event_attendance" AS BIT) 
        AS "event_attendance",
        CAST("explicit_email_opt_in" AS BIT) 
        AS "explicit_email_opt_in",
        CAST("facebook_url" AS VARCHAR(255)) 
        AS "facebook_url",
        CAST("fax" AS VARCHAR(50)) 
        AS "fax",
        CAST("feature_requests" AS VARCHAR(MAX)) 
        AS "feature_requests",
        CAST(DATEADD(day, CAST("first_engagement_date" AS INT), '1899-12-30') AS DATE) 
        AS "first_engagement_date",
        CAST("first_lead_source" AS VARCHAR) 
        AS "first_lead_source",
        CAST("first_lead_source_category" AS VARCHAR) 
        AS "first_lead_source_category",
        CAST("first_lead_source_detail" AS VARCHAR) 
        AS "first_lead_source_detail",
        CAST(DATEADD(day, CAST("first_mql_date" AS INT) - 2, '1900-01-01') AS DATE) 
        AS "first_mql_date",
        CAST("first_utm_campaign" AS VARCHAR) 
        AS "first_utm_campaign",
        CAST("first_utm_content" AS VARCHAR) 
        AS "first_utm_content",
        CAST("first_utm_id" AS VARCHAR) 
        AS "first_utm_id",
        CAST("first_utm_medium" AS VARCHAR) 
        AS "first_utm_medium",
        CAST("first_utm_source" AS VARCHAR(255)) 
        AS "first_utm_source",
        CAST("first_utm_term" AS VARCHAR) 
        AS "first_utm_term",
        CAST("fit_score" AS DECIMAL) 
        AS "fit_score",
        CAST("fivetran_account_id" AS VARCHAR(MAX)) 
        AS "fivetran_account_id",
        CAST("fivetran_account_stage" AS VARCHAR) 
        AS "fivetran_account_stage",
        CAST(DATEADD(DAY, CAST("fivetran_association_date" AS INT), '1899-12-30') AS DATE) 
        AS "fivetran_association_date",
        CAST("fivetran_user_id" AS VARCHAR(255)) 
        AS "fivetran_user_id",
        CAST("fivetran_user_roles" AS VARCHAR(255)) 
        AS "fivetran_user_roles",
        CAST(CASE WHEN "flagged_for_deletion" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "flagged_for_deletion",
        CONVERT(DATETIME, CONVERT(VARCHAR(50), "free_trial_email_confirmed_date", 121)) 
        AS "free_trial_email_confirmed_date",
        CAST("gdpr_consent" AS BIT) 
        AS "gdpr_consent",
        CAST("geo_city" AS VARCHAR) 
        AS "geo_city",
        CAST("geo_country" AS VARCHAR) 
        AS "geo_country",
        CAST("geo_country_code" AS VARCHAR) 
        AS "geo_country_code",
        CAST("geo_postal_code" AS VARCHAR) 
        AS "geo_postal_code",
        CAST("geo_state" AS VARCHAR) 
        AS "geo_state",
        CAST("geocode_accuracy" AS VARCHAR) 
        AS "geocode_accuracy",
        CAST("google_click_id" AS VARCHAR) 
        AS "google_click_id",
        CAST("has_opted_out_of_email" AS BIT) 
        AS "has_opted_out_of_email",
        "hide_date" 
        AS "hide_date",
        CAST("hvr_channel" AS VARCHAR) 
        AS "hvr_channel",
        CAST(CAST("implicit_email_opt_in" AS INT) AS BIT) 
        AS "implicit_email_opt_in",
        CAST("individual_id" AS VARCHAR) 
        AS "individual_id",
        CAST("inferred_city" AS VARCHAR) 
        AS "inferred_city",
        CAST("inferred_company" AS VARCHAR) 
        AS "inferred_company",
        CAST("inferred_country" AS VARCHAR) 
        AS "inferred_country",
        CAST("inferred_metro_area" AS VARCHAR) 
        AS "inferred_metro_area",
        CAST("inferred_phone_area_code" AS VARCHAR) 
        AS "inferred_phone_area_code",
        CAST("inferred_postal_code" AS VARCHAR) 
        AS "inferred_postal_code",
        CAST("inferred_state_region" AS VARCHAR) 
        AS "inferred_state_region",
        CAST("intent_minutes_30d" AS INT) 
        AS "intent_minutes_30d",
        CAST("intent_score" AS DECIMAL) 
        AS "intent_score",
        CAST("intent_topics" AS VARCHAR) 
        AS "intent_topics",
        CONVERT(DATETIME, CONVERT(VARCHAR(33), "intent_update_time", 121)) 
        AS "intent_update_time",
        CAST("is_active_in_sequence" AS BIT) 
        AS "is_active_in_sequence",
        CAST(CAST("is_calendly_created" AS BIT) AS BIT) 
        AS "is_calendly_created",
        CASE WHEN "is_clearbit_ready" = '0' THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END 
        AS "is_clearbit_ready",
        CAST(CAST("is_competitor" AS INT) AS BIT) 
        AS "is_competitor",
        CAST("is_converted" AS BIT) 
        AS "is_converted",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CASE WHEN "is_emea_event_routing" = '0' THEN 0 ELSE 1 END 
        AS "is_emea_event_routing",
        CAST("is_enriched" AS BIT) 
        AS "is_enriched",
        CAST("is_fivetran_active" AS BIT) 
        AS "is_fivetran_active",
        CAST("is_previous_customer" AS BIT) 
        AS "is_previous_customer",
        CAST("is_startup" AS BIT) 
        AS "is_startup",
        CAST("is_unread_by_owner" AS BIT) 
        AS "is_unread_by_owner",
        CASE WHEN "is_user_gem" = '0' THEN 0 ELSE 1 END 
        AS "is_user_gem",
        CAST("isell_os_key_id" AS VARCHAR) 
        AS "isell_os_key_id",
        CAST("jigsaw_contact_id" AS VARCHAR) 
        AS "jigsaw_contact_id",
        CAST("job_change_flag" AS BIT) 
        AS "job_change_flag",
        CAST("job_title" AS VARCHAR) 
        AS "job_title",
        CAST("keyword" AS VARCHAR) 
        AS "keyword",
        CAST("landing_page_first_touch" AS VARCHAR) 
        AS "landing_page_first_touch",
        CAST("landing_page_last_touch" AS VARCHAR) 
        AS "landing_page_last_touch",
        CAST(CONVERT(VARCHAR(23), "last_activity_date", 121) AS DATETIME) 
        AS "last_activity_date",
        CAST("last_interesting_moment_date" AS DATETIME) 
        AS "last_interesting_moment_date",
        CAST("last_lead_source" AS VARCHAR) 
        AS "last_lead_source",
        CAST("last_lead_source_category" AS VARCHAR) 
        AS "last_lead_source_category",
        CAST("last_lead_source_detail" AS VARCHAR) 
        AS "last_lead_source_detail",
        CAST("last_modified_date" AS DATETIME) 
        AS "last_modified_date",
        CONVERT(DATETIME, CONVERT(VARCHAR(23), "last_referenced_date", 121)) 
        AS "last_referenced_date",
        CAST("last_utm_id" AS VARCHAR) 
        AS "last_utm_id",
        "last_viewed_date" 
        AS "last_viewed_date",
        CAST("latitude" AS DECIMAL(10,8)) 
        AS "latitude",
        CAST("lead_creation_datetime" AS DATETIME) 
        AS "lead_creation_datetime",
        CAST(CAST("lead_creation_time" AS VARCHAR(8)) AS TIME) 
        AS "lead_creation_time",
        CAST("lead_number_c" AS VARCHAR) 
        AS "lead_number_c",
        CAST("lead_source" AS VARCHAR) 
        AS "lead_source",
        CAST("lead_source_detail_c" AS VARCHAR) 
        AS "lead_source_detail_c",
        CAST("lead_type" AS VARCHAR) 
        AS "lead_type",
        CAST("lead_url" AS VARCHAR(MAX)) 
        AS "lead_url",
        CAST("leadiq_country" AS VARCHAR) 
        AS "leadiq_country",
        CAST("leadiq_employee_count" AS INT) 
        AS "leadiq_employee_count",
        CAST("leadiq_employee_range" AS VARCHAR) 
        AS "leadiq_employee_range",
        CAST("leadiq_state" AS VARCHAR) 
        AS "leadiq_state",
        CAST("leadiq_zip_code" AS VARCHAR) 
        AS "leadiq_zip_code",
        CAST("leandata_a2b_account" AS VARCHAR(255)) 
        AS "leandata_a2b_account",
        CAST("leandata_a2b_group" AS VARCHAR) 
        AS "leandata_a2b_group",
        CAST("leandata_matched_account" AS VARCHAR) 
        AS "leandata_matched_account",
        CAST("leandata_matched_lead" AS BIT) 
        AS "leandata_matched_lead",
        CAST("leandata_modified_score" AS DECIMAL) 
        AS "leandata_modified_score",
        CAST("leandata_owner_override" AS VARCHAR) 
        AS "leandata_owner_override",
        CAST("leandata_reporting_timestamp" AS DATETIME) 
        AS "leandata_reporting_timestamp",
        CAST("leandata_reroute" AS BIT) 
        AS "leandata_reroute",
        CAST("leandata_router_status" AS VARCHAR) 
        AS "leandata_router_status",
        CAST("leandata_search" AS VARCHAR) 
        AS "leandata_search",
        CAST("leandata_segment" AS VARCHAR) 
        AS "leandata_segment",
        CAST("leandata_status_info" AS VARCHAR) 
        AS "leandata_status_info",
        CAST("leandata_tag" AS VARCHAR(50)) 
        AS "leandata_tag",
        CAST("legacy_hvr_id" AS VARCHAR) 
        AS "legacy_hvr_id",
        CAST("linked_in_url_c" AS VARCHAR(255)) 
        AS "linked_in_url_c",
        CAST("linkedin_company_id" AS VARCHAR) 
        AS "linkedin_company_id",
        CAST("linkedin_member_token" AS VARCHAR(255)) 
        AS "linkedin_member_token",
        CAST("linkedin_profile_url" AS VARCHAR(MAX)) 
        AS "linkedin_profile_url",
        CAST("longitude" AS DECIMAL(10,7)) 
        AS "longitude",
        CAST("manual_route_trigger" AS BIT) 
        AS "manual_route_trigger",
        CAST("marketing_channel_first_touch" AS VARCHAR) 
        AS "marketing_channel_first_touch",
        CAST("marketing_channel_last_touch" AS VARCHAR) 
        AS "marketing_channel_last_touch",
        CAST("marketing_cloud_subscriber" AS VARCHAR) 
        AS "marketing_cloud_subscriber",
        CAST("marketing_connector_interest" AS VARCHAR) 
        AS "marketing_connector_interest",
        CAST("marketing_stage" AS VARCHAR) 
        AS "marketing_stage",
        CAST(CONVERT(VARCHAR(23), "marketing_system_creation_date", 121) AS DATETIME) 
        AS "marketing_system_creation_date",
        CAST("marketo_sync_block_reason" AS VARCHAR) 
        AS "marketo_sync_block_reason",
        CAST("master_record_id" AS VARCHAR) 
        AS "master_record_id",
        CAST("match_type" AS VARCHAR) 
        AS "match_type",
        CAST("metadata_creation_date" AS DATETIME) 
        AS "metadata_creation_date",
        CAST("mkto_71_lead_score_c" AS VARCHAR) 
        AS "mkto_71_lead_score_c",
        CAST("mobile_phone" AS VARCHAR) 
        AS "mobile_phone",
        CAST(DATEADD(day, CAST("mql_date" AS INT), '1900-01-01') AS DATE) 
        AS "mql_date",
        CAST("network" AS VARCHAR) 
        AS "network",
        CAST("notes_c" AS VARCHAR) 
        AS "notes_c",
        CAST("number_of_employees" AS INT) 
        AS "number_of_employees",
        CAST("opportunity_competitors" AS VARCHAR) 
        AS "opportunity_competitors",
        CAST("opportunity_products" AS VARCHAR) 
        AS "opportunity_products",
        CAST("original_referrer_url" AS VARCHAR(MAX)) 
        AS "original_referrer_url",
        CAST("original_search_engine" AS VARCHAR) 
        AS "original_search_engine",
        CAST("original_search_phrase" AS VARCHAR) 
        AS "original_search_phrase",
        CAST("original_source_info" AS VARCHAR) 
        AS "original_source_info",
        CAST("original_source_type" AS VARCHAR) 
        AS "original_source_type",
        CAST("original_utm_campaign_c" AS VARCHAR) 
        AS "original_utm_campaign_c",
        CAST("original_utm_content_c" AS VARCHAR(255)) 
        AS "original_utm_content_c",
        CAST("original_utm_medium_c" AS VARCHAR) 
        AS "original_utm_medium_c",
        CAST("original_utm_source_c" AS VARCHAR) 
        AS "original_utm_source_c",
        CAST("original_utm_term_c" AS VARCHAR) 
        AS "original_utm_term_c",
        CAST("owner_id" AS VARCHAR(255)) 
        AS "owner_id",
        CAST("pardot_campaign" AS VARCHAR(255)) 
        AS "pardot_campaign",
        CAST("pardot_comments" AS VARCHAR(MAX)) 
        AS "pardot_comments",
        CAST(CAST("pardot_conversion_date" AS VARCHAR(50)) AS DATETIME) 
        AS "pardot_conversion_date",
        CAST("pardot_conversion_object_name" AS VARCHAR) 
        AS "pardot_conversion_object_name",
        CAST("pardot_conversion_object_type" AS VARCHAR) 
        AS "pardot_conversion_object_type",
        CAST(CONVERT(VARCHAR(8), "pardot_created_date") AS DATETIME) 
        AS "pardot_created_date",
        CAST("pardot_first_activity" AS VARCHAR) 
        AS "pardot_first_activity",
        CAST("pardot_first_search_term" AS VARCHAR) 
        AS "pardot_first_search_term",
        CAST("pardot_first_search_type" AS VARCHAR) 
        AS "pardot_first_search_type",
        CAST("pardot_first_touch_url" AS VARCHAR) 
        AS "pardot_first_touch_url",
        CAST("pardot_grade" AS VARCHAR) 
        AS "pardot_grade",
        CAST("pardot_hard_bounced" AS BIT) 
        AS "pardot_hard_bounced",
        CAST(CONVERT(VARCHAR(23), "pardot_last_scored_date", 121) AS DATETIME) 
        AS "pardot_last_scored_date",
        CAST("partner_rep_email" AS VARCHAR) 
        AS "partner_rep_email",
        CAST("partner_rep_name" AS VARCHAR(255)) 
        AS "partner_rep_name",
        CAST("partner_type" AS VARCHAR) 
        AS "partner_type",
        CAST("past_account" AS VARCHAR) 
        AS "past_account",
        CAST("past_company" AS VARCHAR) 
        AS "past_company",
        CAST("past_contact" AS VARCHAR) 
        AS "past_contact",
        CAST("past_job_title" AS VARCHAR) 
        AS "past_job_title",
        CAST("phone" AS VARCHAR) 
        AS "phone",
        CAST("phone_number" AS VARCHAR) 
        AS "phone_number",
        CAST("pi_last_activity_c" AS VARCHAR) 
        AS "pi_last_activity_c",
        CAST("pi_notes_c" AS VARCHAR) 
        AS "pi_notes_c",
        CAST("pi_score_c" AS VARCHAR) 
        AS "pi_score_c",
        CAST("pi_utm_campaign_c" AS VARCHAR) 
        AS "pi_utm_campaign_c",
        CAST("pi_utm_content_c" AS VARCHAR) 
        AS "pi_utm_content_c",
        CAST("pi_utm_medium_c" AS VARCHAR) 
        AS "pi_utm_medium_c",
        CAST("pi_utm_source_c" AS VARCHAR) 
        AS "pi_utm_source_c",
        CAST("pi_utm_term_c" AS VARCHAR) 
        AS "pi_utm_term_c",
        CAST("postal_code" AS VARCHAR) 
        AS "postal_code",
        CAST("previous_lead_source" AS VARCHAR) 
        AS "previous_lead_source",
        CAST("previous_lead_source_details" AS VARCHAR(255)) 
        AS "previous_lead_source_details",
        CAST("primary_contact" AS VARCHAR) 
        AS "primary_contact",
        CAST("promotion_id" AS VARCHAR) 
        AS "promotion_id",
        CAST("recent_campaign_status" AS VARCHAR) 
        AS "recent_campaign_status",
        CAST("referral_account" AS VARCHAR) 
        AS "referral_account",
        CAST("referral_contact" AS VARCHAR) 
        AS "referral_contact",
        CAST("referral_email" AS VARCHAR) 
        AS "referral_email",
        CAST("referral_first_name" AS VARCHAR(255)) 
        AS "referral_first_name",
        CAST("referral_last_name" AS VARCHAR(255)) 
        AS "referral_last_name",
        CAST("region_c" AS VARCHAR) 
        AS "region_c",
        CAST("relative_score" AS DECIMAL) 
        AS "relative_score",
        CAST("role" AS VARCHAR) 
        AS "role",
        CAST("sales_email_opt_out" AS BIT) 
        AS "sales_email_opt_out",
        DATEADD(DAY, FLOOR("sales_email_opt_out_datetime"), '1900-01-01') +
        DATEADD(SECOND, ("sales_email_opt_out_datetime" - FLOOR("sales_email_opt_out_datetime")) * 86400, '00:00:00') 
        AS "sales_email_opt_out_datetime",
        CAST("salesloft_cadence_trigger" AS VARCHAR) 
        AS "salesloft_cadence_trigger",
        CAST("salesloft_last_completed_step" AS VARCHAR) 
        AS "salesloft_last_completed_step",
        CAST(DATEADD(day, CAST("salesloft_next_step_due_date" AS INT), '1900-01-01') AS DATE) 
        AS "salesloft_next_step_due_date",
        CAST("salesloft_recent_cadence_name" AS VARCHAR) 
        AS "salesloft_recent_cadence_name",
        CAST("salutation" AS VARCHAR) 
        AS "salutation",
        CAST(CASE WHEN "score_sync_needed" = 0 THEN 0 ELSE 1 END AS BIT) 
        AS "score_sync_needed",
        CAST("secondary_email" AS VARCHAR) 
        AS "secondary_email",
        CAST("source_detail_c" AS VARCHAR) 
        AS "source_detail_c",
        CAST(CASE WHEN "startup_eligibility_certified" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "startup_eligibility_certified",
        CAST("state" AS VARCHAR) 
        AS "state",
        CAST("state_c" AS VARCHAR) 
        AS "state_c",
        CAST("state_code" AS VARCHAR) 
        AS "state_code",
        CAST("street" AS VARCHAR(255)) 
        AS "street",
        CAST("system_modification_timestamp" AS DATETIME) 
        AS "system_modification_timestamp",
        CAST("target_audience" AS VARCHAR) 
        AS "target_audience",
        CAST("tech_stack" AS VARCHAR) 
        AS "tech_stack",
        CAST("territory" AS VARCHAR) 
        AS "territory",
        CAST(DATEADD(DAY, CAST("touchpoint_date_first_touch" AS INT), '1900-01-01') AS DATE) 
        AS "touchpoint_date_first_touch",
        CAST(DATEADD(DAY, CAST("touchpoint_date_last_touch" AS INT), '1900-01-01') AS DATE) 
        AS "touchpoint_date_last_touch",
        CAST("touchpoint_source_first_touch" AS VARCHAR) 
        AS "touchpoint_source_first_touch",
        CAST("touchpoint_source_last_touch" AS VARCHAR) 
        AS "touchpoint_source_last_touch",
        CAST(DATEADD(day, CAST("trial_start_date" AS INT), '1900-01-01') AS DATE) 
        AS "trial_start_date",
        CAST("twitter_handle" AS VARCHAR(255)) 
        AS "twitter_handle",
        CAST("unique_email" AS VARCHAR(255)) 
        AS "unique_email",
        CAST("up_region_c" AS VARCHAR) 
        AS "up_region_c",
        CAST("user_gems_current_info" AS VARCHAR) 
        AS "user_gems_current_info",
        CAST("user_gems_id" AS VARCHAR) 
        AS "user_gems_id",
        CAST("user_gems_past_info" AS VARCHAR) 
        AS "user_gems_past_info",
        CAST("utm_campaign_c" AS VARCHAR) 
        AS "utm_campaign_c",
        CAST("utm_content_c" AS VARCHAR) 
        AS "utm_content_c",
        CAST("utm_id" AS VARCHAR) 
        AS "utm_id",
        CAST("utm_medium_c" AS VARCHAR) 
        AS "utm_medium_c",
        CAST("utm_source_c" AS VARCHAR) 
        AS "utm_source_c",
        CAST("utm_term_c" AS VARCHAR) 
        AS "utm_term_c",
        CAST("verified" AS BIT) 
        AS "verified",
        CAST("volume_millions" AS DECIMAL(10,2)) 
        AS "volume_millions",
        CAST("website" AS VARCHAR(MAX)) 
        AS "website",
        CAST("zip_code" AS VARCHAR) 
        AS "zip_code",
        CAST("zipcode" AS VARCHAR) 
        AS "zipcode",
        CAST("zoominfo_company_id" AS VARCHAR) 
        AS "zoominfo_company_id",
        CAST("zoominfo_country" AS VARCHAR(255)) 
        AS "zoominfo_country",
        CAST("zoominfo_employee_count_c" AS INT) 
        AS "zoominfo_employee_count_c",
        CAST(CONVERT(VARCHAR(23), "zoominfo_first_updated", 121) AS DATETIME) 
        AS "zoominfo_first_updated",
        CAST("zoominfo_id" AS VARCHAR) 
        AS "zoominfo_id",
        CONVERT(DATETIME, CONVERT(VARCHAR(33), "zoominfo_last_updated", 121)) 
        AS "zoominfo_last_updated",
        CAST("zoominfo_state_c" AS VARCHAR) 
        AS "zoominfo_state_c"
    FROM "sf_lead_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_lead_data_projected_renamed_cleaned_casted"