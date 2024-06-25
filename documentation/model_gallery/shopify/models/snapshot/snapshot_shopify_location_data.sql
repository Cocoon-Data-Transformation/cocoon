-- Slowly Changing Dimension: Dimension keys are "location_id"
-- Effective date columns are "last_update_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "is_deleted",
    "location_name",
    "is_active",
    "province_state",
    "is_legacy",
    "local_province_name",
    "country_name",
    "province_state_code",
    "primary_address",
    "iso_country_code",
    "location_id",
    "local_country_name",
    "country_code",
    "creation_timestamp",
    "postal_code",
    "secondary_address"
FROM (
     SELECT 
            "is_deleted",
            "location_name",
            "is_active",
            "province_state",
            "is_legacy",
            "local_province_name",
            "country_name",
            "province_state_code",
            "primary_address",
            "iso_country_code",
            "location_id",
            "local_country_name",
            "country_code",
            "creation_timestamp",
            "postal_code",
            "secondary_address",
            ROW_NUMBER() OVER (
                PARTITION BY "location_id" 
                ORDER BY "last_update_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_shopify_location_data"
) ranked
WHERE "cocoon_rn" = 1