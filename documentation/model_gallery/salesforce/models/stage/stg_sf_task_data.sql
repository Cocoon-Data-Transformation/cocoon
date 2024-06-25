-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_task_data_removeWideColumns" AS (
    -- Remove wide columns with pattern. The regex and columns are:
    -- ^sales_loft_\d+_.*$: sales_loft_1_call_disposition_c, sales_loft_1_call_sentiment_c, sales_loft_1_sales_loft_cadence_name_c, sales_loft_1_sales_loft_clicked_count_c, sales_loft_1_sales_loft_email_template_title_c, sales_loft_1_sales_loft_replies_count_c, sales_loft_1_sales_loft_step_day_c, sales_loft_1_sales_loft_view_count_c
    SELECT 
        "_fivetran_active",
        "_fivetran_synced",
        "account_id",
        "activity_date",
        "affectlayer_affect_layer_call_id_c",
        "affectlayer_chorus_call_id_c",
        "assigned_to_name_c",
        "assigned_to_role_c",
        "associated_sdr_c",
        "attendance_number_c",
        "bizible_2_bizible_id_c",
        "bizible_2_bizible_touchpoint_date_c",
        "call_disposition",
        "call_disposition_2_c",
        "call_disposition_c",
        "call_duration_in_seconds",
        "call_object",
        "call_recording_c",
        "call_type",
        "campaign_c",
        "co_sell_partner_account_c",
        "co_selling_activity_c",
        "collections_hold_c",
        "completed_date_time",
        "created_by_id",
        "created_date",
        "description",
        "description_c",
        "duration_in_minutes_c",
        "event_name_c",
        "execute_collections_plan_activity_c",
        "expected_payment_date_c",
        "first_meeting_c",
        "first_meeting_held_c",
        "how_did_you_bring_value_or_create_trust_c",
        "how_did_you_bring_value_or_earn_trust_c",
        "id",
        "invitee_uuid_c",
        "is_a_co_sell_activity_c",
        "is_archived",
        "is_closed",
        "is_deleted",
        "is_high_priority",
        "is_recurrence",
        "is_reminder_set",
        "last_modified_by_id",
        "last_modified_date",
        "last_rep_activity_date_c",
        "legacy_hvr_id_c",
        "lid_date_sent_c",
        "lid_url_c",
        "meeting_name_c",
        "meeting_type_c",
        "no_show_c",
        "opportunity_c",
        "owner_id",
        "partner_account_c",
        "partner_activity_type_c",
        "partner_contact_c",
        "priority",
        "proof_of_referral_c",
        "record_type_id",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_day_of_week_mask",
        "recurrence_end_date_only",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month_of_year",
        "recurrence_regenerated_type",
        "recurrence_start_date_only",
        "recurrence_time_zone_sid_key",
        "recurrence_type",
        "referral_account_c",
        "referral_contact_c",
        "reminder_date_time",
        "sales_loft_cadence_id_c",
        "sales_loft_cadence_name_c",
        "sales_loft_clicked_count_c",
        "sales_loft_email_template_id_c",
        "sales_loft_email_template_title_c",
        "sales_loft_external_identifier_c",
        "sales_loft_reply_count_c",
        "sales_loft_step_day_new_c",
        "sales_loft_step_id_c",
        "sales_loft_step_name_c",
        "sales_loft_step_type_c",
        "sales_loft_viewed_count_c",
        "status",
        "subject",
        "system_modstamp",
        "task_subtype",
        "topic_c",
        "type",
        "vidyard_c",
        "what_count",
        "what_id",
        "who_count",
        "who_id"
    FROM "sf_task_data"
),

