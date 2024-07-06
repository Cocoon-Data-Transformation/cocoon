-- Slowly Changing Dimension: Dimension keys are "ticket_id", "changed_field"
-- Effective date columns are "update_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "changed_field",
    "ticket_id",
    "new_value"
FROM (
     SELECT 
            "changed_field",
            "ticket_id",
            "new_value",
            ROW_NUMBER() OVER (
                PARTITION BY "ticket_id", "changed_field" 
                ORDER BY "update_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_ticket_field_history_data"
) ranked
WHERE "cocoon_rn" = 1