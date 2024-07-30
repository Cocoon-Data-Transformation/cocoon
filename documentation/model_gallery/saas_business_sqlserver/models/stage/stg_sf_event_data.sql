-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:37:19.454543+00:00
WITH 
"sf_event_data_projected" AS (
    -- Projection: Selecting 112 out of 113 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "salesforce_account_id",
        "activity_date",
        "activity_date_time",
        "created_by_id",
        "created_date",
        "description",
        "duration_in_minutes",
        "end_date_time",
        "event_subtype",
        "group_event_type",
        "invitee_uuid_c",
        "is_child",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurrence",
        "is_reminder_set",
        "last_modified_by_id",
        "last_modified_date",
        "location",
        "no_show_c",
        "owner_id",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_day_of_week_mask",
        "recurrence_end_date_only",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month_of_year",
        "recurrence_start_date_time",
        "recurrence_time_zone_sid_key",
        "recurrence_type",
        "referral_account_c",
        "referral_contact_c",
        "reminder_date_time",
        "show_as",
        "start_date_time",
        "subject",
        "system_modstamp",
        "type",
        "what_count",
        "what_id",
        "who_count",
        "who_id",
        "first_meeting_held_c",
        "associated_sdr_c",
        "first_meeting_c",
        "call_recording_c",
        "affectlayer_chorus_call_id_c",
        "affectlayer_affect_layer_call_id_c",
        "last_rep_activity_date_c",
        "lid_url_c",
        "lid_date_sent_c",
        "sales_loft_step_id_c",
        "sales_loft_step_name_c",
        "sales_loft_step_type_c",
        "sales_loft_email_template_id_c",
        "sales_loft_external_identifier_c",
        "sales_loft_cadence_id_c",
        "sales_loft_clicked_count_c",
        "sales_loft_cadence_name_c",
        "sales_loft_reply_count_c",
        "call_disposition_c",
        "sales_loft_email_template_title_c",
        "sales_loft_step_day_new_c",
        "call_disposition_2_c",
        "sales_loft_viewed_count_c",
        "sales_loft_1_sales_loft_step_day_c",
        "sales_loft_1_sales_loft_clicked_count_c",
        "sales_loft_1_sales_loft_view_count_c",
        "sales_loft_1_call_disposition_c",
        "sales_loft_1_sales_loft_replies_count_c",
        "sales_loft_1_sales_loft_cadence_name_c",
        "sales_loft_1_call_sentiment_c",
        "sales_loft_1_sales_loft_email_template_title_c",
        "is_recurrence_2",
        "is_recurrence_2_exception",
        "is_recurrence_2_exclusion",
        "recurrence_2_pattern_start_date",
        "recurrence_2_pattern_text",
        "recurrence_2_pattern_time_zone",
        "recurrence_2_pattern_version",
        "co_selling_activity_c",
        "is_a_co_sell_activity_c",
        "partner_contact_c",
        "description_c",
        "campaign_c",
        "event_name_c",
        "partner_account_c",
        "topic_c",
        "attendance_number_c",
        "partner_activity_type_c",
        "how_did_you_bring_value_or_create_trust_c",
        "proof_of_referral_c",
        "how_did_you_bring_value_or_earn_trust_c",
        "duration_in_minutes_c",
        "vidyard_c",
        "collections_hold_c",
        "execute_collections_plan_activity_c",
        "expected_payment_date_c",
        "end_date",
        "opportunity_c",
        "meeting_type_c",
        "meeting_name_c",
        "bizible_2_bizible_id_c",
        "bizible_2_bizible_touchpoint_date_c",
        "assigned_to_role_c",
        "assigned_to_name_c",
        "legacy_hvr_id_c",
        "is_archived",
        "_fivetran_active"
    FROM "MyAppDB"."dbo"."sf_event_data"
),

