-- Slowly Changing Dimension: Dimension keys are "account_id"
-- Effective date columns are "last_update_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "account_id",
    "account_display_name",
    "parent_account_id",
    "account_status",
    "account_type",
    "account_creation_date"
FROM (
     SELECT 
            "account_id",
            "account_display_name",
            "parent_account_id",
            "account_status",
            "account_type",
            "account_creation_date",
            ROW_NUMBER() OVER (
                PARTITION BY "account_id" 
                ORDER BY "last_update_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_twilio_account_history_data"
) ranked
WHERE "cocoon_rn" = 1