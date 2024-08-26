-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 15:59:02.558135+00:00
WITH 
"facebook_ads_creative_history_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['page_link', 'template_page_link', 'id', 'account_id', 'name', 'url_tags', '_fivetran_synced', 'asset_feed_spec_link_urls', 'object_story_link_data_child_attachments', 'object_story_link_data_caption', 'object_story_link_data_description', 'object_story_link_data_link', 'object_story_link_data_message', 'template_app_link_spec_ios', '_fivetran_id']
    SELECT 
        "page_link",
        "template_page_link",
        "id",
        "account_id",
        "name",
        "url_tags",
        "asset_feed_spec_link_urls",
        "object_story_link_data_child_attachments",
        "object_story_link_data_caption",
        "object_story_link_data_description",
        "object_story_link_data_link",
        "object_story_link_data_message",
        "template_app_link_spec_ios",
        "_fivetran_id"
    FROM "memory"."main"."facebook_ads_creative_history_data"
),

"facebook_ads_creative_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- page_link -> landing_page_url
    -- id -> creative_id
    -- name -> encoded_ad_name
    -- url_tags -> utm_parameters
    -- asset_feed_spec_link_urls -> asset_feed_specs
    -- object_story_link_data_child_attachments -> ad_attachments
    -- object_story_link_data_caption -> ad_caption
    -- object_story_link_data_description -> ad_description
    -- object_story_link_data_link -> ad_link
    -- object_story_link_data_message -> ad_message
    -- template_app_link_spec_ios -> ios_app_link_specs
    -- _fivetran_id -> fivetran_id
    SELECT 
        "page_link" AS "landing_page_url",
        "template_page_link",
        "id" AS "creative_id",
        "account_id",
        "name" AS "encoded_ad_name",
        "url_tags" AS "utm_parameters",
        "asset_feed_spec_link_urls" AS "asset_feed_specs",
        "object_story_link_data_child_attachments" AS "ad_attachments",
        "object_story_link_data_caption" AS "ad_caption",
        "object_story_link_data_description" AS "ad_description",
        "object_story_link_data_link" AS "ad_link",
        "object_story_link_data_message" AS "ad_message",
        "template_app_link_spec_ios" AS "ios_app_link_specs",
        "_fivetran_id" AS "fivetran_id"
    FROM "facebook_ads_creative_history_data_projected"
),

"facebook_ads_creative_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from DECIMAL to VARCHAR
    -- ad_attachments: from VARCHAR to JSON
    -- asset_feed_specs: from VARCHAR to JSON
    -- creative_id: from INT to VARCHAR
    -- ios_app_link_specs: from VARCHAR to JSON
    -- template_page_link: from DECIMAL to VARCHAR
    -- utm_parameters: from VARCHAR to JSON
    SELECT
        "landing_page_url",
        "encoded_ad_name",
        "ad_caption",
        "ad_description",
        "ad_link",
        "ad_message",
        "fivetran_id",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("ad_attachments" AS JSON) 
        AS "ad_attachments",
        CAST("asset_feed_specs" AS JSON) 
        AS "asset_feed_specs",
        CAST("creative_id" AS VARCHAR) 
        AS "creative_id",
        CAST("ios_app_link_specs" AS JSON) 
        AS "ios_app_link_specs",
        CAST("template_page_link" AS VARCHAR) 
        AS "template_page_link",
        CAST("utm_parameters" AS JSON) 
        AS "utm_parameters"
    FROM "facebook_ads_creative_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "facebook_ads_creative_history_data_projected_renamed_casted"