"sf_event_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- salesforce_account_id -> account_id
    -- activity_date_time -> activity_datetime
    -- created_by_id -> creator_id
    -- created_date -> creation_datetime
    -- duration_in_minutes -> duration_minutes
    -- end_date_time -> end_datetime
    -- invitee_uuid_c -> invitee_id
    -- is_child -> is_child_event
    -- is_reminder_set -> has_reminder
    -- last_modified_by_id -> last_modifier_id
    -- no_show_c -> is_no_show
    -- recurrence_day_of_week_mask -> recurrence_weekdays
    -- recurrence_end_date_only -> recurrence_end_date
    -- recurrence_month_of_year -> recurrence_month
    -- recurrence_start_date_time -> recurrence_start_datetime
    -- recurrence_time_zone_sid_key -> recurrence_timezone
    -- referral_account_c -> referral_account
    -- referral_contact_c -> referral_contact
    -- reminder_date_time -> reminder_datetime
    -- show_as -> availability_status
    -- start_date_time -> event_start_datetime
    -- type -> event_type
    -- what_count -> associated_object_count
    -- what_id -> associated_object_id
    -- who_count -> associated_contact_count
    -- who_id -> associated_contact_id
    -- first_meeting_held_c -> first_meeting_held
    -- associated_sdr_c -> associated_sdr
    -- first_meeting_c -> first_meeting
    -- call_recording_c -> call_recording
    -- affectlayer_chorus_call_id_c -> chorus_call_id
    -- affectlayer_affect_layer_call_id_c -> affect_layer_call_id
    -- last_rep_activity_date_c -> last_rep_activity_date
    -- lid_url_c -> lid_url
    -- lid_date_sent_c -> lid_date_sent
    -- sales_loft_step_id_c -> salesloft_step_id
    -- sales_loft_step_name_c -> salesloft_step_name
    -- sales_loft_step_type_c -> salesloft_step_type
    -- sales_loft_email_template_id_c -> salesloft_email_template_id
    -- sales_loft_external_identifier_c -> salesloft_external_identifier
    -- sales_loft_cadence_id_c -> salesloft_cadence_id
    -- sales_loft_clicked_count_c -> salesloft_click_count
    -- sales_loft_cadence_name_c -> salesloft_cadence_name
    -- sales_loft_reply_count_c -> salesloft_reply_count
    -- call_disposition_c -> call_disposition
    -- sales_loft_email_template_title_c -> salesloft_email_template_title
    -- sales_loft_step_day_new_c -> salesloft_step_day
    -- call_disposition_2_c -> call_disposition_secondary
    -- sales_loft_viewed_count_c -> salesloft_view_count
    -- sales_loft_1_sales_loft_step_day_c -> salesloft_step_day_alt
    -- sales_loft_1_sales_loft_clicked_count_c -> salesloft_click_count_alt
    -- sales_loft_1_sales_loft_view_count_c -> salesloft_view_count_alt
    -- sales_loft_1_call_disposition_c -> call_disposition_alt
    -- sales_loft_1_sales_loft_replies_count_c -> salesloft_reply_count_alt
    -- sales_loft_1_sales_loft_cadence_name_c -> salesloft_cadence_name_alt
    -- sales_loft_1_call_sentiment_c -> call_sentiment
    -- sales_loft_1_sales_loft_email_template_title_c -> salesloft_email_template_title_alt
    -- is_recurrence_2_exception -> is_recurrence_exception
    -- is_recurrence_2_exclusion -> is_recurrence_exclusion
    -- recurrence_2_pattern_start_date -> recurrence_start_date
    -- recurrence_2_pattern_text -> recurrence_pattern_description
    -- recurrence_2_pattern_time_zone -> recurrence_time_zone
    -- recurrence_2_pattern_version -> recurrence_pattern_version
    -- co_selling_activity_c -> is_co_selling_activity
    -- is_a_co_sell_activity_c -> is_confirmed_co_sell_activity
    -- partner_contact_c -> partner_contact
    -- campaign_c -> campaign
    -- event_name_c -> event_name
    -- partner_account_c -> partner_account
    -- topic_c -> event_topic
    -- attendance_number_c -> attendee_count
    -- partner_activity_type_c -> partner_activity_type
    -- how_did_you_bring_value_or_create_trust_c -> value_creation_description
    -- proof_of_referral_c -> referral_proof
    -- how_did_you_bring_value_or_earn_trust_c -> trust_earning_description
    -- duration_in_minutes_c -> event_duration_minutes
    -- vidyard_c -> vidyard_integration
    -- collections_hold_c -> collections_hold_status
    -- execute_collections_plan_activity_c -> collections_plan_executed
    -- expected_payment_date_c -> expected_payment_date
    -- end_date -> event_end_datetime
    -- opportunity_c -> opportunity_id
    -- meeting_type_c -> meeting_type
    -- meeting_name_c -> meeting_name
    -- bizible_2_bizible_id_c -> bizible_id
    -- bizible_2_bizible_touchpoint_date_c -> bizible_touchpoint_date
    -- assigned_to_role_c -> assigned_role
    -- assigned_to_name_c -> assigned_name
    -- legacy_hvr_id_c -> legacy_hvr_id
    -- _fivetran_active -> fivetran_active_status
    SELECT 
        "id" AS "event_id",
        "salesforce_account_id" AS "account_id",
        "activity_date",
        "activity_date_time" AS "activity_datetime",
        "created_by_id" AS "creator_id",
        "created_date" AS "creation_datetime",
        "description",
        "duration_in_minutes" AS "duration_minutes",
        "end_date_time" AS "end_datetime",
        "event_subtype",
        "group_event_type",
        "invitee_uuid_c" AS "invitee_id",
        "is_child" AS "is_child_event",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurrence",
        "is_reminder_set" AS "has_reminder",
        "last_modified_by_id" AS "last_modifier_id",
        "last_modified_date",
        "location",
        "no_show_c" AS "is_no_show",
        "owner_id",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_day_of_week_mask" AS "recurrence_weekdays",
        "recurrence_end_date_only" AS "recurrence_end_date",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month_of_year" AS "recurrence_month",
        "recurrence_start_date_time" AS "recurrence_start_datetime",
        "recurrence_time_zone_sid_key" AS "recurrence_timezone",
        "recurrence_type",
        "referral_account_c" AS "referral_account",
        "referral_contact_c" AS "referral_contact",
        "reminder_date_time" AS "reminder_datetime",
        "show_as" AS "availability_status",
        "start_date_time" AS "event_start_datetime",
        "subject",
        "system_modstamp",
        "type" AS "event_type",
        "what_count" AS "associated_object_count",
        "what_id" AS "associated_object_id",
        "who_count" AS "associated_contact_count",
        "who_id" AS "associated_contact_id",
        "first_meeting_held_c" AS "first_meeting_held",
        "associated_sdr_c" AS "associated_sdr",
        "first_meeting_c" AS "first_meeting",
        "call_recording_c" AS "call_recording",
        "affectlayer_chorus_call_id_c" AS "chorus_call_id",
        "affectlayer_affect_layer_call_id_c" AS "affect_layer_call_id",
        "last_rep_activity_date_c" AS "last_rep_activity_date",
        "lid_url_c" AS "lid_url",
        "lid_date_sent_c" AS "lid_date_sent",
        "sales_loft_step_id_c" AS "salesloft_step_id",
        "sales_loft_step_name_c" AS "salesloft_step_name",
        "sales_loft_step_type_c" AS "salesloft_step_type",
        "sales_loft_email_template_id_c" AS "salesloft_email_template_id",
        "sales_loft_external_identifier_c" AS "salesloft_external_identifier",
        "sales_loft_cadence_id_c" AS "salesloft_cadence_id",
        "sales_loft_clicked_count_c" AS "salesloft_click_count",
        "sales_loft_cadence_name_c" AS "salesloft_cadence_name",
        "sales_loft_reply_count_c" AS "salesloft_reply_count",
        "call_disposition_c" AS "call_disposition",
        "sales_loft_email_template_title_c" AS "salesloft_email_template_title",
        "sales_loft_step_day_new_c" AS "salesloft_step_day",
        "call_disposition_2_c" AS "call_disposition_secondary",
        "sales_loft_viewed_count_c" AS "salesloft_view_count",
        "sales_loft_1_sales_loft_step_day_c" AS "salesloft_step_day_alt",
        "sales_loft_1_sales_loft_clicked_count_c" AS "salesloft_click_count_alt",
        "sales_loft_1_sales_loft_view_count_c" AS "salesloft_view_count_alt",
        "sales_loft_1_call_disposition_c" AS "call_disposition_alt",
        "sales_loft_1_sales_loft_replies_count_c" AS "salesloft_reply_count_alt",
        "sales_loft_1_sales_loft_cadence_name_c" AS "salesloft_cadence_name_alt",
        "sales_loft_1_call_sentiment_c" AS "call_sentiment",
        "sales_loft_1_sales_loft_email_template_title_c" AS "salesloft_email_template_title_alt",
        "is_recurrence_2",
        "is_recurrence_2_exception" AS "is_recurrence_exception",
        "is_recurrence_2_exclusion" AS "is_recurrence_exclusion",
        "recurrence_2_pattern_start_date" AS "recurrence_start_date",
        "recurrence_2_pattern_text" AS "recurrence_pattern_description",
        "recurrence_2_pattern_time_zone" AS "recurrence_time_zone",
        "recurrence_2_pattern_version" AS "recurrence_pattern_version",
        "co_selling_activity_c" AS "is_co_selling_activity",
        "is_a_co_sell_activity_c" AS "is_confirmed_co_sell_activity",
        "partner_contact_c" AS "partner_contact",
        "description_c",
        "campaign_c" AS "campaign",
        "event_name_c" AS "event_name",
        "partner_account_c" AS "partner_account",
        "topic_c" AS "event_topic",
        "attendance_number_c" AS "attendee_count",
        "partner_activity_type_c" AS "partner_activity_type",
        "how_did_you_bring_value_or_create_trust_c" AS "value_creation_description",
        "proof_of_referral_c" AS "referral_proof",
        "how_did_you_bring_value_or_earn_trust_c" AS "trust_earning_description",
        "duration_in_minutes_c" AS "event_duration_minutes",
        "vidyard_c" AS "vidyard_integration",
        "collections_hold_c" AS "collections_hold_status",
        "execute_collections_plan_activity_c" AS "collections_plan_executed",
        "expected_payment_date_c" AS "expected_payment_date",
        "end_date" AS "event_end_datetime",
        "opportunity_c" AS "opportunity_id",
        "meeting_type_c" AS "meeting_type",
        "meeting_name_c" AS "meeting_name",
        "bizible_2_bizible_id_c" AS "bizible_id",
        "bizible_2_bizible_touchpoint_date_c" AS "bizible_touchpoint_date",
        "assigned_to_role_c" AS "assigned_role",
        "assigned_to_name_c" AS "assigned_name",
        "legacy_hvr_id_c" AS "legacy_hvr_id",
        "is_archived",
        "_fivetran_active" AS "fivetran_active_status"
    FROM "sf_event_data_projected"
),

