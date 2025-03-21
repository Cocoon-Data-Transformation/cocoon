-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-09 03:50:19.200233+00:00
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
    FROM "memory"."main"."sf_lead_data"
),

"sf_lead_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- email_bounced_reason -> email_bounce_reason
    -- email_bounced_date -> email_bounce_date
    -- secondary_email_c -> secondary_email
    -- system_modstamp -> last_modified_timestamp
    -- up_district_c -> district
    -- mc_4_sf_mc_subscriber_c -> marketing_cloud_subscriber
    -- lead_source_detail_c -> lead_source_details
    -- latitude -> lead_latitude
    -- cbit_clearbit_c -> clearbit_status
    -- industry -> lead_industry
    -- title -> job_title
    -- company -> company_name
    -- last_name -> lead_last_name
    -- up_territory_c -> territory
    -- gclid_c -> google_click_id
    -- active_in_sequence_c -> active_in_sequence
    -- cbit_clearbit_ready_c -> clearbit_data_ready
    -- calendly_created_c -> calendly_created_date
    -- account_c -> account_id
    -- all_connectors_c -> account_connectors
    -- all_data_warehouses_c -> account_all_data_warehouses
    -- bi_tools_c -> lead_bi_tools
    -- competitors_c -> competitors
    -- connectors_products_c -> connector_products
    -- contact_c -> primary_contact
    -- data_warehouse_products_c -> data_warehouse_products
    -- notes_c -> notes
    -- timeframe_c -> timeframe
    -- account_all_products_c -> account_products
    -- account_bi_tools_c -> account_bi_tools
    -- account_data_warehouses_c -> account_data_warehouses
    -- opportunity_competitors_c -> opportunity_competitors
    -- opportunity_products_c -> opportunity_products
    -- referral_account_c -> referral_account
    -- referral_contact_c -> referral_contact
    -- volume_in_millions_c -> sales_volume_millions
    -- feature_requests_c -> feature_requests
    -- demo_scheduled_by_calenderly_c -> demo_scheduled_calendly
    -- to_delete_c -> marked_for_deletion
    -- email_quality_c -> email_quality
    -- email_quality_catchall_c -> email_catchall
    -- old_lead_source_c -> previous_lead_source
    -- old_lead_source_detail_c -> previous_lead_source_detail
    -- act_on_lead_score_c -> act_on_lead_score
    -- cbit_created_by_clearbit_c -> created_by_clearbit
    -- fivetran_user_id_c -> fivetran_user_id
    -- geo_state_acton_c -> lead_state_acton
    -- actonreferrer_c -> lead_referrer
    -- company_type_c -> company_type
    -- pi_comments_c -> lead_comments
    -- pi_conversion_date_c -> conversion_date
    -- pi_conversion_object_name_c -> conversion_object_name
    -- pi_conversion_object_type_c -> conversion_object_type
    -- pi_created_date_c -> lead_creation_date
    -- pi_first_activity_c -> first_activity
    -- pi_first_search_term_c -> first_search_term
    -- pi_first_search_type_c -> first_search_type
    -- pi_first_touch_url_c -> first_touch_url
    -- pi_grade_c -> lead_grade
    -- pi_last_activity_c -> last_activity
    -- pi_needs_score_synced_c -> needs_score_sync
    -- pi_notes_c -> lead_notes
    -- pi_pardot_hard_bounced_c -> pardot_hard_bounced
    -- pi_pardot_last_scored_at_c -> pardot_last_scored_at
    -- pi_url_c -> lead_url
    -- competitor_c -> is_competitor
    -- source_detail_c -> source_detail
    -- fivetran_account_stage_c -> fivetran_account_stage
    -- fivetran_account_id_c -> fivetran_account_id
    -- lean_data_router_status_c -> router_status
    -- lean_data_matched_lead_c -> matched_lead
    -- lean_data_routing_action_c -> routing_action
    -- lean_data_search_index_c -> search_index
    -- lean_data_reporting_matched_account_c -> reporting_matched_account_id
    -- lean_data_reporting_timestamp_c -> reporting_timestamp
    -- lean_data_ld_segment_c -> leandata_segment
    -- lean_data_marketing_sys_created_date_c -> marketing_system_creation_date
    -- lean_data_matched_account_c -> matched_account
    -- lean_data_a_2_b_account_c -> leandata_account
    -- lean_data_search_c -> search_terms
    -- lean_data_routing_status_c -> routing_status
    -- lean_data_a_2_b_group_c -> leandata_group
    -- lean_data_matched_buyer_persona_c -> matched_buyer_persona
    -- lean_data_tag_c -> lead_tags
    -- lean_data_status_info_c -> status_info
    -- lean_data_modified_score_c -> modified_score
    -- do_not_route_lead_c -> do_not_route_lead
    -- partner_type_c -> partner_type
    -- allbound_id_c -> allbound_id
    -- lid_linked_in_company_id_c -> linkedin_company_id
    -- lid_linked_in_member_token_c -> linkedin_member_token
    -- lean_data_re_route_c -> reroute_flag
    -- sales_loft_1_most_recent_cadence_next_step_due_date_c -> next_cadence_step_due_date
    -- sales_loft_1_most_recent_last_completed_step_c -> last_completed_cadence_step
    -- sales_loft_1_most_recent_cadence_name_c -> recent_cadence_name
    -- network_c -> network
    -- matchtype_c -> match_type
    -- device_c -> device
    -- creative_c -> creative_content
    -- adgroupid_c -> ad_group_id
    -- keyword_c -> lead_keyword
    -- partner_rep_email_c -> partner_rep_email
    -- partner_rep_name_c -> partner_rep_name
    -- lead_type_c -> lead_type
    -- contact_stage_c -> contact_stage
    -- es_app_esalexa_rank_c -> alexa_rank
    -- es_app_esaudience_names_c -> audience_names
    -- es_app_escity_c -> enriched_city
    -- es_app_escompany_phone_c -> company_phone
    -- es_app_escreated_timestamp_c -> created_timestamp
    -- es_app_esenriched_c -> is_enriched
    -- es_app_esenriched_timestamp_c -> enriched_timestamp
    -- es_app_esfacebook_c -> facebook_url
    -- es_app_esindustry_c -> industry
    -- es_app_esintent_aggregate_score_c -> intent_score
    -- es_app_esintent_timestamp_c -> intent_timestamp
    -- es_app_esintent_topics_c -> intent_topics
    -- es_app_eskeywords_c -> keywords
    -- es_app_esoverall_fit_score_c -> fit_score
    -- es_app_esrevenue_c -> company_revenue
    -- es_app_esstreet_c -> street_address
    -- es_app_estechnologies_c -> technologies
    -- es_app_estwitter_c -> twitter_url
    -- es_app_eszipcode_c -> zip_code
    -- marketing_prospect_routing_rules_c -> prospect_routing_rules
    -- marketing_process_c -> marketing_process_stage
    -- automation_tracking_c -> automation_tracking
    -- user_gems_has_changed_job_c -> has_changed_job
    -- user_gems_linked_in_c -> linkedin_profile
    -- email_opt_in_c -> email_opt_in
    -- email_opt_in_explicit_c -> email_explicit_opt_in
    -- email_opt_in_implicit_c -> email_implicit_opt_in
    -- gdpr_opt_in_explicit_c -> gdpr_opt_in_status
    -- user_gems_is_a_user_gem_c -> is_user_gem
    -- user_gems_past_account_c -> past_account
    -- user_gems_past_company_c -> previous_company
    -- user_gems_past_contact_c -> previous_contact_info
    -- user_gems_past_title_c -> previous_job_title
    -- promotion_id_c -> promotion_id
    -- previous_customer_c -> is_previous_customer
    -- referral_contact_email_c -> referral_email
    -- referral_firstname_c -> referral_first_name
    -- referral_last_name_c -> referral_last_name
    -- mkto_71_acquisition_date_c -> acquisition_date
    -- mkto_71_acquisition_program_id_c -> acquisition_program_id
    -- mkto_acquisition_program_c -> acquisition_program
    -- mkto_71_inferred_city_c -> inferred_city
    -- mkto_71_inferred_company_c -> inferred_company
    -- mkto_71_inferred_country_c -> inferred_country
    -- mkto_71_inferred_metropolitan_area_c -> inferred_metro_area
    -- mkto_71_inferred_phone_area_code_c -> inferred_phone_area_code
    -- mkto_71_inferred_postal_code_c -> inferred_postal_code
    -- mkto_71_inferred_state_region_c -> inferred_state_region
    -- mkto_71_original_referrer_c -> original_referrer
    -- mkto_71_original_search_engine_c -> original_search_engine
    -- mkto_71_original_search_phrase_c -> original_search_phrase
    -- mkto_71_original_source_info_c -> original_source_info
    -- mkto_71_original_source_type_c -> original_source_type
    -- mkto_si_hide_date_c -> sales_insight_hide_date
    -- mkto_si_last_interesting_moment_date_c -> last_interesting_moment_date
    -- mkto_si_last_interesting_moment_desc_c -> last_interaction_description
    -- mkto_si_last_interesting_moment_source_c -> last_interaction_source
    -- mkto_si_last_interesting_moment_type_c -> last_interaction_type
    -- mkto_si_msicontact_id_c -> marketo_contact_id
    -- mkto_si_priority_c -> lead_priority_score
    -- mkto_si_relative_score_value_c -> relative_score
    -- mkto_si_urgency_value_c -> lead_urgency
    -- cloudingo_agent_ar_c -> cloudingo_agent_ar
    -- cloudingo_agent_ardi_c -> cloudingo_agent_ardi
    -- cloudingo_agent_as_c -> cloudingo_agent_as
    -- cloudingo_agent_atz_c -> cloudingo_agent_atz
    -- cloudingo_agent_av_c -> cloudingo_agent_av
    -- cloudingo_agent_les_c -> cloudingo_agent_les
    -- do_not_sync_marketo_c -> marketo_sync_exclusion
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
    -- city_c -> custom_city
    -- country_c -> country_custom
    -- state_c -> state_custom
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
    -- converted_date_time_c -> converted_datetime
    -- lead_created_date_time_reporting_c -> lead_creation_datetime
    -- lead_iq_employee_range_c -> employee_range
    -- lead_iq_zip_code_c -> lead_zip_code
    -- zoominfo_country_c -> zoominfo_country
    -- zoominfo_employee_count_c -> zoominfo_employee_count
    -- zoominfo_state_c -> zoominfo_state
    -- zoominfo_technologies_c -> zoominfo_technologies
    -- zoominfo_zip_code_c -> zoominfo_zip_code
    -- attended_event_c -> attended_event
    -- mql_date_c -> mql_date
    -- user_gems_user_gems_id_c -> user_gems_id
    -- dozisf_zoom_info_company_id_c -> zoominfo_company_id
    -- dozisf_zoom_info_first_updated_c -> zoominfo_first_update_date
    -- dozisf_zoom_info_id_c -> zoominfo_id
    -- dozisf_zoom_info_last_updated_c -> zoominfo_last_update_date
    -- lean_data_manual_route_trigger_c -> manual_route_trigger
    -- first_mql_date_c -> first_mql_date
    -- fivetran_account_association_date_c -> fivetran_association_date
    -- fivetran_account_user_role_s_c -> fivetran_user_roles
    -- mql_reason_c -> mql_reason
    -- trial_contact_start_date_c -> trial_start_date
    -- enrichment_request_c -> enrichment_request
    -- meta_data_create_date_c -> metadata_creation_date
    -- clarus_date_c -> clarus_date
    -- clarus_editor_c -> clarus_editor
    -- clarus_notes_c -> clarus_notes
    -- clarus_project_c -> clarus_project_id
    -- clarus_status_c -> clarus_status
    -- marketing_connector_interest_c -> marketing_connector_interest
    -- recent_marketing_campaign_status_c -> recent_campaign_status
    -- salesloft_cadence_trigger_c -> cadence_trigger
    -- datawarehouse_used_c -> data_warehouse_used
    -- contact_status_c -> contact_status
    -- leandata_contact_owner_override_c -> contact_owner_override
    -- potential_fivetran_use_case_c -> fivetran_use_case
    -- bizible_2_account_c -> bizible_account_id
    -- bizible_2_ad_campaign_name_ft_c -> bizible_first_touch_campaign
    -- bizible_2_ad_campaign_name_lc_c -> bizible_last_touch_campaign
    -- bizible_2_bizible_id_c -> bizible_id
    -- bizible_2_landing_page_ft_c -> bizible_first_touch_landing_page
    -- bizible_2_landing_page_lc_c -> bizible_last_touch_landing_page
    -- bizible_2_marketing_channel_ft_c -> bizible_first_touch_marketing_channel
    -- bizible_2_marketing_channel_lc_c -> marketing_channel
    -- bizible_2_touchpoint_date_ft_c -> first_touchpoint_date
    -- bizible_2_touchpoint_date_lc_c -> last_touchpoint_date
    -- bizible_2_touchpoint_source_ft_c -> first_touchpoint_source
    -- bizible_2_touchpoint_source_lc_c -> last_touchpoint_source
    -- bombora_app_bombora_surge_record_count_c -> bombora_surge_count
    -- bombora_app_bombora_last_date_time_updated_c -> bombora_last_updated
    -- bombora_app_bombora_total_composite_score_c -> bombora_composite_score
    -- beta_connector_interest_c -> beta_connector_interest
    -- user_gems_ug_past_infos_c -> past_user_gems_info
    -- user_gems_ug_current_infos_c -> current_user_gems_info
    -- user_gems_ug_created_by_ug_c -> created_by_user_gems
    -- free_trial_email_confirmed_date_c -> free_trial_confirmation_date
    -- dnboptimizer_dn_bcontact_record_c -> dnb_contact_record
    -- dnboptimizer_dn_bcompany_record_c -> dnb_company_record
    -- dnboptimizer_dnb_d_u_n_s_number_c -> duns_number
    -- i_sell_oskey_id_c -> i_sell_os_key_id
    -- verified_c -> is_verified
    -- pbf_startup_c -> is_startup
    -- pbf_startup_certify_eligibility_c -> startup_certification_eligible
    -- engagio_intent_minutes_last_30_days_c -> engagio_intent_minutes_30d
    -- engagio_engagement_minutes_last_3_months_c -> engagio_engagement_minutes_3m
    -- engagio_engagement_minutes_last_7_days_c -> engagio_engagement_minutes_7d
    -- engagio_matched_account_c -> engagio_matched_account
    -- engagio_first_engagement_date_c -> engagio_first_engagement_date
    -- engagio_match_time_c -> engagio_match_time
    -- engagio_department_c -> engagio_department
    -- engagio_role_c -> engagio_role
    -- legacy_hvr_id_c -> legacy_id
    -- hvr_channel_c -> hvr_channel
    -- email_opt_in_double_c -> email_double_opt_in
    -- phone_number_catch_all_c -> phone_number_catch_all
    -- contacts_domain_exists_c -> domain_exists
    -- utm_id_c -> utm_id
    -- source_every_utm_id_c -> all_utm_ids
    -- source_last_utm_id_c -> last_utm_id
    -- source_first_utm_id_c -> first_utm_id
    -- do_not_sync_reason_marketo_c -> marketo_sync_exclusion_reason
    -- _fivetran_active -> fivetran_active_status
    SELECT 
        "country",
        "email_bounced_reason" AS "email_bounce_reason",
        "email_bounced_date" AS "email_bounce_date",
        "owner_id",
        "secondary_email_c" AS "secondary_email",
        "lead_source",
        "converted_date",
        "last_modified_date",
        "master_record_id",
        "last_modified_by_id",
        "system_modstamp" AS "last_modified_timestamp",
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
        "lead_source_detail_c" AS "lead_source_details",
        "created_by_id",
        "salutation",
        "is_converted",
        "state_code",
        "is_unread_by_owner",
        "status",
        "city",
        "latitude" AS "lead_latitude",
        "cbit_clearbit_c" AS "clearbit_status",
        "industry" AS "lead_industry",
        "title" AS "job_title",
        "last_viewed_date",
        "converted_opportunity_id",
        "is_deleted",
        "street",
        "company" AS "company_name",
        "first_name",
        "email",
        "website",
        "last_name" AS "lead_last_name",
        "number_of_employees",
        "up_territory_c" AS "territory",
        "created_date",
        "gclid_c" AS "google_click_id",
        "active_in_sequence_c" AS "active_in_sequence",
        "postal_code",
        "cbit_clearbit_ready_c" AS "clearbit_data_ready",
        "has_opted_out_of_email",
        "converted_salesforce_account_id",
        "mobile_phone",
        "calendly_created_c" AS "calendly_created_date",
        "account_c" AS "account_id",
        "all_connectors_c" AS "account_connectors",
        "all_data_warehouses_c" AS "account_all_data_warehouses",
        "bi_tools_c" AS "lead_bi_tools",
        "competitors_c" AS "competitors",
        "annual_revenue",
        "connectors_products_c" AS "connector_products",
        "contact_c" AS "primary_contact",
        "data_warehouse_products_c" AS "data_warehouse_products",
        "notes_c" AS "notes",
        "timeframe_c" AS "timeframe",
        "account_all_products_c" AS "account_products",
        "account_bi_tools_c" AS "account_bi_tools",
        "account_data_warehouses_c" AS "account_data_warehouses",
        "opportunity_competitors_c" AS "opportunity_competitors",
        "opportunity_products_c" AS "opportunity_products",
        "description",
        "referral_account_c" AS "referral_account",
        "referral_contact_c" AS "referral_contact",
        "volume_in_millions_c" AS "sales_volume_millions",
        "feature_requests_c" AS "feature_requests",
        "lead_number_c",
        "demo_scheduled_by_calenderly_c" AS "demo_scheduled_calendly",
        "to_delete_c" AS "marked_for_deletion",
        "bounced_email_c",
        "email_quality_c" AS "email_quality",
        "email_quality_catchall_c" AS "email_catchall",
        "old_lead_source_c" AS "previous_lead_source",
        "email_bounced_c",
        "old_lead_source_detail_c" AS "previous_lead_source_detail",
        "utm_medium_c",
        "utm_source_c",
        "utm_campaign_c",
        "utm_content_c",
        "utm_term_c",
        "act_on_lead_score_c" AS "act_on_lead_score",
        "cbit_created_by_clearbit_c" AS "created_by_clearbit",
        "fivetran_user_id_c" AS "fivetran_user_id",
        "geo_state_acton_c" AS "lead_state_acton",
        "actoncountry_c",
        "actoncity_c",
        "actoncountrycode_c",
        "actonpostalcode_c",
        "actonreferrer_c" AS "lead_referrer",
        "actonstate_c",
        "geo_city_c",
        "geo_country_c",
        "geo_country_code_c",
        "geo_postal_code_c",
        "geo_state_c",
        "company_type_c" AS "company_type",
        "pi_campaign_c",
        "pi_comments_c" AS "lead_comments",
        "pi_conversion_date_c" AS "conversion_date",
        "pi_conversion_object_name_c" AS "conversion_object_name",
        "pi_conversion_object_type_c" AS "conversion_object_type",
        "pi_created_date_c" AS "lead_creation_date",
        "pi_first_activity_c" AS "first_activity",
        "pi_first_search_term_c" AS "first_search_term",
        "pi_first_search_type_c" AS "first_search_type",
        "pi_first_touch_url_c" AS "first_touch_url",
        "pi_grade_c" AS "lead_grade",
        "pi_last_activity_c" AS "last_activity",
        "pi_needs_score_synced_c" AS "needs_score_sync",
        "pi_notes_c" AS "lead_notes",
        "pi_pardot_hard_bounced_c" AS "pardot_hard_bounced",
        "pi_pardot_last_scored_at_c" AS "pardot_last_scored_at",
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
        "source_detail_c" AS "source_detail",
        "fivetran_account_stage_c" AS "fivetran_account_stage",
        "fivetran_account_id_c" AS "fivetran_account_id",
        "lean_data_router_status_c" AS "router_status",
        "lean_data_matched_lead_c" AS "matched_lead",
        "lean_data_routing_action_c" AS "routing_action",
        "lean_data_search_index_c" AS "search_index",
        "lean_data_reporting_matched_account_c" AS "reporting_matched_account_id",
        "lean_data_reporting_timestamp_c" AS "reporting_timestamp",
        "lean_data_ld_segment_c" AS "leandata_segment",
        "lean_data_marketing_sys_created_date_c" AS "marketing_system_creation_date",
        "lean_data_matched_account_c" AS "matched_account",
        "lean_data_a_2_b_account_c" AS "leandata_account",
        "lean_data_search_c" AS "search_terms",
        "lean_data_routing_status_c" AS "routing_status",
        "lean_data_a_2_b_group_c" AS "leandata_group",
        "lean_data_matched_buyer_persona_c" AS "matched_buyer_persona",
        "lean_data_tag_c" AS "lead_tags",
        "lean_data_status_info_c" AS "status_info",
        "lean_data_modified_score_c" AS "modified_score",
        "do_not_route_lead_c" AS "do_not_route_lead",
        "partner_type_c" AS "partner_type",
        "allbound_id_c" AS "allbound_id",
        "lid_linked_in_company_id_c" AS "linkedin_company_id",
        "lid_linked_in_member_token_c" AS "linkedin_member_token",
        "lean_data_re_route_c" AS "reroute_flag",
        "sales_loft_1_most_recent_cadence_next_step_due_date_c" AS "next_cadence_step_due_date",
        "sales_loft_1_most_recent_last_completed_step_c" AS "last_completed_cadence_step",
        "sales_loft_1_most_recent_cadence_name_c" AS "recent_cadence_name",
        "network_c" AS "network",
        "matchtype_c" AS "match_type",
        "device_c" AS "device",
        "creative_c" AS "creative_content",
        "adgroupid_c" AS "ad_group_id",
        "keyword_c" AS "lead_keyword",
        "campaignid_c",
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
        "es_app_esaudience_names_c" AS "audience_names",
        "es_app_escity_c" AS "enriched_city",
        "es_app_escompany_phone_c" AS "company_phone",
        "es_app_escountry_c",
        "es_app_escreated_timestamp_c" AS "created_timestamp",
        "es_app_esecid_c",
        "es_app_esemployees_c",
        "es_app_esenriched_c" AS "is_enriched",
        "es_app_esenriched_timestamp_c" AS "enriched_timestamp",
        "es_app_esfacebook_c" AS "facebook_url",
        "es_app_esindustry_c" AS "industry",
        "es_app_esintent_aggregate_score_c" AS "intent_score",
        "es_app_esintent_timestamp_c" AS "intent_timestamp",
        "es_app_esintent_topics_c" AS "intent_topics",
        "es_app_eskeywords_c" AS "keywords",
        "es_app_eslinked_in_c",
        "es_app_esoverall_fit_score_c" AS "fit_score",
        "es_app_esrevenue_c" AS "company_revenue",
        "es_app_essource_c",
        "es_app_esstate_c",
        "es_app_esstreet_c" AS "street_address",
        "es_app_estechnologies_c" AS "technologies",
        "es_app_estwitter_c" AS "twitter_url",
        "es_app_eszipcode_c" AS "zip_code",
        "marketing_prospect_routing_rules_c" AS "prospect_routing_rules",
        "individual_id",
        "marketing_process_c" AS "marketing_process_stage",
        "automation_tracking_c" AS "automation_tracking",
        "user_gems_has_changed_job_c" AS "has_changed_job",
        "user_gems_linked_in_c" AS "linkedin_profile",
        "email_opt_in_c" AS "email_opt_in",
        "email_opt_in_explicit_c" AS "email_explicit_opt_in",
        "email_opt_in_implicit_c" AS "email_implicit_opt_in",
        "gdpr_opt_in_explicit_c" AS "gdpr_opt_in_status",
        "user_gems_is_a_user_gem_c" AS "is_user_gem",
        "user_gems_past_account_c" AS "past_account",
        "user_gems_past_company_c" AS "previous_company",
        "user_gems_past_contact_c" AS "previous_contact_info",
        "user_gems_past_title_c" AS "previous_job_title",
        "promotion_id_c" AS "promotion_id",
        "previous_customer_c" AS "is_previous_customer",
        "referral_contact_email_c" AS "referral_email",
        "referral_firstname_c" AS "referral_first_name",
        "referral_last_name_c" AS "referral_last_name",
        "mkto_71_lead_score_c",
        "mkto_71_acquisition_date_c" AS "acquisition_date",
        "mkto_71_acquisition_program_id_c" AS "acquisition_program_id",
        "mkto_acquisition_program_c" AS "acquisition_program",
        "mkto_71_inferred_city_c" AS "inferred_city",
        "mkto_71_inferred_company_c" AS "inferred_company",
        "mkto_71_inferred_country_c" AS "inferred_country",
        "mkto_71_inferred_metropolitan_area_c" AS "inferred_metro_area",
        "mkto_71_inferred_phone_area_code_c" AS "inferred_phone_area_code",
        "mkto_71_inferred_postal_code_c" AS "inferred_postal_code",
        "mkto_71_inferred_state_region_c" AS "inferred_state_region",
        "mkto_71_original_referrer_c" AS "original_referrer",
        "mkto_71_original_search_engine_c" AS "original_search_engine",
        "mkto_71_original_search_phrase_c" AS "original_search_phrase",
        "mkto_71_original_source_info_c" AS "original_source_info",
        "mkto_71_original_source_type_c" AS "original_source_type",
        "mkto_si_hide_date_c" AS "sales_insight_hide_date",
        "mkto_si_last_interesting_moment_date_c" AS "last_interesting_moment_date",
        "mkto_si_last_interesting_moment_desc_c" AS "last_interaction_description",
        "mkto_si_last_interesting_moment_source_c" AS "last_interaction_source",
        "mkto_si_last_interesting_moment_type_c" AS "last_interaction_type",
        "mkto_si_msicontact_id_c" AS "marketo_contact_id",
        "mkto_si_priority_c" AS "lead_priority_score",
        "mkto_si_relative_score_value_c" AS "relative_score",
        "mkto_si_urgency_value_c" AS "lead_urgency",
        "cloudingo_agent_ar_c" AS "cloudingo_agent_ar",
        "cloudingo_agent_ardi_c" AS "cloudingo_agent_ardi",
        "cloudingo_agent_as_c" AS "cloudingo_agent_as",
        "cloudingo_agent_atz_c" AS "cloudingo_agent_atz",
        "cloudingo_agent_av_c" AS "cloudingo_agent_av",
        "cloudingo_agent_les_c" AS "cloudingo_agent_les",
        "do_not_sync_marketo_c" AS "marketo_sync_exclusion",
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
        "city_c" AS "custom_city",
        "country_c" AS "country_custom",
        "state_c" AS "state_custom",
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
        "converted_date_time_c" AS "converted_datetime",
        "lead_created_date_time_reporting_c" AS "lead_creation_datetime",
        "lead_iq_country_c",
        "lead_iq_employee_count_c",
        "lead_iq_employee_range_c" AS "employee_range",
        "lead_iq_state_c",
        "lead_iq_zip_code_c" AS "lead_zip_code",
        "zoominfo_country_c" AS "zoominfo_country",
        "zoominfo_employee_count_c" AS "zoominfo_employee_count",
        "zoominfo_state_c" AS "zoominfo_state",
        "zoominfo_technologies_c" AS "zoominfo_technologies",
        "zoominfo_zip_code_c" AS "zoominfo_zip_code",
        "attended_event_c" AS "attended_event",
        "mql_date_c" AS "mql_date",
        "user_gems_user_gems_id_c" AS "user_gems_id",
        "dozisf_zoom_info_company_id_c" AS "zoominfo_company_id",
        "dozisf_zoom_info_first_updated_c" AS "zoominfo_first_update_date",
        "dozisf_zoom_info_id_c" AS "zoominfo_id",
        "dozisf_zoom_info_last_updated_c" AS "zoominfo_last_update_date",
        "lean_data_manual_route_trigger_c" AS "manual_route_trigger",
        "first_mql_date_c" AS "first_mql_date",
        "fivetran_account_association_date_c" AS "fivetran_association_date",
        "fivetran_account_user_role_s_c" AS "fivetran_user_roles",
        "mql_reason_c" AS "mql_reason",
        "trial_contact_start_date_c" AS "trial_start_date",
        "enrichment_request_c" AS "enrichment_request",
        "meta_data_create_date_c" AS "metadata_creation_date",
        "clarus_date_c" AS "clarus_date",
        "clarus_editor_c" AS "clarus_editor",
        "clarus_notes_c" AS "clarus_notes",
        "clarus_project_c" AS "clarus_project_id",
        "clarus_status_c" AS "clarus_status",
        "marketing_connector_interest_c" AS "marketing_connector_interest",
        "recent_marketing_campaign_status_c" AS "recent_campaign_status",
        "salesloft_cadence_trigger_c" AS "cadence_trigger",
        "datawarehouse_used_c" AS "data_warehouse_used",
        "contact_status_c" AS "contact_status",
        "leandata_contact_owner_override_c" AS "contact_owner_override",
        "potential_fivetran_use_case_c" AS "fivetran_use_case",
        "bizible_2_account_c" AS "bizible_account_id",
        "bizible_2_ad_campaign_name_ft_c" AS "bizible_first_touch_campaign",
        "bizible_2_ad_campaign_name_lc_c" AS "bizible_last_touch_campaign",
        "bizible_2_bizible_id_c" AS "bizible_id",
        "bizible_2_landing_page_ft_c" AS "bizible_first_touch_landing_page",
        "bizible_2_landing_page_lc_c" AS "bizible_last_touch_landing_page",
        "bizible_2_marketing_channel_ft_c" AS "bizible_first_touch_marketing_channel",
        "bizible_2_marketing_channel_lc_c" AS "marketing_channel",
        "bizible_2_touchpoint_date_ft_c" AS "first_touchpoint_date",
        "bizible_2_touchpoint_date_lc_c" AS "last_touchpoint_date",
        "bizible_2_touchpoint_source_ft_c" AS "first_touchpoint_source",
        "bizible_2_touchpoint_source_lc_c" AS "last_touchpoint_source",
        "sales_email_opt_out_c",
        "sales_email_opt_out_date_time_c",
        "bombora_app_bombora_surge_record_count_c" AS "bombora_surge_count",
        "bombora_app_bombora_last_date_time_updated_c" AS "bombora_last_updated",
        "bombora_app_bombora_total_composite_score_c" AS "bombora_composite_score",
        "linked_in_url_c",
        "beta_connector_interest_c" AS "beta_connector_interest",
        "user_gems_ug_past_infos_c" AS "past_user_gems_info",
        "user_gems_ug_current_infos_c" AS "current_user_gems_info",
        "user_gems_ug_created_by_ug_c" AS "created_by_user_gems",
        "free_trial_email_confirmed_date_c" AS "free_trial_confirmation_date",
        "dnboptimizer_dn_bcontact_record_c" AS "dnb_contact_record",
        "dnboptimizer_dn_bcompany_record_c" AS "dnb_company_record",
        "dnboptimizer_dnb_d_u_n_s_number_c" AS "duns_number",
        "i_sell_oskey_id_c" AS "i_sell_os_key_id",
        "verified_c" AS "is_verified",
        "email_opt_out_date_time_c",
        "pbf_startup_c" AS "is_startup",
        "pbf_startup_certify_eligibility_c" AS "startup_certification_eligible",
        "engagio_intent_minutes_last_30_days_c" AS "engagio_intent_minutes_30d",
        "engagio_engagement_minutes_last_3_months_c" AS "engagio_engagement_minutes_3m",
        "engagio_engagement_minutes_last_7_days_c" AS "engagio_engagement_minutes_7d",
        "engagio_matched_account_c" AS "engagio_matched_account",
        "engagio_first_engagement_date_c" AS "engagio_first_engagement_date",
        "engagio_match_time_c" AS "engagio_match_time",
        "engagio_department_c" AS "engagio_department",
        "engagio_role_c" AS "engagio_role",
        "legacy_hvr_id_c" AS "legacy_id",
        "hvr_channel_c" AS "hvr_channel",
        "email_opt_in_double_c" AS "email_double_opt_in",
        "phone_number_catch_all_c" AS "phone_number_catch_all",
        "contacts_domain_exists_c" AS "domain_exists",
        "utm_id_c" AS "utm_id",
        "source_every_utm_id_c" AS "all_utm_ids",
        "source_last_utm_id_c" AS "last_utm_id",
        "source_first_utm_id_c" AS "first_utm_id",
        "do_not_sync_reason_marketo_c" AS "marketo_sync_exclusion_reason",
        "_fivetran_active" AS "fivetran_active_status"
    FROM "sf_lead_data_projected"
),

