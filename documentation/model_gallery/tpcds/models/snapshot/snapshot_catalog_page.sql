-- Slowly Changing Dimension: Dimension keys are "page_id"
-- Effective date columns are "end_date_key"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "page_surrogate_key",
    "page_id",
    "start_date_key",
    "department",
    "catalog_id",
    "page_number",
    "catalog_type",
    "page_description"
FROM (
     SELECT 
            "page_surrogate_key",
            "page_id",
            "start_date_key",
            "department",
            "catalog_id",
            "page_number",
            "catalog_type",
            "page_description",
            ROW_NUMBER() OVER (
                PARTITION BY "page_id" 
                ORDER BY "end_date_key" 
            DESC) AS "cocoon_rn"
    FROM "stg_catalog_page"
) ranked
WHERE "cocoon_rn" = 1