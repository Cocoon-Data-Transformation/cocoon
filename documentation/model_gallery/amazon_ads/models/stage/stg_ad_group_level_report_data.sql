-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:30:07.435997+00:00
WITH 
"ad_group_level_report_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['ad_group_id', 'date_', '_fivetran_synced', 'campaign_bidding_strategy', 'clicks', 'cost', 'impressions']
    SELECT 
        "ad_group_id",
        "date_",
        "campaign_bidding_strategy",
        "clicks",
        "cost",
        "impressions"
    FROM "memory"."main"."ad_group_level_report_data"
),

"ad_group_level_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> performance_date
    -- campaign_bidding_strategy -> bidding_strategy
    SELECT 
        "ad_group_id",
        "date_" AS "performance_date",
        "campaign_bidding_strategy" AS "bidding_strategy",
        "clicks",
        "cost",
        "impressions"
    FROM "ad_group_level_report_data_projected"
),

"ad_group_level_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- performance_date: from VARCHAR to DATE
    SELECT
        "ad_group_id",
        "bidding_strategy",
        "clicks",
        "cost",
        "impressions",
        CAST("performance_date" AS DATE) 
        AS "performance_date"
    FROM "ad_group_level_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "ad_group_level_report_data_projected_renamed_casted"