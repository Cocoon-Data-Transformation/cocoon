-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:56:59.737905+00:00
WITH 
"survey_projected" AS (
    -- Projection: Selecting 73 out of 74 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "auto_scoring_category",
        "brand_base_url",
        "brand_id",
        "bundle_short_name",
        "composition_type",
        "creator_id",
        "default_scoring_category",
        "division_id",
        "is_active",
        "last_accessed",
        "last_activated",
        "last_modified",
        "option_active_response_set",
        "option_anonymize_response",
        "option_auto_confirm_start",
        "option_autoadvance",
        "option_autoadvance_pages",
        "option_autofocus",
        "option_available_languages",
        "option_back_button",
        "option_ballot_box_stuffing_prevention",
        "option_collect_geo_location",
        "option_confirm_start",
        "option_custom_styles",
        "option_email_thank_you",
        "option_eosredirect_url",
        "option_highlight_questions",
        "option_inactive_survey",
        "option_new_scoring",
        "option_next_button",
        "option_no_index",
        "option_page_transition",
        "option_partial_data",
        "option_partial_data_close_after",
        "option_password_protection",
        "option_previous_button",
        "option_progress_bar_display",
        "option_protect_selection_ids",
        "option_recaptcha_v_3",
        "option_referer_check",
        "option_referer_url",
        "option_relevant_id",
        "option_relevant_idlockout_period",
        "option_response_summary",
        "option_save_and_continue",
        "option_secure_response_files",
        "option_show_export_tags",
        "option_skin",
        "option_skin_library",
        "option_skin_question_width",
        "option_skin_type",
        "option_survey_creation_date",
        "option_survey_expiration",
        "option_survey_language",
        "option_survey_meta_description",
        "option_survey_name",
        "option_survey_protection",
        "option_survey_termination",
        "option_survey_title",
        "option_validate_message",
        "owner_id",
        "project_category",
        "project_type",
        "registry_sha",
        "registry_version",
        "schema_version",
        "scoring_summary_after_questions",
        "scoring_summary_after_survey",
        "scoring_summary_category",
        "survey_name",
        "survey_status"
    FROM "memory"."main"."survey"
),

