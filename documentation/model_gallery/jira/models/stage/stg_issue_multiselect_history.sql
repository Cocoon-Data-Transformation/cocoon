-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"issue_multiselect_history_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_id",
        "time_",
        "field_id",
        "issue_id",
        "value_"
    FROM "issue_multiselect_history"
),

"issue_multiselect_history_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_id -> record_id
    -- time_ -> change_timestamp
    -- value_ -> new_field_value
    SELECT 
        "_fivetran_id" AS "record_id",
        "time_" AS "change_timestamp",
        "field_id",
        "issue_id",
        "value_" AS "new_field_value"
    FROM "issue_multiselect_history_projected"
),

"issue_multiselect_history_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- change_timestamp: from VARCHAR to TIMESTAMP
    -- new_field_value: from INT to VARCHAR
    SELECT
        "record_id",
        "field_id",
        "issue_id",
        CAST("change_timestamp" AS TIMESTAMP) AS "change_timestamp",
        CAST("new_field_value" AS VARCHAR) AS "new_field_value"
    FROM "issue_multiselect_history_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "issue_multiselect_history_projected_renamed_casted"