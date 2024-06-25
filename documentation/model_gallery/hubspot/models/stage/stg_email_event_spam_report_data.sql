-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_spam_report_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "ip_address",
        "user_agent"
    FROM "email_event_spam_report_data"
),

"email_event_spam_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    SELECT 
        "id" AS "event_id",
        "ip_address",
        "user_agent"
    FROM "email_event_spam_report_data_projected"
),

"email_event_spam_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    -- ip_address: from DECIMAL to VARCHAR
    -- user_agent: from DECIMAL to VARCHAR
    SELECT
        CAST("event_id" AS UUID) AS "event_id",
        CAST("ip_address" AS VARCHAR) AS "ip_address",
        CAST("user_agent" AS VARCHAR) AS "user_agent"
    FROM "email_event_spam_report_data_projected_renamed"
),

"email_event_spam_report_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- ip_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_agent has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "event_id"
    FROM "email_event_spam_report_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_spam_report_data_projected_renamed_casted_missing_handled"