-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_ad_group_report_data_projected" AS (
    -- Projection: Selecting 27 out of 28 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "ad_group_id",
        "advertiser_id",
        "date_",
        "ad_group_name",
        "ad_group_status",
        "campaign_daily_spend_cap",
        "campaign_id",
        "campaign_lifetime_spend_cap",
        "campaign_name",
        "campaign_status",
        "clickthrough_1",
        "clickthrough_1_gross",
        "cpc_in_micro_dollar",
        "cpm_in_micro_dollar",
        "ctr",
        "ecpc_in_micro_dollar",
        "ecpm_in_micro_dollar",
        "ectr",
        "engagement_1",
        "impression_1",
        "impression_1_gross",
        "outbound_click_1",
        "paid_impression",
        "spend_in_micro_dollar",
        "total_engagement",
        "total_impression_frequency",
        "total_impression_user"
    FROM "pinterest_ad_group_report_data"
),

"pinterest_ad_group_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- clickthrough_1 -> clickthrough_count
    -- clickthrough_1_gross -> clickthrough_count_gross
    -- cpc_in_micro_dollar -> cost_per_click_micro
    -- cpm_in_micro_dollar -> cost_per_thousand_impressions_micro
    -- ctr -> click_through_rate
    -- ecpc_in_micro_dollar -> effective_cost_per_click_micro
    -- ecpm_in_micro_dollar -> effective_cost_per_thousand_impressions_micro
    -- ectr -> effective_click_through_rate
    -- engagement_1 -> engagement_count
    -- impression_1 -> impression_count
    -- impression_1_gross -> impression_count_gross
    -- outbound_click_1 -> outbound_click_count
    -- paid_impression -> paid_impression_count
    -- spend_in_micro_dollar -> spend_micro
    -- total_engagement -> total_engagement_count
    -- total_impression_frequency -> average_impression_frequency
    -- total_impression_user -> total_impression_users
    SELECT 
        "ad_group_id",
        "advertiser_id",
        "date_" AS "report_date",
        "ad_group_name",
        "ad_group_status",
        "campaign_daily_spend_cap",
        "campaign_id",
        "campaign_lifetime_spend_cap",
        "campaign_name",
        "campaign_status",
        "clickthrough_1" AS "clickthrough_count",
        "clickthrough_1_gross" AS "clickthrough_count_gross",
        "cpc_in_micro_dollar" AS "cost_per_click_micro",
        "cpm_in_micro_dollar" AS "cost_per_thousand_impressions_micro",
        "ctr" AS "click_through_rate",
        "ecpc_in_micro_dollar" AS "effective_cost_per_click_micro",
        "ecpm_in_micro_dollar" AS "effective_cost_per_thousand_impressions_micro",
        "ectr" AS "effective_click_through_rate",
        "engagement_1" AS "engagement_count",
        "impression_1" AS "impression_count",
        "impression_1_gross" AS "impression_count_gross",
        "outbound_click_1" AS "outbound_click_count",
        "paid_impression" AS "paid_impression_count",
        "spend_in_micro_dollar" AS "spend_micro",
        "total_engagement" AS "total_engagement_count",
        "total_impression_frequency" AS "average_impression_frequency",
        "total_impression_user" AS "total_impression_users"
    FROM "pinterest_ad_group_report_data_projected"
),

"pinterest_ad_group_report_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- ad_group_name: The problem is that the ad_group_name column contains a single unusual value that combines a date-time stamp with 'Ad group'. This is not a typical format for an ad group name, which usually consists of a descriptive name related to the ad campaign or target audience. The correct value should be a meaningful ad group name without the date-time prefix. 
    SELECT
        "ad_group_id",
        "advertiser_id",
        "report_date",
        CASE
            WHEN "ad_group_name" = '2022-06-07 14:30 | Ad group' THEN 'Ad group'
            ELSE "ad_group_name"
        END AS "ad_group_name",
        "ad_group_status",
        "campaign_daily_spend_cap",
        "campaign_id",
        "campaign_lifetime_spend_cap",
        "campaign_name",
        "campaign_status",
        "clickthrough_count",
        "clickthrough_count_gross",
        "cost_per_click_micro",
        "cost_per_thousand_impressions_micro",
        "click_through_rate",
        "effective_cost_per_click_micro",
        "effective_cost_per_thousand_impressions_micro",
        "effective_click_through_rate",
        "engagement_count",
        "impression_count",
        "impression_count_gross",
        "outbound_click_count",
        "paid_impression_count",
        "spend_micro",
        "total_engagement_count",
        "average_impression_frequency",
        "total_impression_users"
    FROM "pinterest_ad_group_report_data_projected_renamed"
),

"pinterest_ad_group_report_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- ad_group_id: from INT to VARCHAR
    -- advertiser_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- clickthrough_count: from DECIMAL to INT
    -- clickthrough_count_gross: from DECIMAL to INT
    -- outbound_click_count: from DECIMAL to INT
    -- report_date: from VARCHAR to TIMESTAMP
    SELECT
        "ad_group_name",
        "ad_group_status",
        "campaign_daily_spend_cap",
        "campaign_lifetime_spend_cap",
        "campaign_name",
        "campaign_status",
        "cost_per_click_micro",
        "cost_per_thousand_impressions_micro",
        "click_through_rate",
        "effective_cost_per_click_micro",
        "effective_cost_per_thousand_impressions_micro",
        "effective_click_through_rate",
        "engagement_count",
        "impression_count",
        "impression_count_gross",
        "paid_impression_count",
        "spend_micro",
        "total_engagement_count",
        "average_impression_frequency",
        "total_impression_users",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("clickthrough_count" AS INT) AS "clickthrough_count",
        CAST("clickthrough_count_gross" AS INT) AS "clickthrough_count_gross",
        CAST("outbound_click_count" AS INT) AS "outbound_click_count",
        CAST("report_date" AS TIMESTAMP) AS "report_date"
    FROM "pinterest_ad_group_report_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_ad_group_report_data_projected_renamed_cleaned_casted"