"sf_task_data_removeWideColumns_projected" AS (
    -- Projection: Selecting 98 out of 99 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "account_id",
        "activity_date",
        "affectlayer_affect_layer_call_id_c",
        "affectlayer_chorus_call_id_c",
        "assigned_to_name_c",
        "assigned_to_role_c",
        "associated_sdr_c",
        "attendance_number_c",
        "bizible_2_bizible_id_c",
        "bizible_2_bizible_touchpoint_date_c",
        "call_disposition",
        "call_disposition_2_c",
        "call_disposition_c",
        "call_duration_in_seconds",
        "call_object",
        "call_recording_c",
        "call_type",
        "campaign_c",
        "co_sell_partner_account_c",
        "co_selling_activity_c",
        "collections_hold_c",
        "completed_date_time",
        "created_by_id",
        "created_date",
        "description",
        "description_c",
        "duration_in_minutes_c",
        "event_name_c",
        "execute_collections_plan_activity_c",
        "expected_payment_date_c",
        "first_meeting_c",
        "first_meeting_held_c",
        "how_did_you_bring_value_or_create_trust_c",
        "how_did_you_bring_value_or_earn_trust_c",
        "id",
        "invitee_uuid_c",
        "is_a_co_sell_activity_c",
        "is_archived",
        "is_closed",
        "is_deleted",
        "is_high_priority",
        "is_recurrence",
        "is_reminder_set",
        "last_modified_by_id",
        "last_modified_date",
        "last_rep_activity_date_c",
        "legacy_hvr_id_c",
        "lid_date_sent_c",
        "lid_url_c",
        "meeting_name_c",
        "meeting_type_c",
        "no_show_c",
        "opportunity_c",
        "owner_id",
        "partner_account_c",
        "partner_activity_type_c",
        "partner_contact_c",
        "priority",
        "proof_of_referral_c",
        "record_type_id",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_day_of_week_mask",
        "recurrence_end_date_only",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month_of_year",
        "recurrence_regenerated_type",
        "recurrence_start_date_only",
        "recurrence_time_zone_sid_key",
        "recurrence_type",
        "referral_account_c",
        "referral_contact_c",
        "reminder_date_time",
        "sales_loft_cadence_id_c",
        "sales_loft_cadence_name_c",
        "sales_loft_clicked_count_c",
        "sales_loft_email_template_id_c",
        "sales_loft_email_template_title_c",
        "sales_loft_external_identifier_c",
        "sales_loft_reply_count_c",
        "sales_loft_step_day_new_c",
        "sales_loft_step_id_c",
        "sales_loft_step_name_c",
        "sales_loft_step_type_c",
        "sales_loft_viewed_count_c",
        "status",
        "subject",
        "system_modstamp",
        "task_subtype",
        "topic_c",
        "type",
        "vidyard_c",
        "what_count",
        "what_id",
        "who_count",
        "who_id"
    FROM "sf_task_data_removeWideColumns"
),

