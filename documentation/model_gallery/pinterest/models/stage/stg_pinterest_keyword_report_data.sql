-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_keyword_report_data_projected" AS (
    -- Projection: Selecting 32 out of 33 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "ad_group_id",
        "advertiser_id",
        "campaign_id",
        "date_",
        "keyword_id",
        "pin_id",
        "pin_promotion_id",
        "ad_group_name",
        "ad_group_status",
        "campaign_daily_spend_cap",
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
        "pin_promotion_name",
        "pin_promotion_status",
        "spend_in_micro_dollar",
        "targeting_type",
        "targeting_value",
        "total_engagement"
    FROM "pinterest_keyword_report_data"
),

"pinterest_keyword_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> performance_date
    -- clickthrough_1 -> clickthrough_count
    -- clickthrough_1_gross -> clickthrough_count_gross
    -- cpc_in_micro_dollar -> cost_per_click_micro
    -- cpm_in_micro_dollar -> cost_per_mille_micro
    -- ctr -> click_through_rate
    -- ecpc_in_micro_dollar -> effective_cost_per_click_micro
    -- ecpm_in_micro_dollar -> effective_cost_per_mille_micro
    -- ectr -> effective_click_through_rate
    -- engagement_1 -> engagement_count
    -- impression_1 -> impression_count
    -- impression_1_gross -> impression_count_gross
    -- outbound_click_1 -> outbound_click_count
    -- paid_impression -> paid_impression_count
    -- spend_in_micro_dollar -> spend_micro
    -- targeting_value -> keyword_category
    SELECT 
        "ad_group_id",
        "advertiser_id",
        "campaign_id",
        "date_" AS "performance_date",
        "keyword_id",
        "pin_id",
        "pin_promotion_id",
        "ad_group_name",
        "ad_group_status",
        "campaign_daily_spend_cap",
        "campaign_lifetime_spend_cap",
        "campaign_name",
        "campaign_status",
        "clickthrough_1" AS "clickthrough_count",
        "clickthrough_1_gross" AS "clickthrough_count_gross",
        "cpc_in_micro_dollar" AS "cost_per_click_micro",
        "cpm_in_micro_dollar" AS "cost_per_mille_micro",
        "ctr" AS "click_through_rate",
        "ecpc_in_micro_dollar" AS "effective_cost_per_click_micro",
        "ecpm_in_micro_dollar" AS "effective_cost_per_mille_micro",
        "ectr" AS "effective_click_through_rate",
        "engagement_1" AS "engagement_count",
        "impression_1" AS "impression_count",
        "impression_1_gross" AS "impression_count_gross",
        "outbound_click_1" AS "outbound_click_count",
        "paid_impression" AS "paid_impression_count",
        "pin_promotion_name",
        "pin_promotion_status",
        "spend_in_micro_dollar" AS "spend_micro",
        "targeting_type",
        "targeting_value" AS "keyword_category",
        "total_engagement"
    FROM "pinterest_keyword_report_data_projected"
),

"pinterest_keyword_report_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- ad_group_name: The problem is that the ad_group_name column contains a single unusual value that combines a date-time stamp with 'Ad group'. This is not a typical format for an ad group name, which usually consists of a descriptive name related to the ad campaign or target audience. The correct value should be a meaningful ad group name without the date-time prefix. 
    -- keyword_category: The problem is inconsistency in representing cat-related interests. We have 'cat lover', 'cat drawing', and 'cat', which are all related to cats but represented differently. The correct approach would be to standardize these under a single category. Since 'cat lover' is the most frequent among these, we'll use it as the standard representation. 
    SELECT
        "ad_group_id",
        "advertiser_id",
        "campaign_id",
        "performance_date",
        "keyword_id",
        "pin_id",
        "pin_promotion_id",
        CASE
            WHEN "ad_group_name" = '2022-06-07 14:30 | Ad group' THEN 'Ad group'
            ELSE "ad_group_name"
        END AS "ad_group_name",
        "ad_group_status",
        "campaign_daily_spend_cap",
        "campaign_lifetime_spend_cap",
        "campaign_name",
        "campaign_status",
        "clickthrough_count",
        "clickthrough_count_gross",
        "cost_per_click_micro",
        "cost_per_mille_micro",
        "click_through_rate",
        "effective_cost_per_click_micro",
        "effective_cost_per_mille_micro",
        "effective_click_through_rate",
        "engagement_count",
        "impression_count",
        "impression_count_gross",
        "outbound_click_count",
        "paid_impression_count",
        "pin_promotion_name",
        "pin_promotion_status",
        "spend_micro",
        "targeting_type",
        CASE
            WHEN "keyword_category" = 'cat drawing' THEN 'cat lover'
            WHEN "keyword_category" = 'cat' THEN 'cat lover'
            ELSE "keyword_category"
        END AS "keyword_category",
        "total_engagement"
    FROM "pinterest_keyword_report_data_projected_renamed"
),

