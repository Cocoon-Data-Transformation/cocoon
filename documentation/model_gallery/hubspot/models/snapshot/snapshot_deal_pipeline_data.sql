-- Slowly Changing Dimension: Dimension keys are "pipeline_id"
-- Effective date columns are "updated_at"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "pipeline_id",
    "is_deleted",
    "is_active",
    "display_order",
    "encrypted_label",
    "created_at"
FROM (
     SELECT 
            "pipeline_id",
            "is_deleted",
            "is_active",
            "display_order",
            "encrypted_label",
            "created_at",
            ROW_NUMBER() OVER (
                PARTITION BY "pipeline_id" 
                ORDER BY "updated_at" 
            DESC) AS "cocoon_rn"
    FROM "stg_deal_pipeline_data"
) ranked
WHERE "cocoon_rn" = 1