"sf_task_data_removeWideColumns_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- affectlayer_affect_layer_call_id_c -> affect_layer_call_id
    -- affectlayer_chorus_call_id_c -> chorus_call_id
    -- assigned_to_name_c -> assigned_to_name
    -- assigned_to_role_c -> assigned_to_role
    -- associated_sdr_c -> associated_sdr
    -- attendance_number_c -> attendance_number
    -- bizible_2_bizible_id_c -> bizible_id
    -- bizible_2_bizible_touchpoint_date_c -> bizible_touchpoint_date
    -- call_disposition_2_c -> call_disposition_secondary
    -- call_disposition_c -> call_disposition_custom
    -- call_duration_in_seconds -> call_duration_seconds
    -- call_recording_c -> call_recording
    -- campaign_c -> campaign
    -- co_sell_partner_account_c -> co_sell_partner_account
    -- co_selling_activity_c -> is_co_selling_activity
    -- collections_hold_c -> is_collections_hold
    -- description_c -> description_custom
    -- duration_in_minutes_c -> duration_minutes
    -- event_name_c -> event_name
    -- execute_collections_plan_activity_c -> is_collections_plan_activity
    -- expected_payment_date_c -> expected_payment_date
    -- first_meeting_c -> first_meeting_date
    -- first_meeting_held_c -> first_meeting_held
    -- how_did_you_bring_value_or_create_trust_c -> value_creation_description
    -- how_did_you_bring_value_or_earn_trust_c -> trust_earning_description
    -- invitee_uuid_c -> invitee_uuid
    -- is_a_co_sell_activity_c -> is_co_sell_activity
    -- is_recurrence -> is_recurring
    -- is_reminder_set -> has_reminder
    -- last_rep_activity_date_c -> last_rep_activity_date
    -- legacy_hvr_id_c -> legacy_hvr_id
    -- lid_date_sent_c -> lid_sent_date
    -- lid_url_c -> lid_url
    -- meeting_name_c -> meeting_name
    -- meeting_type_c -> meeting_type
    -- no_show_c -> is_no_show
    -- opportunity_c -> opportunity_id
    -- partner_account_c -> partner_account_id
    -- partner_activity_type_c -> partner_activity_type
    -- partner_contact_c -> partner_contact_id
    -- proof_of_referral_c -> proof_of_referral
    -- recurrence_day_of_week_mask -> recurrence_weekday_mask
    -- recurrence_end_date_only -> recurrence_end_date
    -- recurrence_month_of_year -> recurrence_month
    -- recurrence_regenerated_type -> recurrence_regeneration_type
    -- recurrence_start_date_only -> recurrence_start_date
    -- recurrence_time_zone_sid_key -> recurrence_timezone
    -- referral_account_c -> referral_account_id
    -- referral_contact_c -> referral_contact_id
    -- reminder_date_time -> reminder_datetime
    -- sales_loft_cadence_id_c -> sales_loft_cadence_id
    -- sales_loft_cadence_name_c -> sales_loft_cadence_name
    -- sales_loft_clicked_count_c -> sales_loft_click_count
    -- sales_loft_email_template_id_c -> sales_loft_email_template_id
    -- sales_loft_email_template_title_c -> sales_loft_email_template_title
    -- sales_loft_external_identifier_c -> sales_loft_external_id
    -- sales_loft_reply_count_c -> sales_loft_reply_count
    -- sales_loft_step_day_new_c -> sales_loft_step_day
    -- sales_loft_step_id_c -> sales_loft_step_id
    -- sales_loft_step_name_c -> sales_loft_step_name
    -- sales_loft_step_type_c -> sales_loft_step_type
    -- sales_loft_viewed_count_c -> sales_loft_view_count
    -- topic_c -> task_topic
    -- type -> task_type
    -- vidyard_c -> has_vidyard_video
    -- what_count -> associated_object_count
    -- what_id -> associated_object_id
    -- who_count -> associated_person_count
    -- who_id -> associated_person_id
    SELECT 
        "_fivetran_active" AS "is_active",
        "account_id",
        "activity_date",
        "affectlayer_affect_layer_call_id_c" AS "affect_layer_call_id",
        "affectlayer_chorus_call_id_c" AS "chorus_call_id",
        "assigned_to_name_c" AS "assigned_to_name",
        "assigned_to_role_c" AS "assigned_to_role",
        "associated_sdr_c" AS "associated_sdr",
        "attendance_number_c" AS "attendance_number",
        "bizible_2_bizible_id_c" AS "bizible_id",
        "bizible_2_bizible_touchpoint_date_c" AS "bizible_touchpoint_date",
        "call_disposition",
        "call_disposition_2_c" AS "call_disposition_secondary",
        "call_disposition_c" AS "call_disposition_custom",
        "call_duration_in_seconds" AS "call_duration_seconds",
        "call_object",
        "call_recording_c" AS "call_recording",
        "call_type",
        "campaign_c" AS "campaign",
        "co_sell_partner_account_c" AS "co_sell_partner_account",
        "co_selling_activity_c" AS "is_co_selling_activity",
        "collections_hold_c" AS "is_collections_hold",
        "completed_date_time",
        "created_by_id",
        "created_date",
        "description",
        "description_c" AS "description_custom",
        "duration_in_minutes_c" AS "duration_minutes",
        "event_name_c" AS "event_name",
        "execute_collections_plan_activity_c" AS "is_collections_plan_activity",
        "expected_payment_date_c" AS "expected_payment_date",
        "first_meeting_c" AS "first_meeting_date",
        "first_meeting_held_c" AS "first_meeting_held",
        "how_did_you_bring_value_or_create_trust_c" AS "value_creation_description",
        "how_did_you_bring_value_or_earn_trust_c" AS "trust_earning_description",
        "id",
        "invitee_uuid_c" AS "invitee_uuid",
        "is_a_co_sell_activity_c" AS "is_co_sell_activity",
        "is_archived",
        "is_closed",
        "is_deleted",
        "is_high_priority",
        "is_recurrence" AS "is_recurring",
        "is_reminder_set" AS "has_reminder",
        "last_modified_by_id",
        "last_modified_date",
        "last_rep_activity_date_c" AS "last_rep_activity_date",
        "legacy_hvr_id_c" AS "legacy_hvr_id",
        "lid_date_sent_c" AS "lid_sent_date",
        "lid_url_c" AS "lid_url",
        "meeting_name_c" AS "meeting_name",
        "meeting_type_c" AS "meeting_type",
        "no_show_c" AS "is_no_show",
        "opportunity_c" AS "opportunity_id",
        "owner_id",
        "partner_account_c" AS "partner_account_id",
        "partner_activity_type_c" AS "partner_activity_type",
        "partner_contact_c" AS "partner_contact_id",
        "priority",
        "proof_of_referral_c" AS "proof_of_referral",
        "record_type_id",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_day_of_week_mask" AS "recurrence_weekday_mask",
        "recurrence_end_date_only" AS "recurrence_end_date",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month_of_year" AS "recurrence_month",
        "recurrence_regenerated_type" AS "recurrence_regeneration_type",
        "recurrence_start_date_only" AS "recurrence_start_date",
        "recurrence_time_zone_sid_key" AS "recurrence_timezone",
        "recurrence_type",
        "referral_account_c" AS "referral_account_id",
        "referral_contact_c" AS "referral_contact_id",
        "reminder_date_time" AS "reminder_datetime",
        "sales_loft_cadence_id_c" AS "sales_loft_cadence_id",
        "sales_loft_cadence_name_c" AS "sales_loft_cadence_name",
        "sales_loft_clicked_count_c" AS "sales_loft_click_count",
        "sales_loft_email_template_id_c" AS "sales_loft_email_template_id",
        "sales_loft_email_template_title_c" AS "sales_loft_email_template_title",
        "sales_loft_external_identifier_c" AS "sales_loft_external_id",
        "sales_loft_reply_count_c" AS "sales_loft_reply_count",
        "sales_loft_step_day_new_c" AS "sales_loft_step_day",
        "sales_loft_step_id_c" AS "sales_loft_step_id",
        "sales_loft_step_name_c" AS "sales_loft_step_name",
        "sales_loft_step_type_c" AS "sales_loft_step_type",
        "sales_loft_viewed_count_c" AS "sales_loft_view_count",
        "status",
        "subject",
        "system_modstamp",
        "task_subtype",
        "topic_c" AS "task_topic",
        "type" AS "task_type",
        "vidyard_c" AS "has_vidyard_video",
        "what_count" AS "associated_object_count",
        "what_id" AS "associated_object_id",
        "who_count" AS "associated_person_count",
        "who_id" AS "associated_person_id"
    FROM "sf_task_data_removeWideColumns_projected"
),