"survey_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> survey_id
    -- _fivetran_deleted -> is_deleted
    -- option_active_response_set -> active_response_set
    -- option_anonymize_response -> anonymize_response
    -- option_auto_confirm_start -> auto_confirm_start
    -- option_autoadvance -> autoadvance
    -- option_autoadvance_pages -> autoadvance_pages
    -- option_autofocus -> autofocus
    -- option_available_languages -> available_languages
    -- option_back_button -> show_back_button
    -- option_ballot_box_stuffing_prevention -> prevent_ballot_stuffing
    -- option_collect_geo_location -> collect_geolocation
    -- option_confirm_start -> confirm_start
    -- option_custom_styles -> custom_styles
    -- option_email_thank_you -> send_thank_you_email
    -- option_eosredirect_url -> end_of_survey_redirect_url
    -- option_highlight_questions -> highlight_questions
    -- option_inactive_survey -> inactive_survey_behavior
    -- option_new_scoring -> new_scoring_enabled
    -- option_next_button -> next_button_text
    -- option_no_index -> no_index_enabled
    -- option_page_transition -> page_transition_effect
    -- option_partial_data -> partial_data_allowed
    -- option_partial_data_close_after -> partial_data_close_time
    -- option_password_protection -> password_protected
    -- option_previous_button -> previous_button_text
    -- option_progress_bar_display -> progress_bar_display
    -- option_protect_selection_ids -> protect_selection_ids
    -- option_recaptcha_v_3 -> recaptcha_v3_settings
    -- option_referer_check -> referer_check_enabled
    -- option_referer_url -> allowed_referer_url
    -- option_relevant_id -> survey_relevant_id
    -- option_relevant_idlockout_period -> relevant_id_lockout_period
    -- option_response_summary -> response_summary_enabled
    -- option_save_and_continue -> save_and_continue_enabled
    -- option_secure_response_files -> secure_response_files_enabled
    -- option_show_export_tags -> show_export_tags
    -- option_skin -> survey_skin_settings
    -- option_skin_library -> skin_library_name
    -- option_skin_question_width -> skin_question_width
    -- option_skin_type -> skin_type
    -- option_survey_creation_date -> survey_creation_date
    -- option_survey_expiration -> survey_expiration_date
    -- option_survey_language -> survey_language
    -- option_survey_meta_description -> survey_meta_description
    -- option_survey_protection -> survey_protection_type
    -- option_survey_termination -> survey_termination_message
    -- option_survey_title -> survey_title
    -- option_validate_message -> validation_message
    -- scoring_summary_after_questions -> show_question_scoring
    -- scoring_summary_after_survey -> show_survey_scoring
    -- scoring_summary_category -> scoring_category
    SELECT 
        "id" AS "survey_id",
        "_fivetran_deleted" AS "is_deleted",
        "auto_scoring_category",
        "brand_base_url",
        "brand_id",
        "bundle_short_name",
        "composition_type",
        "creator_id",
        "default_scoring_category",
        "division_id",
        "is_active",
        "last_accessed",
        "last_activated",
        "last_modified",
        "option_active_response_set" AS "active_response_set",
        "option_anonymize_response" AS "anonymize_response",
        "option_auto_confirm_start" AS "auto_confirm_start",
        "option_autoadvance" AS "autoadvance",
        "option_autoadvance_pages" AS "autoadvance_pages",
        "option_autofocus" AS "autofocus",
        "option_available_languages" AS "available_languages",
        "option_back_button" AS "show_back_button",
        "option_ballot_box_stuffing_prevention" AS "prevent_ballot_stuffing",
        "option_collect_geo_location" AS "collect_geolocation",
        "option_confirm_start" AS "confirm_start",
        "option_custom_styles" AS "custom_styles",
        "option_email_thank_you" AS "send_thank_you_email",
        "option_eosredirect_url" AS "end_of_survey_redirect_url",
        "option_highlight_questions" AS "highlight_questions",
        "option_inactive_survey" AS "inactive_survey_behavior",
        "option_new_scoring" AS "new_scoring_enabled",
        "option_next_button" AS "next_button_text",
        "option_no_index" AS "no_index_enabled",
        "option_page_transition" AS "page_transition_effect",
        "option_partial_data" AS "partial_data_allowed",
        "option_partial_data_close_after" AS "partial_data_close_time",
        "option_password_protection" AS "password_protected",
        "option_previous_button" AS "previous_button_text",
        "option_progress_bar_display" AS "progress_bar_display",
        "option_protect_selection_ids" AS "protect_selection_ids",
        "option_recaptcha_v_3" AS "recaptcha_v3_settings",
        "option_referer_check" AS "referer_check_enabled",
        "option_referer_url" AS "allowed_referer_url",
        "option_relevant_id" AS "survey_relevant_id",
        "option_relevant_idlockout_period" AS "relevant_id_lockout_period",
        "option_response_summary" AS "response_summary_enabled",
        "option_save_and_continue" AS "save_and_continue_enabled",
        "option_secure_response_files" AS "secure_response_files_enabled",
        "option_show_export_tags" AS "show_export_tags",
        "option_skin" AS "survey_skin_settings",
        "option_skin_library" AS "skin_library_name",
        "option_skin_question_width" AS "skin_question_width",
        "option_skin_type" AS "skin_type",
        "option_survey_creation_date" AS "survey_creation_date",
        "option_survey_expiration" AS "survey_expiration_date",
        "option_survey_language" AS "survey_language",
        "option_survey_meta_description" AS "survey_meta_description",
        "option_survey_name",
        "option_survey_protection" AS "survey_protection_type",
        "option_survey_termination" AS "survey_termination_message",
        "option_survey_title" AS "survey_title",
        "option_validate_message" AS "validation_message",
        "owner_id",
        "project_category",
        "project_type",
        "registry_sha",
        "registry_version",
        "schema_version",
        "scoring_summary_after_questions" AS "show_question_scoring",
        "scoring_summary_after_survey" AS "show_survey_scoring",
        "scoring_summary_category" AS "scoring_category",
        "survey_name",
        "survey_status"
    FROM "survey_projected"
),

