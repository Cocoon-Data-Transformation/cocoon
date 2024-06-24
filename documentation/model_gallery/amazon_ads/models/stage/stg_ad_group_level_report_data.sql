-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ad_group_level_report_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "ad_group_id",
        "date_",
        "campaign_bidding_strategy",
        "clicks",
        "cost",
        "impressions"
    FROM "ad_group_level_report_data"
),

"ad_group_level_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- campaign_bidding_strategy -> bidding_strategy
    SELECT 
        ad_group_id,
        date_ AS report_date,
        campaign_bidding_strategy AS bidding_strategy,
        clicks,
        cost,
        impressions
    FROM ad_group_level_report_data_projected
),

"ad_group_level_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- report_date: from VARCHAR to DATE
    SELECT
        "ad_group_id",
        "bidding_strategy",
        "clicks",
        "cost",
        "impressions",
        CAST("report_date" AS DATE) AS "report_date"
    FROM "ad_group_level_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "ad_group_level_report_data_projected_renamed_casted"