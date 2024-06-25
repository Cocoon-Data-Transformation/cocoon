-- Slowly Changing Dimension: Dimension keys are "company_id", "property_name"
-- Effective date columns are "update_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "data_source",
    "property_name",
    "property_value",
    "company_id",
    "source_id"
FROM (
     SELECT 
            "data_source",
            "property_name",
            "property_value",
            "company_id",
            "source_id",
            ROW_NUMBER() OVER (
                PARTITION BY "company_id", "property_name" 
                ORDER BY "update_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_company_property_history_data"
) ranked
WHERE "cocoon_rn" = 1