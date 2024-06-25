-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_delivered_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "response",
        "smtp_id"
    FROM "email_event_delivered_data"
),

"email_event_delivered_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- response -> smtp_response
    -- smtp_id -> smtp_transaction_id
    SELECT 
        "id" AS "event_id",
        "response" AS "smtp_response",
        "smtp_id" AS "smtp_transaction_id"
    FROM "email_event_delivered_data_projected"
),

"email_event_delivered_data_projected_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "event_id",
        "smtp_transaction_id",
        TRIM("smtp_response") AS "smtp_response"
    FROM "email_event_delivered_data_projected_renamed"
),

"email_event_delivered_data_projected_renamed_trimmed_casted" AS (
    -- Column Type Casting: 
    -- event_id: from VARCHAR to UUID
    SELECT
        "smtp_transaction_id",
        "smtp_response",
        CAST("event_id" AS UUID) AS "event_id"
    FROM "email_event_delivered_data_projected_renamed_trimmed"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_delivered_data_projected_renamed_trimmed_casted"