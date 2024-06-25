-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_click_data_projected" AS (
    -- Projection: Selecting 7 out of 8 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "referer",
        "browser",
        "location",
        "ip_address",
        "url",
        "user_agent"
    FROM "email_event_click_data"
),

"email_event_click_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- referer -> referrer_url
    -- browser -> encrypted_browser
    -- location -> encrypted_location
    -- ip_address -> encrypted_ip
    -- url -> encrypted_clicked_url
    -- user_agent -> encrypted_user_agent
    SELECT 
        "id" AS "event_id",
        "referer" AS "referrer_url",
        "browser" AS "encrypted_browser",
        "location" AS "encrypted_location",
        "ip_address" AS "encrypted_ip",
        "url" AS "encrypted_clicked_url",
        "user_agent" AS "encrypted_user_agent"
    FROM "email_event_click_data_projected"
),

"email_event_click_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- encrypted_ip: from DECIMAL to VARCHAR
    -- event_id: from VARCHAR to UUID
    -- referrer_url: from DECIMAL to VARCHAR
    SELECT
        "encrypted_browser",
        "encrypted_location",
        "encrypted_clicked_url",
        "encrypted_user_agent",
        CAST("encrypted_ip" AS VARCHAR) AS "encrypted_ip",
        CAST("event_id" AS UUID) AS "event_id",
        CAST("referrer_url" AS VARCHAR) AS "referrer_url"
    FROM "email_event_click_data_projected_renamed"
),

"email_event_click_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- encrypted_ip has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- referrer_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "encrypted_browser",
        "encrypted_location",
        "encrypted_clicked_url",
        "encrypted_user_agent",
        "event_id"
    FROM "email_event_click_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_click_data_projected_renamed_casted_missing_handled"