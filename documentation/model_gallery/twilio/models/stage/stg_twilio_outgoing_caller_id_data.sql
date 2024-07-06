-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:41:41.817864+00:00
WITH 
"twilio_outgoing_caller_id_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_at",
        "friendly_name",
        "phone_number",
        "updated_at"
    FROM "memory"."main"."twilio_outgoing_caller_id_data"
),

"twilio_outgoing_caller_id_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> caller_id_sid
    -- created_at -> creation_timestamp
    -- friendly_name -> display_name
    -- phone_number -> encrypted_phone_number
    -- updated_at -> last_updated_timestamp
    SELECT 
        "id" AS "caller_id_sid",
        "created_at" AS "creation_timestamp",
        "friendly_name" AS "display_name",
        "phone_number" AS "encrypted_phone_number",
        "updated_at" AS "last_updated_timestamp"
    FROM "twilio_outgoing_caller_id_data_projected"
),

"twilio_outgoing_caller_id_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- caller_id_sid: The problem is that all values in the caller_id_sid column contain the substring 'ez' which appears to be an anomaly in the otherwise standard format of Twilio Phone Number SIDs. Twilio Phone Number SIDs typically follow the pattern 'PN' followed by 32 hexadecimal characters. The 'ez' substring is likely a typo or an error in the identifier generation process. The correct values should have this 'ez' substring removed to conform to the standard Twilio Phone Number SID format. 
    -- display_name: The problem is that the display_name column contains a phone number ('(555) 555-5555') instead of a name. This is unusual because the display_name field typically contains a person's name, not their contact information. Phone numbers should be stored in a separate column dedicated to contact information. The correct value for display_name should be a name or an empty string if the name is unknown. 
    SELECT
        CASE
            WHEN "caller_id_sid" = 'PN44c122e81553f4502ae1ed93bez832ed' THEN 'PN44c122e81553f4502ae1ed93b832ed'
            WHEN "caller_id_sid" = 'PN9964151032a6aeb47dc10d199eza8fcb' THEN 'PN9964151032a6aeb47dc10d199a8fcb'
            WHEN "caller_id_sid" = 'PNd7b72b5139b563564a37c3661ezea947' THEN 'PNd7b72b5139b563564a37c3661ea947'
            ELSE "caller_id_sid"
        END AS "caller_id_sid",
        "creation_timestamp",
        CASE
            WHEN "display_name" = '''(555) 555-5555''' THEN ''''
            ELSE "display_name"
        END AS "display_name",
        "encrypted_phone_number",
        "last_updated_timestamp"
    FROM "twilio_outgoing_caller_id_data_projected_renamed"
),

"twilio_outgoing_caller_id_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_updated_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "caller_id_sid",
        "display_name",
        "encrypted_phone_number",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("last_updated_timestamp" AS TIMESTAMP) AS "last_updated_timestamp"
    FROM "twilio_outgoing_caller_id_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_outgoing_caller_id_data_projected_renamed_cleaned_casted"