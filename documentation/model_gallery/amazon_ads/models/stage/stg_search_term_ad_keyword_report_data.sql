-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:38:31.035705+00:00
WITH 
"search_term_ad_keyword_report_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['ad_group_id', 'campaign_id', 'date_', 'keyword_id', '_fivetran_synced', 'campaign_budget_amount', 'campaign_budget_currency_code', 'campaign_budget_type', 'clicks', 'cost', 'impressions', 'keyword_bid', 'search_term', 'targeting']
    SELECT 
        "ad_group_id",
        "campaign_id",
        "date_",
        "keyword_id",
        "campaign_budget_amount",
        "campaign_budget_currency_code",
        "campaign_budget_type",
        "clicks",
        "cost",
        "impressions",
        "keyword_bid",
        "search_term",
        "targeting"
    FROM "memory"."main"."search_term_ad_keyword_report_data"
),

"search_term_ad_keyword_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> performance_date
    -- campaign_budget_amount -> daily_budget_amount
    -- campaign_budget_currency_code -> budget_currency
    -- campaign_budget_type -> budget_type
    -- cost -> daily_ad_cost
    -- keyword_bid -> keyword_bid_amount
    -- targeting -> targeting_criteria
    SELECT 
        "ad_group_id",
        "campaign_id",
        "date_" AS "performance_date",
        "keyword_id",
        "campaign_budget_amount" AS "daily_budget_amount",
        "campaign_budget_currency_code" AS "budget_currency",
        "campaign_budget_type" AS "budget_type",
        "clicks",
        "cost" AS "daily_ad_cost",
        "impressions",
        "keyword_bid" AS "keyword_bid_amount",
        "search_term",
        "targeting" AS "targeting_criteria"
    FROM "search_term_ad_keyword_report_data_projected"
),

"search_term_ad_keyword_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- performance_date: from VARCHAR to DATE
    SELECT
        "ad_group_id",
        "campaign_id",
        "keyword_id",
        "daily_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "daily_ad_cost",
        "impressions",
        "keyword_bid_amount",
        "search_term",
        "targeting_criteria",
        CAST("performance_date" AS DATE) 
        AS "performance_date"
    FROM "search_term_ad_keyword_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "search_term_ad_keyword_report_data_projected_renamed_casted"