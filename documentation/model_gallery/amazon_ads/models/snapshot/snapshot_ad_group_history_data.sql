-- Slowly Changing Dimension: Dimension keys are "ad_group_id"
-- Effective date columns are "last_updated_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "ad_group_id",
    "campaign_id",
    "default_bid",
    "ad_group_name",
    "serving_status",
    "ad_group_state",
    "creation_date"
FROM (
     SELECT 
            "ad_group_id",
            "campaign_id",
            "default_bid",
            "ad_group_name",
            "serving_status",
            "ad_group_state",
            "creation_date",
            ROW_NUMBER() OVER (
                PARTITION BY "ad_group_id" 
                ORDER BY "last_updated_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_ad_group_history_data"
) ranked
WHERE "cocoon_rn" = 1