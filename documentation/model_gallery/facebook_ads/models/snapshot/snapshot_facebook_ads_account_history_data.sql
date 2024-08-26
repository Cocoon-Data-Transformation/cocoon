-- Slowly Changing Dimension: Dimension keys are "account_id"
-- Version columns are creation_timestamp
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "encrypted_account_name",
    "account_status",
    "country_code",
    "account_currency",
    "account_timezone",
    "account_id"
FROM "stg_facebook_ads_account_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "account_id"
    ORDER BY
        creation_timestamp DESC
) = 1