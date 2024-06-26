-- Slowly Changing Dimension: Dimension keys are "store_id"
-- Effective date columns are "record_end_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "store_id",
    "store_surrogate_key",
    "store_floor_space",
    "company_id",
    "store_country",
    "store_state",
    "store_street_type",
    "store_hours",
    "store_county",
    "market_manager",
    "store_gmt_offset",
    "store_city",
    "store_tax_percentage",
    "employee_count",
    "store_suite_number",
    "store_street_name",
    "store_manager",
    "market_id",
    "division_id",
    "record_start_date",
    "store_close_date",
    "store_street_number",
    "store_zip_code"
FROM (
     SELECT 
            "store_id",
            "store_surrogate_key",
            "store_floor_space",
            "company_id",
            "store_country",
            "store_state",
            "store_street_type",
            "store_hours",
            "store_county",
            "market_manager",
            "store_gmt_offset",
            "store_city",
            "store_tax_percentage",
            "employee_count",
            "store_suite_number",
            "store_street_name",
            "store_manager",
            "market_id",
            "division_id",
            "record_start_date",
            "store_close_date",
            "store_street_number",
            "store_zip_code",
            ROW_NUMBER() OVER (
                PARTITION BY "store_id" 
                ORDER BY "record_end_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_store"
) ranked
WHERE "cocoon_rn" = 1