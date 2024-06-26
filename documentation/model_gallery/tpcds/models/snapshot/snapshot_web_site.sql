-- Slowly Changing Dimension: Dimension keys are "website_id"
-- Effective date columns are "record_end_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "gmt_offset",
    "suite_number",
    "website_id",
    "street_name",
    "street_type",
    "company_id",
    "web_state",
    "market_manager",
    "web_country",
    "site_manager",
    "website_name",
    "web_county",
    "website_surrogate_key",
    "web_city",
    "market_id",
    "web_classification",
    "tax_percentage",
    "record_start_date",
    "street_number",
    "web_close_date",
    "web_open_date",
    "zip_code"
FROM (
     SELECT 
            "gmt_offset",
            "suite_number",
            "website_id",
            "street_name",
            "street_type",
            "company_id",
            "web_state",
            "market_manager",
            "web_country",
            "site_manager",
            "website_name",
            "web_county",
            "website_surrogate_key",
            "web_city",
            "market_id",
            "web_classification",
            "tax_percentage",
            "record_start_date",
            "street_number",
            "web_close_date",
            "web_open_date",
            "zip_code",
            ROW_NUMBER() OVER (
                PARTITION BY "website_id" 
                ORDER BY "record_end_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_web_site"
) ranked
WHERE "cocoon_rn" = 1