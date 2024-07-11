-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_event_data_removeWideColumns" AS (
    -- Remove wide columns with pattern. The regex and columns are:
    -- ^sales_loft_\d+_.*$: sales_loft_1_call_disposition_c, sales_loft_1_call_sentiment_c, sales_loft_1_sales_loft_cadence_name_c, sales_loft_1_sales_loft_clicked_count_c, sales_loft_1_sales_loft_email_template_title_c, sales_loft_1_sales_loft_replies_count_c, sales_loft_1_sales_loft_step_day_c, sales_loft_1_sales_loft_view_count_c
    -- ^recurrence_2_pattern_.*$: recurrence_2_pattern_start_date, recurrence_2_pattern_text, recurrence_2_pattern_time_zone, recurrence_2_pattern_version
    -- ^sales_loft_.*(_\d+)?_c$: sales_loft_cadence_id_c, sales_loft_cadence_name_c, sales_loft_clicked_count_c, sales_loft_email_template_id_c, sales_loft_email_template_title_c, sales_loft_external_identifier_c, sales_loft_reply_count_c, sales_loft_step_day_new_c, sales_loft_step_id_c, sales_loft_step_name_c ...
    SELECT 
        "_fivetran_active",
        "_fivetran_synced",
        "salesforce_account_id",
        "activity_date",
        "activity_date_time",
        "affectlayer_affect_layer_call_id_c",
        "affectlayer_chorus_call_id_c",
        "assigned_to_name_c",
        "assigned_to_role_c",
        "associated_sdr_c",
        "attendance_number_c",
        "bizible_2_bizible_id_c",
        "bizible_2_bizible_touchpoint_date_c",
        "call_disposition_2_c",
        "call_disposition_c",
        "call_recording_c",
        "campaign_c",
        "co_selling_activity_c",
        "collections_hold_c",
        "created_by_id",
        "created_date",
        "description",
        "description_c",
        "duration_in_minutes",
        "duration_in_minutes_c",
        "end_date",
        "end_date_time",
        "event_name_c",
        "event_subtype",
        "execute_collections_plan_activity_c",
        "expected_payment_date_c",
        "first_meeting_c",
        "first_meeting_held_c",
        "group_event_type",
        "how_did_you_bring_value_or_create_trust_c",
        "how_did_you_bring_value_or_earn_trust_c",
        "id",
        "invitee_uuid_c",
        "is_a_co_sell_activity_c",
        "is_archived",
        "is_child",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurrence",
        "is_recurrence_2",
        "is_recurrence_2_exception",
        "is_recurrence_2_exclusion",
        "is_reminder_set",
        "last_modified_by_id",
        "last_modified_date",
        "last_rep_activity_date_c",
        "legacy_hvr_id_c",
        "lid_date_sent_c",
        "lid_url_c",
        "location",
        "meeting_name_c",
        "meeting_type_c",
        "no_show_c",
        "opportunity_c",
        "owner_id",
        "partner_account_c",
        "partner_activity_type_c",
        "partner_contact_c",
        "proof_of_referral_c",
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
        "topic_c",
        "type",
        "vidyard_c",
        "what_count",
        "what_id",
        "who_count",
        "who_id"
    FROM "sf_event_data"
),

