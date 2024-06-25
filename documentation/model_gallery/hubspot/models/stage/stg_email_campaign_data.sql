-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_campaign_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "app_id",
        "content_id",
        "num_included",
        "num_queued",
        "sub_type",
        "type",
        "app_name",
        "name",
        "subject"
    FROM "email_campaign_data"
),

"email_campaign_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> campaign_id
    -- num_included -> recipients_included
    -- num_queued -> emails_queued
    -- sub_type -> campaign_subtype
    -- type -> campaign_type
    -- app_name -> encrypted_app_name
    -- name -> encrypted_campaign_name
    -- subject -> encrypted_email_subject
    SELECT 
        "id" AS "campaign_id",
        "app_id",
        "content_id",
        "num_included" AS "recipients_included",
        "num_queued" AS "emails_queued",
        "sub_type" AS "campaign_subtype",
        "type" AS "campaign_type",
        "app_name" AS "encrypted_app_name",
        "name" AS "encrypted_campaign_name",
        "subject" AS "encrypted_email_subject"
    FROM "email_campaign_data_projected"
),

"email_campaign_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- campaign_subtype: from DECIMAL to VARCHAR
    -- emails_queued: from DECIMAL to VARCHAR
    -- recipients_included: from DECIMAL to VARCHAR
    SELECT
        "content_id",
        "campaign_type",
        "encrypted_app_name",
        "encrypted_campaign_name",
        "encrypted_email_subject",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("campaign_subtype" AS VARCHAR) AS "campaign_subtype",
        CAST("emails_queued" AS VARCHAR) AS "emails_queued",
        CAST("recipients_included" AS VARCHAR) AS "recipients_included"
    FROM "email_campaign_data_projected_renamed"
),

"email_campaign_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 6 columns with unacceptable missing values
    -- campaign_type has 1.0 percent missing. Strategy: 🔄 Unchanged
    -- content_id has 1.0 percent missing. Strategy: 🔄 Unchanged
    -- emails_queued has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- encrypted_campaign_name has 1.0 percent missing. Strategy: 🔄 Unchanged
    -- encrypted_email_subject has 1.0 percent missing. Strategy: 🔄 Unchanged
    -- recipients_included has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "content_id",
        "campaign_type",
        "encrypted_app_name",
        "encrypted_campaign_name",
        "encrypted_email_subject",
        "app_id",
        "campaign_id",
        "campaign_subtype"
    FROM "email_campaign_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "email_campaign_data_projected_renamed_casted_missing_handled"