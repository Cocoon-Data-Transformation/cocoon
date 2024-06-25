-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "app_id",
        "caused_by_created",
        "caused_by_id",
        "created",
        "email_campaign_id",
        "obsoleted_by_created",
        "obsoleted_by_id",
        "portal_id",
        "sent_by_created",
        "sent_by_id",
        "type",
        "filtered_event",
        "recipient"
    FROM "email_event_data"
),

"email_event_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- app_id -> application_id
    -- caused_by_created -> causal_event_created_at
    -- caused_by_id -> causal_event_id
    -- created -> event_created_at
    -- email_campaign_id -> campaign_id
    -- obsoleted_by_created -> obsoleting_event_created_at
    -- obsoleted_by_id -> obsoleting_event_id
    -- sent_by_created -> sending_event_created_at
    -- sent_by_id -> sending_event_id
    -- type -> event_type
    -- filtered_event -> is_filtered_event
    -- recipient -> encrypted_recipient_id
    SELECT 
        "id" AS "event_id",
        "app_id" AS "application_id",
        "caused_by_created" AS "causal_event_created_at",
        "caused_by_id" AS "causal_event_id",
        "created" AS "event_created_at",
        "email_campaign_id" AS "campaign_id",
        "obsoleted_by_created" AS "obsoleting_event_created_at",
        "obsoleted_by_id" AS "obsoleting_event_id",
        "portal_id",
        "sent_by_created" AS "sending_event_created_at",
        "sent_by_id" AS "sending_event_id",
        "type" AS "event_type",
        "filtered_event" AS "is_filtered_event",
        "recipient" AS "encrypted_recipient_id"
    FROM "email_event_data_projected"
),

"email_event_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- causal_event_created_at: from DECIMAL to TIMESTAMP
    -- causal_event_id: from DECIMAL to UUID
    -- event_created_at: from VARCHAR to TIMESTAMP
    -- event_id: from VARCHAR to UUID
    -- obsoleting_event_created_at: from DECIMAL to TIMESTAMP
    -- obsoleting_event_id: from DECIMAL to UUID
    -- sending_event_created_at: from VARCHAR to TIMESTAMP
    -- sending_event_id: from VARCHAR to UUID
    SELECT
        "application_id",
        "campaign_id",
        "portal_id",
        "event_type",
        "is_filtered_event",
        "encrypted_recipient_id",
        CAST("causal_event_created_at" AS TIMESTAMP) AS "causal_event_created_at",
        CAST("causal_event_id" AS UUID) AS "causal_event_id",
        CAST("event_created_at" AS TIMESTAMP) AS "event_created_at",
        CAST("event_id" AS UUID) AS "event_id",
        CAST("obsoleting_event_created_at" AS TIMESTAMP) AS "obsoleting_event_created_at",
        CAST("obsoleting_event_id" AS UUID) AS "obsoleting_event_id",
        CAST("sending_event_created_at" AS TIMESTAMP) AS "sending_event_created_at",
        CAST("sending_event_id" AS UUID) AS "sending_event_id"
    FROM "email_event_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_data_projected_renamed_casted"