"sf_task_data_removeWideColumns_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- assigned_to_name: The problem is that 'fivetran ae' is in all lowercase and uses an uncommon abbreviation 'ae'. In a professional context, it's likely that this should be properly capitalized and the abbreviation expanded. 'AE' typically stands for 'Account Executive' in business contexts. The correct value should be properly capitalized and use the full job title. 
    -- assigned_to_role: The problem is that 'X' is a non-descriptive placeholder value that doesn't indicate a specific role assignment. It's likely being used to denote that a role has not been assigned or the assignment is unknown. The correct value for an unassigned or unknown role would be an empty string or null value. 
    -- task_type: The problem is that 'X' is the only value present in the task_type column, and it's not descriptive of any typical task type. 'X' is likely a placeholder or an error code, rather than a meaningful task type. Without more context about the nature of the tasks in the dataset, it's impossible to determine what the correct task types should be. In this case, the best approach is to map this placeholder to an empty string, indicating that the true task type is unknown or not specified. 
    SELECT
        "is_active",
        "account_id",
        "activity_date",
        "affect_layer_call_id",
        "chorus_call_id",
        CASE
            WHEN "assigned_to_name" = 'fivetran ae' THEN 'Fivetran Account Executive'
            ELSE "assigned_to_name"
        END AS "assigned_to_name",
        CASE
            WHEN "assigned_to_role" = 'X' THEN ''
            ELSE "assigned_to_role"
        END AS "assigned_to_role",
        "associated_sdr",
        "attendance_number",
        "bizible_id",
        "bizible_touchpoint_date",
        "call_disposition",
        "call_disposition_secondary",
        "call_disposition_custom",
        "call_duration_seconds",
        "call_object",
        "call_recording",
        "call_type",
        "campaign",
        "co_sell_partner_account",
        "is_co_selling_activity",
        "is_collections_hold",
        "completed_date_time",
        "created_by_id",
        "created_date",
        "description",
        "description_custom",
        "duration_minutes",
        "event_name",
        "is_collections_plan_activity",
        "expected_payment_date",
        "first_meeting_date",
        "first_meeting_held",
        "value_creation_description",
        "trust_earning_description",
        "id",
        "invitee_uuid",
        "is_co_sell_activity",
        "is_archived",
        "is_closed",
        "is_deleted",
        "is_high_priority",
        "is_recurring",
        "has_reminder",
        "last_modified_by_id",
        "last_modified_date",
        "last_rep_activity_date",
        "legacy_hvr_id",
        "lid_sent_date",
        "lid_url",
        "meeting_name",
        "meeting_type",
        "is_no_show",
        "opportunity_id",
        "owner_id",
        "partner_account_id",
        "partner_activity_type",
        "partner_contact_id",
        "priority",
        "proof_of_referral",
        "record_type_id",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_weekday_mask",
        "recurrence_end_date",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month",
        "recurrence_regeneration_type",
        "recurrence_start_date",
        "recurrence_timezone",
        "recurrence_type",
        "referral_account_id",
        "referral_contact_id",
        "reminder_datetime",
        "sales_loft_cadence_id",
        "sales_loft_cadence_name",
        "sales_loft_click_count",
        "sales_loft_email_template_id",
        "sales_loft_email_template_title",
        "sales_loft_external_id",
        "sales_loft_reply_count",
        "sales_loft_step_day",
        "sales_loft_step_id",
        "sales_loft_step_name",
        "sales_loft_step_type",
        "sales_loft_view_count",
        "status",
        "subject",
        "system_modstamp",
        "task_subtype",
        "task_topic",
        CASE
            WHEN "task_type" = 'X' THEN ''
            ELSE "task_type"
        END AS "task_type",
        "has_vidyard_video",
        "associated_object_count",
        "associated_object_id",
        "associated_person_count",
        "associated_person_id"
    FROM "sf_task_data_removeWideColumns_projected_renamed"
),

