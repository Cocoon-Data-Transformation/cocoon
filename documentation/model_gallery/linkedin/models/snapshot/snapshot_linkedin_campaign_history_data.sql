-- Slowly Changing Dimension: Dimension keys are "campaign_id"
-- Effective date columns are "last_updated_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "encrypted_campaign_name",
    "campaign_version",
    "account_id",
    "campaign_group_id",
    "campaign_id",
    "creation_timestamp"
FROM (
     SELECT 
            "encrypted_campaign_name",
            "campaign_version",
            "account_id",
            "campaign_group_id",
            "campaign_id",
            "creation_timestamp",
            ROW_NUMBER() OVER (
                PARTITION BY "campaign_id" 
                ORDER BY "last_updated_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_linkedin_campaign_history_data"
) ranked
WHERE "cocoon_rn" = 1