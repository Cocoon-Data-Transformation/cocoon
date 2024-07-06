-- Slowly Changing Dimension: Dimension keys are "caller_id_sid"
-- Effective date columns are "last_updated_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "caller_id_sid",
    "display_name",
    "encrypted_phone_number",
    "creation_timestamp"
FROM (
     SELECT 
            "caller_id_sid",
            "display_name",
            "encrypted_phone_number",
            "creation_timestamp",
            ROW_NUMBER() OVER (
                PARTITION BY "caller_id_sid" 
                ORDER BY "last_updated_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_twilio_outgoing_caller_id_data"
) ranked
WHERE "cocoon_rn" = 1