-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:59:48.468752+00:00
WITH 
"survey_response_projected" AS (
    -- Projection: Selecting 18 out of 19 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "distribution_channel",
        "duration_in_seconds",
        "end_date",
        "finished",
        "ip_address",
        "last_modified_date",
        "location_latitude",
        "location_longitude",
        "progress",
        "recipient_email",
        "recipient_first_name",
        "recipient_last_name",
        "recorded_date",
        "start_date",
        "status",
        "survey_id",
        "user_language"
    FROM "memory"."main"."survey_response"
),

"survey_response_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> response_id
    -- duration_in_seconds -> survey_duration_seconds
    -- end_date -> response_end_datetime
    -- finished -> is_survey_completed
    -- ip_address -> respondent_ip_address
    -- last_modified_date -> last_modified_datetime
    -- location_latitude -> respondent_latitude
    -- location_longitude -> respondent_longitude
    -- progress -> survey_progress_percentage
    -- recorded_date -> response_recorded_datetime
    -- start_date -> response_start_datetime
    -- status -> response_status
    -- user_language -> respondent_language
    SELECT 
        "id" AS "response_id",
        "distribution_channel",
        "duration_in_seconds" AS "survey_duration_seconds",
        "end_date" AS "response_end_datetime",
        "finished" AS "is_survey_completed",
        "ip_address" AS "respondent_ip_address",
        "last_modified_date" AS "last_modified_datetime",
        "location_latitude" AS "respondent_latitude",
        "location_longitude" AS "respondent_longitude",
        "progress" AS "survey_progress_percentage",
        "recipient_email",
        "recipient_first_name",
        "recipient_last_name",
        "recorded_date" AS "response_recorded_datetime",
        "start_date" AS "response_start_datetime",
        "status" AS "response_status",
        "survey_id",
        "user_language" AS "respondent_language"
    FROM "survey_response_projected"
),

"survey_response_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- recipient_last_name: The problem is that the last name "Aggarwak=l" contains an equals sign (=), which is not typical in names. It appears that the equals sign was mistakenly included, possibly due to a data entry error or parsing issue. The correct value should be "Aggarwal", which is a common Indian surname. 
    SELECT
        "response_id",
        "distribution_channel",
        "survey_duration_seconds",
        "response_end_datetime",
        "is_survey_completed",
        "respondent_ip_address",
        "last_modified_datetime",
        "respondent_latitude",
        "respondent_longitude",
        "survey_progress_percentage",
        "recipient_email",
        "recipient_first_name",
        CASE
            WHEN "recipient_last_name" = '''Aggarwak=l''' THEN '''Aggarwal'''
            ELSE "recipient_last_name"
        END AS "recipient_last_name",
        "response_recorded_datetime",
        "response_start_datetime",
        "response_status",
        "survey_id",
        "respondent_language"
    FROM "survey_response_projected_renamed"
),

"survey_response_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- is_survey_completed: from INT to BIT
    -- last_modified_datetime: from VARCHAR to TIMESTAMP
    -- response_end_datetime: from VARCHAR to TIMESTAMP
    -- response_recorded_datetime: from VARCHAR to TIMESTAMP
    -- response_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "response_id",
        "distribution_channel",
        "survey_duration_seconds",
        "respondent_ip_address",
        "respondent_latitude",
        "respondent_longitude",
        "survey_progress_percentage",
        "recipient_email",
        "recipient_first_name",
        "recipient_last_name",
        "response_status",
        "survey_id",
        "respondent_language",
        CAST("is_survey_completed" AS BIT) AS "is_survey_completed",
        CAST("last_modified_datetime" AS TIMESTAMP) AS "last_modified_datetime",
        CAST("response_end_datetime" AS TIMESTAMP) AS "response_end_datetime",
        CAST("response_recorded_datetime" AS TIMESTAMP) AS "response_recorded_datetime",
        CAST("response_start_datetime" AS TIMESTAMP) AS "response_start_datetime"
    FROM "survey_response_projected_renamed_cleaned"
),

"survey_response_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- recipient_first_name has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- recipient_last_name has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- respondent_latitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- respondent_longitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "response_id",
        "distribution_channel",
        "survey_duration_seconds",
        "respondent_ip_address",
        "survey_progress_percentage",
        "recipient_email",
        "recipient_first_name",
        "recipient_last_name",
        "response_status",
        "survey_id",
        "respondent_language",
        "is_survey_completed",
        "last_modified_datetime",
        "response_end_datetime",
        "response_recorded_datetime",
        "response_start_datetime"
    FROM "survey_response_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "survey_response_projected_renamed_cleaned_casted_missing_handled"