"pinterest_keyword_report_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- ad_group_id: from INT to VARCHAR
    -- advertiser_id: from INT to VARCHAR
    -- campaign_daily_spend_cap: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- campaign_lifetime_spend_cap: from INT to VARCHAR
    -- clickthrough_count: from DECIMAL to INT
    -- clickthrough_count_gross: from DECIMAL to INT
    -- engagement_count: from DECIMAL to INT
    -- keyword_id: from INT to VARCHAR
    -- outbound_click_count: from DECIMAL to INT
    -- performance_date: from VARCHAR to TIMESTAMP
    -- pin_id: from INT to VARCHAR
    -- pin_promotion_id: from INT to VARCHAR
    -- total_engagement: from DECIMAL to VARCHAR
    SELECT
        "ad_group_name",
        "ad_group_status",
        "campaign_name",
        "campaign_status",
        "cost_per_click_micro",
        "cost_per_mille_micro",
        "click_through_rate",
        "effective_cost_per_click_micro",
        "effective_cost_per_mille_micro",
        "effective_click_through_rate",
        "impression_count",
        "impression_count_gross",
        "paid_impression_count",
        "pin_promotion_name",
        "pin_promotion_status",
        "spend_micro",
        "targeting_type",
        "keyword_category",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        CAST("campaign_daily_spend_cap" AS VARCHAR) AS "campaign_daily_spend_cap",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("campaign_lifetime_spend_cap" AS VARCHAR) AS "campaign_lifetime_spend_cap",
        CAST("clickthrough_count" AS INT) AS "clickthrough_count",
        CAST("clickthrough_count_gross" AS INT) AS "clickthrough_count_gross",
        CAST("engagement_count" AS INT) AS "engagement_count",
        CAST("keyword_id" AS VARCHAR) AS "keyword_id",
        CAST("outbound_click_count" AS INT) AS "outbound_click_count",
        CAST("performance_date" AS TIMESTAMP) AS "performance_date",
        CAST("pin_id" AS VARCHAR) AS "pin_id",
        CAST("pin_promotion_id" AS VARCHAR) AS "pin_promotion_id",
        CAST("total_engagement" AS VARCHAR) AS "total_engagement"
    FROM "pinterest_keyword_report_data_projected_renamed_cleaned"
),

"pinterest_keyword_report_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 9 columns with unacceptable missing values
    -- click_through_rate has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clickthrough_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clickthrough_count_gross has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_per_click_micro has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- effective_click_through_rate has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- effective_cost_per_click_micro has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- engagement_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- outbound_click_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- total_engagement has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "ad_group_name",
        "ad_group_status",
        "campaign_name",
        "campaign_status",
        "cost_per_mille_micro",
        "effective_cost_per_mille_micro",
        "impression_count",
        "impression_count_gross",
        "paid_impression_count",
        "pin_promotion_name",
        "pin_promotion_status",
        "spend_micro",
        "targeting_type",
        "keyword_category",
        "ad_group_id",
        "advertiser_id",
        "campaign_daily_spend_cap",
        "campaign_id",
        "campaign_lifetime_spend_cap",
        "keyword_id",
        "performance_date",
        "pin_id",
        "pin_promotion_id"
    FROM "pinterest_keyword_report_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_keyword_report_data_projected_renamed_cleaned_casted_missing_handled"