-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:39:31.598218+00:00
WITH 
"targeting_keyword_report_data_projected" AS (
    -- Projection: Selecting 15 out of 16 columns
    -- Columns projected out: ['ad_group_id', 'campaign_id', 'date_', 'keyword_id', '_fivetran_synced', 'ad_keyword_status', 'campaign_budget_amount', 'campaign_budget_currency_code', 'campaign_budget_type', 'clicks', 'cost', 'impressions', 'keyword_bid', 'keyword_type', 'match_type', 'targeting']
    SELECT 
        "ad_group_id",
        "campaign_id",
        "date_",
        "keyword_id",
        "ad_keyword_status",
        "campaign_budget_amount",
        "campaign_budget_currency_code",
        "campaign_budget_type",
        "clicks",
        "cost",
        "impressions",
        "keyword_bid",
        "keyword_type",
        "match_type",
        "targeting"
    FROM "memory"."main"."targeting_keyword_report_data"
),

"targeting_keyword_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> performance_date
    -- ad_keyword_status -> keyword_status
    -- campaign_budget_amount -> daily_budget_amount
    -- campaign_budget_currency_code -> budget_currency
    -- campaign_budget_type -> budget_type
    -- targeting -> target_keyword
    SELECT 
        "ad_group_id",
        "campaign_id",
        "date_" AS "performance_date",
        "keyword_id",
        "ad_keyword_status" AS "keyword_status",
        "campaign_budget_amount" AS "daily_budget_amount",
        "campaign_budget_currency_code" AS "budget_currency",
        "campaign_budget_type" AS "budget_type",
        "clicks",
        "cost",
        "impressions",
        "keyword_bid",
        "keyword_type",
        "match_type",
        "targeting" AS "target_keyword"
    FROM "targeting_keyword_report_data_projected"
),

"targeting_keyword_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- performance_date: from VARCHAR to DATE
    SELECT
        "ad_group_id",
        "campaign_id",
        "keyword_id",
        "keyword_status",
        "daily_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "cost",
        "impressions",
        "keyword_bid",
        "keyword_type",
        "match_type",
        "target_keyword",
        CAST("performance_date" AS DATE) 
        AS "performance_date"
    FROM "targeting_keyword_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "targeting_keyword_report_data_projected_renamed_casted"