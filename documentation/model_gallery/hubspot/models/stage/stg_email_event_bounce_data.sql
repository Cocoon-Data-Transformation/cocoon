-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_bounce_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "category",
        "status",
        "response"
    FROM "email_event_bounce_data"
),

"email_event_bounce_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- category -> bounce_reason
    -- status -> bounce_status_code
    -- response -> encoded_server_response
    SELECT 
        "id" AS "event_id",
        "category" AS "bounce_reason",
        "status" AS "bounce_status_code",
        "response" AS "encoded_server_response"
    FROM "email_event_bounce_data_projected"
),

"email_event_bounce_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    SELECT
        "bounce_reason",
        "bounce_status_code",
        "encoded_server_response",
        CAST("event_id" AS UUID) AS "event_id"
    FROM "email_event_bounce_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_bounce_data_projected_renamed_casted"