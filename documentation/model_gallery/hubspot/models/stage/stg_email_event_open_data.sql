-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_open_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "duration",
        "browser",
        "ip_address",
        "location",
        "user_agent"
    FROM "email_event_open_data"
),

"email_event_open_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- duration -> duration_seconds
    -- browser -> encrypted_browser
    -- ip_address -> encrypted_ip_address
    -- location -> encrypted_location
    -- user_agent -> encrypted_user_agent
    SELECT 
        "id" AS "event_id",
        "duration" AS "duration_seconds",
        "browser" AS "encrypted_browser",
        "ip_address" AS "encrypted_ip_address",
        "location" AS "encrypted_location",
        "user_agent" AS "encrypted_user_agent"
    FROM "email_event_open_data_projected"
),

"email_event_open_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- encrypted_ip_address: from DECIMAL to VARCHAR
    -- event_id: from VARCHAR to UUID
    SELECT
        "duration_seconds",
        "encrypted_browser",
        "encrypted_location",
        "encrypted_user_agent",
        CAST("encrypted_ip_address" AS VARCHAR) AS "encrypted_ip_address",
        CAST("event_id" AS UUID) AS "event_id"
    FROM "email_event_open_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_open_data_projected_renamed_casted"