"survey_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- allowed_referer_url: from DECIMAL to VARCHAR
    -- anonymize_response: from DECIMAL to VARCHAR
    -- auto_confirm_start: from DECIMAL to VARCHAR
    -- auto_scoring_category: from DECIMAL to VARCHAR
    -- available_languages: from DECIMAL to VARCHAR
    -- bundle_short_name: from DECIMAL to VARCHAR
    -- collect_geolocation: from DECIMAL to VARCHAR
    -- composition_type: from DECIMAL to VARCHAR
    -- confirm_start: from DECIMAL to VARCHAR
    -- creator_id: from DECIMAL to VARCHAR
    -- custom_styles: from VARCHAR to JSON
    -- default_scoring_category: from DECIMAL to VARCHAR
    -- division_id: from DECIMAL to VARCHAR
    -- end_of_survey_redirect_url: from DECIMAL to VARCHAR
    -- inactive_survey_behavior: from DECIMAL to VARCHAR
    -- is_active: from DECIMAL to VARCHAR
    -- last_accessed: from DECIMAL to TIMESTAMP
    -- last_activated: from VARCHAR to TIMESTAMP
    -- last_modified: from VARCHAR to TIMESTAMP
    -- option_survey_name: from DECIMAL to VARCHAR
    -- page_transition_effect: from DECIMAL to VARCHAR
    -- partial_data_close_time: from DECIMAL to VARCHAR
    -- password_protected: from DECIMAL to VARCHAR
    -- progress_bar_display: from DECIMAL to VARCHAR
    -- protect_selection_ids: from DECIMAL to VARCHAR
    -- recaptcha_v3_settings: from DECIMAL to VARCHAR
    -- referer_check_enabled: from DECIMAL to VARCHAR
    -- registry_sha: from DECIMAL to VARCHAR
    -- registry_version: from DECIMAL to VARCHAR
    -- relevant_id_lockout_period: from DECIMAL to VARCHAR
    -- response_summary_enabled: from DECIMAL to VARCHAR
    -- schema_version: from DECIMAL to VARCHAR
    -- scoring_category: from DECIMAL to VARCHAR
    -- send_thank_you_email: from DECIMAL to VARCHAR
    -- show_export_tags: from DECIMAL to VARCHAR
    -- survey_creation_date: from VARCHAR to TIMESTAMP
    -- survey_expiration_date: from DECIMAL to TIMESTAMP
    -- survey_meta_description: from DECIMAL to VARCHAR
    -- survey_relevant_id: from DECIMAL to VARCHAR
    -- survey_skin_settings: from VARCHAR to JSON
    -- validation_message: from DECIMAL to VARCHAR
    SELECT
        "survey_id",
        "is_deleted",
        "brand_base_url",
        "brand_id",
        "active_response_set",
        "autoadvance",
        "autoadvance_pages",
        "autofocus",
        "show_back_button",
        "prevent_ballot_stuffing",
        "highlight_questions",
        "new_scoring_enabled",
        "next_button_text",
        "no_index_enabled",
        "partial_data_allowed",
        "previous_button_text",
        "save_and_continue_enabled",
        "secure_response_files_enabled",
        "skin_library_name",
        "skin_question_width",
        "skin_type",
        "survey_language",
        "survey_protection_type",
        "survey_termination_message",
        "survey_title",
        "owner_id",
        "project_category",
        "project_type",
        "show_question_scoring",
        "show_survey_scoring",
        "survey_name",
        "survey_status",
        CAST("allowed_referer_url" AS VARCHAR) AS "allowed_referer_url",
        CAST("anonymize_response" AS VARCHAR) AS "anonymize_response",
        CAST("auto_confirm_start" AS VARCHAR) AS "auto_confirm_start",
        CAST("auto_scoring_category" AS VARCHAR) AS "auto_scoring_category",
        CAST("available_languages" AS VARCHAR) AS "available_languages",
        CAST("bundle_short_name" AS VARCHAR) AS "bundle_short_name",
        CAST("collect_geolocation" AS VARCHAR) AS "collect_geolocation",
        CAST("composition_type" AS VARCHAR) AS "composition_type",
        CAST("confirm_start" AS VARCHAR) AS "confirm_start",
        CAST("creator_id" AS VARCHAR) AS "creator_id",
        CAST("custom_styles" AS JSON) AS "custom_styles",
        CAST("default_scoring_category" AS VARCHAR) AS "default_scoring_category",
        CAST("division_id" AS VARCHAR) AS "division_id",
        CAST("end_of_survey_redirect_url" AS VARCHAR) AS "end_of_survey_redirect_url",
        CAST("inactive_survey_behavior" AS VARCHAR) AS "inactive_survey_behavior",
        CAST("is_active" AS VARCHAR) AS "is_active",
        CAST("last_accessed" AS TIMESTAMP) AS "last_accessed",
        CAST("last_activated" AS TIMESTAMP) AS "last_activated",
        CAST("last_modified" AS TIMESTAMP) AS "last_modified",
        CAST("option_survey_name" AS VARCHAR) AS "option_survey_name",
        CAST("page_transition_effect" AS VARCHAR) AS "page_transition_effect",
        CAST("partial_data_close_time" AS VARCHAR) AS "partial_data_close_time",
        CAST("password_protected" AS VARCHAR) AS "password_protected",
        CAST("progress_bar_display" AS VARCHAR) AS "progress_bar_display",
        CAST("protect_selection_ids" AS VARCHAR) AS "protect_selection_ids",
        CAST("recaptcha_v3_settings" AS VARCHAR) AS "recaptcha_v3_settings",
        CAST("referer_check_enabled" AS VARCHAR) AS "referer_check_enabled",
        CAST("registry_sha" AS VARCHAR) AS "registry_sha",
        CAST("registry_version" AS VARCHAR) AS "registry_version",
        CAST("relevant_id_lockout_period" AS VARCHAR) AS "relevant_id_lockout_period",
        CAST("response_summary_enabled" AS VARCHAR) AS "response_summary_enabled",
        CAST("schema_version" AS VARCHAR) AS "schema_version",
        CAST("scoring_category" AS VARCHAR) AS "scoring_category",
        CAST("send_thank_you_email" AS VARCHAR) AS "send_thank_you_email",
        CAST("show_export_tags" AS VARCHAR) AS "show_export_tags",
        CAST("survey_creation_date" AS TIMESTAMP) AS "survey_creation_date",
        CAST("survey_expiration_date" AS TIMESTAMP) AS "survey_expiration_date",
        CAST("survey_meta_description" AS VARCHAR) AS "survey_meta_description",
        CAST("survey_relevant_id" AS VARCHAR) AS "survey_relevant_id",
        CAST("survey_skin_settings" AS JSON) AS "survey_skin_settings",
        CAST("validation_message" AS VARCHAR) AS "validation_message"
    FROM "survey_projected_renamed"
),

