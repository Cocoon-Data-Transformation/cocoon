-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_campaign_report_data_projected" AS (
    -- Projection: Selecting 24 out of 25 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "advertiser_id",
        "campaign_id",
        "date_",
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
        "spend_in_micro_dollar",
        "total_engagement",
        "total_impression_frequency",
        "total_impression_user"
    FROM "pinterest_campaign_report_data"
),

"pinterest_campaign_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- campaign_daily_spend_cap -> daily_spend_cap_micro
    -- campaign_lifetime_spend_cap -> lifetime_spend_cap_micro
    -- clickthrough_1 -> clicks
    -- clickthrough_1_gross -> total_clicks
    -- cpc_in_micro_dollar -> cpc_micro
    -- cpm_in_micro_dollar -> cpm_micro
    -- ecpc_in_micro_dollar -> ecpc_micro
    -- ecpm_in_micro_dollar -> ecpm_micro
    -- engagement_1 -> engagements
    -- impression_1 -> impressions
    -- impression_1_gross -> total_impressions
    -- outbound_click_1 -> outbound_clicks
    -- paid_impression -> paid_impressions
    -- spend_in_micro_dollar -> spend_micro
    -- total_engagement -> total_engagements
    -- total_impression_frequency -> avg_impression_frequency
    -- total_impression_user -> unique_users_reached
    SELECT 
        "advertiser_id",
        "campaign_id",
        "date_",
        "campaign_daily_spend_cap" AS "daily_spend_cap_micro",
        "campaign_lifetime_spend_cap" AS "lifetime_spend_cap_micro",
        "campaign_name",
        "campaign_status",
        "clickthrough_1" AS "clicks",
        "clickthrough_1_gross" AS "total_clicks",
        "cpc_in_micro_dollar" AS "cpc_micro",
        "cpm_in_micro_dollar" AS "cpm_micro",
        "ctr",
        "ecpc_in_micro_dollar" AS "ecpc_micro",
        "ecpm_in_micro_dollar" AS "ecpm_micro",
        "ectr",
        "engagement_1" AS "engagements",
        "impression_1" AS "impressions",
        "impression_1_gross" AS "total_impressions",
        "outbound_click_1" AS "outbound_clicks",
        "paid_impression" AS "paid_impressions",
        "spend_in_micro_dollar" AS "spend_micro",
        "total_engagement" AS "total_engagements",
        "total_impression_frequency" AS "avg_impression_frequency",
        "total_impression_user" AS "unique_users_reached"
    FROM "pinterest_campaign_report_data_projected"
),

"pinterest_campaign_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- advertiser_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- clicks: from DECIMAL to INT
    -- date_: from VARCHAR to TIMESTAMP
    -- outbound_clicks: from DECIMAL to INT
    SELECT
        "daily_spend_cap_micro",
        "lifetime_spend_cap_micro",
        "campaign_name",
        "campaign_status",
        "total_clicks",
        "cpc_micro",
        "cpm_micro",
        "ctr",
        "ecpc_micro",
        "ecpm_micro",
        "ectr",
        "engagements",
        "impressions",
        "total_impressions",
        "paid_impressions",
        "spend_micro",
        "total_engagements",
        "avg_impression_frequency",
        "unique_users_reached",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("clicks" AS INT) AS "clicks",
        CAST("date_" AS TIMESTAMP) AS "date_",
        CAST("outbound_clicks" AS INT) AS "outbound_clicks"
    FROM "pinterest_campaign_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_campaign_report_data_projected_renamed_casted"