"sf_event_data_removeWideColumns_projected" AS (
    -- Projection: Selecting 88 out of 89 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "salesforce_account_id",
        "activity_date",
        "activity_date_time",
        "affectlayer_affect_layer_call_id_c",
        "affectlayer_chorus_call_id_c",
        "assigned_to_name_c",
        "assigned_to_role_c",
        "associated_sdr_c",
        "attendance_number_c",
        "bizible_2_bizible_id_c",
        "bizible_2_bizible_touchpoint_date_c",
        "call_disposition_2_c",
        "call_disposition_c",
        "call_recording_c",
        "campaign_c",
        "co_selling_activity_c",
        "collections_hold_c",
        "created_by_id",
        "created_date",
        "description",
        "description_c",
        "duration_in_minutes",
        "duration_in_minutes_c",
        "end_date",
        "end_date_time",
        "event_name_c",
        "event_subtype",
        "execute_collections_plan_activity_c",
        "expected_payment_date_c",
        "first_meeting_c",
        "first_meeting_held_c",
        "group_event_type",
        "how_did_you_bring_value_or_create_trust_c",
        "how_did_you_bring_value_or_earn_trust_c",
        "id",
        "invitee_uuid_c",
        "is_a_co_sell_activity_c",
        "is_archived",
        "is_child",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurrence",
        "is_recurrence_2",
        "is_recurrence_2_exception",
        "is_recurrence_2_exclusion",
        "is_reminder_set",
        "last_modified_by_id",
        "last_modified_date",
        "last_rep_activity_date_c",
        "legacy_hvr_id_c",
        "lid_date_sent_c",
        "lid_url_c",
        "location",
        "meeting_name_c",
        "meeting_type_c",
        "no_show_c",
        "opportunity_c",
        "owner_id",
        "partner_account_c",
        "partner_activity_type_c",
        "partner_contact_c",
        "proof_of_referral_c",
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
        "topic_c",
        "type",
        "vidyard_c",
        "what_count",
        "what_id",
        "who_count",
        "who_id"
    FROM "sf_event_data_removeWideColumns"
),

