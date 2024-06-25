-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_deferred_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "attempt",
        "response"
    FROM "email_event_deferred_data"
),

"email_event_deferred_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- attempt -> attempt_count
    -- response -> server_response
    SELECT 
        "id" AS "event_id",
        "attempt" AS "attempt_count",
        "response" AS "server_response"
    FROM "email_event_deferred_data_projected"
),

"email_event_deferred_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    -- server_response: from DECIMAL to VARCHAR
    SELECT
        "attempt_count",
        CAST("event_id" AS UUID) AS "event_id",
        CAST("server_response" AS VARCHAR) AS "server_response"
    FROM "email_event_deferred_data_projected_renamed"
),

"email_event_deferred_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- server_response has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "attempt_count",
        "event_id"
    FROM "email_event_deferred_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_deferred_data_projected_renamed_casted_missing_handled"