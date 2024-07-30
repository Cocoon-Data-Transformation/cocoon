-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 03:02:00.269648+00:00
WITH 
"sf_task_data_projected" AS (
    -- Projection: Selecting 106 out of 107 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "referral_account_c",
        "who_id",
        "call_disposition",
        "recurrence_day_of_month",
        "owner_id",
        "recurrence_end_date_only",
        "subject",
        "description",
        "last_modified_date",
        "recurrence_time_zone_sid_key",
        "is_recurrence",
        "what_count",
        "call_object",
        "is_deleted",
        "recurrence_day_of_week_mask",
        "last_modified_by_id",
        "system_modstamp",
        "recurrence_regenerated_type",
        "id",
        "recurrence_type",
        "reminder_date_time",
        "call_type",
        "is_high_priority",
        "is_closed",
        "recurrence_month_of_year",
        "is_reminder_set",
        "activity_date",
        "recurrence_instance",
        "priority",
        "recurrence_interval",
        "who_count",
        "recurrence_start_date_only",
        "salesforce_account_id",
        "referral_contact_c",
        "call_duration_in_seconds",
        "created_by_id",
        "created_date",
        "recurrence_activity_id",
        "what_id",
        "task_subtype",
        "status",
        "invitee_uuid_c",
        "type",
        "no_show_c",
        "first_meeting_held_c",
        "associated_sdr_c",
        "first_meeting_c",
        "call_recording_c",
        "affectlayer_chorus_call_id_c",
        "affectlayer_affect_layer_call_id_c",
        "last_rep_activity_date_c",
        "lid_url_c",
        "lid_date_sent_c",
        "record_type_id",
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
        "completed_date_time",
        "is_a_co_sell_activity_c",
        "partner_contact_c",
        "co_selling_activity_c",
        "description_c",
        "co_sell_partner_account_c",
        "campaign_c",
        "partner_account_c",
        "topic_c",
        "event_name_c",
        "attendance_number_c",
        "partner_activity_type_c",
        "proof_of_referral_c",
        "how_did_you_bring_value_or_create_trust_c",
        "how_did_you_bring_value_or_earn_trust_c",
        "duration_in_minutes_c",
        "vidyard_c",
        "expected_payment_date_c",
        "execute_collections_plan_activity_c",
        "collections_hold_c",
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
    FROM "MyAppDB"."dbo"."sf_task_data"
),