"sf_event_data_removeWideColumns_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- activity_date_time -> activity_datetime
    -- affectlayer_affect_layer_call_id_c -> affect_layer_call_id
    -- affectlayer_chorus_call_id_c -> chorus_call_id
    -- assigned_to_name_c -> assigned_to_name
    -- assigned_to_role_c -> assigned_to_role
    -- associated_sdr_c -> associated_sdr
    -- attendance_number_c -> attendance_count
    -- bizible_2_bizible_id_c -> bizible_id
    -- bizible_2_bizible_touchpoint_date_c -> bizible_touchpoint_date
    -- call_disposition_2_c -> secondary_call_disposition
    -- call_disposition_c -> primary_call_disposition
    -- call_recording_c -> call_recording
    -- campaign_c -> campaign_id
    -- co_selling_activity_c -> is_co_selling_activity
    -- collections_hold_c -> is_collections_hold
    -- created_date -> created_datetime
    -- description_c -> additional_description
    -- duration_in_minutes -> duration_minutes
    -- duration_in_minutes_c -> custom_duration_minutes
    -- end_date_time -> end_datetime
    -- event_name_c -> event_name
    -- execute_collections_plan_activity_c -> is_collections_plan_execution
    -- expected_payment_date_c -> expected_payment_date
    -- first_meeting_c -> is_first_meeting
    -- first_meeting_held_c -> first_meeting_date
    -- how_did_you_bring_value_or_create_trust_c -> value_creation_description
    -- how_did_you_bring_value_or_earn_trust_c -> trust_earning_description
    -- id -> event_id
    -- invitee_uuid_c -> invitee_id
    -- is_a_co_sell_activity_c -> is_co_sell_activity
    -- is_child -> is_child_event
    -- is_recurrence -> is_recurring
    -- is_recurrence_2 -> is_recurring_secondary
    -- is_recurrence_2_exception -> is_recurrence_exception
    -- is_recurrence_2_exclusion -> is_recurrence_exclusion
    -- is_reminder_set -> has_reminder
    -- last_rep_activity_date_c -> last_rep_activity_date
    -- legacy_hvr_id_c -> legacy_id
    -- lid_date_sent_c -> lid_sent_date
    -- lid_url_c -> lid_url
    -- meeting_name_c -> meeting_name
    -- meeting_type_c -> meeting_type
    -- no_show_c -> is_no_show
    -- opportunity_c -> opportunity_id
    -- partner_account_c -> partner_salesforce_account_id
    -- partner_activity_type_c -> partner_activity_type
    -- partner_contact_c -> partner_contact_id
    -- proof_of_referral_c -> proof_of_referral
    -- recurrence_end_date_only -> recurrence_end_date
    -- recurrence_time_zone_sid_key -> recurrence_time_zone_id
    -- referral_account_c -> referral_salesforce_account_id
    -- referral_contact_c -> referral_contact_id
    -- topic_c -> event_topic
    -- type -> event_type
    -- vidyard_c -> vidyard_enabled
    -- what_count -> associated_object_count
    -- what_id -> associated_object_id
    -- who_count -> associated_contact_count
    -- who_id -> associated_contact_id
    SELECT 
        "_fivetran_active" AS "is_active",
        "salesforce_account_id",
        "activity_date",
        "activity_date_time" AS "activity_datetime",
        "affectlayer_affect_layer_call_id_c" AS "affect_layer_call_id",
        "affectlayer_chorus_call_id_c" AS "chorus_call_id",
        "assigned_to_name_c" AS "assigned_to_name",
        "assigned_to_role_c" AS "assigned_to_role",
        "associated_sdr_c" AS "associated_sdr",
        "attendance_number_c" AS "attendance_count",
        "bizible_2_bizible_id_c" AS "bizible_id",
        "bizible_2_bizible_touchpoint_date_c" AS "bizible_touchpoint_date",
        "call_disposition_2_c" AS "secondary_call_disposition",
        "call_disposition_c" AS "primary_call_disposition",
        "call_recording_c" AS "call_recording",
        "campaign_c" AS "campaign_id",
        "co_selling_activity_c" AS "is_co_selling_activity",
        "collections_hold_c" AS "is_collections_hold",
        "created_by_id",
        "created_date" AS "created_datetime",
        "description",
        "description_c" AS "additional_description",
        "duration_in_minutes" AS "duration_minutes",
        "duration_in_minutes_c" AS "custom_duration_minutes",
        "end_date",
        "end_date_time" AS "end_datetime",
        "event_name_c" AS "event_name",
        "event_subtype",
        "execute_collections_plan_activity_c" AS "is_collections_plan_execution",
        "expected_payment_date_c" AS "expected_payment_date",
        "first_meeting_c" AS "is_first_meeting",
        "first_meeting_held_c" AS "first_meeting_date",
        "group_event_type",
        "how_did_you_bring_value_or_create_trust_c" AS "value_creation_description",
        "how_did_you_bring_value_or_earn_trust_c" AS "trust_earning_description",
        "id" AS "event_id",
        "invitee_uuid_c" AS "invitee_id",
        "is_a_co_sell_activity_c" AS "is_co_sell_activity",
        "is_archived",
        "is_child" AS "is_child_event",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurrence" AS "is_recurring",
        "is_recurrence_2" AS "is_recurring_secondary",
        "is_recurrence_2_exception" AS "is_recurrence_exception",
        "is_recurrence_2_exclusion" AS "is_recurrence_exclusion",
        "is_reminder_set" AS "has_reminder",
        "last_modified_by_id",
        "last_modified_date",
        "last_rep_activity_date_c" AS "last_rep_activity_date",
        "legacy_hvr_id_c" AS "legacy_id",
        "lid_date_sent_c" AS "lid_sent_date",
        "lid_url_c" AS "lid_url",
        "location",
        "meeting_name_c" AS "meeting_name",
        "meeting_type_c" AS "meeting_type",
        "no_show_c" AS "is_no_show",
        "opportunity_c" AS "opportunity_id",
        "owner_id",
        "partner_account_c" AS "partner_salesforce_account_id",
        "partner_activity_type_c" AS "partner_activity_type",
        "partner_contact_c" AS "partner_contact_id",
        "proof_of_referral_c" AS "proof_of_referral",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_day_of_week_mask",
        "recurrence_end_date_only" AS "recurrence_end_date",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month_of_year",
        "recurrence_start_date_time",
        "recurrence_time_zone_sid_key" AS "recurrence_time_zone_id",
        "recurrence_type",
        "referral_account_c" AS "referral_salesforce_account_id",
        "referral_contact_c" AS "referral_contact_id",
        "reminder_date_time",
        "show_as",
        "start_date_time",
        "subject",
        "system_modstamp",
        "topic_c" AS "event_topic",
        "type" AS "event_type",
        "vidyard_c" AS "vidyard_enabled",
        "what_count" AS "associated_object_count",
        "what_id" AS "associated_object_id",
        "who_count" AS "associated_contact_count",
        "who_id" AS "associated_contact_id"
    FROM "sf_event_data_removeWideColumns_projected"
),

