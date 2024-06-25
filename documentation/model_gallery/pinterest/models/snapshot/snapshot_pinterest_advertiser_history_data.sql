-- Slowly Changing Dimension: Dimension keys are "advertiser_id"
-- Effective date columns are "last_updated_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "payment_method",
    "billing_status",
    "account_status",
    "country",
    "account_currency",
    "account_name",
    "account_creation_date",
    "advertiser_id",
    "merchant_id",
    "owner_id"
FROM (
     SELECT 
            "payment_method",
            "billing_status",
            "account_status",
            "country",
            "account_currency",
            "account_name",
            "account_creation_date",
            "advertiser_id",
            "merchant_id",
            "owner_id",
            ROW_NUMBER() OVER (
                PARTITION BY "advertiser_id" 
                ORDER BY "last_updated_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_pinterest_advertiser_history_data"
) ranked
WHERE "cocoon_rn" = 1