"sf_lead_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- name: The problem is that the name column contains only a single value 'h', which is highly unusual for a name field. A single letter, especially a lowercase one, is not typically used as a name. This could be a placeholder, an error, or a result of data truncation. Without more context or additional data, it's difficult to determine the correct value. The safest approach would be to treat this as missing data. 
    -- company_name: The problem is that 'Z' appears to be an incomplete company name or an abbreviation. Single-letter company names are highly unusual and likely represent missing or truncated data. Without additional context or information about what 'Z' might stand for, it's difficult to determine the correct full company name. In this case, the best approach is to leave it as is, but flag it for further investigation or data cleanup. 
    -- first_name: The problem is that the first_name column contains only a single value 'H', which is unusual for a first name. This is likely an abbreviation or a data entry error. In most cases, 'H' would not be a complete first name but rather an initial. However, without additional context or data, it's impossible to determine what the full name should be. 
    -- search_index: The problem is that the search_index column contains a single unusual value: 'geomecyvdvhj amazon'. This value appears to have random characters ('geomecyvdvhj') before the word 'amazon', suggesting a typo or error. Since this is the only value in the column, and we don't have additional context about what the correct value should be, we can't determine a more appropriate mapping. In this case, the best approach may be to keep the value as is or map it to just 'amazon' if we're certain that's what it's supposed to represent. 
    SELECT
        "country",
        "email_bounce_reason",
        "email_bounce_date",
        "owner_id",
        "secondary_email",
        "lead_source",
        "converted_date",
        "last_modified_date",
        "master_record_id",
        "last_modified_by_id",
        "last_modified_timestamp",
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
        "lead_source_details",
        "created_by_id",
        "salutation",
        "is_converted",
        "state_code",
        "is_unread_by_owner",
        "status",
        "city",
        "lead_latitude",
        "clearbit_status",
        "lead_industry",
        "job_title",
        "last_viewed_date",
        "converted_opportunity_id",
        "is_deleted",
        "street",
        "company_name",
        CASE
            WHEN "first_name" = 'H' THEN NULL
            ELSE "first_name"
        END AS "first_name",
        "email",
        "website",
        "lead_last_name",
        "number_of_employees",
        "territory",
        "created_date",
        "google_click_id",
        "active_in_sequence",
        "postal_code",
        "clearbit_data_ready",
        "has_opted_out_of_email",
        "converted_salesforce_account_id",
        "mobile_phone",
        "calendly_created_date",
        "account_id",
        "account_connectors",
        "account_all_data_warehouses",
        "lead_bi_tools",
        "competitors",
        "annual_revenue",
        "connector_products",
        "primary_contact",
        "data_warehouse_products",
        "notes",
        "timeframe",
        "account_products",
        "account_bi_tools",
        "account_data_warehouses",
        "opportunity_competitors",
        "opportunity_products",
        "description",
        "referral_account",
        "referral_contact",
        "sales_volume_millions",
        "feature_requests",
        "lead_number_c",
        "demo_scheduled_calendly",
        "marked_for_deletion",
        "bounced_email_c",
        "email_quality",
        "email_catchall",
        "previous_lead_source",
        "email_bounced_c",
        "previous_lead_source_detail",
        "utm_medium_c",
        "utm_source_c",
        "utm_campaign_c",
        "utm_content_c",
        "utm_term_c",
        "act_on_lead_score",
        "created_by_clearbit",
        "fivetran_user_id",
        "lead_state_acton",
        "actoncountry_c",
        "actoncity_c",
        "actoncountrycode_c",
        "actonpostalcode_c",
        "lead_referrer",
        "actonstate_c",
        "geo_city_c",
        "geo_country_c",
        "geo_country_code_c",
        "geo_postal_code_c",
        "geo_state_c",
        "company_type",
        "pi_campaign_c",
        "lead_comments",
        "conversion_date",
        "conversion_object_name",
        "conversion_object_type",
        "lead_creation_date",
        "first_activity",
        "first_search_term",
        "first_search_type",
        "first_touch_url",
        "lead_grade",
        "last_activity",
        "needs_score_sync",
        "lead_notes",
        "pardot_hard_bounced",
        "pardot_last_scored_at",
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
        "source_detail",
        "fivetran_account_stage",
        "fivetran_account_id",
        "router_status",
        "matched_lead",
        "routing_action",
        CASE
            WHEN "search_index" = 'geomecyvdvhj amazon' THEN 'amazon'
            ELSE "search_index"
        END AS "search_index",
        "reporting_matched_account_id",
        "reporting_timestamp",
        "leandata_segment",
        "marketing_system_creation_date",
        "matched_account",
        "leandata_account",
        "search_terms",
        "routing_status",
        "leandata_group",
        "matched_buyer_persona",
        "lead_tags",
        "status_info",
        "modified_score",
        "do_not_route_lead",
        "partner_type",
        "allbound_id",
        "linkedin_company_id",
        "linkedin_member_token",
        "reroute_flag",
        "next_cadence_step_due_date",
        "last_completed_cadence_step",
        "recent_cadence_name",
        "network",
        "match_type",
        "device",
        "creative_content",
        "ad_group_id",
        "lead_keyword",
        "campaignid_c",
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
        "audience_names",
        "enriched_city",
        "company_phone",
        "es_app_escountry_c",
        "created_timestamp",
        "es_app_esecid_c",
        "es_app_esemployees_c",
        "is_enriched",
        "enriched_timestamp",
        "facebook_url",
        "industry",
        "intent_score",
        "intent_timestamp",
        "intent_topics",
        "keywords",
        "es_app_eslinked_in_c",
        "fit_score",
        "company_revenue",
        "es_app_essource_c",
        "es_app_esstate_c",
        "street_address",
        "technologies",
        "twitter_url",
        "zip_code",
        "prospect_routing_rules",
        "individual_id",
        "marketing_process_stage",
        "automation_tracking",
        "has_changed_job",
        "linkedin_profile",
        "email_opt_in",
        "email_explicit_opt_in",
        "email_implicit_opt_in",
        "gdpr_opt_in_status",
        "is_user_gem",
        "past_account",
        "previous_company",
        "previous_contact_info",
        "previous_job_title",
        "promotion_id",
        "is_previous_customer",
        "referral_email",
        "referral_first_name",
        "referral_last_name",
        "mkto_71_lead_score_c",
        "acquisition_date",
        "acquisition_program_id",
        "acquisition_program",
        "inferred_city",
        "inferred_company",
        "inferred_country",
        "inferred_metro_area",
        "inferred_phone_area_code",
        "inferred_postal_code",
        "inferred_state_region",
        "original_referrer",
        "original_search_engine",
        "original_search_phrase",
        "original_source_info",
        "original_source_type",
        "sales_insight_hide_date",
        "last_interesting_moment_date",
        "last_interaction_description",
        "last_interaction_source",
        "last_interaction_type",
        "marketo_contact_id",
        "lead_priority_score",
        "relative_score",
        "lead_urgency",
        "cloudingo_agent_ar",
        "cloudingo_agent_ardi",
        "cloudingo_agent_as",
        "cloudingo_agent_atz",
        "cloudingo_agent_av",
        "cloudingo_agent_les",
        "marketo_sync_exclusion",
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
        "custom_city",
        "country_custom",
        "state_custom",
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
        "converted_datetime",
        "lead_creation_datetime",
        "lead_iq_country_c",
        "lead_iq_employee_count_c",
        "employee_range",
        "lead_iq_state_c",
        "lead_zip_code",
        "zoominfo_country",
        "zoominfo_employee_count",
        "zoominfo_state",
        "zoominfo_technologies",
        "zoominfo_zip_code",
        "attended_event",
        "mql_date",
        "user_gems_id",
        "zoominfo_company_id",
        "zoominfo_first_update_date",
        "zoominfo_id",
        "zoominfo_last_update_date",
        "manual_route_trigger",
        "first_mql_date",
        "fivetran_association_date",
        "fivetran_user_roles",
        "mql_reason",
        "trial_start_date",
        "enrichment_request",
        "metadata_creation_date",
        "clarus_date",
        "clarus_editor",
        "clarus_notes",
        "clarus_project_id",
        "clarus_status",
        "marketing_connector_interest",
        "recent_campaign_status",
        "cadence_trigger",
        "data_warehouse_used",
        "contact_status",
        "contact_owner_override",
        "fivetran_use_case",
        "bizible_account_id",
        "bizible_first_touch_campaign",
        "bizible_last_touch_campaign",
        "bizible_id",
        "bizible_first_touch_landing_page",
        "bizible_last_touch_landing_page",
        "bizible_first_touch_marketing_channel",
        "marketing_channel",
        "first_touchpoint_date",
        "last_touchpoint_date",
        "first_touchpoint_source",
        "last_touchpoint_source",
        "sales_email_opt_out_c",
        "sales_email_opt_out_date_time_c",
        "bombora_surge_count",
        "bombora_last_updated",
        "bombora_composite_score",
        "linked_in_url_c",
        "beta_connector_interest",
        "past_user_gems_info",
        "current_user_gems_info",
        "created_by_user_gems",
        "free_trial_confirmation_date",
        "dnb_contact_record",
        "dnb_company_record",
        "duns_number",
        "i_sell_os_key_id",
        "is_verified",
        "email_opt_out_date_time_c",
        "is_startup",
        "startup_certification_eligible",
        "engagio_intent_minutes_30d",
        "engagio_engagement_minutes_3m",
        "engagio_engagement_minutes_7d",
        "engagio_matched_account",
        "engagio_first_engagement_date",
        "engagio_match_time",
        "engagio_department",
        "engagio_role",
        "legacy_id",
        "hvr_channel",
        "email_double_opt_in",
        "phone_number_catch_all",
        "domain_exists",
        "utm_id",
        "all_utm_ids",
        "last_utm_id",
        "first_utm_id",
        "marketo_sync_exclusion_reason",
        "fivetran_active_status"
    FROM "sf_lead_data_projected_renamed"
),