"sf_event_data_removeWideColumns_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- activity_date: from VARCHAR to DATE
    -- activity_datetime: from VARCHAR to TIMESTAMP
    -- additional_description: from DECIMAL to VARCHAR
    -- affect_layer_call_id: from DECIMAL to VARCHAR
    -- assigned_to_name: from DECIMAL to VARCHAR
    -- assigned_to_role: from DECIMAL to VARCHAR
    -- associated_sdr: from DECIMAL to VARCHAR
    -- attendance_count: from DECIMAL to INT
    -- bizible_id: from DECIMAL to VARCHAR
    -- bizible_touchpoint_date: from DECIMAL to DATE
    -- call_recording: from DECIMAL to VARCHAR
    -- campaign_id: from DECIMAL to VARCHAR
    -- chorus_call_id: from DECIMAL to VARCHAR
    -- created_datetime: from VARCHAR to TIMESTAMP
    -- custom_duration_minutes: from DECIMAL to INT
    -- end_date: from VARCHAR to DATE
    -- end_datetime: from VARCHAR to TIMESTAMP
    -- event_name: from DECIMAL to VARCHAR
    -- event_topic: from DECIMAL to VARCHAR
    -- expected_payment_date: from DECIMAL to DATE
    -- first_meeting_date: from DECIMAL to DATE
    -- invitee_id: from DECIMAL to VARCHAR
    -- is_active: from DECIMAL to BOOLEAN
    -- is_co_sell_activity: from DECIMAL to BOOLEAN
    -- is_co_selling_activity: from DECIMAL to BOOLEAN
    -- is_first_meeting: from DECIMAL to BOOLEAN
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- last_rep_activity_date: from DECIMAL to DATE
    -- legacy_id: from DECIMAL to VARCHAR
    -- lid_sent_date: from DECIMAL to DATE
    -- lid_url: from DECIMAL to VARCHAR
    -- location: from DECIMAL to VARCHAR
    -- meeting_name: from DECIMAL to VARCHAR
    -- meeting_type: from DECIMAL to VARCHAR
    -- opportunity_id: from DECIMAL to VARCHAR
    -- partner_salesforce_account_id: from DECIMAL to VARCHAR
    -- partner_activity_type: from DECIMAL to VARCHAR
    -- partner_contact_id: from DECIMAL to VARCHAR
    -- primary_call_disposition: from DECIMAL to VARCHAR
    -- proof_of_referral: from DECIMAL to VARCHAR
    -- recurrence_activity_id: from DECIMAL to VARCHAR
    -- recurrence_day_of_month: from DECIMAL to INT
    -- recurrence_day_of_week_mask: from DECIMAL to VARCHAR
    -- recurrence_end_date: from DECIMAL to DATE
    -- recurrence_instance: from DECIMAL to VARCHAR
    -- recurrence_interval: from DECIMAL to INT
    -- recurrence_month_of_year: from DECIMAL to INT
    -- recurrence_start_date_time: from DECIMAL to TIMESTAMP
    -- recurrence_time_zone_id: from DECIMAL to VARCHAR
    -- recurrence_type: from DECIMAL to VARCHAR
    -- referral_salesforce_account_id: from DECIMAL to VARCHAR
    -- referral_contact_id: from DECIMAL to VARCHAR
    -- reminder_date_time: from DECIMAL to TIMESTAMP
    -- secondary_call_disposition: from DECIMAL to VARCHAR
    -- start_date_time: from VARCHAR to TIMESTAMP
    -- system_modstamp: from VARCHAR to TIMESTAMP
    -- trust_earning_description: from DECIMAL to VARCHAR
    -- value_creation_description: from DECIMAL to VARCHAR
    SELECT
        "salesforce_account_id",
        "is_collections_hold",
        "created_by_id",
        "description",
        "duration_minutes",
        "event_subtype",
        "is_collections_plan_execution",
        "group_event_type",
        "event_id",
        "is_archived",
        "is_child_event",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurring",
        "is_recurring_secondary",
        "is_recurrence_exception",
        "is_recurrence_exclusion",
        "has_reminder",
        "last_modified_by_id",
        "is_no_show",
        "owner_id",
        "show_as",
        "subject",
        "event_type",
        "vidyard_enabled",
        "associated_object_count",
        "associated_object_id",
        "associated_contact_count",
        "associated_contact_id",
        CAST("activity_date" AS DATE) AS "activity_date",
        CAST("activity_datetime" AS TIMESTAMP) AS "activity_datetime",
        CAST("additional_description" AS VARCHAR) AS "additional_description",
        CAST("affect_layer_call_id" AS VARCHAR) AS "affect_layer_call_id",
        CAST("assigned_to_name" AS VARCHAR) AS "assigned_to_name",
        CAST("assigned_to_role" AS VARCHAR) AS "assigned_to_role",
        CAST("associated_sdr" AS VARCHAR) AS "associated_sdr",
        CAST("attendance_count" AS INT) AS "attendance_count",
        CAST("bizible_id" AS VARCHAR) AS "bizible_id",
        CAST("bizible_touchpoint_date" AS DATE) AS "bizible_touchpoint_date",
        CAST("call_recording" AS VARCHAR) AS "call_recording",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("chorus_call_id" AS VARCHAR) AS "chorus_call_id",
        CAST("created_datetime" AS TIMESTAMP) AS "created_datetime",
        CAST("custom_duration_minutes" AS INT) AS "custom_duration_minutes",
        CAST("end_date" AS DATE) AS "end_date",
        CAST("end_datetime" AS TIMESTAMP) AS "end_datetime",
        CAST("event_name" AS VARCHAR) AS "event_name",
        CAST("event_topic" AS VARCHAR) AS "event_topic",
        CAST("expected_payment_date" AS DATE) AS "expected_payment_date",
        CAST("first_meeting_date" AS DATE) AS "first_meeting_date",
        CAST("invitee_id" AS VARCHAR) AS "invitee_id",
        CAST("is_active" AS BOOLEAN) AS "is_active",
        CAST("is_co_sell_activity" AS BOOLEAN) AS "is_co_sell_activity",
        CAST("is_co_selling_activity" AS BOOLEAN) AS "is_co_selling_activity",
        CAST("is_first_meeting" AS BOOLEAN) AS "is_first_meeting",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("last_rep_activity_date" AS DATE) AS "last_rep_activity_date",
        CAST("legacy_id" AS VARCHAR) AS "legacy_id",
        CAST("lid_sent_date" AS DATE) AS "lid_sent_date",
        CAST("lid_url" AS VARCHAR) AS "lid_url",
        CAST("location" AS VARCHAR) AS "location",
        CAST("meeting_name" AS VARCHAR) AS "meeting_name",
        CAST("meeting_type" AS VARCHAR) AS "meeting_type",
        CAST("opportunity_id" AS VARCHAR) AS "opportunity_id",
        CAST("partner_salesforce_account_id" AS VARCHAR) AS "partner_salesforce_account_id",
        CAST("partner_activity_type" AS VARCHAR) AS "partner_activity_type",
        CAST("partner_contact_id" AS VARCHAR) AS "partner_contact_id",
        CAST("primary_call_disposition" AS VARCHAR) AS "primary_call_disposition",
        CAST("proof_of_referral" AS VARCHAR) AS "proof_of_referral",
        CAST("recurrence_activity_id" AS VARCHAR) AS "recurrence_activity_id",
        CAST("recurrence_day_of_month" AS INT) AS "recurrence_day_of_month",
        CAST("recurrence_day_of_week_mask" AS VARCHAR) AS "recurrence_day_of_week_mask",
        CAST("recurrence_end_date" AS DATE) AS "recurrence_end_date",
        CAST("recurrence_instance" AS VARCHAR) AS "recurrence_instance",
        CAST("recurrence_interval" AS INT) AS "recurrence_interval",
        CAST("recurrence_month_of_year" AS INT) AS "recurrence_month_of_year",
        CAST("recurrence_start_date_time" AS TIMESTAMP) AS "recurrence_start_date_time",
        CAST("recurrence_time_zone_id" AS VARCHAR) AS "recurrence_time_zone_id",
        CAST("recurrence_type" AS VARCHAR) AS "recurrence_type",
        CAST("referral_salesforce_account_id" AS VARCHAR) AS "referral_salesforce_account_id",
        CAST("referral_contact_id" AS VARCHAR) AS "referral_contact_id",
        CAST("reminder_date_time" AS TIMESTAMP) AS "reminder_date_time",
        CAST("secondary_call_disposition" AS VARCHAR) AS "secondary_call_disposition",
        CAST("start_date_time" AS TIMESTAMP) AS "start_date_time",
        CAST("system_modstamp" AS TIMESTAMP) AS "system_modstamp",
        CAST("trust_earning_description" AS VARCHAR) AS "trust_earning_description",
        CAST("value_creation_description" AS VARCHAR) AS "value_creation_description"
    FROM "sf_event_data_removeWideColumns_projected_renamed"
),

