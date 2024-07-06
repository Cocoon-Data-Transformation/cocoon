-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:45:16.233443+00:00
WITH 
"distribution_projected" AS (
    -- Projection: Selecting 24 out of 25 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "created_date",
        "header_from_email",
        "header_from_name",
        "header_reply_to_email",
        "header_subject",
        "message_library_id",
        "message_message_id",
        "message_message_text",
        "modified_date",
        "organization_id",
        "owner_id",
        "parent_distribution_id",
        "recipient_contact_id",
        "recipient_library_id",
        "recipient_mailing_list_id",
        "recipient_sample_id",
        "request_status",
        "request_type",
        "send_date",
        "survey_link_expiration_date",
        "survey_link_link_type",
        "survey_link_survey_id"
    FROM "memory"."main"."distribution"
),

"distribution_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> distribution_id
    -- _fivetran_deleted -> is_deleted
    -- header_from_email -> sender_email
    -- header_from_name -> sender_name
    -- header_reply_to_email -> reply_to_email
    -- header_subject -> email_subject
    -- message_message_id -> message_id
    -- message_message_text -> message_text
    -- recipient_mailing_list_id -> mailing_list_id
    -- recipient_sample_id -> sample_id
    -- request_status -> distribution_status
    -- request_type -> distribution_type
    -- survey_link_expiration_date -> survey_expiration_date
    -- survey_link_link_type -> survey_link_type
    -- survey_link_survey_id -> survey_id
    SELECT 
        "id" AS "distribution_id",
        "_fivetran_deleted" AS "is_deleted",
        "created_date",
        "header_from_email" AS "sender_email",
        "header_from_name" AS "sender_name",
        "header_reply_to_email" AS "reply_to_email",
        "header_subject" AS "email_subject",
        "message_library_id",
        "message_message_id" AS "message_id",
        "message_message_text" AS "message_text",
        "modified_date",
        "organization_id",
        "owner_id",
        "parent_distribution_id",
        "recipient_contact_id",
        "recipient_library_id",
        "recipient_mailing_list_id" AS "mailing_list_id",
        "recipient_sample_id" AS "sample_id",
        "request_status" AS "distribution_status",
        "request_type" AS "distribution_type",
        "send_date",
        "survey_link_expiration_date" AS "survey_expiration_date",
        "survey_link_link_type" AS "survey_link_type",
        "survey_link_survey_id" AS "survey_id"
    FROM "distribution_projected"
),

"distribution_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_date: from VARCHAR to TIMESTAMP
    -- message_id: from DECIMAL to VARCHAR
    -- message_library_id: from DECIMAL to VARCHAR
    -- message_text: from DECIMAL to VARCHAR
    -- modified_date: from VARCHAR to TIMESTAMP
    -- parent_distribution_id: from DECIMAL to VARCHAR
    -- send_date: from VARCHAR to TIMESTAMP
    -- survey_expiration_date: from VARCHAR to TIMESTAMP
    SELECT
        "distribution_id",
        "is_deleted",
        "sender_email",
        "sender_name",
        "reply_to_email",
        "email_subject",
        "organization_id",
        "owner_id",
        "recipient_contact_id",
        "recipient_library_id",
        "mailing_list_id",
        "sample_id",
        "distribution_status",
        "distribution_type",
        "survey_link_type",
        "survey_id",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("message_id" AS VARCHAR) AS "message_id",
        CAST("message_library_id" AS VARCHAR) AS "message_library_id",
        CAST("message_text" AS VARCHAR) AS "message_text",
        CAST("modified_date" AS TIMESTAMP) AS "modified_date",
        CAST("parent_distribution_id" AS VARCHAR) AS "parent_distribution_id",
        CAST("send_date" AS TIMESTAMP) AS "send_date",
        CAST("survey_expiration_date" AS TIMESTAMP) AS "survey_expiration_date"
    FROM "distribution_projected_renamed"
),

"distribution_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 7 columns with unacceptable missing values
    -- message_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- message_library_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- message_text has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- parent_distribution_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- recipient_contact_id has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- recipient_library_id has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- survey_expiration_date has 20.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "distribution_id",
        "is_deleted",
        "sender_email",
        "sender_name",
        "reply_to_email",
        "email_subject",
        "organization_id",
        "owner_id",
        "recipient_contact_id",
        "recipient_library_id",
        "mailing_list_id",
        "sample_id",
        "distribution_status",
        "distribution_type",
        "survey_link_type",
        "survey_id",
        "created_date",
        "modified_date",
        "send_date",
        "survey_expiration_date"
    FROM "distribution_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "distribution_projected_renamed_casted_missing_handled"