"survey_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 39 columns with unacceptable missing values
    -- allowed_referer_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- anonymize_response has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- auto_confirm_start has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- auto_scoring_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- available_languages has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bundle_short_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- collect_geolocation has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- composition_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- confirm_start has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- creator_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_styles has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- default_scoring_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- division_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- end_of_survey_redirect_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inactive_survey_behavior has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_accessed has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_activated has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- option_survey_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- page_transition_effect has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partial_data_close_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- password_protected has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- progress_bar_display has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- protect_selection_ids has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- recaptcha_v3_settings has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referer_check_enabled has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- registry_sha has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- registry_version has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- relevant_id_lockout_period has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- response_summary_enabled has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- schema_version has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- scoring_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- send_thank_you_email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- show_export_tags has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- skin_question_width has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- survey_meta_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- survey_relevant_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- survey_title has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- validation_message has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "survey_id",
        "is_deleted",
        "brand_base_url",
        "brand_id",
        "active_response_set",
        "autoadvance",
        "autoadvance_pages",
        "autofocus",
        "show_back_button",
        "prevent_ballot_stuffing",
        "highlight_questions",
        "new_scoring_enabled",
        "next_button_text",
        "no_index_enabled",
        "partial_data_allowed",
        "previous_button_text",
        "save_and_continue_enabled",
        "secure_response_files_enabled",
        "skin_library_name",
        "skin_question_width",
        "skin_type",
        "survey_language",
        "survey_protection_type",
        "survey_termination_message",
        "survey_title",
        "owner_id",
        "project_category",
        "project_type",
        "show_question_scoring",
        "show_survey_scoring",
        "survey_name",
        "survey_status",
        "custom_styles",
        "last_activated",
        "last_modified",
        "survey_creation_date",
        "survey_expiration_date",
        "survey_skin_settings"
    FROM "survey_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "survey_projected_renamed_casted_missing_handled"