"sf_event_data_removeWideColumns_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 32 columns with unacceptable missing values
    -- additional_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- affect_layer_call_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- assigned_to_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- assigned_to_role has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- associated_object_id has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- associated_sdr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bizible_touchpoint_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_duration_minutes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- event_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- event_topic has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_first_meeting has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_rep_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legacy_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lid_sent_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lid_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- location has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- meeting_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- meeting_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opportunity_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_salesforce_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_activity_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- primary_call_disposition has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- proof_of_referral has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_salesforce_account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referral_contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reminder_date_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- secondary_call_disposition has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- trust_earning_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- value_creation_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "salesforce_account_id",
        "is_collections_hold",
        "created_by_id",
        "description",
        "duration_minutes",
        "event_subtype",
        "is_collections_plan_execution",
        "group_event_type",
        "event_id",
        "is_archived",
        "is_child_event",
        "is_deleted",
        "is_group_event",
        "is_private",
        "is_recurring",
        "is_recurring_secondary",
        "is_recurrence_exception",
        "is_recurrence_exclusion",
        "has_reminder",
        "last_modified_by_id",
        "is_no_show",
        "owner_id",
        "show_as",
        "subject",
        "event_type",
        "vidyard_enabled",
        "associated_object_count",
        "associated_object_id",
        "associated_contact_count",
        "associated_contact_id",
        "activity_date",
        "activity_datetime",
        "attendance_count",
        "call_recording",
        "campaign_id",
        "chorus_call_id",
        "created_datetime",
        "end_date",
        "end_datetime",
        "expected_payment_date",
        "first_meeting_date",
        "invitee_id",
        "is_co_sell_activity",
        "is_co_selling_activity",
        "last_modified_date",
        "recurrence_activity_id",
        "recurrence_day_of_month",
        "recurrence_day_of_week_mask",
        "recurrence_end_date",
        "recurrence_instance",
        "recurrence_interval",
        "recurrence_month_of_year",
        "recurrence_start_date_time",
        "recurrence_time_zone_id",
        "recurrence_type",
        "start_date_time",
        "system_modstamp"
    FROM "sf_event_data_removeWideColumns_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_event_data_removeWideColumns_projected_renamed_casted_missing_handled"