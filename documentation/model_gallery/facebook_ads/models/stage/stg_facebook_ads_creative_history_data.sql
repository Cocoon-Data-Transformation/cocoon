-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"facebook_ads_creative_history_data_renamed" AS (
    -- Rename: Renaming columns
    -- page_link -> facebook_page_url
    -- template_page_link -> page_link_template
    -- id -> ad_creative_id
    -- account_id -> facebook_account_id
    -- name -> ad_creative_name
    -- url_tags -> tracking_url_parameters
    -- _fivetran_synced -> fivetran_sync_timestamp
    -- asset_feed_spec_link_urls -> asset_feed_link_specs
    -- object_story_link_data_child_attachments -> link_child_attachments
    -- object_story_link_data_caption -> link_caption
    -- object_story_link_data_description -> link_description
    -- object_story_link_data_link -> link_url
    -- object_story_link_data_message -> link_message
    -- template_app_link_spec_ios -> ios_app_link_specs
    -- _fivetran_id -> fivetran_unique_id
    SELECT 
        page_link AS facebook_page_url,
        template_page_link AS page_link_template,
        id AS ad_creative_id,
        account_id AS facebook_account_id,
        name AS ad_creative_name,
        url_tags AS tracking_url_parameters,
        _fivetran_synced AS fivetran_sync_timestamp,
        asset_feed_spec_link_urls AS asset_feed_link_specs,
        object_story_link_data_child_attachments AS link_child_attachments,
        object_story_link_data_caption AS link_caption,
        object_story_link_data_description AS link_description,
        object_story_link_data_link AS link_url,
        object_story_link_data_message AS link_message,
        template_app_link_spec_ios AS ios_app_link_specs,
        _fivetran_id AS fivetran_unique_id
    FROM facebook_ads_creative_history_data
),

"facebook_ads_creative_history_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- ad_creative_id: from INT to VARCHAR
    -- asset_feed_link_specs: from VARCHAR to ARRAY
    -- facebook_account_id: from DECIMAL to VARCHAR
    -- fivetran_sync_timestamp: from VARCHAR to TIMESTAMP
    -- ios_app_link_specs: from VARCHAR to ARRAY
    -- link_child_attachments: from VARCHAR to ARRAY
    -- page_link_template: from DECIMAL to VARCHAR
    -- tracking_url_parameters: from VARCHAR to ARRAY
    SELECT
        "facebook_page_url",
        "ad_creative_name",
        "link_caption",
        "link_description",
        "link_url",
        "link_message",
        "fivetran_unique_id",
        CAST("ad_creative_id" AS VARCHAR) AS "ad_creative_id",
        from_json("asset_feed_link_specs", '[{"website_url": "VARCHAR", "display_url": "VARCHAR"}]') AS "asset_feed_link_specs",
        CAST("facebook_account_id" AS VARCHAR) AS "facebook_account_id",
        CASE
            WHEN regexp_full_match("fivetran_sync_timestamp", '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}') THEN CAST("fivetran_sync_timestamp" AS TIMESTAMP)
            WHEN regexp_full_match("fivetran_sync_timestamp", '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}') THEN CAST("fivetran_sync_timestamp" AS TIMESTAMP)
            ELSE "fivetran_sync_timestamp"
        END AS "fivetran_sync_timestamp",
        from_json("ios_app_link_specs", '["JSON"]') AS "ios_app_link_specs",
        from_json("link_child_attachments", '["JSON"]') AS "link_child_attachments",
        CAST("page_link_template" AS VARCHAR) AS "page_link_template",
        from_json("tracking_url_parameters", '[{"key": "VARCHAR", "value": "VARCHAR", "type": "VARCHAR"}]') AS "tracking_url_parameters"
    FROM "facebook_ads_creative_history_data_renamed"
),

"facebook_ads_creative_history_data_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- facebook_account_id has 100.0 percent missing. Strategy: 🔄 Unchanged
    -- page_link_template has 100.0 percent missing. Strategy: 🗑️ Drop Column
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
        "fivetran_sync_timestamp",
        "ios_app_link_specs",
        "link_child_attachments",
        "tracking_url_parameters"
    FROM "facebook_ads_creative_history_data_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "facebook_ads_creative_history_data_renamed_casted_missing_handled"