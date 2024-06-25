-- Slowly Changing Dimension: Dimension keys are "account_id"
-- Effective date columns are "last_update_time"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "account_id",
    "encrypted_account_name",
    "account_currency",
    "revision_number",
    "account_creation_time"
FROM (
     SELECT 
            "account_id",
            "encrypted_account_name",
            "account_currency",
            "revision_number",
            "account_creation_time",
            ROW_NUMBER() OVER (
                PARTITION BY "account_id" 
                ORDER BY "last_update_time" 
            DESC) AS "cocoon_rn"
    FROM "stg_linkedin_account_history_data"
) ranked
WHERE "cocoon_rn" = 1