"sf_task_data_removeWideColumns_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- assigned_to_role: ['']
    -- task_type: ['']
    SELECT 
        CASE
            WHEN "assigned_to_role" = '' THEN NULL
            ELSE "assigned_to_role"
        END AS "assigned_to_role",
        CASE
            WHEN "task_type" = '' THEN NULL
            ELSE "task_type"
        END AS "task_type",
        "is_co_sell_activity",
        "recurrence_day_of_month",
        "account_id",
        "legacy_hvr_id",
        "duration_minutes",
        "value_creation_description",
        "recurrence_regeneration_type",
        "chorus_call_id",
        "assigned_to_name",
        "recurrence_timezone",
        "recurrence_end_date",
        "affect_layer_call_id",
        "associated_person_count",
        "recurrence_activity_id",
        "recurrence_weekday_mask",
        "subject",
        "recurrence_interval",
        "call_type",
        "associated_sdr",
        "trust_earning_description",
        "first_meeting_date",
        "call_disposition",
        "call_duration_seconds",
        "created_by_id",
        "partner_account_id",
        "sales_loft_step_name",
        "id",
        "lid_url",
        "partner_contact_id",
        "is_archived",
        "sales_loft_step_id",
        "sales_loft_cadence_name",
        "sales_loft_external_id",
        "description_custom",
        "activity_date",
        "sales_loft_view_count",
        "partner_activity_type",
        "referral_account_id",
        "opportunity_id",
        "last_modified_by_id",
        "priority",
        "sales_loft_reply_count",
        "system_modstamp",
        "sales_loft_email_template_title",
        "reminder_datetime",
        "invitee_uuid",
        "record_type_id",
        "is_collections_hold",
        "call_recording",
        "is_active",
        "associated_object_id",
        "meeting_type",
        "meeting_name",
        "description",
        "attendance_number",
        "sales_loft_step_type",
        "has_vidyard_video",
        "last_modified_date",
        "is_no_show",
        "sales_loft_step_day",
        "status",
        "recurrence_month",
        "event_name",
        "sales_loft_click_count",
        "call_disposition_custom",
        "is_collections_plan_activity",
        "completed_date_time",
        "is_closed",
        "referral_contact_id",
        "expected_payment_date",
        "last_rep_activity_date",
        "recurrence_instance",
        "campaign",
        "associated_object_count",
        "call_disposition_secondary",
        "is_co_selling_activity",
        "recurrence_start_date",
        "task_topic",
        "is_high_priority",
        "proof_of_referral",
        "sales_loft_email_template_id",
        "bizible_id",
        "recurrence_type",
        "owner_id",
        "co_sell_partner_account",
        "bizible_touchpoint_date",
        "is_recurring",
        "is_deleted",
        "associated_person_id",
        "task_subtype",
        "call_object",
        "first_meeting_held",
        "has_reminder",
        "created_date",
        "sales_loft_cadence_id",
        "lid_sent_date"
    FROM "sf_task_data_removeWideColumns_projected_renamed_cleaned"
),