"sf_task_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- referral_account_c -> referral_account_id
    -- who_id -> associated_person_id
    -- owner_id -> task_owner_id
    -- recurrence_end_date_only -> recurrence_end_date
    -- subject -> task_subject
    -- description -> task_description
    -- recurrence_time_zone_sid_key -> recurrence_time_zone
    -- is_recurrence -> is_recurring
    -- what_count -> related_object_count
    -- call_object -> call_details
    -- recurrence_day_of_week_mask -> recurrence_weekdays
    -- system_modstamp -> system_modification_timestamp
    -- recurrence_regenerated_type -> recurrence_regeneration_type
    -- id -> task_id
    -- reminder_date_time -> reminder_datetime
    -- recurrence_month_of_year -> recurrence_month
    -- is_reminder_set -> has_reminder
    -- activity_date -> due_date
    -- recurrence_instance -> recurrence_week_of_month
    -- priority -> task_priority
    -- who_count -> associated_person_count
    -- recurrence_start_date_only -> recurrence_start_date
    -- salesforce_account_id -> account_id
    -- referral_contact_c -> referral_contact
    -- call_duration_in_seconds -> call_duration
    -- created_by_id -> creator_id
    -- created_date -> creation_timestamp
    -- what_id -> related_object_id
    -- invitee_uuid_c -> invitee_uuid
    -- type -> activity_type
    -- no_show_c -> is_no_show
    -- first_meeting_held_c -> is_first_meeting_held
    -- associated_sdr_c -> associated_sdr
    -- first_meeting_c -> is_first_meeting
    -- call_recording_c -> call_recording_url
    -- affectlayer_chorus_call_id_c -> chorus_call_id
    -- affectlayer_affect_layer_call_id_c -> affect_layer_call_id
    -- last_rep_activity_date_c -> last_rep_activity_date
    -- lid_url_c -> lid_url
    -- lid_date_sent_c -> lid_sent_date
    -- sales_loft_step_id_c -> salesloft_step_id
    -- sales_loft_step_name_c -> salesloft_step_name
    -- sales_loft_step_type_c -> salesloft_step_type
    -- sales_loft_email_template_id_c -> salesloft_email_template_id
    -- sales_loft_external_identifier_c -> salesloft_external_id
    -- sales_loft_cadence_id_c -> salesloft_cadence_id
    -- sales_loft_clicked_count_c -> salesloft_email_clicks
    -- sales_loft_cadence_name_c -> salesloft_cadence_name
    -- sales_loft_reply_count_c -> salesloft_email_replies
    -- sales_loft_email_template_title_c -> salesloft_email_template
    -- sales_loft_step_day_new_c -> salesloft_step_day
    -- call_disposition_2_c -> call_disposition_secondary
    -- sales_loft_viewed_count_c -> salesloft_email_views
    -- sales_loft_1_sales_loft_step_day_c -> salesloft_step_day_alternate
    -- sales_loft_1_sales_loft_clicked_count_c -> salesloft_email_clicks_alternate
    -- sales_loft_1_sales_loft_view_count_c -> salesloft_email_views_alternate
    -- sales_loft_1_call_disposition_c -> call_disposition_alternate
    -- sales_loft_1_sales_loft_replies_count_c -> salesloft_email_replies_alternate
    -- sales_loft_1_sales_loft_cadence_name_c -> salesloft_cadence_name_alternate
    -- sales_loft_1_call_sentiment_c -> call_sentiment
    -- sales_loft_1_sales_loft_email_template_title_c -> salesloft_email_template_alternate
    -- is_a_co_sell_activity_c -> is_co_sell_activity
    -- partner_contact_c -> partner_contact
    -- co_selling_activity_c -> co_selling_activity_description
    -- description_c -> activity_description
    -- co_sell_partner_account_c -> co_sell_partner_account
    -- campaign_c -> campaign
    -- partner_account_c -> partner_account
    -- topic_c -> activity_topic
    -- event_name_c -> event_name
    -- attendance_number_c -> attendance_number
    -- partner_activity_type_c -> partner_activity_type
    -- proof_of_referral_c -> referral_proof
    -- how_did_you_bring_value_or_create_trust_c -> value_creation_description
    -- how_did_you_bring_value_or_earn_trust_c -> value_or_trust_action
    -- duration_in_minutes_c -> duration_minutes
    -- vidyard_c -> vidyard_used
    -- expected_payment_date_c -> expected_payment_date
    -- execute_collections_plan_activity_c -> collections_plan_executed
    -- collections_hold_c -> collections_hold
    -- opportunity_c -> opportunity_id
    -- meeting_type_c -> meeting_type
    -- meeting_name_c -> meeting_name
    -- bizible_2_bizible_id_c -> bizible_id
    -- bizible_2_bizible_touchpoint_date_c -> bizible_touchpoint_date
    -- assigned_to_role_c -> assigned_role
    -- assigned_to_name_c -> assigned_name
    -- legacy_hvr_id_c -> legacy_hvr_id
    -- _fivetran_active -> fivetran_active
    SELECT 
        "referral_account_c" AS "referral_account_id",
        "who_id" AS "associated_person_id",
        "call_disposition",
        "recurrence_day_of_month",
        "owner_id" AS "task_owner_id",
        "recurrence_end_date_only" AS "recurrence_end_date",
        "subject" AS "task_subject",
        "description" AS "task_description",
        "last_modified_date",
        "recurrence_time_zone_sid_key" AS "recurrence_time_zone",
        "is_recurrence" AS "is_recurring",
        "what_count" AS "related_object_count",
        "call_object" AS "call_details",
        "is_deleted",
        "recurrence_day_of_week_mask" AS "recurrence_weekdays",
        "last_modified_by_id",
        "system_modstamp" AS "system_modification_timestamp",
        "recurrence_regenerated_type" AS "recurrence_regeneration_type",
        "id" AS "task_id",
        "recurrence_type",
        "reminder_date_time" AS "reminder_datetime",
        "call_type",
        "is_high_priority",
        "is_closed",
        "recurrence_month_of_year" AS "recurrence_month",
        "is_reminder_set" AS "has_reminder",
        "activity_date" AS "due_date",
        "recurrence_instance" AS "recurrence_week_of_month",
        "priority" AS "task_priority",
        "recurrence_interval",
        "who_count" AS "associated_person_count",
        "recurrence_start_date_only" AS "recurrence_start_date",
        "salesforce_account_id" AS "account_id",
        "referral_contact_c" AS "referral_contact",
        "call_duration_in_seconds" AS "call_duration",
        "created_by_id" AS "creator_id",
        "created_date" AS "creation_timestamp",
        "recurrence_activity_id",
        "what_id" AS "related_object_id",
        "task_subtype",
        "status",
        "invitee_uuid_c" AS "invitee_uuid",
        "type" AS "activity_type",
        "no_show_c" AS "is_no_show",
        "first_meeting_held_c" AS "is_first_meeting_held",
        "associated_sdr_c" AS "associated_sdr",
        "first_meeting_c" AS "is_first_meeting",
        "call_recording_c" AS "call_recording_url",
        "affectlayer_chorus_call_id_c" AS "chorus_call_id",
        "affectlayer_affect_layer_call_id_c" AS "affect_layer_call_id",
        "last_rep_activity_date_c" AS "last_rep_activity_date",
        "lid_url_c" AS "lid_url",
        "lid_date_sent_c" AS "lid_sent_date",
        "record_type_id",
        "sales_loft_step_id_c" AS "salesloft_step_id",
        "sales_loft_step_name_c" AS "salesloft_step_name",
        "sales_loft_step_type_c" AS "salesloft_step_type",
        "sales_loft_email_template_id_c" AS "salesloft_email_template_id",
        "sales_loft_external_identifier_c" AS "salesloft_external_id",
        "sales_loft_cadence_id_c" AS "salesloft_cadence_id",
        "sales_loft_clicked_count_c" AS "salesloft_email_clicks",
        "sales_loft_cadence_name_c" AS "salesloft_cadence_name",
        "sales_loft_reply_count_c" AS "salesloft_email_replies",
        "call_disposition_c",
        "sales_loft_email_template_title_c" AS "salesloft_email_template",
        "sales_loft_step_day_new_c" AS "salesloft_step_day",
        "call_disposition_2_c" AS "call_disposition_secondary",
        "sales_loft_viewed_count_c" AS "salesloft_email_views",
        "sales_loft_1_sales_loft_step_day_c" AS "salesloft_step_day_alternate",
        "sales_loft_1_sales_loft_clicked_count_c" AS "salesloft_email_clicks_alternate",
        "sales_loft_1_sales_loft_view_count_c" AS "salesloft_email_views_alternate",
        "sales_loft_1_call_disposition_c" AS "call_disposition_alternate",
        "sales_loft_1_sales_loft_replies_count_c" AS "salesloft_email_replies_alternate",
        "sales_loft_1_sales_loft_cadence_name_c" AS "salesloft_cadence_name_alternate",
        "sales_loft_1_call_sentiment_c" AS "call_sentiment",
        "sales_loft_1_sales_loft_email_template_title_c" AS "salesloft_email_template_alternate",
        "completed_date_time",
        "is_a_co_sell_activity_c" AS "is_co_sell_activity",
        "partner_contact_c" AS "partner_contact",
        "co_selling_activity_c" AS "co_selling_activity_description",
        "description_c" AS "activity_description",
        "co_sell_partner_account_c" AS "co_sell_partner_account",
        "campaign_c" AS "campaign",
        "partner_account_c" AS "partner_account",
        "topic_c" AS "activity_topic",
        "event_name_c" AS "event_name",
        "attendance_number_c" AS "attendance_number",
        "partner_activity_type_c" AS "partner_activity_type",
        "proof_of_referral_c" AS "referral_proof",
        "how_did_you_bring_value_or_create_trust_c" AS "value_creation_description",
        "how_did_you_bring_value_or_earn_trust_c" AS "value_or_trust_action",
        "duration_in_minutes_c" AS "duration_minutes",
        "vidyard_c" AS "vidyard_used",
        "expected_payment_date_c" AS "expected_payment_date",
        "execute_collections_plan_activity_c" AS "collections_plan_executed",
        "collections_hold_c" AS "collections_hold",
        "opportunity_c" AS "opportunity_id",
        "meeting_type_c" AS "meeting_type",
        "meeting_name_c" AS "meeting_name",
        "bizible_2_bizible_id_c" AS "bizible_id",
        "bizible_2_bizible_touchpoint_date_c" AS "bizible_touchpoint_date",
        "assigned_to_role_c" AS "assigned_role",
        "assigned_to_name_c" AS "assigned_name",
        "legacy_hvr_id_c" AS "legacy_hvr_id",
        "is_archived",
        "_fivetran_active" AS "fivetran_active"
    FROM "sf_task_data_projected"
),

