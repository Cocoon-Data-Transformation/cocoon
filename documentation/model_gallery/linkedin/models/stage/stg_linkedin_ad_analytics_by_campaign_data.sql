-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"linkedin_ad_analytics_by_campaign_data_removeWideColumns" AS (
    -- Remove wide columns with pattern. The regex and columns are:
    -- ^viral_.*$: viral_card_clicks, viral_card_impressions, viral_clicks, viral_comment_likes, viral_comments, viral_company_page_clicks, viral_external_website_conversions, viral_external_website_post_click_conversions, viral_external_website_post_view_conversions, viral_follows ...
    -- ^video_.*completions$: video_completions, video_first_quartile_completions, video_midpoint_completions, video_third_quartile_completions
    -- ^external_website_.*conversions$: external_website_conversions, external_website_post_click_conversions, external_website_post_view_conversions
    SELECT 
        "action_clicks",
        "ad_unit_clicks",
        "approximate_unique_impressions",
        "campaign_id",
        "card_clicks",
        "card_impressions",
        "clicks",
        "comment_likes",
        "comments",
        "company_page_clicks",
        "conversion_value_in_local_currency",
        "cost_in_local_currency",
        "cost_in_usd",
        "day_",
        "follows",
        "full_screen_plays",
        "impressions",
        "landing_page_clicks",
        "lead_generation_mail_contact_info_shares",
        "lead_generation_mail_interested_clicks",
        "likes",
        "one_click_lead_form_opens",
        "one_click_leads",
        "opens",
        "other_engagements",
        "shares",
        "text_url_clicks",
        "total_engagements",
        "video_starts",
        "video_views"
    FROM "linkedin_ad_analytics_by_campaign_data"
),

"linkedin_ad_analytics_by_campaign_data_removeWideColumns_renamed" AS (
    -- Rename: Renaming columns
    -- action_clicks -> action_button_clicks
    -- approximate_unique_impressions -> unique_impressions
    -- clicks -> total_clicks
    -- conversion_value_in_local_currency -> conversion_value_local
    -- cost_in_local_currency -> cost_local
    -- cost_in_usd -> cost_usd
    -- day_ -> date_
    -- impressions -> total_impressions
    -- lead_generation_mail_contact_info_shares -> lead_gen_mail_shares
    -- lead_generation_mail_interested_clicks -> lead_gen_mail_clicks
    -- one_click_lead_form_opens -> one_click_form_opens
    -- opens -> ad_opens
    SELECT 
        "action_clicks" AS "action_button_clicks",
        "ad_unit_clicks",
        "approximate_unique_impressions" AS "unique_impressions",
        "campaign_id",
        "card_clicks",
        "card_impressions",
        "clicks" AS "total_clicks",
        "comment_likes",
        "comments",
        "company_page_clicks",
        "conversion_value_in_local_currency" AS "conversion_value_local",
        "cost_in_local_currency" AS "cost_local",
        "cost_in_usd" AS "cost_usd",
        "day_" AS "date_",
        "follows",
        "full_screen_plays",
        "impressions" AS "total_impressions",
        "landing_page_clicks",
        "lead_generation_mail_contact_info_shares" AS "lead_gen_mail_shares",
        "lead_generation_mail_interested_clicks" AS "lead_gen_mail_clicks",
        "likes",
        "one_click_lead_form_opens" AS "one_click_form_opens",
        "one_click_leads",
        "opens" AS "ad_opens",
        "other_engagements",
        "shares",
        "text_url_clicks",
        "total_engagements",
        "video_starts",
        "video_views"
    FROM "linkedin_ad_analytics_by_campaign_data_removeWideColumns"
),

"linkedin_ad_analytics_by_campaign_data_removeWideColumns_renamed_casted" AS (
    -- Column Type Casting: 
    -- ad_unit_clicks: from DECIMAL to VARCHAR
    -- card_clicks: from DECIMAL to VARCHAR
    -- comments: from DECIMAL to VARCHAR
    -- company_page_clicks: from DECIMAL to VARCHAR
    -- date_: from VARCHAR to TIMESTAMP
    -- follows: from DECIMAL to VARCHAR
    -- full_screen_plays: from DECIMAL to VARCHAR
    -- likes: from DECIMAL to VARCHAR
    -- one_click_leads: from DECIMAL to VARCHAR
    -- text_url_clicks: from DECIMAL to VARCHAR
    -- video_starts: from DECIMAL to VARCHAR
    SELECT
        "action_button_clicks",
        "unique_impressions",
        "campaign_id",
        "card_impressions",
        "total_clicks",
        "comment_likes",
        "conversion_value_local",
        "cost_local",
        "cost_usd",
        "total_impressions",
        "landing_page_clicks",
        "lead_gen_mail_shares",
        "lead_gen_mail_clicks",
        "one_click_form_opens",
        "ad_opens",
        "other_engagements",
        "shares",
        "total_engagements",
        "video_views",
        CAST("ad_unit_clicks" AS VARCHAR) AS "ad_unit_clicks",
        CAST("card_clicks" AS VARCHAR) AS "card_clicks",
        CAST("comments" AS VARCHAR) AS "comments",
        CAST("company_page_clicks" AS VARCHAR) AS "company_page_clicks",
        CAST("date_" AS TIMESTAMP) AS "date_",
        CAST("follows" AS VARCHAR) AS "follows",
        CAST("full_screen_plays" AS VARCHAR) AS "full_screen_plays",
        CAST("likes" AS VARCHAR) AS "likes",
        CAST("one_click_leads" AS VARCHAR) AS "one_click_leads",
        CAST("text_url_clicks" AS VARCHAR) AS "text_url_clicks",
        CAST("video_starts" AS VARCHAR) AS "video_starts"
    FROM "linkedin_ad_analytics_by_campaign_data_removeWideColumns_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "linkedin_ad_analytics_by_campaign_data_removeWideColumns_renamed_casted"