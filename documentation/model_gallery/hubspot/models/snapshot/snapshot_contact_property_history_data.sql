-- Slowly Changing Dimension: Dimension keys are "contact_id", "property_name"
-- Effective date columns are "change_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "contact_id",
    "source",
    "property_name",
    "property_value",
    "source_id"
FROM (
     SELECT 
            "contact_id",
            "source",
            "property_name",
            "property_value",
            "source_id",
            ROW_NUMBER() OVER (
                PARTITION BY "contact_id", "property_name" 
                ORDER BY "change_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_contact_property_history_data"
) ranked
WHERE "cocoon_rn" = 1