"sf_task_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- activity_type: The problem is that the activity_type column contains only one value, 'X', which is non-descriptive and doesn't represent a clear activity type. This is unusual because activity types typically describe specific actions or categories of activities. The 'X' value is likely a placeholder or default value that was used when the actual activity type was unknown or not recorded. In this case, since there's no additional information about what 'X' might represent, it's best to treat it as an unknown or undefined activity type.
    SELECT
        "referral_account_id",
        "associated_person_id",
        "call_disposition",
        "recurrence_day_of_month",
        "task_owner_id",
        "recurrence_end_date",
        "task_subject",
        "task_description",
        "last_modified_date",
        "recurrence_time_zone",
        "is_recurring",
        "related_object_count",
        "call_details",
        "is_deleted",
        "recurrence_weekdays",
        "last_modified_by_id",
        "system_modification_timestamp",
        "recurrence_regeneration_type",
        "task_id",
        "recurrence_type",
        "reminder_datetime",
        "call_type",
        "is_high_priority",
        "is_closed",
        "recurrence_month",
        "has_reminder",
        "due_date",
        "recurrence_week_of_month",
        "task_priority",
        "recurrence_interval",
        "associated_person_count",
        "recurrence_start_date",
        "account_id",
        "referral_contact",
        "call_duration",
        "creator_id",
        "creation_timestamp",
        "recurrence_activity_id",
        "related_object_id",
        "task_subtype",
        "status",
        "invitee_uuid",
        CASE
            WHEN "activity_type" = 'X' THEN NULL
            ELSE "activity_type"
        END AS "activity_type",
        "is_no_show",
        "is_first_meeting_held",
        "associated_sdr",
        "is_first_meeting",
        "call_recording_url",
        "chorus_call_id",
        "affect_layer_call_id",
        "last_rep_activity_date",
        "lid_url",
        "lid_sent_date",
        "record_type_id",
        "salesloft_step_id",
        "salesloft_step_name",
        "salesloft_step_type",
        "salesloft_email_template_id",
        "salesloft_external_id",
        "salesloft_cadence_id",
        "salesloft_email_clicks",
        "salesloft_cadence_name",
        "salesloft_email_replies",
        "call_disposition_c",
        "salesloft_email_template",
        "salesloft_step_day",
        "call_disposition_secondary",
        "salesloft_email_views",
        "salesloft_step_day_alternate",
        "salesloft_email_clicks_alternate",
        "salesloft_email_views_alternate",
        "call_disposition_alternate",
        "salesloft_email_replies_alternate",
        "salesloft_cadence_name_alternate",
        "call_sentiment",
        "salesloft_email_template_alternate",
        "completed_date_time",
        "is_co_sell_activity",
        "partner_contact",
        "co_selling_activity_description",
        "activity_description",
        "co_sell_partner_account",
        "campaign",
        "partner_account",
        "activity_topic",
        "event_name",
        "attendance_number",
        "partner_activity_type",
        "referral_proof",
        "value_creation_description",
        "value_or_trust_action",
        "duration_minutes",
        "vidyard_used",
        "expected_payment_date",
        "collections_plan_executed",
        "collections_hold",
        "opportunity_id",
        "meeting_type",
        "meeting_name",
        "bizible_id",
        "bizible_touchpoint_date",
        "assigned_role",
        "assigned_name",
        "legacy_hvr_id",
        "is_archived",
        "fivetran_active"
    FROM "sf_task_data_projected_renamed"
),

