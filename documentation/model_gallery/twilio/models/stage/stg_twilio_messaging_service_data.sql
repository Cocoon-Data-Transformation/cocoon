-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:40:26.363718+00:00
WITH 
"twilio_messaging_service_data_projected" AS (
    -- Projection: Selecting 22 out of 23 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "account_id",
        "area_code_geomatch",
        "created_at",
        "fallback_method",
        "fallback_to_long_code",
        "fallback_url",
        "friendly_name",
        "inbound_method",
        "inbound_request_url",
        "mms_converter",
        "scan_message_content",
        "smart_encoding",
        "status_callback",
        "sticky_sender",
        "synchronous_validation",
        "updated_at",
        "us_app_to_person_registered",
        "use_inbound_webhook_on_number",
        "usecase",
        "validity_period"
    FROM "memory"."main"."twilio_messaging_service_data"
),

"twilio_messaging_service_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> service_id
    -- _fivetran_deleted -> is_deleted
    -- fallback_method -> fallback_http_method
    -- friendly_name -> service_name
    -- inbound_method -> inbound_http_method
    -- status_callback -> status_callback_url
    -- us_app_to_person_registered -> us_a2p_10dlc_registered
    -- use_inbound_webhook_on_number -> use_inbound_webhook
    -- validity_period -> validity_period_seconds
    SELECT 
        "id" AS "service_id",
        "_fivetran_deleted" AS "is_deleted",
        "account_id",
        "area_code_geomatch",
        "created_at",
        "fallback_method" AS "fallback_http_method",
        "fallback_to_long_code",
        "fallback_url",
        "friendly_name" AS "service_name",
        "inbound_method" AS "inbound_http_method",
        "inbound_request_url",
        "mms_converter",
        "scan_message_content",
        "smart_encoding",
        "status_callback" AS "status_callback_url",
        "sticky_sender",
        "synchronous_validation",
        "updated_at",
        "us_app_to_person_registered" AS "us_a2p_10dlc_registered",
        "use_inbound_webhook_on_number" AS "use_inbound_webhook",
        "usecase",
        "validity_period" AS "validity_period_seconds"
    FROM "twilio_messaging_service_data_projected"
),

"twilio_messaging_service_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- fallback_url: from DECIMAL to VARCHAR
    -- inbound_request_url: from DECIMAL to VARCHAR
    -- status_callback_url: from DECIMAL to VARCHAR
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "service_id",
        "is_deleted",
        "account_id",
        "area_code_geomatch",
        "fallback_http_method",
        "fallback_to_long_code",
        "service_name",
        "inbound_http_method",
        "mms_converter",
        "scan_message_content",
        "smart_encoding",
        "sticky_sender",
        "synchronous_validation",
        "us_a2p_10dlc_registered",
        "use_inbound_webhook",
        "usecase",
        "validity_period_seconds",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("fallback_url" AS VARCHAR) AS "fallback_url",
        CAST("inbound_request_url" AS VARCHAR) AS "inbound_request_url",
        CAST("status_callback_url" AS VARCHAR) AS "status_callback_url",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "twilio_messaging_service_data_projected_renamed"
),

"twilio_messaging_service_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- inbound_request_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- status_callback_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "service_id",
        "is_deleted",
        "account_id",
        "area_code_geomatch",
        "fallback_http_method",
        "fallback_to_long_code",
        "service_name",
        "inbound_http_method",
        "mms_converter",
        "scan_message_content",
        "smart_encoding",
        "sticky_sender",
        "synchronous_validation",
        "us_a2p_10dlc_registered",
        "use_inbound_webhook",
        "usecase",
        "validity_period_seconds",
        "created_at",
        "fallback_url",
        "updated_at"
    FROM "twilio_messaging_service_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_messaging_service_data_projected_renamed_casted_missing_handled"