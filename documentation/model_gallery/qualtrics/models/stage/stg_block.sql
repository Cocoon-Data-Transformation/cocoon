-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:41:50.303242+00:00
WITH 
"block_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "survey_id",
        "_fivetran_deleted",
        "block_locking",
        "block_visibility",
        "description",
        "randomize_questions",
        "type"
    FROM "memory"."main"."block"
),

"block_projected_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- block_locking has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- block_visibility has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- randomize_questions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "id",
        "survey_id",
        "_fivetran_deleted",
        "description",
        "type"
    FROM "block_projected"
)

-- COCOON BLOCK END
SELECT * FROM "block_projected_missing_handled"