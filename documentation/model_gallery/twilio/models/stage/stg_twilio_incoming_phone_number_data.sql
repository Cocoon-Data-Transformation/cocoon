-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:36:33.248319+00:00
WITH 
"twilio_incoming_phone_number_data_projected" AS (
    -- Projection: Selecting 18 out of 19 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "account_id",
        "address_id",
        "address_requirements",
        "beta",
        "capabilities_mms",
        "capabilities_sms",
        "capabilities_voice",
        "created_at",
        "emergency_address_id",
        "emergency_status",
        "friendly_name",
        "origin",
        "phone_number",
        "trunk_id",
        "updated_at",
        "voice_caller_id_lookup",
        "voice_url"
    FROM "memory"."main"."twilio_incoming_phone_number_data"
),

"twilio_incoming_phone_number_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> phone_number_id
    -- beta -> is_beta
    -- capabilities_mms -> supports_mms
    -- capabilities_sms -> supports_sms
    -- capabilities_voice -> supports_voice
    -- created_at -> creation_timestamp
    -- updated_at -> last_updated_timestamp
    -- voice_caller_id_lookup -> caller_id_lookup_enabled
    -- voice_url -> voice_handler_url
    SELECT 
        "id" AS "phone_number_id",
        "account_id",
        "address_id",
        "address_requirements",
        "beta" AS "is_beta",
        "capabilities_mms" AS "supports_mms",
        "capabilities_sms" AS "supports_sms",
        "capabilities_voice" AS "supports_voice",
        "created_at" AS "creation_timestamp",
        "emergency_address_id",
        "emergency_status",
        "friendly_name",
        "origin",
        "phone_number",
        "trunk_id",
        "updated_at" AS "last_updated_timestamp",
        "voice_caller_id_lookup" AS "caller_id_lookup_enabled",
        "voice_url" AS "voice_handler_url"
    FROM "twilio_incoming_phone_number_data_projected"
),

"twilio_incoming_phone_number_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- friendly_name: The problem is that the 'friendly_name' column contains a phone number format '(555) 555-5555' instead of actual friendly names. This appears to be placeholder data rather than genuine friendly names. Typically, a 'friendly_name' field would contain human-readable names or identifiers, not phone numbers. The correct values should be actual names or meaningful identifiers for the entities represented in this dataset. 
    SELECT
        "phone_number_id",
        "account_id",
        "address_id",
        "address_requirements",
        "is_beta",
        "supports_mms",
        "supports_sms",
        "supports_voice",
        "creation_timestamp",
        "emergency_address_id",
        "emergency_status",
        CASE
            WHEN "friendly_name" = '''(555) 555-5555''' THEN ''''
            ELSE "friendly_name"
        END AS "friendly_name",
        "origin",
        "phone_number",
        "trunk_id",
        "last_updated_timestamp",
        "caller_id_lookup_enabled",
        "voice_handler_url"
    FROM "twilio_incoming_phone_number_data_projected_renamed"
),

"twilio_incoming_phone_number_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- address_id: from DECIMAL to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- emergency_address_id: from DECIMAL to VARCHAR
    -- last_updated_timestamp: from VARCHAR to TIMESTAMP
    -- phone_number: from INT to VARCHAR
    -- trunk_id: from DECIMAL to VARCHAR
    SELECT
        "phone_number_id",
        "account_id",
        "address_requirements",
        "is_beta",
        "supports_mms",
        "supports_sms",
        "supports_voice",
        "emergency_status",
        "friendly_name",
        "origin",
        "caller_id_lookup_enabled",
        "voice_handler_url",
        CAST("address_id" AS VARCHAR) AS "address_id",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("emergency_address_id" AS VARCHAR) AS "emergency_address_id",
        CAST("last_updated_timestamp" AS TIMESTAMP) AS "last_updated_timestamp",
        CAST("phone_number" AS VARCHAR) AS "phone_number",
        CAST("trunk_id" AS VARCHAR) AS "trunk_id"
    FROM "twilio_incoming_phone_number_data_projected_renamed_cleaned"
),

"twilio_incoming_phone_number_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- address_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- emergency_address_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "phone_number_id",
        "account_id",
        "address_requirements",
        "is_beta",
        "supports_mms",
        "supports_sms",
        "supports_voice",
        "emergency_status",
        "friendly_name",
        "origin",
        "caller_id_lookup_enabled",
        "voice_handler_url",
        "creation_timestamp",
        "last_updated_timestamp",
        "phone_number",
        "trunk_id"
    FROM "twilio_incoming_phone_number_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_incoming_phone_number_data_projected_renamed_cleaned_casted_missing_handled"