-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_dropped_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "drop_reason",
        "bcc",
        "cc",
        "drop_message",
        "from_",
        "reply_to",
        "subject"
    FROM "email_event_dropped_data"
),

"email_event_dropped_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- bcc -> encrypted_bcc
    -- cc -> encrypted_cc
    -- drop_message -> encrypted_drop_message
    -- from_ -> encrypted_sender
    -- reply_to -> encrypted_reply_to
    -- subject -> encrypted_subject
    SELECT 
        "id" AS "event_id",
        "drop_reason",
        "bcc" AS "encrypted_bcc",
        "cc" AS "encrypted_cc",
        "drop_message" AS "encrypted_drop_message",
        "from_" AS "encrypted_sender",
        "reply_to" AS "encrypted_reply_to",
        "subject" AS "encrypted_subject"
    FROM "email_event_dropped_data_projected"
),

"email_event_dropped_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    SELECT
        "drop_reason",
        "encrypted_bcc",
        "encrypted_cc",
        "encrypted_drop_message",
        "encrypted_sender",
        "encrypted_reply_to",
        "encrypted_subject",
        CAST("event_id" AS UUID) AS "event_id"
    FROM "email_event_dropped_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_dropped_data_projected_renamed_casted"