"sf_task_data_removeWideColumns_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- activity_date: from VARCHAR to TIMESTAMP
    -- affect_layer_call_id: from DECIMAL to VARCHAR
    -- associated_sdr: from DECIMAL to VARCHAR
    -- attendance_number: from DECIMAL to VARCHAR
    -- bizible_id: from DECIMAL to VARCHAR
    -- bizible_touchpoint_date: from DECIMAL to VARCHAR
    -- call_disposition: from DECIMAL to VARCHAR
    -- call_disposition_custom: from DECIMAL to VARCHAR
    -- call_disposition_secondary: from DECIMAL to VARCHAR
    -- call_duration_seconds: from DECIMAL to VARCHAR
    -- call_object: from DECIMAL to VARCHAR
    -- call_recording: from DECIMAL to VARCHAR
    -- call_type: from DECIMAL to VARCHAR
    -- campaign: from DECIMAL to VARCHAR
    -- chorus_call_id: from DECIMAL to VARCHAR
    -- co_sell_partner_account: from DECIMAL to VARCHAR
    -- completed_date_time: from VARCHAR to TIMESTAMP
    -- created_date: from VARCHAR to TIMESTAMP
    -- description_custom: from DECIMAL to VARCHAR
    -- duration_minutes: from DECIMAL to VARCHAR
    -- event_name: from DECIMAL to VARCHAR
    -- expected_payment_date: from DECIMAL to DATE
    -- first_meeting_date: from DECIMAL to DATE
    -- first_meeting_held: from DECIMAL to TIMESTAMP
    -- invitee_uuid: from DECIMAL to UUID
    -- is_active: from DECIMAL to BOOLEAN
    -- is_co_sell_activity: from DECIMAL to BOOLEAN
    -- is_co_selling_activity: from DECIMAL to BOOLEAN
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- last_rep_activity_date: from DECIMAL to DATE
    -- legacy_hvr_id: from DECIMAL to VARCHAR
    -- lid_sent_date: from DECIMAL to DATE
    -- lid_url: from DECIMAL to VARCHAR
    -- opportunity_id: from DECIMAL to VARCHAR
    -- partner_account_id: from DECIMAL to VARCHAR
    -- partner_activity_type: from DECIMAL to VARCHAR
    -- partner_contact_id: from DECIMAL to VARCHAR
    -- proof_of_referral: from DECIMAL to VARCHAR
    -- recurrence_activity_id: from DECIMAL to VARCHAR
    -- recurrence_day_of_month: from DECIMAL to INT
    -- recurrence_end_date: from DECIMAL to DATE
    -- recurrence_instance: from DECIMAL to VARCHAR
    -- recurrence_interval: from DECIMAL to INT
    -- recurrence_month: from DECIMAL to INT
    -- recurrence_regeneration_type: from DECIMAL to VARCHAR
    -- recurrence_start_date: from DECIMAL to DATE
    -- recurrence_timezone: from DECIMAL to VARCHAR
    -- recurrence_type: from DECIMAL to VARCHAR
    -- recurrence_weekday_mask: from DECIMAL to INT
    -- referral_account_id: from DECIMAL to VARCHAR
    -- referral_contact_id: from DECIMAL to VARCHAR
    -- reminder_datetime: from DECIMAL to TIMESTAMP
    -- sales_loft_cadence_id: from DECIMAL to VARCHAR
    -- sales_loft_cadence_name: from DECIMAL to VARCHAR
    -- sales_loft_click_count: from DECIMAL to INT
    -- sales_loft_email_template_id: from DECIMAL to VARCHAR
    -- sales_loft_email_template_title: from DECIMAL to VARCHAR
    -- sales_loft_external_id: from DECIMAL to VARCHAR
    -- sales_loft_reply_count: from DECIMAL to INT
    -- sales_loft_step_day: from DECIMAL to INT
    -- sales_loft_step_id: from DECIMAL to VARCHAR
    -- sales_loft_step_name: from DECIMAL to VARCHAR
    -- sales_loft_step_type: from DECIMAL to VARCHAR
    -- sales_loft_view_count: from DECIMAL to INT
    -- system_modstamp: from VARCHAR to TIMESTAMP
    -- task_topic: from DECIMAL to VARCHAR
    -- trust_earning_description: from DECIMAL to VARCHAR
    -- value_creation_description: from DECIMAL to VARCHAR
    SELECT
        "assigned_to_role",
        "task_type",
        "account_id",
        "assigned_to_name",
        "associated_person_count",
        "subject",
        "created_by_id",
        "id",
        "is_archived",
        "last_modified_by_id",
        "priority",
        "record_type_id",
        "is_collections_hold",
        "associated_object_id",
        "meeting_type",
        "meeting_name",
        "description",
        "has_vidyard_video",
        "is_no_show",
        "status",
        "is_collections_plan_activity",
        "is_closed",
        "associated_object_count",
        "is_high_priority",
        "owner_id",
        "is_recurring",
        "is_deleted",
        "associated_person_id",
        "task_subtype",
        "has_reminder",
        CAST("activity_date" AS TIMESTAMP) AS "activity_date",
        CAST("affect_layer_call_id" AS VARCHAR) AS "affect_layer_call_id",
        CAST("associated_sdr" AS VARCHAR) AS "associated_sdr",
        CAST("attendance_number" AS VARCHAR) AS "attendance_number",
        CAST("bizible_id" AS VARCHAR) AS "bizible_id",
        CAST("bizible_touchpoint_date" AS VARCHAR) AS "bizible_touchpoint_date",
        CAST("call_disposition" AS VARCHAR) AS "call_disposition",
        CAST("call_disposition_custom" AS VARCHAR) AS "call_disposition_custom",
        CAST("call_disposition_secondary" AS VARCHAR) AS "call_disposition_secondary",
        CAST("call_duration_seconds" AS VARCHAR) AS "call_duration_seconds",
        CAST("call_object" AS VARCHAR) AS "call_object",
        CAST("call_recording" AS VARCHAR) AS "call_recording",
        CAST("call_type" AS VARCHAR) AS "call_type",
        CAST("campaign" AS VARCHAR) AS "campaign",
        CAST("chorus_call_id" AS VARCHAR) AS "chorus_call_id",
        CAST("co_sell_partner_account" AS VARCHAR) AS "co_sell_partner_account",
        CAST("completed_date_time" AS TIMESTAMP) AS "completed_date_time",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("description_custom" AS VARCHAR) AS "description_custom",
        CAST("duration_minutes" AS VARCHAR) AS "duration_minutes",
        CAST("event_name" AS VARCHAR) AS "event_name",
        CAST("expected_payment_date" AS DATE) AS "expected_payment_date",
        CAST("first_meeting_date" AS DATE) AS "first_meeting_date",
        CAST("first_meeting_held" AS TIMESTAMP) AS "first_meeting_held",
        CAST("invitee_uuid" AS UUID) AS "invitee_uuid",
        CAST("is_active" AS BOOLEAN) AS "is_active",
        CAST("is_co_sell_activity" AS BOOLEAN) AS "is_co_sell_activity",
        CAST("is_co_selling_activity" AS BOOLEAN) AS "is_co_selling_activity",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("last_rep_activity_date" AS DATE) AS "last_rep_activity_date",
        CAST("legacy_hvr_id" AS VARCHAR) AS "legacy_hvr_id",
        CAST("lid_sent_date" AS DATE) AS "lid_sent_date",
        CAST("lid_url" AS VARCHAR) AS "lid_url",
        CAST("opportunity_id" AS VARCHAR) AS "opportunity_id",
        CAST("partner_account_id" AS VARCHAR) AS "partner_account_id",
        CAST("partner_activity_type" AS VARCHAR) AS "partner_activity_type",
        CAST("partner_contact_id" AS VARCHAR) AS "partner_contact_id",
        CAST("proof_of_referral" AS VARCHAR) AS "proof_of_referral",
        CAST("recurrence_activity_id" AS VARCHAR) AS "recurrence_activity_id",
        CAST("recurrence_day_of_month" AS INT) AS "recurrence_day_of_month",
        CAST("recurrence_end_date" AS DATE) AS "recurrence_end_date",
        CAST("recurrence_instance" AS VARCHAR) AS "recurrence_instance",
        CAST("recurrence_interval" AS INT) AS "recurrence_interval",
        CAST("recurrence_month" AS INT) AS "recurrence_month",
        CAST("recurrence_regeneration_type" AS VARCHAR) AS "recurrence_regeneration_type",
        CAST("recurrence_start_date" AS DATE) AS "recurrence_start_date",
        CAST("recurrence_timezone" AS VARCHAR) AS "recurrence_timezone",
        CAST("recurrence_type" AS VARCHAR) AS "recurrence_type",
        CAST("recurrence_weekday_mask" AS INT) AS "recurrence_weekday_mask",
        CAST("referral_account_id" AS VARCHAR) AS "referral_account_id",
        CAST("referral_contact_id" AS VARCHAR) AS "referral_contact_id",
        CAST("reminder_datetime" AS TIMESTAMP) AS "reminder_datetime",
        CAST("sales_loft_cadence_id" AS VARCHAR) AS "sales_loft_cadence_id",
        CAST("sales_loft_cadence_name" AS VARCHAR) AS "sales_loft_cadence_name",
        CAST("sales_loft_click_count" AS INT) AS "sales_loft_click_count",
        CAST("sales_loft_email_template_id" AS VARCHAR) AS "sales_loft_email_template_id",
        CAST("sales_loft_email_template_title" AS VARCHAR) AS "sales_loft_email_template_title",
        CAST("sales_loft_external_id" AS VARCHAR) AS "sales_loft_external_id",
        CAST("sales_loft_reply_count" AS INT) AS "sales_loft_reply_count",
        CAST("sales_loft_step_day" AS INT) AS "sales_loft_step_day",
        CAST("sales_loft_step_id" AS VARCHAR) AS "sales_loft_step_id",
        CAST("sales_loft_step_name" AS VARCHAR) AS "sales_loft_step_name",
        CAST("sales_loft_step_type" AS VARCHAR) AS "sales_loft_step_type",
        CAST("sales_loft_view_count" AS INT) AS "sales_loft_view_count",
        CAST("system_modstamp" AS TIMESTAMP) AS "system_modstamp",
        CAST("task_topic" AS VARCHAR) AS "task_topic",
        CAST("trust_earning_description" AS VARCHAR) AS "trust_earning_description",
        CAST("value_creation_description" AS VARCHAR) AS "value_creation_description"
    FROM "sf_task_data_removeWideColumns_projected_renamed_cleaned_null"
),

