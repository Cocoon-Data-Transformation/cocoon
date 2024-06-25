-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_print_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "browser",
        "ip_address",
        "location",
        "user_agent"
    FROM "email_event_print_data"
),

"email_event_print_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- browser -> encrypted_browser_id
    -- location -> encrypted_location
    -- user_agent -> encrypted_user_agent
    SELECT 
        "id" AS "event_id",
        "browser" AS "encrypted_browser_id",
        "ip_address",
        "location" AS "encrypted_location",
        "user_agent" AS "encrypted_user_agent"
    FROM "email_event_print_data_projected"
),

"email_event_print_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    -- ip_address: from DECIMAL to VARCHAR
    SELECT
        "encrypted_browser_id",
        "encrypted_location",
        "encrypted_user_agent",
        CAST("event_id" AS UUID) AS "event_id",
        CAST("ip_address" AS VARCHAR) AS "ip_address"
    FROM "email_event_print_data_projected_renamed"
),

"email_event_print_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- ip_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "encrypted_browser_id",
        "encrypted_location",
        "encrypted_user_agent",
        "event_id"
    FROM "email_event_print_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_print_data_projected_renamed_casted_missing_handled"