-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:57:52.211204+00:00
WITH 
"survey_embedded_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "import_id",
        "key_",
        "response_id",
        "value_"
    FROM "memory"."main"."survey_embedded_data"
),

"survey_embedded_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- import_id -> data_category
    -- key_ -> data_key
    -- value_ -> data_value
    SELECT 
        "import_id" AS "data_category",
        "key_" AS "data_key",
        "response_id",
        "value_" AS "data_value"
    FROM "survey_embedded_data_projected"
),

"survey_embedded_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- data_value: from DECIMAL to VARCHAR
    SELECT
        "data_category",
        "data_key",
        "response_id",
        CAST("data_value" AS VARCHAR) AS "data_value"
    FROM "survey_embedded_data_projected_renamed"
),

"survey_embedded_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- data_value has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "data_category",
        "data_key",
        "response_id"
    FROM "survey_embedded_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "survey_embedded_data_projected_renamed_casted_missing_handled"