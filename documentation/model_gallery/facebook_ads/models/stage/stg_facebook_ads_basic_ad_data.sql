-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 15:55:39.612740+00:00
WITH 
"facebook_ads_basic_ad_data_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> performance_date
    -- inline_link_clicks -> link_clicks
    -- spend -> ad_spend
    -- reach -> unique_reach
    -- frequency -> average_frequency
    SELECT 
        "ad_id",
        "ad_name",
        "adset_name",
        "date_" AS "performance_date",
        "account_id",
        "impressions",
        "inline_link_clicks" AS "link_clicks",
        "spend" AS "ad_spend",
        "reach" AS "unique_reach",
        "frequency" AS "average_frequency"
    FROM "memory"."main"."facebook_ads_basic_ad_data"
),

"facebook_ads_basic_ad_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- ad_id: from INT to VARCHAR
    -- performance_date: from VARCHAR to DATE
    SELECT
        "ad_name",
        "adset_name",
        "impressions",
        "link_clicks",
        "ad_spend",
        "unique_reach",
        "average_frequency",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("ad_id" AS VARCHAR) 
        AS "ad_id",
        CAST("performance_date" AS DATE) 
        AS "performance_date"
    FROM "facebook_ads_basic_ad_data_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "facebook_ads_basic_ad_data_renamed_casted"