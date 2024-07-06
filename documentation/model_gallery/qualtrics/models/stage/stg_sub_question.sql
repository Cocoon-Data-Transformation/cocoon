-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:51:31.889107+00:00
WITH 
"sub_question_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "key_",
        "question_id",
        "survey_id",
        "_fivetran_deleted",
        "choice_data_export_tag",
        "text"
    FROM "memory"."main"."sub_question"
),

"sub_question_projected_renamed" AS (
    -- Rename: Renaming columns
    -- key_ -> answer_choice_id
    -- _fivetran_deleted -> is_deleted
    -- choice_data_export_tag -> export_tag
    -- text -> answer_text
    SELECT 
        "key_" AS "answer_choice_id",
        "question_id",
        "survey_id",
        "_fivetran_deleted" AS "is_deleted",
        "choice_data_export_tag" AS "export_tag",
        "text" AS "answer_text"
    FROM "sub_question_projected"
),

"sub_question_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- export_tag: from DECIMAL to VARCHAR
    SELECT
        "answer_choice_id",
        "question_id",
        "survey_id",
        "is_deleted",
        "answer_text",
        CAST("export_tag" AS VARCHAR) AS "export_tag"
    FROM "sub_question_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "sub_question_projected_renamed_casted"