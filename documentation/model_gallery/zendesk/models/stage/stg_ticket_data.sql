-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_data_projected" AS (
    -- Projection: Selecting 35 out of 36 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "allow_channelback",
        "assignee_id",
        "brand_id",
        "created_at",
        "description",
        "due_at",
        "external_id",
        "forum_topic_id",
        "group_id",
        "has_incidents",
        "is_public",
        "organization_id",
        "priority",
        "problem_id",
        "recipient",
        "requester_id",
        "status",
        "subject",
        "submitter_id",
        "system_client",
        "ticket_form_id",
        "type",
        "updated_at",
        "url",
        "via_channel",
        "via_source_from_id",
        "via_source_from_title",
        "via_source_rel",
        "via_source_to_address",
        "via_source_to_name",
        "merged_ticket_ids",
        "via_source_from_address",
        "followup_ids",
        "via_followup_source_id"
    FROM "ticket_data"
),

"ticket_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ticket_id
    -- allow_channelback -> channelback_allowed
    -- created_at -> creation_timestamp
    -- description -> ticket_description
    -- due_at -> due_date
    -- recipient -> recipient_email
    -- status -> ticket_status
    -- subject -> ticket_subject
    -- type -> ticket_type
    -- updated_at -> last_update_timestamp
    -- url -> api_url
    -- via_channel -> submission_channel
    -- via_source_from_id -> ticket_source_id
    -- via_source_from_title -> ticket_source_name
    -- via_source_rel -> ticket_source_relationship
    -- via_source_to_address -> ticket_recipient_address
    -- via_source_to_name -> ticket_recipient_name
    -- via_source_from_address -> source_email_address
    -- via_followup_source_id -> followup_source_id
    SELECT 
        "id" AS "ticket_id",
        "allow_channelback" AS "channelback_allowed",
        "assignee_id",
        "brand_id",
        "created_at" AS "creation_timestamp",
        "description" AS "ticket_description",
        "due_at" AS "due_date",
        "external_id",
        "forum_topic_id",
        "group_id",
        "has_incidents",
        "is_public",
        "organization_id",
        "priority",
        "problem_id",
        "recipient" AS "recipient_email",
        "requester_id",
        "status" AS "ticket_status",
        "subject" AS "ticket_subject",
        "submitter_id",
        "system_client",
        "ticket_form_id",
        "type" AS "ticket_type",
        "updated_at" AS "last_update_timestamp",
        "url" AS "api_url",
        "via_channel" AS "submission_channel",
        "via_source_from_id" AS "ticket_source_id",
        "via_source_from_title" AS "ticket_source_name",
        "via_source_rel" AS "ticket_source_relationship",
        "via_source_to_address" AS "ticket_recipient_address",
        "via_source_to_name" AS "ticket_recipient_name",
        "merged_ticket_ids",
        "via_source_from_address" AS "source_email_address",
        "followup_ids",
        "via_followup_source_id" AS "followup_source_id"
    FROM "ticket_data_projected"
),

