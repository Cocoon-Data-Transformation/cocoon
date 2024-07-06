-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:50:48.307661+00:00
WITH 
"question_response_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_id",
        "loop_id",
        "question",
        "question_id",
        "question_option_key",
        "response_id",
        "sub_question_key",
        "sub_question_text",
        "value_"
    FROM "memory"."main"."question_response"
),

"question_response_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_id -> record_id
    -- question -> question_topic
    -- question_option_key -> option_key
    -- value_ -> response_value
    SELECT 
        "_fivetran_id" AS "record_id",
        "loop_id",
        "question" AS "question_topic",
        "question_id",
        "question_option_key" AS "option_key",
        "response_id",
        "sub_question_key",
        "sub_question_text",
        "value_" AS "response_value"
    FROM "question_response_projected"
),

"question_response_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- loop_id: from DECIMAL to VARCHAR
    -- option_key: from DECIMAL to VARCHAR
    -- sub_question_key: from DECIMAL to VARCHAR
    -- sub_question_text: from DECIMAL to VARCHAR
    SELECT
        "record_id",
        "question_topic",
        "question_id",
        "response_id",
        "response_value",
        CAST("loop_id" AS VARCHAR) AS "loop_id",
        CAST("option_key" AS VARCHAR) AS "option_key",
        CAST("sub_question_key" AS VARCHAR) AS "sub_question_key",
        CAST("sub_question_text" AS VARCHAR) AS "sub_question_text"
    FROM "question_response_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "question_response_projected_renamed_casted"