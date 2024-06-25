-- Slowly Changing Dimension: Dimension keys are "ad_group_id"
-- Effective date columns are "end_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "ad_group_name",
    "ad_group_status",
    "pacing_delivery_type",
    "placement_group",
    "summary_status",
    "ad_account_id",
    "ad_group_id",
    "campaign_id",
    "creation_timestamp",
    "start_timestamp"
FROM (
     SELECT 
            "ad_group_name",
            "ad_group_status",
            "pacing_delivery_type",
            "placement_group",
            "summary_status",
            "ad_account_id",
            "ad_group_id",
            "campaign_id",
            "creation_timestamp",
            "start_timestamp",
            ROW_NUMBER() OVER (
                PARTITION BY "ad_group_id" 
                ORDER BY "end_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_pinterest_ad_group_history_data"
) ranked
WHERE "cocoon_rn" = 1