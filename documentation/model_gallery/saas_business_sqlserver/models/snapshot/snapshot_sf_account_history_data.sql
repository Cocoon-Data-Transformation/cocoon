-- Slowly Changing Dimension: Dimension keys are "record_id"
-- Version columns are valid_from, valid_to
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "account_type_encrypted",
    "billing_street",
    "industry",
    "shipping_country",
    "record_type_id",
    "record_id",
    "master_record_id",
    "account_source",
    "description",
    "website_encrypted",
    "owner_id",
    "billing_city",
    "billing_state",
    "billing_country",
    "billing_postal_code",
    "account_name",
    "account_number",
    "account_rating",
    "annual_revenue",
    "employee_count",
    "is_active",
    "is_deleted",
    "last_activity_date",
    "last_referenced_date",
    "last_viewed_date",
    "ownership_type",
    "parent_account_id",
    "shipping_city",
    "shipping_postal_code",
    "shipping_state",
    "shipping_street"
FROM "stg_sf_account_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "record_id"
    ORDER BY
        CAST(valid_from AS DATE) DESC,
        CASE WHEN valid_to IS NULL THEN 1 ELSE 0 END DESC,
        CAST(valid_to AS DATE) DESC
) = 1