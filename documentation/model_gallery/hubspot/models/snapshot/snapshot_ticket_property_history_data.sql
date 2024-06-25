-- Slowly Changing Dimension: Dimension keys are "ticket_id", "property_name"
-- Effective date columns are "valid_until"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "property_name",
    "property_value",
    "value_source",
    "is_active",
    "recorded_at",
    "ticket_id",
    "valid_from"
FROM (
     SELECT 
            "property_name",
            "property_value",
            "value_source",
            "is_active",
            "recorded_at",
            "ticket_id",
            "valid_from",
            ROW_NUMBER() OVER (
                PARTITION BY "ticket_id", "property_name" 
                ORDER BY "valid_until" 
            DESC) AS "cocoon_rn"
    FROM "stg_ticket_property_history_data"
) ranked
WHERE "cocoon_rn" = 1