"ticket_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- ticket_description: The problem is that 'description1' appears to be a placeholder value rather than actual ticket content. It's unusual because real ticket descriptions would typically contain varied and specific information about different issues or requests. The presence of only this single, generic value suggests that actual description data is missing or was not properly imported. In this case, there isn't a "correct" value to map to, as we don't have the real descriptions. 
    -- ticket_subject: The problem is that 'subject1' appears to be a placeholder value rather than actual ticket subject content. In a real dataset, ticket subjects would typically contain varied, descriptive text related to the issue being reported. The correct values should be actual ticket subject content, but since we don't have that information, we can't map it to a specific correct value. 
    -- ticket_recipient_address: The problem is that 'X' is not a valid email address format and likely represents missing or placeholder data. The correct value for missing or placeholder data in an email address field should be an empty string. 
    -- merged_ticket_ids: The problem is that the values in the merged_ticket_ids column are string representations of lists rather than actual list values. The correct values should be actual Python lists. The '[]' represents an empty list, while '[1967]' represents a list containing a single integer value. 
    SELECT
        "ticket_id",
        "channelback_allowed",
        "assignee_id",
        "brand_id",
        "creation_timestamp",
        CASE
            WHEN "ticket_description" = '''description1''' THEN ''''
            ELSE "ticket_description"
        END AS "ticket_description",
        "due_date",
        "external_id",
        "forum_topic_id",
        "group_id",
        "has_incidents",
        "is_public",
        "organization_id",
        "priority",
        "problem_id",
        "recipient_email",
        "requester_id",
        "ticket_status",
        CASE
            WHEN "ticket_subject" = '''subject1''' THEN ''''
            ELSE "ticket_subject"
        END AS "ticket_subject",
        "submitter_id",
        "system_client",
        "ticket_form_id",
        "ticket_type",
        "last_update_timestamp",
        "api_url",
        "submission_channel",
        "ticket_source_id",
        "ticket_source_name",
        "ticket_source_relationship",
        CASE
            WHEN "ticket_recipient_address" = '''X''' THEN ''''
            ELSE "ticket_recipient_address"
        END AS "ticket_recipient_address",
        "ticket_recipient_name",
        CASE
            WHEN "merged_ticket_ids" = '''[]''' THEN '[]'
            WHEN "merged_ticket_ids" = '''[1967]''' THEN '[1967]'
            ELSE "merged_ticket_ids"
        END AS "merged_ticket_ids",
        "source_email_address",
        "followup_ids",
        "followup_source_id"
    FROM "ticket_data_projected_renamed"
),

"ticket_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- ticket_recipient_address: ['X']
    -- merged_ticket_ids: ['[]']
    SELECT 
        CASE
            WHEN "ticket_recipient_address" = 'X' THEN NULL
            ELSE "ticket_recipient_address"
        END AS "ticket_recipient_address",
        CASE
            WHEN "merged_ticket_ids" = '[]' THEN NULL
            ELSE "merged_ticket_ids"
        END AS "merged_ticket_ids",
        "forum_topic_id",
        "last_update_timestamp",
        "system_client",
        "is_public",
        "due_date",
        "ticket_recipient_name",
        "followup_source_id",
        "creation_timestamp",
        "api_url",
        "has_incidents",
        "source_email_address",
        "ticket_description",
        "priority",
        "recipient_email",
        "ticket_subject",
        "submitter_id",
        "ticket_source_name",
        "assignee_id",
        "followup_ids",
        "organization_id",
        "ticket_source_relationship",
        "problem_id",
        "external_id",
        "ticket_status",
        "ticket_source_id",
        "brand_id",
        "submission_channel",
        "channelback_allowed",
        "ticket_id",
        "requester_id",
        "ticket_type",
        "ticket_form_id",
        "group_id"
    FROM "ticket_data_projected_renamed_cleaned"
),

"ticket_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- assignee_id: from DECIMAL to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- due_date: from DECIMAL to DATE
    -- external_id: from DECIMAL to VARCHAR
    -- followup_ids: from VARCHAR to ARRAY
    -- followup_source_id: from DECIMAL to VARCHAR
    -- forum_topic_id: from DECIMAL to VARCHAR
    -- last_update_timestamp: from VARCHAR to TIMESTAMP
    -- merged_ticket_ids: from VARCHAR to ARRAY
    -- priority: from DECIMAL to VARCHAR
    -- problem_id: from DECIMAL to VARCHAR
    -- requester_id: from INT to VARCHAR
    -- source_email_address: from DECIMAL to VARCHAR
    -- submitter_id: from INT to VARCHAR
    -- system_client: from DECIMAL to VARCHAR
    -- ticket_source_id: from DECIMAL to VARCHAR
    -- ticket_source_name: from DECIMAL to VARCHAR
    -- ticket_source_relationship: from DECIMAL to VARCHAR
    SELECT
        "ticket_recipient_address",
        "is_public",
        "ticket_recipient_name",
        "api_url",
        "has_incidents",
        "ticket_description",
        "recipient_email",
        "ticket_subject",
        "organization_id",
        "ticket_status",
        "brand_id",
        "submission_channel",
        "channelback_allowed",
        "ticket_id",
        "ticket_type",
        "ticket_form_id",
        "group_id",
        CAST("assignee_id" AS VARCHAR) AS "assignee_id",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("due_date" AS DATE) AS "due_date",
        CAST("external_id" AS VARCHAR) AS "external_id",
        CASE 
            WHEN "followup_ids" = '[]' THEN CAST('[]' AS INTEGER[])
            ELSE TRY_CAST("followup_ids" AS INTEGER[])
        END AS "followup_ids",
        CAST("followup_source_id" AS VARCHAR) AS "followup_source_id",
        CAST("forum_topic_id" AS VARCHAR) AS "forum_topic_id",
        CAST("last_update_timestamp" AS TIMESTAMP) AS "last_update_timestamp",
        from_json("merged_ticket_ids", '["INTEGER"]') AS "merged_ticket_ids",
        CAST("priority" AS VARCHAR) AS "priority",
        CAST("problem_id" AS VARCHAR) AS "problem_id",
        CAST("requester_id" AS VARCHAR) AS "requester_id",
        CAST("source_email_address" AS VARCHAR) AS "source_email_address",
        CAST("submitter_id" AS VARCHAR) AS "submitter_id",
        CAST("system_client" AS VARCHAR) AS "system_client",
        CAST("ticket_source_id" AS VARCHAR) AS "ticket_source_id",
        CAST("ticket_source_name" AS VARCHAR) AS "ticket_source_name",
        CAST("ticket_source_relationship" AS VARCHAR) AS "ticket_source_relationship"
    FROM "ticket_data_projected_renamed_cleaned_null"
),

"ticket_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 11 columns with unacceptable missing values
    -- assignee_id has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- external_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_id has 10.0 percent missing. Strategy: 🔄 Unchanged
    -- organization_id has 10.0 percent missing. Strategy: 🔄 Unchanged
    -- source_email_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- system_client has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ticket_recipient_address has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- ticket_recipient_name has 10.0 percent missing. Strategy: 🔄 Unchanged
    -- ticket_source_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ticket_source_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ticket_source_relationship has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "ticket_recipient_address",
        "is_public",
        "ticket_recipient_name",
        "api_url",
        "has_incidents",
        "ticket_description",
        "recipient_email",
        "ticket_subject",
        "organization_id",
        "ticket_status",
        "brand_id",
        "submission_channel",
        "channelback_allowed",
        "ticket_id",
        "ticket_type",
        "ticket_form_id",
        "group_id",
        "assignee_id",
        "creation_timestamp",
        "due_date",
        "followup_ids",
        "followup_source_id",
        "forum_topic_id",
        "last_update_timestamp",
        "merged_ticket_ids",
        "priority",
        "problem_id",
        "requester_id",
        "submitter_id"
    FROM "ticket_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_data_projected_renamed_cleaned_null_casted_missing_handled"