"sf_event_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- subject: The problem is that the 'subject' column only contains a single generic value 'subject', which doesn't provide any meaningful categorization or information about the actual subjects. This suggests that the column may have been incorrectly populated or is a placeholder. The correct values would typically be specific subject categories relevant to the dataset, such as 'Mathematics', 'History', 'Science', etc. However, without additional context or information about the intended use of this column, it's not possible to determine the correct specific subject categories.
    SELECT
        "event_id",
        "account_id",
        "activity_date",
        "activity_datetime",
        "creator_id",
        "creation_datetime",
        "description",
        "duration_minutes",
        "end_datetime",
        "event_subtype",
        "group_event_type",
        "invitee_id",
        "is_child_event",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurrence",
        "has_reminder",
        "last_modifier_id",
        "last_modified_date",
        "location",
        "is_no_show",
        "owner_id",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_weekdays",
        "recurrence_end_date",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month",
        "recurrence_start_datetime",
        "recurrence_timezone",
        "recurrence_type",
        "referral_account",
        "referral_contact",
        "reminder_datetime",
        "availability_status",
        "event_start_datetime",
        CASE
            WHEN "subject" = 'subject' THEN NULL
            ELSE "subject"
        END AS "subject",
        "system_modstamp",
        "event_type",
        "associated_object_count",
        "associated_object_id",
        "associated_contact_count",
        "associated_contact_id",
        "first_meeting_held",
        "associated_sdr",
        "first_meeting",
        "call_recording",
        "chorus_call_id",
        "affect_layer_call_id",
        "last_rep_activity_date",
        "lid_url",
        "lid_date_sent",
        "salesloft_step_id",
        "salesloft_step_name",
        "salesloft_step_type",
        "salesloft_email_template_id",
        "salesloft_external_identifier",
        "salesloft_cadence_id",
        "salesloft_click_count",
        "salesloft_cadence_name",
        "salesloft_reply_count",
        "call_disposition",
        "salesloft_email_template_title",
        "salesloft_step_day",
        "call_disposition_secondary",
        "salesloft_view_count",
        "salesloft_step_day_alt",
        "salesloft_click_count_alt",
        "salesloft_view_count_alt",
        "call_disposition_alt",
        "salesloft_reply_count_alt",
        "salesloft_cadence_name_alt",
        "call_sentiment",
        "salesloft_email_template_title_alt",
        "is_recurrence_2",
        "is_recurrence_exception",
        "is_recurrence_exclusion",
        "recurrence_start_date",
        "recurrence_pattern_description",
        "recurrence_time_zone",
        "recurrence_pattern_version",
        "is_co_selling_activity",
        "is_confirmed_co_sell_activity",
        "partner_contact",
        "description_c",
        "campaign",
        "event_name",
        "partner_account",
        "event_topic",
        "attendee_count",
        "partner_activity_type",
        "value_creation_description",
        "referral_proof",
        "trust_earning_description",
        "event_duration_minutes",
        "vidyard_integration",
        "collections_hold_status",
        "collections_plan_executed",
        "expected_payment_date",
        "event_end_datetime",
        "opportunity_id",
        "meeting_type",
        "meeting_name",
        "bizible_id",
        "bizible_touchpoint_date",
        "assigned_role",
        "assigned_name",
        "legacy_hvr_id",
        "is_archived",
        "fivetran_active_status"
    FROM "sf_event_data_projected_renamed"
),

