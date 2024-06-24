-- Slowly Changing Dimension: Dimension keys are "ad_creative_id"
-- Effective date columns are "fivetran_sync_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "facebook_page_url",
    "ad_creative_name",
    "link_caption",
    "link_description",
    "link_url",
    "link_message",
    "fivetran_unique_id",
    "ad_creative_id",
    "asset_feed_link_specs",
    "facebook_account_id",
    "ios_app_link_specs",
    "link_child_attachments",
    "tracking_url_parameters"
FROM (
     SELECT 
            "facebook_page_url",
            "ad_creative_name",
            "link_caption",
            "link_description",
            "link_url",
            "link_message",
            "fivetran_unique_id",
            "ad_creative_id",
            "asset_feed_link_specs",
            "facebook_account_id",
            "ios_app_link_specs",
            "link_child_attachments",
            "tracking_url_parameters",
            ROW_NUMBER() OVER (
                PARTITION BY "ad_creative_id" 
                ORDER BY "fivetran_sync_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_facebook_ads_creative_history_data"
) ranked
WHERE "cocoon_rn" = 1