"sf_lead_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_all_data_warehouses: from DECIMAL to VARCHAR
    -- account_bi_tools: from DECIMAL to VARCHAR
    -- account_connectors: from DECIMAL to VARCHAR
    -- account_data_warehouses: from DECIMAL to VARCHAR
    -- account_id: from DECIMAL to VARCHAR
    -- account_products: from DECIMAL to VARCHAR
    -- acquisition_date: from DECIMAL to DATE
    -- acquisition_program: from DECIMAL to VARCHAR
    -- acquisition_program_id: from DECIMAL to VARCHAR
    -- act_on_lead_score: from DECIMAL to INT
    -- actoncity_c: from DECIMAL to VARCHAR
    -- actoncountry_c: from DECIMAL to VARCHAR
    -- actoncountrycode_c: from DECIMAL to VARCHAR
    -- actonpostalcode_c: from DECIMAL to VARCHAR
    -- actonstate_c: from DECIMAL to VARCHAR
    -- ad_group_id: from DECIMAL to VARCHAR
    -- alexa_rank: from DECIMAL to INT
    -- all_lead_source_categories: from DECIMAL to ARRAY
    -- all_lead_source_details: from DECIMAL to ARRAY
    -- all_lead_sources: from DECIMAL to ARRAY
    -- all_utm_campaigns: from DECIMAL to ARRAY
    -- all_utm_content: from DECIMAL to ARRAY
    -- all_utm_ids: from DECIMAL to ARRAY
    -- all_utm_mediums: from DECIMAL to ARRAY
    -- all_utm_sources: from DECIMAL to ARRAY
    -- all_utm_terms: from DECIMAL to ARRAY
    -- allbound_id: from DECIMAL to VARCHAR
    -- annual_revenue: from INT to DECIMAL
    -- audience_names: from DECIMAL to VARCHAR
    -- automation_tracking: from DECIMAL to VARCHAR
    -- beta_connector_interest: from DECIMAL to VARCHAR
    -- bizible_account_id: from DECIMAL to VARCHAR
    -- bizible_first_touch_campaign: from DECIMAL to VARCHAR
    -- bizible_first_touch_landing_page: from DECIMAL to VARCHAR
    -- bizible_first_touch_marketing_channel: from DECIMAL to VARCHAR
    -- bizible_id: from DECIMAL to VARCHAR
    -- bizible_last_touch_campaign: from DECIMAL to VARCHAR
    -- bizible_last_touch_landing_page: from DECIMAL to VARCHAR
    -- bombora_last_updated: from DECIMAL to TIMESTAMP
    -- bombora_surge_count: from DECIMAL to INT
    -- bounced_email_c: from DECIMAL to BOOLEAN
    -- cadence_trigger: from DECIMAL to VARCHAR
    -- calendly_created_date: from DECIMAL to TIMESTAMP
    -- campaignid_c: from DECIMAL to VARCHAR
    -- city: from DECIMAL to VARCHAR
    -- clarus_date: from DECIMAL to DATE
    -- clarus_editor: from DECIMAL to VARCHAR
    -- clarus_notes: from DECIMAL to VARCHAR
    -- clarus_project_id: from DECIMAL to VARCHAR
    -- clarus_status: from DECIMAL to VARCHAR
    -- clearbit_status: from DECIMAL to VARCHAR
    -- cloudingo_agent_ar: from DECIMAL to VARCHAR
    -- cloudingo_agent_ardi: from DECIMAL to VARCHAR
    -- cloudingo_agent_atz: from DECIMAL to VARCHAR
    -- cloudingo_agent_av: from DECIMAL to VARCHAR
    -- company_phone: from DECIMAL to VARCHAR
    -- company_revenue: from DECIMAL to VARCHAR
    -- company_type: from DECIMAL to VARCHAR
    -- competitors: from DECIMAL to VARCHAR
    -- connector_products: from DECIMAL to VARCHAR
    -- contact_owner_override: from DECIMAL to VARCHAR
    -- contact_status: from DECIMAL to VARCHAR
    -- conversion_date: from DECIMAL to VARCHAR
    -- conversion_object_name: from DECIMAL to VARCHAR
    -- conversion_object_type: from DECIMAL to VARCHAR
    -- converted_date: from VARCHAR to TIMESTAMP
    -- converted_datetime: from VARCHAR to TIMESTAMP
    -- converted_opportunity_id: from DECIMAL to VARCHAR
    -- country: from DECIMAL to VARCHAR
    -- country_code: from DECIMAL to VARCHAR
    -- country_custom: from DECIMAL to VARCHAR
    -- created_date: from VARCHAR to TIMESTAMP
    -- created_timestamp: from DECIMAL to VARCHAR
    -- creative_content: from DECIMAL to VARCHAR
    -- csi_code: from DECIMAL to VARCHAR
    -- current_user_gems_info: from DECIMAL to VARCHAR
    -- custom_city: from DECIMAL to VARCHAR
    -- data_warehouse_products: from DECIMAL to VARCHAR
    -- data_warehouse_used: from DECIMAL to VARCHAR
    -- demographic_score: from DECIMAL to VARCHAR
    -- description: from DECIMAL to VARCHAR
    -- device: from DECIMAL to VARCHAR
    -- direct_office: from DECIMAL to VARCHAR
    -- district: from DECIMAL to VARCHAR
    -- dnb_company_record: from DECIMAL to VARCHAR
    -- dnb_contact_record: from DECIMAL to VARCHAR
    -- domain_exists: from DECIMAL to VARCHAR
    -- drift_cql_status: from DECIMAL to VARCHAR
    -- duns_number: from DECIMAL to VARCHAR
    -- email_bounce_date: from DECIMAL to DATE
    -- email_bounce_reason: from DECIMAL to VARCHAR
    -- email_catchall: from DECIMAL to VARCHAR
    -- email_opt_in: from DECIMAL to VARCHAR
    -- email_opt_out_date_time_c: from DECIMAL to TIMESTAMP
    -- employee_range: from DECIMAL to VARCHAR
    -- engagio_department: from DECIMAL to VARCHAR
    -- engagio_engagement_minutes_3m: from DECIMAL to VARCHAR
    -- engagio_first_engagement_date: from DECIMAL to DATE
    -- engagio_match_time: from DECIMAL to TIMESTAMP
    -- engagio_matched_account: from DECIMAL to VARCHAR
    -- engagio_role: from DECIMAL to VARCHAR
    -- enriched_city: from DECIMAL to VARCHAR
    -- enriched_timestamp: from DECIMAL to TIMESTAMP
    -- es_app_escountry_c: from DECIMAL to VARCHAR
    -- es_app_esecid_c: from DECIMAL to VARCHAR
    -- es_app_esemployees_c: from DECIMAL to INT
    -- es_app_eslinked_in_c: from DECIMAL to VARCHAR
    -- es_app_essource_c: from DECIMAL to VARCHAR
    -- es_app_esstate_c: from DECIMAL to VARCHAR
    -- facebook_url: from DECIMAL to VARCHAR
    -- fax: from DECIMAL to VARCHAR
    -- feature_requests: from DECIMAL to VARCHAR
    -- first_activity: from DECIMAL to VARCHAR
    -- first_lead_source: from DECIMAL to VARCHAR
    -- first_lead_source_category: from DECIMAL to VARCHAR
    -- first_lead_source_detail: from DECIMAL to VARCHAR
    -- first_mql_date: from DECIMAL to DATE
    -- first_search_term: from DECIMAL to VARCHAR
    -- first_search_type: from DECIMAL to VARCHAR
    -- first_touch_url: from DECIMAL to VARCHAR
    -- first_touchpoint_date: from DECIMAL to DATE
    -- first_touchpoint_source: from DECIMAL to VARCHAR
    -- first_utm_campaign: from DECIMAL to VARCHAR
    -- first_utm_content: from DECIMAL to VARCHAR
    -- first_utm_id: from DECIMAL to VARCHAR
    -- first_utm_medium: from DECIMAL to VARCHAR
    -- first_utm_source: from DECIMAL to VARCHAR
    -- first_utm_term: from DECIMAL to VARCHAR
    -- fivetran_account_id: from DECIMAL to VARCHAR
    -- fivetran_account_stage: from DECIMAL to VARCHAR
    -- fivetran_active_status: from DECIMAL to BOOLEAN
    -- fivetran_association_date: from DECIMAL to DATE
    -- fivetran_user_id: from DECIMAL to VARCHAR
    -- fivetran_user_roles: from DECIMAL to VARCHAR
    -- free_trial_confirmation_date: from DECIMAL to DATE
    -- geo_city_c: from DECIMAL to VARCHAR
    -- geo_country_c: from DECIMAL to VARCHAR
    -- geo_country_code_c: from DECIMAL to VARCHAR
    -- geo_postal_code_c: from DECIMAL to VARCHAR
    -- geo_state_c: from DECIMAL to VARCHAR
    -- geocode_accuracy: from DECIMAL to VARCHAR
    -- google_click_id: from DECIMAL to VARCHAR
    -- has_changed_job: from DECIMAL to BOOLEAN
    -- hvr_channel: from DECIMAL to VARCHAR
    -- i_sell_os_key_id: from DECIMAL to VARCHAR
    -- individual_id: from DECIMAL to VARCHAR
    -- industry: from DECIMAL to VARCHAR
    -- inferred_city: from DECIMAL to VARCHAR
    -- inferred_company: from DECIMAL to VARCHAR
    -- inferred_country: from DECIMAL to VARCHAR
    -- inferred_metro_area: from DECIMAL to VARCHAR
    -- inferred_phone_area_code: from DECIMAL to VARCHAR
    -- inferred_postal_code: from DECIMAL to VARCHAR
    -- inferred_state_region: from DECIMAL to VARCHAR
    -- intent_timestamp: from DECIMAL to TIMESTAMP
    -- intent_topics: from DECIMAL to ARRAY
    -- is_enriched: from DECIMAL to BOOLEAN
    -- is_previous_customer: from DECIMAL to BOOLEAN
    -- is_startup: from DECIMAL to BOOLEAN
    -- jigsaw_contact_id: from DECIMAL to VARCHAR
    -- job_title: from DECIMAL to VARCHAR
    -- keywords: from DECIMAL to ARRAY
    -- last_activity: from DECIMAL to VARCHAR
    -- last_activity_date: from DECIMAL to DATE
    -- last_completed_cadence_step: from DECIMAL to VARCHAR
    -- last_interesting_moment_date: from VARCHAR to TIMESTAMP
    -- last_lead_source: from DECIMAL to VARCHAR
    -- last_lead_source_category: from DECIMAL to VARCHAR
    -- last_lead_source_detail: from DECIMAL to VARCHAR
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- last_modified_timestamp: from VARCHAR to TIMESTAMP
    -- last_referenced_date: from DECIMAL to DATE
    -- last_touchpoint_date: from DECIMAL to DATE
    -- last_touchpoint_source: from DECIMAL to VARCHAR
    -- last_utm_id: from DECIMAL to VARCHAR
    -- last_viewed_date: from DECIMAL to DATE
    -- lead_bi_tools: from DECIMAL to VARCHAR
    -- lead_comments: from DECIMAL to VARCHAR
    -- lead_creation_date: from DECIMAL to DATE
    -- lead_creation_datetime: from VARCHAR to TIMESTAMP
    -- lead_grade: from DECIMAL to VARCHAR
    -- lead_iq_country_c: from DECIMAL to VARCHAR
    -- lead_iq_employee_count_c: from DECIMAL to INT
    -- lead_iq_state_c: from DECIMAL to VARCHAR
    -- lead_keyword: from DECIMAL to VARCHAR
    -- lead_notes: from DECIMAL to VARCHAR
    -- lead_number_c: from INT to VARCHAR
    -- lead_referrer: from DECIMAL to VARCHAR
    -- lead_source: from DECIMAL to VARCHAR
    -- lead_source_details: from DECIMAL to VARCHAR
    -- lead_state_acton: from DECIMAL to VARCHAR
    -- lead_tags: from DECIMAL to VARCHAR
    -- lead_type: from DECIMAL to VARCHAR
    -- lead_url: from DECIMAL to VARCHAR
    -- lead_zip_code: from DECIMAL to VARCHAR
    -- leandata_account: from DECIMAL to VARCHAR
    -- leandata_group: from DECIMAL to VARCHAR
    -- leandata_segment: from DECIMAL to VARCHAR
    -- legacy_id: from DECIMAL to VARCHAR
    -- linked_in_url_c: from DECIMAL to VARCHAR
    -- linkedin_company_id: from DECIMAL to VARCHAR
    -- linkedin_member_token: from DECIMAL to VARCHAR
    -- linkedin_profile: from DECIMAL to VARCHAR
    -- marketing_channel: from DECIMAL to VARCHAR
    -- marketing_cloud_subscriber: from DECIMAL to VARCHAR
    -- marketing_connector_interest: from DECIMAL to VARCHAR
    -- marketing_process_stage: from DECIMAL to VARCHAR
    -- marketing_system_creation_date: from DECIMAL to TIMESTAMP
    -- marketo_contact_id: from DECIMAL to VARCHAR
    -- marketo_sync_exclusion_reason: from DECIMAL to VARCHAR
    -- master_record_id: from DECIMAL to VARCHAR
    -- match_type: from DECIMAL to VARCHAR
    -- matched_account: from DECIMAL to VARCHAR
    -- matched_buyer_persona: from DECIMAL to VARCHAR
    -- matched_lead: from DECIMAL to VARCHAR
    -- metadata_creation_date: from VARCHAR to TIMESTAMP
    -- mkto_71_lead_score_c: from DECIMAL to VARCHAR
    -- mobile_phone: from DECIMAL to VARCHAR
    -- modified_score: from DECIMAL to VARCHAR
    -- mql_date: from DECIMAL to DATE
    -- needs_score_sync: from DECIMAL to BOOLEAN
    -- network: from DECIMAL to VARCHAR
    -- next_cadence_step_due_date: from DECIMAL to DATE
    -- notes: from DECIMAL to VARCHAR
    -- number_of_employees: from DECIMAL to INT
    -- opportunity_competitors: from DECIMAL to VARCHAR
    -- opportunity_products: from DECIMAL to VARCHAR
    -- original_referrer: from DECIMAL to VARCHAR
    -- original_search_engine: from DECIMAL to VARCHAR
    -- original_search_phrase: from DECIMAL to VARCHAR
    -- original_source_info: from DECIMAL to VARCHAR
    -- original_source_type: from DECIMAL to VARCHAR
    -- original_utm_campaign_c: from DECIMAL to VARCHAR
    -- original_utm_content_c: from DECIMAL to VARCHAR
    -- original_utm_medium_c: from DECIMAL to VARCHAR
    -- original_utm_source_c: from DECIMAL to VARCHAR
    -- original_utm_term_c: from DECIMAL to VARCHAR
    -- pardot_hard_bounced: from DECIMAL to BOOLEAN
    -- pardot_last_scored_at: from DECIMAL to TIMESTAMP
    -- partner_rep_email: from DECIMAL to VARCHAR
    -- partner_rep_name: from DECIMAL to VARCHAR
    -- partner_type: from DECIMAL to VARCHAR
    -- past_account: from DECIMAL to VARCHAR
    -- past_user_gems_info: from DECIMAL to VARCHAR
    -- phone: from DECIMAL to VARCHAR
    -- phone_number_catch_all: from DECIMAL to VARCHAR
    -- pi_campaign_c: from DECIMAL to VARCHAR
    -- pi_utm_campaign_c: from DECIMAL to VARCHAR
    -- pi_utm_content_c: from DECIMAL to VARCHAR
    -- pi_utm_medium_c: from DECIMAL to VARCHAR
    -- pi_utm_source_c: from DECIMAL to VARCHAR
    -- pi_utm_term_c: from DECIMAL to VARCHAR
    -- postal_code: from DECIMAL to VARCHAR
    -- previous_company: from DECIMAL to VARCHAR
    -- previous_contact_info: from DECIMAL to VARCHAR
    -- previous_job_title: from DECIMAL to VARCHAR
    -- previous_lead_source: from DECIMAL to VARCHAR
    -- previous_lead_source_detail: from DECIMAL to VARCHAR
    -- primary_contact: from DECIMAL to VARCHAR
    -- promotion_id: from DECIMAL to VARCHAR
    -- recent_cadence_name: from DECIMAL to VARCHAR
    -- recent_campaign_status: from DECIMAL to VARCHAR
    -- referral_account: from DECIMAL to VARCHAR
    -- referral_contact: from DECIMAL to VARCHAR
    -- referral_email: from DECIMAL to VARCHAR
    -- referral_first_name: from DECIMAL to VARCHAR
    -- referral_last_name: from DECIMAL to VARCHAR
    -- region_c: from DECIMAL to VARCHAR
    -- relative_score: from DECIMAL to VARCHAR
    -- reporting_timestamp: from VARCHAR to TIMESTAMP
    -- reroute_flag: from DECIMAL to VARCHAR
    -- router_status: from DECIMAL to VARCHAR
    -- sales_email_opt_out_date_time_c: from DECIMAL to TIMESTAMP
    -- sales_insight_hide_date: from DECIMAL to DATE
    -- sales_volume_millions: from INT to DECIMAL
    -- salutation: from DECIMAL to VARCHAR
    -- search_terms: from DECIMAL to VARCHAR
    -- secondary_email: from DECIMAL to VARCHAR
    -- source_detail: from DECIMAL to VARCHAR
    -- state: from DECIMAL to VARCHAR
    -- state_code: from DECIMAL to VARCHAR
    -- state_custom: from DECIMAL to VARCHAR
    -- status_info: from DECIMAL to VARCHAR
    -- street: from DECIMAL to VARCHAR
    -- street_address: from DECIMAL to VARCHAR
    -- technologies: from DECIMAL to VARCHAR
    -- territory: from DECIMAL to VARCHAR
    -- timeframe: from DECIMAL to VARCHAR
    -- trial_start_date: from DECIMAL to DATE
    -- twitter_url: from DECIMAL to VARCHAR
    -- unique_email: from DECIMAL to VARCHAR
    -- up_region_c: from DECIMAL to VARCHAR
    -- user_gems_id: from DECIMAL to UUID
    -- utm_campaign_c: from DECIMAL to VARCHAR
    -- utm_content_c: from DECIMAL to VARCHAR
    -- utm_id: from DECIMAL to VARCHAR
    -- utm_medium_c: from DECIMAL to VARCHAR
    -- utm_source_c: from DECIMAL to VARCHAR
    -- utm_term_c: from DECIMAL to VARCHAR
    -- website: from DECIMAL to VARCHAR
    -- zip_code: from DECIMAL to VARCHAR
    -- zoominfo_company_id: from DECIMAL to UUID
    -- zoominfo_country: from DECIMAL to VARCHAR
    -- zoominfo_employee_count: from DECIMAL to INT
    -- zoominfo_first_update_date: from DECIMAL to DATE
    -- zoominfo_id: from DECIMAL to UUID
    -- zoominfo_last_update_date: from DECIMAL to DATE
    -- zoominfo_state: from DECIMAL to VARCHAR
    -- zoominfo_technologies: from DECIMAL to ARRAY
    -- zoominfo_zip_code: from DECIMAL to VARCHAR
    SELECT
        "owner_id",
        "last_modified_by_id",
        "converted_contact_id",
        "id",
        "photo_url",
        "longitude",
        "name",
        "created_by_id",
        "is_converted",
        "is_unread_by_owner",
        "status",
        "lead_latitude",
        "lead_industry",
        "is_deleted",
        "company_name",
        "first_name",
        "email",
        "lead_last_name",
        "active_in_sequence",
        "clearbit_data_ready",
        "has_opted_out_of_email",
        "converted_salesforce_account_id",
        "demo_scheduled_calendly",
        "marked_for_deletion",
        "email_quality",
        "email_bounced_c",
        "created_by_clearbit",
        "pi_score_c",
        "is_competitor",
        "routing_action",
        "search_index",
        "reporting_matched_account_id",
        "routing_status",
        "do_not_route_lead",
        "contact_stage",
        "intent_score",
        "fit_score",
        "prospect_routing_rules",
        "email_explicit_opt_in",
        "email_implicit_opt_in",
        "gdpr_opt_in_status",
        "is_user_gem",
        "last_interaction_description",
        "last_interaction_source",
        "last_interaction_type",
        "lead_priority_score",
        "lead_urgency",
        "cloudingo_agent_as",
        "cloudingo_agent_les",
        "marketo_sync_exclusion",
        "last_utm_campaign",
        "last_utm_content",
        "last_utm_medium",
        "last_utm_source",
        "last_utm_term",
        "behavioral_score",
        "is_emea_event_routing",
        "csi_description",
        "attended_event",
        "manual_route_trigger",
        "mql_reason",
        "enrichment_request",
        "fivetran_use_case",
        "sales_email_opt_out_c",
        "bombora_composite_score",
        "created_by_user_gems",
        "is_verified",
        "startup_certification_eligible",
        "engagio_intent_minutes_30d",
        "engagio_engagement_minutes_7d",
        "email_double_opt_in",
        CAST("account_all_data_warehouses" AS VARCHAR) AS "account_all_data_warehouses",
        CAST("account_bi_tools" AS VARCHAR) AS "account_bi_tools",
        CAST("account_connectors" AS VARCHAR) AS "account_connectors",
        CAST("account_data_warehouses" AS VARCHAR) AS "account_data_warehouses",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("account_products" AS VARCHAR) AS "account_products",
        CAST("acquisition_date" AS DATE) AS "acquisition_date",
        CAST("acquisition_program" AS VARCHAR) AS "acquisition_program",
        CAST("acquisition_program_id" AS VARCHAR) AS "acquisition_program_id",
        CAST("act_on_lead_score" AS INT) AS "act_on_lead_score",
        CAST("actoncity_c" AS VARCHAR) AS "actoncity_c",
        CAST("actoncountry_c" AS VARCHAR) AS "actoncountry_c",
        CAST("actoncountrycode_c" AS VARCHAR) AS "actoncountrycode_c",
        CAST("actonpostalcode_c" AS VARCHAR) AS "actonpostalcode_c",
        CAST("actonstate_c" AS VARCHAR) AS "actonstate_c",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        CAST("alexa_rank" AS INTEGER) AS "alexa_rank",
        string_split('', ',') AS "all_lead_source_categories",
        array_to_string(array["all_lead_source_details"], ',') AS "all_lead_source_details",
        string_split(COALESCE(CAST("all_lead_sources" AS VARCHAR), ''), ',') AS "all_lead_sources",
        COALESCE(json_array("all_utm_campaigns"), '[]')::JSON[] AS "all_utm_campaigns",
        "all_utm_content" AS "all_utm_content",
        CAST("all_utm_ids" AS JSON[]) AS "all_utm_ids",
        STRING_SPLIT('', ',') AS "all_utm_mediums",
        COALESCE(JSON_ARRAY("all_utm_sources"), '[]') AS "all_utm_sources",
        CAST("all_utm_terms" AS VARCHAR[]) AS "all_utm_terms",
        CAST("allbound_id" AS VARCHAR) AS "allbound_id",
        CAST("annual_revenue" AS DECIMAL) AS "annual_revenue",
        CAST("audience_names" AS VARCHAR) AS "audience_names",
        CAST("automation_tracking" AS VARCHAR) AS "automation_tracking",
        CAST("beta_connector_interest" AS VARCHAR) AS "beta_connector_interest",
        CAST("bizible_account_id" AS VARCHAR) AS "bizible_account_id",
        CAST("bizible_first_touch_campaign" AS VARCHAR) AS "bizible_first_touch_campaign",
        CAST("bizible_first_touch_landing_page" AS VARCHAR) AS "bizible_first_touch_landing_page",
        CAST("bizible_first_touch_marketing_channel" AS VARCHAR) AS "bizible_first_touch_marketing_channel",
        CAST("bizible_id" AS VARCHAR) AS "bizible_id",
        CAST("bizible_last_touch_campaign" AS VARCHAR) AS "bizible_last_touch_campaign",
        CAST("bizible_last_touch_landing_page" AS VARCHAR) AS "bizible_last_touch_landing_page",
        CAST("bombora_last_updated" AS TIMESTAMP) AS "bombora_last_updated",
        CAST("bombora_surge_count" AS INT) AS "bombora_surge_count",
        CAST("bounced_email_c" AS BOOLEAN) AS "bounced_email_c",
        CAST("cadence_trigger" AS VARCHAR) AS "cadence_trigger",
        CAST("calendly_created_date" AS TIMESTAMP) AS "calendly_created_date",
        CAST("campaignid_c" AS VARCHAR) AS "campaignid_c",
        CAST("city" AS VARCHAR) AS "city",
        CAST("clarus_date" AS DATE) AS "clarus_date",
        CAST("clarus_editor" AS VARCHAR) AS "clarus_editor",
        CAST("clarus_notes" AS VARCHAR) AS "clarus_notes",
        CAST("clarus_project_id" AS VARCHAR) AS "clarus_project_id",
        CAST("clarus_status" AS VARCHAR) AS "clarus_status",
        CAST("clearbit_status" AS VARCHAR) AS "clearbit_status",
        CAST("cloudingo_agent_ar" AS VARCHAR) AS "cloudingo_agent_ar",
        CAST("cloudingo_agent_ardi" AS VARCHAR) AS "cloudingo_agent_ardi",
        CAST("cloudingo_agent_atz" AS VARCHAR) AS "cloudingo_agent_atz",
        CAST("cloudingo_agent_av" AS VARCHAR) AS "cloudingo_agent_av",
        CAST("company_phone" AS VARCHAR) AS "company_phone",
        CAST("company_revenue" AS VARCHAR) AS "company_revenue",
        CAST("company_type" AS VARCHAR) AS "company_type",
        CAST("competitors" AS VARCHAR) AS "competitors",
        CAST("connector_products" AS VARCHAR) AS "connector_products",
        CAST("contact_owner_override" AS VARCHAR) AS "contact_owner_override",
        CAST("contact_status" AS VARCHAR) AS "contact_status",
        CAST("conversion_date" AS VARCHAR) AS "conversion_date",
        CAST("conversion_object_name" AS VARCHAR) AS "conversion_object_name",
        CAST("conversion_object_type" AS VARCHAR) AS "conversion_object_type",
        CAST("converted_date" AS TIMESTAMP) AS "converted_date",
        CAST("converted_datetime" AS TIMESTAMP) AS "converted_datetime",
        CAST("converted_opportunity_id" AS VARCHAR) AS "converted_opportunity_id",
        CAST("country" AS VARCHAR) AS "country",
        CAST("country_code" AS VARCHAR) AS "country_code",
        CAST("country_custom" AS VARCHAR) AS "country_custom",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("created_timestamp" AS VARCHAR) AS "created_timestamp",
        CAST("creative_content" AS VARCHAR) AS "creative_content",
        CAST("csi_code" AS VARCHAR) AS "csi_code",
        CAST("current_user_gems_info" AS VARCHAR) AS "current_user_gems_info",
        CAST("custom_city" AS VARCHAR) AS "custom_city",
        CAST("data_warehouse_products" AS VARCHAR) AS "data_warehouse_products",
        CAST("data_warehouse_used" AS VARCHAR) AS "data_warehouse_used",
        CAST("demographic_score" AS VARCHAR) AS "demographic_score",
        CAST("description" AS VARCHAR) AS "description",
        CAST("device" AS VARCHAR) AS "device",
        CAST("direct_office" AS VARCHAR) AS "direct_office",
        CAST("district" AS VARCHAR) AS "district",
        CAST("dnb_company_record" AS VARCHAR) AS "dnb_company_record",
        CAST("dnb_contact_record" AS VARCHAR) AS "dnb_contact_record",
        CAST("domain_exists" AS VARCHAR) AS "domain_exists",
        CAST("drift_cql_status" AS VARCHAR) AS "drift_cql_status",
        CAST("duns_number" AS VARCHAR) AS "duns_number",
        CAST("email_bounce_date" AS DATE) AS "email_bounce_date",
        CAST("email_bounce_reason" AS VARCHAR) AS "email_bounce_reason",
        CAST("email_catchall" AS VARCHAR) AS "email_catchall",
        CAST("email_opt_in" AS VARCHAR) AS "email_opt_in",
        CAST("email_opt_out_date_time_c" AS TIMESTAMP) AS "email_opt_out_date_time_c",
        CAST("employee_range" AS VARCHAR) AS "employee_range",
        CAST("engagio_department" AS VARCHAR) AS "engagio_department",
        CAST("engagio_engagement_minutes_3m" AS VARCHAR) AS "engagio_engagement_minutes_3m",
        CAST("engagio_first_engagement_date" AS DATE) AS "engagio_first_engagement_date",
        CAST("engagio_match_time" AS TIMESTAMP) AS "engagio_match_time",
        CAST("engagio_matched_account" AS VARCHAR) AS "engagio_matched_account",
        CAST("engagio_role" AS VARCHAR) AS "engagio_role",
        CAST("enriched_city" AS VARCHAR) AS "enriched_city",
        CAST("enriched_timestamp" AS TIMESTAMP) AS "enriched_timestamp",
        CAST("es_app_escountry_c" AS VARCHAR) AS "es_app_escountry_c",
        CAST("es_app_esecid_c" AS VARCHAR) AS "es_app_esecid_c",
        CAST("es_app_esemployees_c" AS INT) AS "es_app_esemployees_c",
        CAST("es_app_eslinked_in_c" AS VARCHAR) AS "es_app_eslinked_in_c",
        CAST("es_app_essource_c" AS VARCHAR) AS "es_app_essource_c",
        CAST("es_app_esstate_c" AS VARCHAR) AS "es_app_esstate_c",
        CAST("facebook_url" AS VARCHAR) AS "facebook_url",
        CAST("fax" AS VARCHAR) AS "fax",
        CAST("feature_requests" AS VARCHAR) AS "feature_requests",
        CAST("first_activity" AS VARCHAR) AS "first_activity",
        CAST("first_lead_source" AS VARCHAR) AS "first_lead_source",
        CAST("first_lead_source_category" AS VARCHAR) AS "first_lead_source_category",
        CAST("first_lead_source_detail" AS VARCHAR) AS "first_lead_source_detail",
        CAST("first_mql_date" AS DATE) AS "first_mql_date",
        CAST("first_search_term" AS VARCHAR) AS "first_search_term",
        CAST("first_search_type" AS VARCHAR) AS "first_search_type",
        CAST("first_touch_url" AS VARCHAR) AS "first_touch_url",
        CAST("first_touchpoint_date" AS DATE) AS "first_touchpoint_date",
        CAST("first_touchpoint_source" AS VARCHAR) AS "first_touchpoint_source",
        CAST("first_utm_campaign" AS VARCHAR) AS "first_utm_campaign",
        CAST("first_utm_content" AS VARCHAR) AS "first_utm_content",
        CAST("first_utm_id" AS VARCHAR) AS "first_utm_id",
        CAST("first_utm_medium" AS VARCHAR) AS "first_utm_medium",
        CAST("first_utm_source" AS VARCHAR) AS "first_utm_source",
        CAST("first_utm_term" AS VARCHAR) AS "first_utm_term",
        CAST("fivetran_account_id" AS VARCHAR) AS "fivetran_account_id",
        CAST("fivetran_account_stage" AS VARCHAR) AS "fivetran_account_stage",
        CAST("fivetran_active_status" AS BOOLEAN) AS "fivetran_active_status",
        CAST("fivetran_association_date" AS DATE) AS "fivetran_association_date",
        CAST("fivetran_user_id" AS VARCHAR) AS "fivetran_user_id",
        CAST("fivetran_user_roles" AS VARCHAR) AS "fivetran_user_roles",
        CAST("free_trial_confirmation_date" AS DATE) AS "free_trial_confirmation_date",
        CAST("geo_city_c" AS VARCHAR) AS "geo_city_c",
        CAST("geo_country_c" AS VARCHAR) AS "geo_country_c",
        CAST("geo_country_code_c" AS VARCHAR) AS "geo_country_code_c",
        CAST("geo_postal_code_c" AS VARCHAR) AS "geo_postal_code_c",
        CAST("geo_state_c" AS VARCHAR) AS "geo_state_c",
        CAST("geocode_accuracy" AS VARCHAR) AS "geocode_accuracy",
        CAST("google_click_id" AS VARCHAR) AS "google_click_id",
        CAST("has_changed_job" AS BOOLEAN) AS "has_changed_job",
        CAST("hvr_channel" AS VARCHAR) AS "hvr_channel",
        CAST("i_sell_os_key_id" AS VARCHAR) AS "i_sell_os_key_id",
        CAST("individual_id" AS VARCHAR) AS "individual_id",
        CAST("industry" AS VARCHAR) AS "industry",
        CAST("inferred_city" AS VARCHAR) AS "inferred_city",
        CAST("inferred_company" AS VARCHAR) AS "inferred_company",
        CAST("inferred_country" AS VARCHAR) AS "inferred_country",
        CAST("inferred_metro_area" AS VARCHAR) AS "inferred_metro_area",
        CAST("inferred_phone_area_code" AS VARCHAR) AS "inferred_phone_area_code",
        CAST("inferred_postal_code" AS VARCHAR) AS "inferred_postal_code",
        CAST("inferred_state_region" AS VARCHAR) AS "inferred_state_region",
        CAST("intent_timestamp" AS TIMESTAMP) AS "intent_timestamp",
        JSON_ARRAY("intent_topics") AS "intent_topics",
        CAST("is_enriched" AS BOOLEAN) AS "is_enriched",
        CAST("is_previous_customer" AS BOOLEAN) AS "is_previous_customer",
        CAST("is_startup" AS BOOLEAN) AS "is_startup",
        CAST("jigsaw_contact_id" AS VARCHAR) AS "jigsaw_contact_id",
        CAST("job_title" AS VARCHAR) AS "job_title",
        STRING_SPLIT(CAST("keywords" AS VARCHAR), ',') AS "keywords",
        CAST("last_activity" AS VARCHAR) AS "last_activity",
        CAST("last_activity_date" AS DATE) AS "last_activity_date",
        CAST("last_completed_cadence_step" AS VARCHAR) AS "last_completed_cadence_step",
        CAST("last_interesting_moment_date" AS TIMESTAMP) AS "last_interesting_moment_date",
        CAST("last_lead_source" AS VARCHAR) AS "last_lead_source",
        CAST("last_lead_source_category" AS VARCHAR) AS "last_lead_source_category",
        CAST("last_lead_source_detail" AS VARCHAR) AS "last_lead_source_detail",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("last_modified_timestamp" AS TIMESTAMP) AS "last_modified_timestamp",
        CAST("last_referenced_date" AS DATE) AS "last_referenced_date",
        CAST("last_touchpoint_date" AS DATE) AS "last_touchpoint_date",
        CAST("last_touchpoint_source" AS VARCHAR) AS "last_touchpoint_source",
        CAST("last_utm_id" AS VARCHAR) AS "last_utm_id",
        CAST("last_viewed_date" AS DATE) AS "last_viewed_date",
        CAST("lead_bi_tools" AS VARCHAR) AS "lead_bi_tools",
        CAST("lead_comments" AS VARCHAR) AS "lead_comments",
        CAST("lead_creation_date" AS DATE) AS "lead_creation_date",
        CAST("lead_creation_datetime" AS TIMESTAMP) AS "lead_creation_datetime",
        CAST("lead_grade" AS VARCHAR) AS "lead_grade",
        CAST("lead_iq_country_c" AS VARCHAR) AS "lead_iq_country_c",
        CAST("lead_iq_employee_count_c" AS INT) AS "lead_iq_employee_count_c",
        CAST("lead_iq_state_c" AS VARCHAR) AS "lead_iq_state_c",
        CAST("lead_keyword" AS VARCHAR) AS "lead_keyword",
        CAST("lead_notes" AS VARCHAR) AS "lead_notes",
        CAST("lead_number_c" AS VARCHAR) AS "lead_number_c",
        CAST("lead_referrer" AS VARCHAR) AS "lead_referrer",
        CAST("lead_source" AS VARCHAR) AS "lead_source",
        CAST("lead_source_details" AS VARCHAR) AS "lead_source_details",
        CAST("lead_state_acton" AS VARCHAR) AS "lead_state_acton",
        CAST("lead_tags" AS VARCHAR) AS "lead_tags",
        CAST("lead_type" AS VARCHAR) AS "lead_type",
        CAST("lead_url" AS VARCHAR) AS "lead_url",
        CAST("lead_zip_code" AS VARCHAR) AS "lead_zip_code",
        CAST("leandata_account" AS VARCHAR) AS "leandata_account",
        CAST("leandata_group" AS VARCHAR) AS "leandata_group",
        CAST("leandata_segment" AS VARCHAR) AS "leandata_segment",
        CAST("legacy_id" AS VARCHAR) AS "legacy_id",
        CAST("linked_in_url_c" AS VARCHAR) AS "linked_in_url_c",
        CAST("linkedin_company_id" AS VARCHAR) AS "linkedin_company_id",
        CAST("linkedin_member_token" AS VARCHAR) AS "linkedin_member_token",
        CAST("linkedin_profile" AS VARCHAR) AS "linkedin_profile",
        CAST("marketing_channel" AS VARCHAR) AS "marketing_channel",
        CAST("marketing_cloud_subscriber" AS VARCHAR) AS "marketing_cloud_subscriber",
        CAST("marketing_connector_interest" AS VARCHAR) AS "marketing_connector_interest",
        CAST("marketing_process_stage" AS VARCHAR) AS "marketing_process_stage",
        CAST("marketing_system_creation_date" AS TIMESTAMP) AS "marketing_system_creation_date",
        CAST("marketo_contact_id" AS VARCHAR) AS "marketo_contact_id",
        CAST("marketo_sync_exclusion_reason" AS VARCHAR) AS "marketo_sync_exclusion_reason",
        CAST("master_record_id" AS VARCHAR) AS "master_record_id",
        CAST("match_type" AS VARCHAR) AS "match_type",
        CAST("matched_account" AS VARCHAR) AS "matched_account",
        CAST("matched_buyer_persona" AS VARCHAR) AS "matched_buyer_persona",
        CAST("matched_lead" AS VARCHAR) AS "matched_lead",
        CAST("metadata_creation_date" AS TIMESTAMP) AS "metadata_creation_date",
        CAST("mkto_71_lead_score_c" AS VARCHAR) AS "mkto_71_lead_score_c",
        CAST("mobile_phone" AS VARCHAR) AS "mobile_phone",
        CAST("modified_score" AS VARCHAR) AS "modified_score",
        CAST("mql_date" AS DATE) AS "mql_date",
        CAST("needs_score_sync" AS BOOLEAN) AS "needs_score_sync",
        CAST("network" AS VARCHAR) AS "network",
        CAST("next_cadence_step_due_date" AS DATE) AS "next_cadence_step_due_date",
        CAST("notes" AS VARCHAR) AS "notes",
        CAST("number_of_employees" AS INT) AS "number_of_employees",
        CAST("opportunity_competitors" AS VARCHAR) AS "opportunity_competitors",
        CAST("opportunity_products" AS VARCHAR) AS "opportunity_products",
        CAST("original_referrer" AS VARCHAR) AS "original_referrer",
        CAST("original_search_engine" AS VARCHAR) AS "original_search_engine",
        CAST("original_search_phrase" AS VARCHAR) AS "original_search_phrase",
        CAST("original_source_info" AS VARCHAR) AS "original_source_info",
        CAST("original_source_type" AS VARCHAR) AS "original_source_type",
        CAST("original_utm_campaign_c" AS VARCHAR) AS "original_utm_campaign_c",
        CAST("original_utm_content_c" AS VARCHAR) AS "original_utm_content_c",
        CAST("original_utm_medium_c" AS VARCHAR) AS "original_utm_medium_c",
        CAST("original_utm_source_c" AS VARCHAR) AS "original_utm_source_c",
        CAST("original_utm_term_c" AS VARCHAR) AS "original_utm_term_c",
        CAST("pardot_hard_bounced" AS BOOLEAN) AS "pardot_hard_bounced",
        CAST("pardot_last_scored_at" AS TIMESTAMP) AS "pardot_last_scored_at",
        CAST("partner_rep_email" AS VARCHAR) AS "partner_rep_email",
        CAST("partner_rep_name" AS VARCHAR) AS "partner_rep_name",
        CAST("partner_type" AS VARCHAR) AS "partner_type",
        CAST("past_account" AS VARCHAR) AS "past_account",
        CAST("past_user_gems_info" AS VARCHAR) AS "past_user_gems_info",
        CAST("phone" AS VARCHAR) AS "phone",
        CAST("phone_number_catch_all" AS VARCHAR) AS "phone_number_catch_all",
        CAST("pi_campaign_c" AS VARCHAR) AS "pi_campaign_c",
        CAST("pi_utm_campaign_c" AS VARCHAR) AS "pi_utm_campaign_c",
        CAST("pi_utm_content_c" AS VARCHAR) AS "pi_utm_content_c",
        CAST("pi_utm_medium_c" AS VARCHAR) AS "pi_utm_medium_c",
        CAST("pi_utm_source_c" AS VARCHAR) AS "pi_utm_source_c",
        CAST("pi_utm_term_c" AS VARCHAR) AS "pi_utm_term_c",
        CAST("postal_code" AS VARCHAR) AS "postal_code",
        CAST("previous_company" AS VARCHAR) AS "previous_company",
        CAST("previous_contact_info" AS VARCHAR) AS "previous_contact_info",
        CAST("previous_job_title" AS VARCHAR) AS "previous_job_title",
        CAST("previous_lead_source" AS VARCHAR) AS "previous_lead_source",
        CAST("previous_lead_source_detail" AS VARCHAR) AS "previous_lead_source_detail",
        CAST("primary_contact" AS VARCHAR) AS "primary_contact",
        CAST("promotion_id" AS VARCHAR) AS "promotion_id",
        CAST("recent_cadence_name" AS VARCHAR) AS "recent_cadence_name",
        CAST("recent_campaign_status" AS VARCHAR) AS "recent_campaign_status",
        CAST("referral_account" AS VARCHAR) AS "referral_account",
        CAST("referral_contact" AS VARCHAR) AS "referral_contact",
        CAST("referral_email" AS VARCHAR) AS "referral_email",
        CAST("referral_first_name" AS VARCHAR) AS "referral_first_name",
        CAST("referral_last_name" AS VARCHAR) AS "referral_last_name",
        CAST("region_c" AS VARCHAR) AS "region_c",
        CAST("relative_score" AS VARCHAR) AS "relative_score",
        CAST("reporting_timestamp" AS TIMESTAMP) AS "reporting_timestamp",
        CAST("reroute_flag" AS VARCHAR) AS "reroute_flag",
        CAST("router_status" AS VARCHAR) AS "router_status",
        CAST("sales_email_opt_out_date_time_c" AS TIMESTAMP) AS "sales_email_opt_out_date_time_c",
        CAST("sales_insight_hide_date" AS DATE) AS "sales_insight_hide_date",
        CAST("sales_volume_millions" AS DECIMAL) AS "sales_volume_millions",
        CAST("salutation" AS VARCHAR) AS "salutation",
        CAST("search_terms" AS VARCHAR) AS "search_terms",
        CAST("secondary_email" AS VARCHAR) AS "secondary_email",
        CAST("source_detail" AS VARCHAR) AS "source_detail",
        CAST("state" AS VARCHAR) AS "state",
        CAST("state_code" AS VARCHAR) AS "state_code",
        CAST("state_custom" AS VARCHAR) AS "state_custom",
        CAST("status_info" AS VARCHAR) AS "status_info",
        CAST("street" AS VARCHAR) AS "street",
        CAST("street_address" AS VARCHAR) AS "street_address",
        CAST("technologies" AS VARCHAR) AS "technologies",
        CAST("territory" AS VARCHAR) AS "territory",
        CAST("timeframe" AS VARCHAR) AS "timeframe",
        CAST("trial_start_date" AS DATE) AS "trial_start_date",
        CAST("twitter_url" AS VARCHAR) AS "twitter_url",
        CAST("unique_email" AS VARCHAR) AS "unique_email",
        CAST("up_region_c" AS VARCHAR) AS "up_region_c",
        CAST(CAST("user_gems_id" AS VARCHAR) AS UUID) AS "user_gems_id",
        CAST("utm_campaign_c" AS VARCHAR) AS "utm_campaign_c",
        CAST("utm_content_c" AS VARCHAR) AS "utm_content_c",
        CAST("utm_id" AS VARCHAR) AS "utm_id",
        CAST("utm_medium_c" AS VARCHAR) AS "utm_medium_c",
        CAST("utm_source_c" AS VARCHAR) AS "utm_source_c",
        CAST("utm_term_c" AS VARCHAR) AS "utm_term_c",
        CAST("website" AS VARCHAR) AS "website",
        CAST("zip_code" AS VARCHAR) AS "zip_code",
        CAST("zoominfo_company_id" AS UUID) AS "zoominfo_company_id",
        CAST("zoominfo_country" AS VARCHAR) AS "zoominfo_country",
        CAST("zoominfo_employee_count" AS INT) AS "zoominfo_employee_count",
        CAST("zoominfo_first_update_date" AS DATE) AS "zoominfo_first_update_date",
        CAST("zoominfo_id" AS UUID) AS "zoominfo_id",
        CAST("zoominfo_last_update_date" AS DATE) AS "zoominfo_last_update_date",
        CAST("zoominfo_state" AS VARCHAR) AS "zoominfo_state",
        COALESCE(json_array("zoominfo_technologies"), '[]') AS "zoominfo_technologies",
        CAST("zoominfo_zip_code" AS VARCHAR) AS "zoominfo_zip_code"
    FROM "sf_lead_data_projected_renamed_cleaned"
),

