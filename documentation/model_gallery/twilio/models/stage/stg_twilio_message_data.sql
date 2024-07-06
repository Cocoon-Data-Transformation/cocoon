-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:37:52.826731+00:00
WITH 
"twilio_message_data_projected" AS (
    -- Projection: Selecting 17 out of 18 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "account_id",
        "body",
        "created_at",
        "date_sent",
        "direction",
        "error_code",
        "error_message",
        "from_",
        "messaging_service_sid",
        "num_media",
        "num_segments",
        "price",
        "price_unit",
        "status",
        "to_",
        "updated_at"
    FROM "memory"."main"."twilio_message_data"
),

"twilio_message_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> message_id
    -- body -> message_content
    -- date_sent -> sent_at
    -- direction -> message_direction
    -- error_message -> error_description
    -- from_ -> sender_number
    -- messaging_service_sid -> messaging_service_id
    -- num_media -> media_count
    -- num_segments -> segment_count
    -- price -> message_cost
    -- price_unit -> currency
    -- status -> delivery_status
    -- to_ -> recipient_number
    SELECT 
        "id" AS "message_id",
        "account_id",
        "body" AS "message_content",
        "created_at",
        "date_sent" AS "sent_at",
        "direction" AS "message_direction",
        "error_code",
        "error_message" AS "error_description",
        "from_" AS "sender_number",
        "messaging_service_sid" AS "messaging_service_id",
        "num_media" AS "media_count",
        "num_segments" AS "segment_count",
        "price" AS "message_cost",
        "price_unit" AS "currency",
        "status" AS "delivery_status",
        "to_" AS "recipient_number",
        "updated_at"
    FROM "twilio_message_data_projected"
),

"twilio_message_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- error_code: from DECIMAL to VARCHAR
    -- error_description: from DECIMAL to VARCHAR
    -- messaging_service_id: from DECIMAL to VARCHAR
    -- recipient_number: from INT to VARCHAR
    -- sender_number: from INT to VARCHAR
    -- sent_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "message_id",
        "account_id",
        "message_content",
        "message_direction",
        "media_count",
        "segment_count",
        "message_cost",
        "currency",
        "delivery_status",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("error_code" AS VARCHAR) AS "error_code",
        CAST("error_description" AS VARCHAR) AS "error_description",
        CAST("messaging_service_id" AS VARCHAR) AS "messaging_service_id",
        CAST("recipient_number" AS VARCHAR) AS "recipient_number",
        CAST("sender_number" AS VARCHAR) AS "sender_number",
        CAST("sent_at" AS TIMESTAMP) AS "sent_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "twilio_message_data_projected_renamed"
),

"twilio_message_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- messaging_service_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "message_id",
        "account_id",
        "message_content",
        "message_direction",
        "media_count",
        "segment_count",
        "message_cost",
        "currency",
        "delivery_status",
        "created_at",
        "error_code",
        "error_description",
        "recipient_number",
        "sender_number",
        "sent_at",
        "updated_at"
    FROM "twilio_message_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_message_data_projected_renamed_casted_missing_handled"