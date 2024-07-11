-- Slowly Changing Dimension: Dimension keys are "record_id"
-- Effective date columns are "valid_from", "valid_until"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "account_name",
    "shipping_country",
    "account_source",
    "record_id",
    "is_deleted",
    "record_type_id",
    "industry",
    "master_record_id",
    "encrypted_website",
    "owner_id",
    "billing_street",
    "description",
    "billing_postal_code",
    "encrypted_account_type",
    "is_active",
    "employee_count",
    "parent_account_id",
    "shipping_city",
    "shipping_postal_code",
    "shipping_state",
    "shipping_street"
FROM (
     SELECT 
            "account_name",
            "shipping_country",
            "account_source",
            "record_id",
            "is_deleted",
            "record_type_id",
            "industry",
            "master_record_id",
            "encrypted_website",
            "owner_id",
            "billing_street",
            "description",
            "billing_postal_code",
            "encrypted_account_type",
            "is_active",
            "employee_count",
            "parent_account_id",
            "shipping_city",
            "shipping_postal_code",
            "shipping_state",
            "shipping_street",
            ROW_NUMBER() OVER (
                PARTITION BY "record_id" 
                ORDER BY "valid_from", "valid_until" 
            DESC) AS "cocoon_rn"
    FROM "stg_sf_account_history_data"
) ranked
WHERE "cocoon_rn" = 1