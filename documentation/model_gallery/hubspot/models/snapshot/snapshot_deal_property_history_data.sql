-- Slowly Changing Dimension: Dimension keys are "deal_id", "property_name"
-- Effective date columns are "change_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "deal_id",
    "source",
    "property_name",
    "source_id",
    "new_value",
    "deal_id",
    "source",
    "property_name",
    "source_id",
    "new_value"
FROM (
     SELECT 
            "deal_id",
            "source",
            "property_name",
            "source_id",
            "new_value",
            "deal_id",
            "source",
            "property_name",
            "source_id",
            "new_value",
            ROW_NUMBER() OVER (
                PARTITION BY "deal_id", "property_name" 
                ORDER BY "change_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_deal_property_history_data"
) ranked
WHERE "cocoon_rn" = 1