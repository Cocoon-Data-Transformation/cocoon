-- Slowly Changing Dimension: Dimension keys are "creative_id"
-- Effective date columns are "last_modified_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "creative_id",
    "campaign_id",
    "content_status",
    "click_through_url",
    "creation_timestamp"
FROM (
     SELECT 
            "creative_id",
            "campaign_id",
            "content_status",
            "click_through_url",
            "creation_timestamp",
            ROW_NUMBER() OVER (
                PARTITION BY "creative_id" 
                ORDER BY "last_modified_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_linkedin_creative_history_data"
) ranked
WHERE "cocoon_rn" = 1