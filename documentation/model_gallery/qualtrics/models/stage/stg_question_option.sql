-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:49:45.805052+00:00
WITH 
"question_option_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "key_",
        "question_id",
        "survey_id",
        "_fivetran_deleted",
        "recode_value",
        "text"
    FROM "memory"."main"."question_option"
),

"question_option_projected_renamed" AS (
    -- Rename: Renaming columns
    -- key_ -> option_id
    -- _fivetran_deleted -> is_deleted
    -- recode_value -> option_value
    -- text -> option_text
    SELECT 
        "key_" AS "option_id",
        "question_id",
        "survey_id",
        "_fivetran_deleted" AS "is_deleted",
        "recode_value" AS "option_value",
        "text" AS "option_text"
    FROM "question_option_projected"
)

-- COCOON BLOCK END
SELECT * FROM "question_option_projected_renamed"