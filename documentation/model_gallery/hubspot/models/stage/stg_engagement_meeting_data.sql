-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_meeting_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "engagement_id",
        "created_from_link_id",
        "end_time",
        "pre_meeting_prospect_reminders",
        "source",
        "source_id",
        "start_time",
        "web_conference_meeting_id",
        "meeting_outcome",
        "body",
        "external_url",
        "title"
    FROM "engagement_meeting_data"
),

"engagement_meeting_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- created_from_link_id -> original_link_id
    -- pre_meeting_prospect_reminders -> pre_meeting_reminders
    -- web_conference_meeting_id -> web_conference_id
    -- body -> encrypted_meeting_content
    -- external_url -> encrypted_external_url
    -- title -> encrypted_meeting_title
    SELECT 
        "engagement_id",
        "created_from_link_id" AS "original_link_id",
        "end_time",
        "pre_meeting_prospect_reminders" AS "pre_meeting_reminders",
        "source",
        "source_id",
        "start_time",
        "web_conference_meeting_id" AS "web_conference_id",
        "meeting_outcome",
        "body" AS "encrypted_meeting_content",
        "external_url" AS "encrypted_external_url",
        "title" AS "encrypted_meeting_title"
    FROM "engagement_meeting_data_projected"
),

"engagement_meeting_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- end_time: The problem is that some of the end_time values are using the Unix epoch time format (starting from 1970-01-01), which is inconsistent with the majority of the dates that use a more recent and readable format (YYYY-MM-DD HH:MM:SS). The correct values should all follow the YYYY-MM-DD HH:MM:SS format. The 1970 dates are likely errors or placeholders and should be removed or replaced with a valid date if the actual end time is known. 
    SELECT
        "engagement_id",
        "original_link_id",
        CASE
            WHEN "end_time" = '1970-01-19 07:11:40.200' THEN ''
            WHEN "end_time" = '1970-01-19 07:31:58.800' THEN ''
            WHEN "end_time" = '1970-01-19 07:52:03' THEN ''
            WHEN "end_time" = '1970-01-19 08:03:32.400' THEN ''
            WHEN "end_time" = '1970-01-19 08:22:26.400' THEN ''
            WHEN "end_time" = '1970-01-19 08:30:39.600' THEN ''
            WHEN "end_time" = '1970-01-19 08:32:22.200' THEN ''
            ELSE "end_time"
        END AS "end_time",
        "pre_meeting_reminders",
        "source",
        "source_id",
        "start_time",
        "web_conference_id",
        "meeting_outcome",
        "encrypted_meeting_content",
        "encrypted_external_url",
        "encrypted_meeting_title"
    FROM "engagement_meeting_data_projected_renamed"
),

"engagement_meeting_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- end_time: ['']
    SELECT 
        CASE
            WHEN "end_time" = '' THEN NULL
            ELSE "end_time"
        END AS "end_time",
        "encrypted_external_url",
        "source_id",
        "engagement_id",
        "encrypted_meeting_title",
        "encrypted_meeting_content",
        "pre_meeting_reminders",
        "source",
        "web_conference_id",
        "start_time",
        "original_link_id",
        "meeting_outcome"
    FROM "engagement_meeting_data_projected_renamed_cleaned"
),

"engagement_meeting_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- end_time: from VARCHAR to TIMESTAMP
    -- engagement_id: from INT to VARCHAR
    -- meeting_outcome: from DECIMAL to VARCHAR
    -- original_link_id: from DECIMAL to VARCHAR
    -- pre_meeting_reminders: from VARCHAR to JSON
    -- start_time: from VARCHAR to TIMESTAMP
    -- web_conference_id: from DECIMAL to VARCHAR
    SELECT
        "encrypted_external_url",
        "source_id",
        "encrypted_meeting_title",
        "encrypted_meeting_content",
        "source",
        CAST("end_time" AS TIMESTAMP) AS "end_time",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id",
        CAST("meeting_outcome" AS VARCHAR) AS "meeting_outcome",
        CAST("original_link_id" AS VARCHAR) AS "original_link_id",
        CAST("pre_meeting_reminders" AS JSON) AS "pre_meeting_reminders",
        CAST("start_time" AS TIMESTAMP) AS "start_time",
        CAST("web_conference_id" AS VARCHAR) AS "web_conference_id"
    FROM "engagement_meeting_data_projected_renamed_cleaned_null"
),

"engagement_meeting_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 6 columns with unacceptable missing values
    -- encrypted_external_url has 1.0 percent missing. Strategy: 🔄 Unchanged
    -- encrypted_meeting_content has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- end_time has 7.0 percent missing. Strategy: 🔄 Unchanged
    -- meeting_outcome has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- original_link_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_id has 1.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "encrypted_external_url",
        "source_id",
        "encrypted_meeting_title",
        "encrypted_meeting_content",
        "source",
        "end_time",
        "engagement_id",
        "pre_meeting_reminders",
        "start_time",
        "web_conference_id"
    FROM "engagement_meeting_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_meeting_data_projected_renamed_cleaned_null_casted_missing_handled"