"sf_event_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- activity_date: from VARCHAR to DATE
    -- activity_datetime: from VARCHAR to DATETIME
    -- affect_layer_call_id: from FLOAT to VARCHAR
    -- assigned_name: from FLOAT to VARCHAR
    -- assigned_role: from FLOAT to VARCHAR
    -- associated_sdr: from FLOAT to VARCHAR
    -- attendee_count: from FLOAT to INT
    -- bizible_id: from FLOAT to VARCHAR
    -- bizible_touchpoint_date: from FLOAT to DATE
    -- call_disposition: from FLOAT to VARCHAR
    -- call_disposition_alt: from FLOAT to VARCHAR
    -- call_disposition_secondary: from FLOAT to VARCHAR
    -- call_recording: from FLOAT to VARCHAR
    -- call_sentiment: from FLOAT to VARCHAR
    -- campaign: from FLOAT to VARCHAR
    -- chorus_call_id: from FLOAT to VARCHAR
    -- collections_hold_status: from VARCHAR to BOOLEAN
    -- collections_plan_executed: from VARCHAR to BOOLEAN
    -- creation_datetime: from VARCHAR to DATETIME
    -- description_c: from FLOAT to VARCHAR
    -- end_datetime: from VARCHAR to DATETIME
    -- event_duration_minutes: from FLOAT to INT
    -- event_end_datetime: from VARCHAR to DATETIME
    -- event_name: from FLOAT to VARCHAR
    -- event_start_datetime: from VARCHAR to DATETIME
    -- event_topic: from FLOAT to VARCHAR
    -- expected_payment_date: from FLOAT to DATE
    -- first_meeting: from FLOAT to VARCHAR
    -- first_meeting_held: from FLOAT to VARCHAR
    -- fivetran_active_status: from FLOAT to VARCHAR
    -- group_event_type: from FLOAT to DECIMAL
    -- has_reminder: from VARCHAR to BOOLEAN
    -- invitee_id: from FLOAT to VARCHAR
    -- is_archived: from VARCHAR to BOOLEAN
    -- is_child_event: from VARCHAR to BOOLEAN
    -- is_co_selling_activity: from FLOAT to BOOLEAN
    -- is_confirmed_co_sell_activity: from FLOAT to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_group_event: from VARCHAR to BOOLEAN
    -- is_no_show: from VARCHAR to BOOLEAN
    -- is_private: from VARCHAR to BOOLEAN
    -- is_recurrence: from VARCHAR to BOOLEAN
    -- is_recurrence_2: from VARCHAR to BOOLEAN
    -- is_recurrence_exception: from VARCHAR to BOOLEAN
    -- is_recurrence_exclusion: from VARCHAR to BOOLEAN
    -- last_modified_date: from VARCHAR to DATETIME
    -- last_rep_activity_date: from FLOAT to DATE
    -- legacy_hvr_id: from FLOAT to VARCHAR
    -- lid_date_sent: from FLOAT to DATE
    -- lid_url: from FLOAT to VARCHAR
    -- location: from FLOAT to VARCHAR
    -- meeting_name: from FLOAT to VARCHAR
    -- meeting_type: from FLOAT to VARCHAR
    -- opportunity_id: from FLOAT to VARCHAR
    -- partner_account: from FLOAT to VARCHAR
    -- partner_activity_type: from FLOAT to VARCHAR
    -- partner_contact: from FLOAT to VARCHAR
    -- recurrence_activity_id: from FLOAT to VARCHAR
    -- recurrence_day_of_month: from FLOAT to INT
    -- recurrence_end_date: from FLOAT to DATE
    -- recurrence_instance: from FLOAT to VARCHAR
    -- recurrence_interval: from FLOAT to INT
    -- recurrence_month: from FLOAT to INT
    -- recurrence_pattern_description: from FLOAT to VARCHAR
    -- recurrence_pattern_version: from FLOAT to VARCHAR
    -- recurrence_start_date: from FLOAT to DATE
    -- recurrence_start_datetime: from FLOAT to DATETIME
    -- recurrence_time_zone: from FLOAT to VARCHAR
    -- recurrence_timezone: from FLOAT to VARCHAR
    -- recurrence_type: from FLOAT to VARCHAR
    -- recurrence_weekdays: from FLOAT to VARCHAR
    -- referral_account: from FLOAT to VARCHAR
    -- referral_contact: from FLOAT to VARCHAR
    -- referral_proof: from FLOAT to VARCHAR
    -- reminder_datetime: from FLOAT to DATETIME
    -- salesloft_cadence_id: from FLOAT to VARCHAR
    -- salesloft_cadence_name: from FLOAT to VARCHAR
    -- salesloft_cadence_name_alt: from FLOAT to VARCHAR
    -- salesloft_click_count: from FLOAT to INT
    -- salesloft_click_count_alt: from FLOAT to INT
    -- salesloft_email_template_id: from FLOAT to VARCHAR
    -- salesloft_email_template_title: from FLOAT to VARCHAR
    -- salesloft_email_template_title_alt: from FLOAT to VARCHAR
    -- salesloft_external_identifier: from FLOAT to VARCHAR
    -- salesloft_reply_count: from FLOAT to INT
    -- salesloft_reply_count_alt: from FLOAT to INT
    -- salesloft_step_day: from FLOAT to INT
    -- salesloft_step_day_alt: from FLOAT to INT
    -- salesloft_step_id: from FLOAT to VARCHAR
    -- salesloft_step_name: from FLOAT to VARCHAR
    -- salesloft_step_type: from FLOAT to VARCHAR
    -- salesloft_view_count: from FLOAT to INT
    -- salesloft_view_count_alt: from FLOAT to INT
    -- system_modstamp: from VARCHAR to DATETIME
    -- trust_earning_description: from FLOAT to VARCHAR
    -- value_creation_description: from FLOAT to VARCHAR
    -- vidyard_integration: from VARCHAR to BOOLEAN
    SELECT
        "event_id",
        "account_id",
        "creator_id",
        "description",
        "duration_minutes",
        "event_subtype",
        "last_modifier_id",
        "owner_id",
        "availability_status",
        "subject",
        "event_type",
        "associated_object_count",
        "associated_object_id",
        "associated_contact_count",
        "associated_contact_id",
        CAST("activity_date" AS DATE) 
        AS "activity_date",
        CAST("activity_datetime" AS DATETIME) 
        AS "activity_datetime",
        CAST("affect_layer_call_id" AS VARCHAR) 
        AS "affect_layer_call_id",
        CAST("assigned_name" AS VARCHAR) 
        AS "assigned_name",
        CAST("assigned_role" AS VARCHAR) 
        AS "assigned_role",
        CAST("associated_sdr" AS VARCHAR) 
        AS "associated_sdr",
        CAST("attendee_count" AS INT) 
        AS "attendee_count",
        CAST("bizible_id" AS VARCHAR) 
        AS "bizible_id",
        CAST(DATEADD(DAY, CAST("bizible_touchpoint_date" AS INT), '1900-01-01') AS DATE) 
        AS "bizible_touchpoint_date",
        CAST("call_disposition" AS VARCHAR) 
        AS "call_disposition",
        CAST("call_disposition_alt" AS VARCHAR) 
        AS "call_disposition_alt",
        CAST("call_disposition_secondary" AS VARCHAR) 
        AS "call_disposition_secondary",
        CAST("call_recording" AS VARCHAR) 
        AS "call_recording",
        CAST("call_sentiment" AS VARCHAR) 
        AS "call_sentiment",
        CAST("campaign" AS VARCHAR) 
        AS "campaign",
        CAST("chorus_call_id" AS VARCHAR) 
        AS "chorus_call_id",
        CAST(CAST("collections_hold_status" AS INT) AS BIT) 
        AS "collections_hold_status",
        CASE WHEN "collections_plan_executed" = '0' THEN 0 ELSE 1 END 
        AS "collections_plan_executed",
        CAST("creation_datetime" AS DATETIME) 
        AS "creation_datetime",
        CAST("description_c" AS VARCHAR) 
        AS "description_c",
        CAST("end_datetime" AS DATETIME) 
        AS "end_datetime",
        CAST("event_duration_minutes" AS INT) 
        AS "event_duration_minutes",
        CAST("event_end_datetime" AS DATETIME) 
        AS "event_end_datetime",
        CAST("event_name" AS VARCHAR) 
        AS "event_name",
        CAST("event_start_datetime" AS DATETIME) 
        AS "event_start_datetime",
        CAST("event_topic" AS VARCHAR) 
        AS "event_topic",
        CAST(DATEADD(day, FLOOR("expected_payment_date"), '1900-01-01') AS DATE) 
        AS "expected_payment_date",
        CAST("first_meeting" AS VARCHAR) 
        AS "first_meeting",
        CAST("first_meeting_held" AS VARCHAR) 
        AS "first_meeting_held",
        CAST("fivetran_active_status" AS VARCHAR) 
        AS "fivetran_active_status",
        CAST("group_event_type" AS DECIMAL) 
        AS "group_event_type",
        CAST(CASE WHEN "has_reminder" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "has_reminder",
        CAST("invitee_id" AS VARCHAR) 
        AS "invitee_id",
        CAST(CAST("is_archived" AS INT) AS BIT) 
        AS "is_archived",
        CAST(CASE WHEN "is_child_event" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "is_child_event",
        CAST("is_co_selling_activity" AS BIT) 
        AS "is_co_selling_activity",
        CAST("is_confirmed_co_sell_activity" AS BIT) 
        AS "is_confirmed_co_sell_activity",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CAST("is_group_event" AS BIT) 
        AS "is_group_event",
        CAST("is_no_show" AS BIT) 
        AS "is_no_show",
        CAST("is_private" AS BIT) 
        AS "is_private",
        CASE WHEN "is_recurrence" = '0' THEN 0 ELSE 1 END 
        AS "is_recurrence",
        CAST("is_recurrence_2" AS BIT) 
        AS "is_recurrence_2",
        CAST(CASE WHEN "is_recurrence_exception" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "is_recurrence_exception",
        CAST(CASE WHEN "is_recurrence_exclusion" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "is_recurrence_exclusion",
        CAST("last_modified_date" AS DATETIME) 
        AS "last_modified_date",
        "last_rep_activity_date" 
        AS "last_rep_activity_date",
        CAST("legacy_hvr_id" AS VARCHAR) 
        AS "legacy_hvr_id",
        CAST(DATEADD(DAY, FLOOR("lid_date_sent"), '1900-01-01') AS DATE) 
        AS "lid_date_sent",
        CAST("lid_url" AS VARCHAR) 
        AS "lid_url",
        CAST("location" AS VARCHAR) 
        AS "location",
        CAST("meeting_name" AS VARCHAR) 
        AS "meeting_name",
        CAST("meeting_type" AS VARCHAR) 
        AS "meeting_type",
        CAST("opportunity_id" AS VARCHAR) 
        AS "opportunity_id",
        CAST("partner_account" AS VARCHAR) 
        AS "partner_account",
        CAST("partner_activity_type" AS VARCHAR) 
        AS "partner_activity_type",
        CAST("partner_contact" AS VARCHAR) 
        AS "partner_contact",
        CAST("recurrence_activity_id" AS VARCHAR) 
        AS "recurrence_activity_id",
        CAST("recurrence_day_of_month" AS INT) 
        AS "recurrence_day_of_month",
        CAST(DATEADD(DAY, CAST("recurrence_end_date" AS INT), '1900-01-01') AS DATE) 
        AS "recurrence_end_date",
        CAST("recurrence_instance" AS VARCHAR) 
        AS "recurrence_instance",
        CAST("recurrence_interval" AS INT) 
        AS "recurrence_interval",
        CAST("recurrence_month" AS INT) 
        AS "recurrence_month",
        CAST("recurrence_pattern_description" AS VARCHAR) 
        AS "recurrence_pattern_description",
        CAST("recurrence_pattern_version" AS VARCHAR) 
        AS "recurrence_pattern_version",
        CAST(DATEADD(day, CAST("recurrence_start_date" AS INT), '1900-01-01') AS DATE) 
        AS "recurrence_start_date",
        DATEADD(SECOND, CAST("recurrence_start_datetime" AS BIGINT), '1970-01-01') 
        AS "recurrence_start_datetime",
        CAST("recurrence_time_zone" AS VARCHAR) 
        AS "recurrence_time_zone",
        CAST("recurrence_timezone" AS VARCHAR) 
        AS "recurrence_timezone",
        CAST("recurrence_type" AS VARCHAR) 
        AS "recurrence_type",
        CAST("recurrence_weekdays" AS VARCHAR) 
        AS "recurrence_weekdays",
        CAST("referral_account" AS VARCHAR) 
        AS "referral_account",
        CAST("referral_contact" AS VARCHAR) 
        AS "referral_contact",
        CAST("referral_proof" AS VARCHAR) 
        AS "referral_proof",
        CONVERT(DATETIME, CONVERT(VARCHAR(23), "reminder_datetime", 126)) 
        AS "reminder_datetime",
        CAST("salesloft_cadence_id" AS VARCHAR) 
        AS "salesloft_cadence_id",
        CAST("salesloft_cadence_name" AS VARCHAR) 
        AS "salesloft_cadence_name",
        CAST("salesloft_cadence_name_alt" AS VARCHAR) 
        AS "salesloft_cadence_name_alt",
        CAST("salesloft_click_count" AS INT) 
        AS "salesloft_click_count",
        CAST("salesloft_click_count_alt" AS INT) 
        AS "salesloft_click_count_alt",
        CAST("salesloft_email_template_id" AS VARCHAR) 
        AS "salesloft_email_template_id",
        CAST("salesloft_email_template_title" AS VARCHAR(255)) 
        AS "salesloft_email_template_title",
        CAST("salesloft_email_template_title_alt" AS VARCHAR) 
        AS "salesloft_email_template_title_alt",
        CAST("salesloft_external_identifier" AS VARCHAR(255)) 
        AS "salesloft_external_identifier",
        CAST("salesloft_reply_count" AS INT) 
        AS "salesloft_reply_count",
        CAST("salesloft_reply_count_alt" AS INT) 
        AS "salesloft_reply_count_alt",
        CAST("salesloft_step_day" AS INT) 
        AS "salesloft_step_day",
        CAST("salesloft_step_day_alt" AS INT) 
        AS "salesloft_step_day_alt",
        CAST("salesloft_step_id" AS VARCHAR) 
        AS "salesloft_step_id",
        CAST("salesloft_step_name" AS VARCHAR(MAX)) 
        AS "salesloft_step_name",
        CAST("salesloft_step_type" AS VARCHAR) 
        AS "salesloft_step_type",
        CAST("salesloft_view_count" AS INT) 
        AS "salesloft_view_count",
        CAST("salesloft_view_count_alt" AS INT) 
        AS "salesloft_view_count_alt",
        CAST("system_modstamp" AS DATETIME) 
        AS "system_modstamp",
        CAST("trust_earning_description" AS VARCHAR) 
        AS "trust_earning_description",
        CAST("value_creation_description" AS VARCHAR) 
        AS "value_creation_description",
        CAST("vidyard_integration" AS BIT) 
        AS "vidyard_integration"
    FROM "sf_event_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_event_data_projected_renamed_cleaned_casted"