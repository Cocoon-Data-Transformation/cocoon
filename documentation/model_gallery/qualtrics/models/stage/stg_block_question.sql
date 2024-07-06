-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:41:51.567164+00:00
WITH 
"block_question_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "block_id",
        "question_id",
        "survey_id",
        "_fivetran_deleted"
    FROM "memory"."main"."block_question"
)

-- COCOON BLOCK END
SELECT * FROM "block_question_projected"