"sf_lead_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 261 columns with unacceptable missing values
    -- account_all_data_warehouses has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_bi_tools has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_connectors has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_data_warehouses has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_products has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- acquisition_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- acquisition_program has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- acquisition_program_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- act_on_lead_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- actoncity_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- actoncountry_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- actoncountrycode_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- actonpostalcode_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- actonstate_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ad_group_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- alexa_rank has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- all_lead_source_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- all_utm_content has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- all_utm_ids has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- all_utm_terms has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- allbound_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- audience_names has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- automation_tracking has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- beta_connector_interest has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_first_touch_campaign has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_first_touch_landing_page has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_first_touch_marketing_channel has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_last_touch_campaign has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_last_touch_landing_page has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bombora_composite_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bombora_last_updated has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bombora_surge_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bounced_email_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cadence_trigger has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- calendly_created_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- campaignid_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_editor has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_project_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clarus_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clearbit_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cloudingo_agent_ar has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cloudingo_agent_ardi has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cloudingo_agent_atz has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cloudingo_agent_av has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_revenue has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- competitors has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- connector_products has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contact_owner_override has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country_custom has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- created_timestamp has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- creative_content has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- csi_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- current_user_gems_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_warehouse_products has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_warehouse_used has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- demographic_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- device has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- direct_office has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- district has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_company_record has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dnb_contact_record has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- domain_exists has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- drift_cql_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- duns_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_catchall has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_opt_in has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_opt_out_date_time_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_range has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagio_department has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagio_engagement_minutes_3m has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagio_engagement_minutes_7d has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagio_intent_minutes_30d has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagio_match_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagio_matched_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagio_role has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- enriched_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- enriched_timestamp has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- es_app_escountry_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- es_app_esecid_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- es_app_esemployees_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- es_app_eslinked_in_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- es_app_essource_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- es_app_esstate_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- facebook_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fax has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- feature_requests has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_activity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_lead_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_lead_source_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_lead_source_detail has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_touch_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_touchpoint_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_touchpoint_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_utm_campaign has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_utm_content has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_utm_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_utm_medium has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_utm_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_utm_term has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fit_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geo_city_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geo_country_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geo_country_code_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geo_postal_code_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geo_state_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geocode_accuracy has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- google_click_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- has_changed_job has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- hvr_channel has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- i_sell_os_key_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- individual_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inferred_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inferred_company has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inferred_country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inferred_metro_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inferred_phone_area_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inferred_postal_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inferred_state_region has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- intent_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- intent_timestamp has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_enriched has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_previous_customer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_startup has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- jigsaw_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- job_title has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- keywords has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_activity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_lead_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_lead_source_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_lead_source_detail has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_touchpoint_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_touchpoint_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_utm_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_creation_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_grade has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_iq_country_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_iq_employee_count_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_iq_state_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_keyword has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_latitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_referrer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_source has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_source_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_state_acton has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_zip_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- leandata_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- leandata_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- leandata_segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legacy_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- linked_in_url_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- linkedin_company_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- linkedin_member_token has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- linkedin_profile has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- longitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_channel has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_cloud_subscriber has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_connector_interest has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_process_stage has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketing_system_creation_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketo_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- marketo_sync_exclusion_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- master_record_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- match_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- matched_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- matched_buyer_persona has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- matched_lead has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mkto_71_lead_score_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mobile_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- modified_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mql_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- needs_score_sync has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- network has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- next_cadence_step_due_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- number_of_employees has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opportunity_competitors has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opportunity_products has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_referrer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_search_engine has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_search_phrase has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_source_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_source_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_campaign_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_content_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_medium_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_source_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_utm_term_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pardot_hard_bounced has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pardot_last_scored_at has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- phone_number_catch_all has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pi_campaign_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pi_score_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pi_utm_campaign_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pi_utm_content_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pi_utm_medium_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pi_utm_source_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pi_utm_term_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- postal_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- previous_contact_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- primary_contact has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- promotion_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- recent_cadence_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- recent_campaign_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- region_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- relative_score has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reroute_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- router_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_insight_hide_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- salutation has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- search_terms has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- secondary_email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_detail has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state_custom has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- status_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- street has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- street_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- technologies has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- territory has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- timeframe has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- trial_start_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- unique_email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- up_region_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_gems_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_campaign_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_content_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_medium_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_source_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- utm_term_c has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- website has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zip_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_company_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_employee_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_first_update_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_last_update_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zoominfo_zip_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "owner_id",
        "last_modified_by_id",
        "converted_contact_id",
        "id",
        "photo_url",
        "created_by_id",
        "is_converted",
        "is_unread_by_owner",
        "status",
        "lead_industry",
        "is_deleted",
        "company_name",
        "email",
        "lead_last_name",
        "active_in_sequence",
        "clearbit_data_ready",
        "has_opted_out_of_email",
        "converted_salesforce_account_id",
        "demo_scheduled_calendly",
        "marked_for_deletion",
        "email_quality",
        "email_bounced_c",
        "created_by_clearbit",
        "is_competitor",
        "routing_action",
        "search_index",
        "reporting_matched_account_id",
        "routing_status",
        "do_not_route_lead",
        "contact_stage",
        "prospect_routing_rules",
        "email_explicit_opt_in",
        "email_implicit_opt_in",
        "gdpr_opt_in_status",
        "is_user_gem",
        "last_interaction_description",
        "last_interaction_source",
        "last_interaction_type",
        "lead_priority_score",
        "lead_urgency",
        "cloudingo_agent_as",
        "cloudingo_agent_les",
        "marketo_sync_exclusion",
        "last_utm_campaign",
        "last_utm_content",
        "last_utm_medium",
        "last_utm_source",
        "last_utm_term",
        "behavioral_score",
        "is_emea_event_routing",
        "csi_description",
        "attended_event",
        "manual_route_trigger",
        "mql_reason",
        "enrichment_request",
        "fivetran_use_case",
        "sales_email_opt_out_c",
        "created_by_user_gems",
        "is_verified",
        "startup_certification_eligible",
        "email_double_opt_in",
        "all_lead_source_categories",
        "all_lead_sources",
        "all_utm_campaigns",
        "all_utm_mediums",
        "all_utm_sources",
        "annual_revenue",
        "contact_status",
        "conversion_date",
        "conversion_object_name",
        "conversion_object_type",
        "converted_date",
        "converted_datetime",
        "converted_opportunity_id",
        "created_date",
        "email_bounce_date",
        "email_bounce_reason",
        "engagio_first_engagement_date",
        "first_mql_date",
        "first_search_term",
        "first_search_type",
        "fivetran_account_id",
        "fivetran_account_stage",
        "fivetran_active_status",
        "fivetran_association_date",
        "fivetran_user_id",
        "fivetran_user_roles",
        "free_trial_confirmation_date",
        "intent_topics",
        "last_completed_cadence_step",
        "last_interesting_moment_date",
        "last_modified_date",
        "last_modified_timestamp",
        "lead_bi_tools",
        "lead_comments",
        "lead_creation_datetime",
        "lead_notes",
        "lead_number_c",
        "lead_tags",
        "lead_url",
        "metadata_creation_date",
        "partner_rep_email",
        "partner_rep_name",
        "partner_type",
        "past_account",
        "past_user_gems_info",
        "previous_company",
        "previous_job_title",
        "previous_lead_source",
        "previous_lead_source_detail",
        "referral_account",
        "referral_contact",
        "referral_email",
        "referral_first_name",
        "referral_last_name",
        "reporting_timestamp",
        "sales_email_opt_out_date_time_c",
        "sales_volume_millions",
        "twitter_url",
        "zoominfo_technologies"
    FROM "sf_lead_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_lead_data_projected_renamed_cleaned_casted_missing_handled"