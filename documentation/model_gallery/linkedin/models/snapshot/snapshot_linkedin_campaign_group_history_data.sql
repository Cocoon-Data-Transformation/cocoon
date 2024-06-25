-- Slowly Changing Dimension: Dimension keys are "campaign_group_id"
-- Effective date columns are "last_modified_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "encrypted_group_name",
    "account_id",
    "campaign_group_id",
    "creation_timestamp"
FROM (
     SELECT 
            "encrypted_group_name",
            "account_id",
            "campaign_group_id",
            "creation_timestamp",
            ROW_NUMBER() OVER (
                PARTITION BY "campaign_group_id" 
                ORDER BY "last_modified_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_linkedin_campaign_group_history_data"
) ranked
WHERE "cocoon_rn" = 1