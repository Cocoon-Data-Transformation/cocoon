-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"targeting_keyword_report_data_projected" AS (
    -- Projection: Selecting 15 out of 16 columns
    -- Columns projected out: ['_fivetran_synced']
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
    FROM "targeting_keyword_report_data"
),

"targeting_keyword_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- ad_keyword_status -> keyword_status
    -- campaign_budget_amount -> daily_budget_amount
    -- campaign_budget_currency_code -> budget_currency
    -- campaign_budget_type -> budget_type
    -- targeting -> target_phrase
    SELECT 
        ad_group_id,
        campaign_id,
        date_ AS report_date,
        keyword_id,
        ad_keyword_status AS keyword_status,
        campaign_budget_amount AS daily_budget_amount,
        campaign_budget_currency_code AS budget_currency,
        campaign_budget_type AS budget_type,
        clicks,
        cost,
        impressions,
        keyword_bid,
        keyword_type,
        match_type,
        targeting AS target_phrase
    FROM targeting_keyword_report_data_projected
),

"targeting_keyword_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- report_date: from VARCHAR to DATE
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
        "target_phrase",
        CAST("report_date" AS DATE) AS "report_date"
    FROM "targeting_keyword_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "targeting_keyword_report_data_projected_renamed_casted"