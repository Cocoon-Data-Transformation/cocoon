-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"search_term_ad_keyword_report_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
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
    FROM "search_term_ad_keyword_report_data"
),

"search_term_ad_keyword_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- campaign_budget_amount -> daily_budget_amount
    -- campaign_budget_currency_code -> budget_currency
    -- campaign_budget_type -> budget_type
    -- targeting -> targeting_criteria
    SELECT 
        ad_group_id,
        campaign_id,
        date_ AS report_date,
        keyword_id,
        campaign_budget_amount AS daily_budget_amount,
        campaign_budget_currency_code AS budget_currency,
        campaign_budget_type AS budget_type,
        clicks,
        cost,
        impressions,
        keyword_bid,
        search_term,
        targeting AS targeting_criteria
    FROM search_term_ad_keyword_report_data_projected
),

"search_term_ad_keyword_report_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- targeting_criteria: The problem is that the letters 'b', 'y', and 'x' before 'wing parts' are unusual and potentially unclear abbreviations. These likely stand for different types or sections of wing parts, but without more context it's difficult to determine their exact meaning. The correct values should use clear, fully spelled-out terms instead of single letter abbreviations. 
    SELECT
        "ad_group_id",
        "campaign_id",
        "report_date",
        "keyword_id",
        "daily_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "cost",
        "impressions",
        "keyword_bid",
        "search_term",
        CASE
            WHEN "targeting_criteria" = 'b wing parts' THEN 'body wing parts'
            WHEN "targeting_criteria" = 'y wing parts' THEN 'yaw wing parts'
            WHEN "targeting_criteria" = 'x wing parts' THEN 'auxiliary wing parts'
            ELSE "targeting_criteria"
        END AS "targeting_criteria"
    FROM "search_term_ad_keyword_report_data_projected_renamed"
),

"search_term_ad_keyword_report_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- report_date: from VARCHAR to DATE
    SELECT
        "ad_group_id",
        "campaign_id",
        "keyword_id",
        "daily_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "cost",
        "impressions",
        "keyword_bid",
        "search_term",
        "targeting_criteria",
        CAST("report_date" AS DATE) AS "report_date"
    FROM "search_term_ad_keyword_report_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "search_term_ad_keyword_report_data_projected_renamed_cleaned_casted"