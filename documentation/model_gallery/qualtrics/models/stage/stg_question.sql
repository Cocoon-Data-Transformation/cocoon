-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:48:57.242024+00:00
WITH 
"question_projected" AS (
    -- Projection: Selecting 18 out of 19 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "survey_id",
        "_fivetran_deleted",
        "data_export_tag",
        "data_visibility_hidden",
        "data_visibility_private",
        "next_answer_id",
        "next_choice_id",
        "question_description",
        "question_description_option",
        "question_text",
        "question_text_unsafe",
        "question_type",
        "selector",
        "sub_selector",
        "validation_setting_force_response",
        "validation_setting_force_response_type",
        "validation_setting_type"
    FROM "memory"."main"."question"
),

"question_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> question_id
    -- _fivetran_deleted -> is_deleted
    -- data_export_tag -> export_tag
    -- data_visibility_hidden -> is_hidden
    -- data_visibility_private -> is_private
    -- question_description_option -> description_display_option
    -- question_text_unsafe -> raw_question_text
    -- selector -> selector_type
    -- sub_selector -> sub_selector_type
    -- validation_setting_force_response -> force_response
    -- validation_setting_force_response_type -> force_response_type
    -- validation_setting_type -> validation_type
    SELECT 
        "id" AS "question_id",
        "survey_id",
        "_fivetran_deleted" AS "is_deleted",
        "data_export_tag" AS "export_tag",
        "data_visibility_hidden" AS "is_hidden",
        "data_visibility_private" AS "is_private",
        "next_answer_id",
        "next_choice_id",
        "question_description",
        "question_description_option" AS "description_display_option",
        "question_text",
        "question_text_unsafe" AS "raw_question_text",
        "question_type",
        "selector" AS "selector_type",
        "sub_selector" AS "sub_selector_type",
        "validation_setting_force_response" AS "force_response",
        "validation_setting_force_response_type" AS "force_response_type",
        "validation_setting_type" AS "validation_type"
    FROM "question_projected"
),

"question_projected_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "question_id",
        "survey_id",
        "is_deleted",
        "export_tag",
        "is_hidden",
        "is_private",
        "next_answer_id",
        "next_choice_id",
        "description_display_option",
        "question_text",
        "raw_question_text",
        "question_type",
        "selector_type",
        "sub_selector_type",
        "force_response",
        "force_response_type",
        "validation_type",
        TRIM("question_description") AS "question_description"
    FROM "question_projected_renamed"
),

"question_projected_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- question_text: The problem is that 'Click to write the question text' is a placeholder value that should be replaced with actual content. 'Tell About experience ?&nbsp;' has typos, improper capitalization, and an HTML entity that should be removed. 'Marks' appears to be the only valid entry. The correct values should be consistent and meaningful question text. 
    -- raw_question_text: The problem is that this column contains some unusual values. "Click to write the question text" is likely a placeholder and not an actual question. "Tell About experience ?&nbsp;" contains an HTML entity (&nbsp;) which should be removed. "Marks" seems to be the only valid value. The correct values should be either "Marks" or an empty string for invalid entries. 
    -- question_description: The problem is that 'Click to write the question text' is a placeholder value that should not appear in actual data, and 'Tell About experience ?' has grammatical errors and inconsistent capitalization. The correct values should be either 'Marks' (which appears to be a valid category) or a properly formatted question about experience. 
    SELECT
        "question_id",
        "survey_id",
        "is_deleted",
        "export_tag",
        "is_hidden",
        "is_private",
        "next_answer_id",
        "next_choice_id",
        "description_display_option",
        CASE
            WHEN "question_text" = '''Click to write the question text''' THEN ''''
            WHEN "question_text" = '''Tell About experience ?&nbsp;''' THEN '''Tell about experience?'''
            ELSE "question_text"
        END AS "question_text",
        CASE
            WHEN "raw_question_text" = '''Click to write the question text''' THEN ''''
            WHEN "raw_question_text" = '''Tell About experience ?&nbsp;''' THEN '''Tell About experience ?'''
            ELSE "raw_question_text"
        END AS "raw_question_text",
        "question_type",
        "selector_type",
        "sub_selector_type",
        "force_response",
        "force_response_type",
        "validation_type",
        CASE
            WHEN "question_description" = '''Click to write the question text''' THEN ''''
            WHEN "question_description" = '''Tell About experience ?''' THEN '''Tell about experience?'''
            ELSE "question_description"
        END AS "question_description"
    FROM "question_projected_renamed_trimmed"
),

"question_projected_renamed_trimmed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- question_text: ['Click to write the question text']
    -- raw_question_text: ['Click to write the question text']
    -- question_description: ['Click to write the question text']
    SELECT 
        CASE
            WHEN "question_text" = 'Click to write the question text' THEN NULL
            ELSE "question_text"
        END AS "question_text",
        CASE
            WHEN "raw_question_text" = 'Click to write the question text' THEN NULL
            ELSE "raw_question_text"
        END AS "raw_question_text",
        CASE
            WHEN "question_description" = 'Click to write the question text' THEN NULL
            ELSE "question_description"
        END AS "question_description",
        "question_id",
        "description_display_option",
        "question_type",
        "is_hidden",
        "is_deleted",
        "next_choice_id",
        "selector_type",
        "is_private",
        "force_response",
        "export_tag",
        "next_answer_id",
        "survey_id",
        "sub_selector_type",
        "force_response_type",
        "validation_type"
    FROM "question_projected_renamed_trimmed_cleaned"
),

"question_projected_renamed_trimmed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- force_response: from DECIMAL to VARCHAR
    -- force_response_type: from DECIMAL to VARCHAR
    -- is_hidden: from BOOLEAN to VARCHAR
    -- is_private: from BOOLEAN to VARCHAR
    -- validation_type: from DECIMAL to VARCHAR
    SELECT
        "question_text",
        "raw_question_text",
        "question_description",
        "question_id",
        "description_display_option",
        "question_type",
        "is_deleted",
        "next_choice_id",
        "selector_type",
        "export_tag",
        "next_answer_id",
        "survey_id",
        "sub_selector_type",
        CAST("force_response" AS VARCHAR) AS "force_response",
        CAST("force_response_type" AS VARCHAR) AS "force_response_type",
        CAST("is_hidden" AS VARCHAR) AS "is_hidden",
        CAST("is_private" AS VARCHAR) AS "is_private",
        CAST("validation_type" AS VARCHAR) AS "validation_type"
    FROM "question_projected_renamed_trimmed_cleaned_null"
),

"question_projected_renamed_trimmed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 8 columns with unacceptable missing values
    -- force_response has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- force_response_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_hidden has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- is_private has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- question_description has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- question_text has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- raw_question_text has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- validation_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "question_text",
        "raw_question_text",
        "question_description",
        "question_id",
        "description_display_option",
        "question_type",
        "is_deleted",
        "next_choice_id",
        "selector_type",
        "export_tag",
        "next_answer_id",
        "survey_id",
        "sub_selector_type",
        "is_hidden",
        "is_private"
    FROM "question_projected_renamed_trimmed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "question_projected_renamed_trimmed_cleaned_null_casted_missing_handled"