-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_pin_promotion_report_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "date_",
        "pin_promotion_id",
        "ad_group_id",
        "campaign_id",
        "advertiser_id",
        "impression_1",
        "impression_2",
        "clickthrough_1",
        "clickthrough_2",
        "spend_in_micro_dollar"
    FROM "pinterest_pin_promotion_report_data"
),

"pinterest_pin_promotion_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- impression_1 -> primary_impressions
    -- impression_2 -> secondary_impressions
    -- clickthrough_1 -> primary_clickthroughs
    -- clickthrough_2 -> secondary_clickthroughs
    -- spend_in_micro_dollar -> spend_micro_dollars
    SELECT 
        "date_",
        "pin_promotion_id",
        "ad_group_id",
        "campaign_id",
        "advertiser_id",
        "impression_1" AS "primary_impressions",
        "impression_2" AS "secondary_impressions",
        "clickthrough_1" AS "primary_clickthroughs",
        "clickthrough_2" AS "secondary_clickthroughs",
        "spend_in_micro_dollar" AS "spend_micro_dollars"
    FROM "pinterest_pin_promotion_report_data_projected"
),

"pinterest_pin_promotion_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- ad_group_id: from INT to VARCHAR
    -- advertiser_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- date_: from VARCHAR to TIMESTAMP
    -- pin_promotion_id: from INT to VARCHAR
    SELECT
        "primary_impressions",
        "secondary_impressions",
        "primary_clickthroughs",
        "secondary_clickthroughs",
        "spend_micro_dollars",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("date_" AS TIMESTAMP) AS "date_",
        CAST("pin_promotion_id" AS VARCHAR) AS "pin_promotion_id"
    FROM "pinterest_pin_promotion_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_pin_promotion_report_data_projected_renamed_casted"