"sf_task_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- activity_description: from FLOAT to VARCHAR
    -- activity_topic: from FLOAT to VARCHAR
    -- affect_layer_call_id: from FLOAT to VARCHAR
    -- associated_sdr: from FLOAT to VARCHAR
    -- attendance_number: from FLOAT to INT
    -- bizible_id: from FLOAT to VARCHAR
    -- bizible_touchpoint_date: from FLOAT to DATETIME
    -- call_details: from FLOAT to VARCHAR
    -- call_disposition: from FLOAT to VARCHAR
    -- call_disposition_alternate: from FLOAT to VARCHAR
    -- call_disposition_c: from FLOAT to VARCHAR
    -- call_disposition_secondary: from FLOAT to VARCHAR
    -- call_duration: from FLOAT to INT
    -- call_recording_url: from FLOAT to VARCHAR
    -- call_sentiment: from FLOAT to VARCHAR
    -- call_type: from FLOAT to VARCHAR
    -- campaign: from FLOAT to VARCHAR
    -- chorus_call_id: from FLOAT to VARCHAR
    -- co_sell_partner_account: from FLOAT to VARCHAR
    -- co_selling_activity_description: from FLOAT to VARCHAR
    -- collections_hold: from VARCHAR to BOOLEAN
    -- collections_plan_executed: from VARCHAR to BOOLEAN
    -- completed_date_time: from VARCHAR to DATETIME
    -- creation_timestamp: from VARCHAR to DATETIME
    -- due_date: from VARCHAR to DATETIME
    -- duration_minutes: from FLOAT to INT
    -- event_name: from FLOAT to VARCHAR
    -- expected_payment_date: from FLOAT to DATE
    -- fivetran_active: from FLOAT to BOOLEAN
    -- has_reminder: from VARCHAR to BOOLEAN
    -- invitee_uuid: from FLOAT to UNIQUEIDENTIFIER
    -- is_archived: from VARCHAR to BOOLEAN
    -- is_closed: from VARCHAR to BOOLEAN
    -- is_co_sell_activity: from FLOAT to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_first_meeting: from FLOAT to BOOLEAN
    -- is_first_meeting_held: from FLOAT to BOOLEAN
    -- is_high_priority: from VARCHAR to BOOLEAN
    -- is_no_show: from VARCHAR to BOOLEAN
    -- is_recurring: from VARCHAR to BOOLEAN
    -- last_modified_date: from VARCHAR to DATETIME
    -- last_rep_activity_date: from FLOAT to DATE
    -- legacy_hvr_id: from FLOAT to VARCHAR
    -- lid_sent_date: from FLOAT to DATE
    -- lid_url: from FLOAT to VARCHAR
    -- opportunity_id: from FLOAT to VARCHAR
    -- partner_account: from FLOAT to VARCHAR
    -- partner_activity_type: from FLOAT to VARCHAR
    -- partner_contact: from FLOAT to VARCHAR
    -- recurrence_activity_id: from FLOAT to VARCHAR
    -- recurrence_day_of_month: from FLOAT to INT
    -- recurrence_end_date: from FLOAT to DATE
    -- recurrence_interval: from FLOAT to INT
    -- recurrence_month: from FLOAT to INT
    -- recurrence_regeneration_type: from FLOAT to VARCHAR
    -- recurrence_start_date: from FLOAT to DATE
    -- recurrence_time_zone: from FLOAT to VARCHAR
    -- recurrence_type: from FLOAT to VARCHAR
    -- recurrence_week_of_month: from FLOAT to INT
    -- recurrence_weekdays: from FLOAT to VARCHAR
    -- referral_account_id: from FLOAT to VARCHAR
    -- referral_contact: from FLOAT to VARCHAR
    -- referral_proof: from FLOAT to VARCHAR
    -- reminder_datetime: from FLOAT to DATETIME
    -- salesloft_cadence_id: from FLOAT to VARCHAR
    -- salesloft_cadence_name: from FLOAT to VARCHAR
    -- salesloft_cadence_name_alternate: from FLOAT to VARCHAR
    -- salesloft_email_clicks: from FLOAT to INT
    -- salesloft_email_clicks_alternate: from FLOAT to INT
    -- salesloft_email_replies: from FLOAT to INT
    -- salesloft_email_replies_alternate: from FLOAT to INT
    -- salesloft_email_template: from FLOAT to VARCHAR
    -- salesloft_email_template_alternate: from FLOAT to VARCHAR
    -- salesloft_email_template_id: from FLOAT to VARCHAR
    -- salesloft_email_views: from FLOAT to INT
    -- salesloft_email_views_alternate: from FLOAT to INT
    -- salesloft_external_id: from FLOAT to VARCHAR
    -- salesloft_step_day: from FLOAT to INT
    -- salesloft_step_day_alternate: from FLOAT to INT
    -- salesloft_step_id: from FLOAT to VARCHAR
    -- salesloft_step_name: from FLOAT to VARCHAR
    -- salesloft_step_type: from FLOAT to VARCHAR
    -- system_modification_timestamp: from VARCHAR to DATETIME
    -- value_creation_description: from FLOAT to VARCHAR
    -- value_or_trust_action: from FLOAT to VARCHAR
    -- vidyard_used: from VARCHAR to BOOLEAN
    SELECT
        "associated_person_id",
        "task_owner_id",
        "task_subject",
        "task_description",
        "related_object_count",
        "last_modified_by_id",
        "task_id",
        "task_priority",
        "associated_person_count",
        "account_id",
        "creator_id",
        "related_object_id",
        "task_subtype",
        "status",
        "activity_type",
        "record_type_id",
        "meeting_type",
        "meeting_name",
        "assigned_role",
        "assigned_name",
        CAST("activity_description" AS VARCHAR) 
        AS "activity_description",
        CAST("activity_topic" AS VARCHAR) 
        AS "activity_topic",
        CAST("affect_layer_call_id" AS VARCHAR) 
        AS "affect_layer_call_id",
        CAST("associated_sdr" AS VARCHAR) 
        AS "associated_sdr",
        CAST("attendance_number" AS INT) 
        AS "attendance_number",
        CAST("bizible_id" AS VARCHAR) 
        AS "bizible_id",
        CAST(CAST("bizible_touchpoint_date" AS VARCHAR(50)) AS DATETIME) 
        AS "bizible_touchpoint_date",
        CAST("call_details" AS VARCHAR) 
        AS "call_details",
        CAST("call_disposition" AS VARCHAR) 
        AS "call_disposition",
        CAST("call_disposition_alternate" AS VARCHAR) 
        AS "call_disposition_alternate",
        CAST("call_disposition_c" AS VARCHAR) 
        AS "call_disposition_c",
        CAST("call_disposition_secondary" AS VARCHAR) 
        AS "call_disposition_secondary",
        CAST("call_duration" AS INT) 
        AS "call_duration",
        CAST("call_recording_url" AS VARCHAR(MAX)) 
        AS "call_recording_url",
        CAST("call_sentiment" AS VARCHAR) 
        AS "call_sentiment",
        CAST("call_type" AS VARCHAR) 
        AS "call_type",
        CAST("campaign" AS VARCHAR) 
        AS "campaign",
        CAST("chorus_call_id" AS VARCHAR) 
        AS "chorus_call_id",
        CAST("co_sell_partner_account" AS VARCHAR) 
        AS "co_sell_partner_account",
        CAST("co_selling_activity_description" AS VARCHAR(MAX)) 
        AS "co_selling_activity_description",
        CASE WHEN "collections_hold" = '0' THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END 
        AS "collections_hold",
        CASE WHEN "collections_plan_executed" = '0' THEN 0 ELSE 1 END 
        AS "collections_plan_executed",
        CAST("completed_date_time" AS DATETIME) 
        AS "completed_date_time",
        CAST("creation_timestamp" AS DATETIME) 
        AS "creation_timestamp",
        CAST("due_date" AS DATETIME) 
        AS "due_date",
        CAST("duration_minutes" AS INT) 
        AS "duration_minutes",
        CAST("event_name" AS VARCHAR) 
        AS "event_name",
        CAST(DATEADD(day, FLOOR("expected_payment_date"), '1900-01-01') AS DATE) 
        AS "expected_payment_date",
        CAST("fivetran_active" AS BIT) 
        AS "fivetran_active",
        CAST(CASE WHEN "has_reminder" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "has_reminder",
        "invitee_uuid" 
        AS "invitee_uuid",
        CAST(CAST("is_archived" AS INT) AS BIT) 
        AS "is_archived",
        CAST("is_closed" AS BIT) 
        AS "is_closed",
        CAST("is_co_sell_activity" AS BIT) 
        AS "is_co_sell_activity",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CAST("is_first_meeting" AS BIT) 
        AS "is_first_meeting",
        CAST("is_first_meeting_held" AS BIT) 
        AS "is_first_meeting_held",
        CASE WHEN "is_high_priority" = '0' THEN 0 ELSE 1 END 
        AS "is_high_priority",
        CAST("is_no_show" AS BIT) 
        AS "is_no_show",
        CAST("is_recurring" AS BIT) 
        AS "is_recurring",
        CAST("last_modified_date" AS DATETIME) 
        AS "last_modified_date",
        CAST(DATEADD(SECOND, CAST("last_rep_activity_date" AS BIGINT), '1970-01-01') AS DATE) 
        AS "last_rep_activity_date",
        CAST("legacy_hvr_id" AS VARCHAR) 
        AS "legacy_hvr_id",
        CAST(CONVERT(VARCHAR(10), "lid_sent_date") AS DATE) 
        AS "lid_sent_date",
        CAST("lid_url" AS VARCHAR) 
        AS "lid_url",
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
        CAST("recurrence_interval" AS INT) 
        AS "recurrence_interval",
        CAST("recurrence_month" AS INT) 
        AS "recurrence_month",
        CAST("recurrence_regeneration_type" AS VARCHAR) 
        AS "recurrence_regeneration_type",
        CAST(DATEADD(day, CAST("recurrence_start_date" AS INT), '1900-01-01') AS DATE) 
        AS "recurrence_start_date",
        CAST("recurrence_time_zone" AS VARCHAR) 
        AS "recurrence_time_zone",
        CAST("recurrence_type" AS VARCHAR) 
        AS "recurrence_type",
        CAST("recurrence_week_of_month" AS INT) 
        AS "recurrence_week_of_month",
        CAST("recurrence_weekdays" AS VARCHAR) 
        AS "recurrence_weekdays",
        CAST("referral_account_id" AS VARCHAR) 
        AS "referral_account_id",
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
        CAST("salesloft_cadence_name_alternate" AS VARCHAR) 
        AS "salesloft_cadence_name_alternate",
        CAST("salesloft_email_clicks" AS INT) 
        AS "salesloft_email_clicks",
        CAST("salesloft_email_clicks_alternate" AS INT) 
        AS "salesloft_email_clicks_alternate",
        CAST("salesloft_email_replies" AS INT) 
        AS "salesloft_email_replies",
        CAST("salesloft_email_replies_alternate" AS INT) 
        AS "salesloft_email_replies_alternate",
        CAST("salesloft_email_template" AS VARCHAR) 
        AS "salesloft_email_template",
        CAST("salesloft_email_template_alternate" AS VARCHAR) 
        AS "salesloft_email_template_alternate",
        CAST("salesloft_email_template_id" AS VARCHAR) 
        AS "salesloft_email_template_id",
        CAST("salesloft_email_views" AS INT) 
        AS "salesloft_email_views",
        CAST("salesloft_email_views_alternate" AS INT) 
        AS "salesloft_email_views_alternate",
        CAST("salesloft_external_id" AS VARCHAR) 
        AS "salesloft_external_id",
        CAST("salesloft_step_day" AS INT) 
        AS "salesloft_step_day",
        CAST("salesloft_step_day_alternate" AS INT) 
        AS "salesloft_step_day_alternate",
        CAST("salesloft_step_id" AS VARCHAR) 
        AS "salesloft_step_id",
        CAST("salesloft_step_name" AS VARCHAR(MAX)) 
        AS "salesloft_step_name",
        CAST("salesloft_step_type" AS VARCHAR) 
        AS "salesloft_step_type",
        CAST("system_modification_timestamp" AS DATETIME) 
        AS "system_modification_timestamp",
        CAST("value_creation_description" AS VARCHAR) 
        AS "value_creation_description",
        CAST("value_or_trust_action" AS VARCHAR) 
        AS "value_or_trust_action",
        CASE WHEN "vidyard_used" = '0' THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END 
        AS "vidyard_used"
    FROM "sf_task_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_task_data_projected_renamed_cleaned_casted"