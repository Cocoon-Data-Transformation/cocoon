-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_field_history_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "field_name",
        "ticket_id",
        "updated",
        "user_id",
        "value_"
    FROM "ticket_field_history_data"
),

"ticket_field_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- field_name -> changed_field
    -- updated -> update_timestamp
    -- value_ -> new_value
    SELECT 
        "field_name" AS "changed_field",
        "ticket_id",
        "updated" AS "update_timestamp",
        "user_id",
        "value_" AS "new_value"
    FROM "ticket_field_history_data_projected"
),

"ticket_field_history_data_projected_renamed_dedup" AS (
    -- Deduplication: Removed 1 duplicated rows
    SELECT DISTINCT * FROM "ticket_field_history_data_projected_renamed"
),

"ticket_field_history_data_projected_renamed_dedup_casted" AS (
    -- Column Type Casting: 
    -- update_timestamp: from VARCHAR to TIMESTAMP
    -- user_id: from DECIMAL to VARCHAR
    SELECT
        "changed_field",
        "ticket_id",
        "new_value",
        CAST("update_timestamp" AS TIMESTAMP) AS "update_timestamp",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "ticket_field_history_data_projected_renamed_dedup"
),

"ticket_field_history_data_projected_renamed_dedup_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- user_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "changed_field",
        "ticket_id",
        "new_value",
        "update_timestamp"
    FROM "ticket_field_history_data_projected_renamed_dedup_casted"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_field_history_data_projected_renamed_dedup_casted_missing_handled"