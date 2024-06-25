-- Slowly Changing Dimension: Dimension keys are "issue_id", "field_id"
-- Effective date columns are "change_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "record_id",
    "field_id",
    "issue_id",
    "new_field_value"
FROM (
     SELECT 
            "record_id",
            "field_id",
            "issue_id",
            "new_field_value",
            ROW_NUMBER() OVER (
                PARTITION BY "issue_id", "field_id" 
                ORDER BY "change_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_issue_multiselect_history"
) ranked
WHERE "cocoon_rn" = 1