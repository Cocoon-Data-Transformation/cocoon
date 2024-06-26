-- Slowly Changing Dimension: Dimension keys are "call_center_id"
-- Effective date columns are "record_end_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "call_center_name",
    "suite_number",
    "street_name",
    "street_type",
    "size_class",
    "open_date_key",
    "company_id",
    "state",
    "manager_name",
    "square_footage",
    "call_center_surrogate_key",
    "operating_hours",
    "division_name",
    "county",
    "market_manager_name",
    "company_name",
    "employee_count",
    "city",
    "country",
    "market_id",
    "division_id",
    "tax_percentage",
    "call_center_id",
    "call_center_zip_code",
    "closed_date_key",
    "gmt_offset",
    "record_start_date",
    "street_number"
FROM (
     SELECT 
            "call_center_name",
            "suite_number",
            "street_name",
            "street_type",
            "size_class",
            "open_date_key",
            "company_id",
            "state",
            "manager_name",
            "square_footage",
            "call_center_surrogate_key",
            "operating_hours",
            "division_name",
            "county",
            "market_manager_name",
            "company_name",
            "employee_count",
            "city",
            "country",
            "market_id",
            "division_id",
            "tax_percentage",
            "call_center_id",
            "call_center_zip_code",
            "closed_date_key",
            "gmt_offset",
            "record_start_date",
            "street_number",
            ROW_NUMBER() OVER (
                PARTITION BY "call_center_id" 
                ORDER BY "record_end_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_call_center"
) ranked
WHERE "cocoon_rn" = 1