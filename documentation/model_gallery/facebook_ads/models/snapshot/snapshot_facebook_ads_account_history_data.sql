-- Slowly Changing Dimension: Dimension keys are "account_id"
-- Effective date columns are "update_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "encrypted_account_name",
    "account_status",
    "country_code",
    "account_currency",
    "account_timezone",
    "account_id"
FROM (
     SELECT 
            "encrypted_account_name",
            "account_status",
            "country_code",
            "account_currency",
            "account_timezone",
            "account_id",
            ROW_NUMBER() OVER (
                PARTITION BY "account_id" 
                ORDER BY "update_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_facebook_ads_account_history_data"
) ranked
WHERE "cocoon_rn" = 1