"sf_task_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 25 columns with unacceptable missing values
    -- account_id has 10.0 percent missing. Strategy: 🔄 Unchanged
    -- assigned_to_role has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- associated_object_id has 30.0 percent missing. Strategy: 🔄 Unchanged
    -- associated_sdr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- description_custom has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- expected_payment_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_meeting_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_meeting_held has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_rep_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legacy_hvr_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lid_sent_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lid_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opportunity_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_activity_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- proof_of_referral has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reminder_datetime has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- task_topic has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- task_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- trust_earning_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- value_creation_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "account_id",
        "assigned_to_name",
        "associated_person_count",
        "subject",
        "created_by_id",
        "id",
        "is_archived",
        "last_modified_by_id",
        "priority",
        "record_type_id",
        "is_collections_hold",
        "associated_object_id",
        "meeting_type",
        "meeting_name",
        "description",
        "has_vidyard_video",
        "is_no_show",
        "status",
        "is_collections_plan_activity",
        "is_closed",
        "associated_object_count",
        "is_high_priority",
        "owner_id",
        "is_recurring",
        "is_deleted",
        "associated_person_id",
        "task_subtype",
        "has_reminder",
        "activity_date",
        "affect_layer_call_id",
        "attendance_number",
        "bizible_id",
        "bizible_touchpoint_date",
        "call_disposition",
        "call_disposition_custom",
        "call_disposition_secondary",
        "call_duration_seconds",
        "call_object",
        "call_recording",
        "call_type",
        "campaign",
        "chorus_call_id",
        "co_sell_partner_account",
        "completed_date_time",
        "created_date",
        "duration_minutes",
        "event_name",
        "invitee_uuid",
        "is_co_sell_activity",
        "is_co_selling_activity",
        "last_modified_date",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_end_date",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month",
        "recurrence_regeneration_type",
        "recurrence_start_date",
        "recurrence_timezone",
        "recurrence_type",
        "recurrence_weekday_mask",
        "sales_loft_cadence_id",
        "sales_loft_cadence_name",
        "sales_loft_click_count",
        "sales_loft_email_template_id",
        "sales_loft_email_template_title",
        "sales_loft_external_id",
        "sales_loft_reply_count",
        "sales_loft_step_day",
        "sales_loft_step_id",
        "sales_loft_step_name",
        "sales_loft_step_type",
        "sales_loft_view_count",
        "system_modstamp"
    FROM "sf_task_data_removeWideColumns_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_task_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled"