-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"issue_field_history_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "field_id",
        "issue_id",
        "time_",
        "value_"
    FROM "issue_field_history"
),

"issue_field_history_projected_renamed" AS (
    -- Rename: Renaming columns
    -- field_id -> field_identifier
    -- issue_id -> issue_identifier
    -- time_ -> change_timestamp
    -- value_ -> new_field_value
    SELECT 
        "field_id" AS "field_identifier",
        "issue_id" AS "issue_identifier",
        "time_" AS "change_timestamp",
        "value_" AS "new_field_value"
    FROM "issue_field_history_projected"
),

"issue_field_history_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- change_timestamp: from VARCHAR to TIMESTAMP
    -- issue_identifier: from INT to VARCHAR
    SELECT
        "field_identifier",
        "new_field_value",
        CAST("change_timestamp" AS TIMESTAMP) AS "change_timestamp",
        CAST("issue_identifier" AS VARCHAR) AS "issue_identifier"
    FROM "issue_field_history_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "issue_field_history_projected_renamed_casted"