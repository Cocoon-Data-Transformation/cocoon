-- Slowly Changing Dimension: Dimension keys are "form_id"
-- Effective date columns are "updated_at"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "form_id",
    "is_deleted",
    "is_active",
    "form_identifier",
    "is_visible_to_end_user",
    "form_name",
    "created_at"
FROM (
     SELECT 
            "form_id",
            "is_deleted",
            "is_active",
            "form_identifier",
            "is_visible_to_end_user",
            "form_name",
            "created_at",
            ROW_NUMBER() OVER (
                PARTITION BY "form_id" 
                ORDER BY "updated_at" 
            DESC) AS "cocoon_rn"
    FROM "stg_ticket_form_history_data"
) ranked
WHERE "cocoon_rn" = 1