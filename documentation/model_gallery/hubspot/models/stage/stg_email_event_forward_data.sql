-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_forward_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "browser",
        "ip_address",
        "location",
        "user_agent"
    FROM "email_event_forward_data"
),

"email_event_forward_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- browser -> encrypted_browser
    -- ip_address -> forwarding_ip
    -- location -> encrypted_location
    -- user_agent -> encrypted_user_agent
    SELECT 
        "id" AS "event_id",
        "browser" AS "encrypted_browser",
        "ip_address" AS "forwarding_ip",
        "location" AS "encrypted_location",
        "user_agent" AS "encrypted_user_agent"
    FROM "email_event_forward_data_projected"
),

"email_event_forward_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    -- forwarding_ip: from DECIMAL to VARCHAR
    SELECT
        "encrypted_browser",
        "encrypted_location",
        "encrypted_user_agent",
        CAST("event_id" AS UUID) AS "event_id",
        CAST("forwarding_ip" AS VARCHAR) AS "forwarding_ip"
    FROM "email_event_forward_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_forward_data_projected_renamed_casted"