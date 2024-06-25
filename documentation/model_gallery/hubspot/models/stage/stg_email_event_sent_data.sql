-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_sent_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "bcc",
        "cc",
        "from_",
        "reply_to",
        "subject"
    FROM "email_event_sent_data"
),

"email_event_sent_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- bcc -> encrypted_bcc_recipients
    -- cc -> encrypted_cc_recipients
    -- from_ -> encrypted_sender
    -- reply_to -> encrypted_reply_to
    -- subject -> encrypted_subject
    SELECT 
        "id" AS "event_id",
        "bcc" AS "encrypted_bcc_recipients",
        "cc" AS "encrypted_cc_recipients",
        "from_" AS "encrypted_sender",
        "reply_to" AS "encrypted_reply_to",
        "subject" AS "encrypted_subject"
    FROM "email_event_sent_data_projected"
),

"email_event_sent_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    SELECT
        "encrypted_bcc_recipients",
        "encrypted_cc_recipients",
        "encrypted_sender",
        "encrypted_reply_to",
        "encrypted_subject",
        CAST("event_id" AS UUID) AS "event_id"
    FROM "email_event_sent_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_sent_data_projected_renamed_casted"