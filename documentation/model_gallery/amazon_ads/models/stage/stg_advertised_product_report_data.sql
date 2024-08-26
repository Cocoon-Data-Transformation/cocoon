-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:28:43.711244+00:00
WITH 
"advertised_product_report_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['ad_group_id', 'ad_id', 'campaign_id', 'date_', '_fivetran_synced', 'campaign_budget_amount', 'campaign_budget_currency_code', 'campaign_budget_type', 'clicks', 'cost', 'impressions', '__advertised_asin', '__advertised_sku']
    SELECT 
        "ad_group_id",
        "ad_id",
        "campaign_id",
        "date_",
        "campaign_budget_amount",
        "campaign_budget_currency_code",
        "campaign_budget_type",
        "clicks",
        "cost",
        "impressions",
        "__advertised_asin",
        "__advertised_sku"
    FROM "memory"."main"."advertised_product_report_data"
),

"advertised_product_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- campaign_budget_amount -> daily_budget_amount
    -- campaign_budget_currency_code -> budget_currency
    -- campaign_budget_type -> budget_type
    -- cost -> ad_spend
    -- __advertised_asin -> product_asin
    -- __advertised_sku -> product_sku
    SELECT 
        "ad_group_id",
        "ad_id",
        "campaign_id",
        "date_" AS "report_date",
        "campaign_budget_amount" AS "daily_budget_amount",
        "campaign_budget_currency_code" AS "budget_currency",
        "campaign_budget_type" AS "budget_type",
        "clicks",
        "cost" AS "ad_spend",
        "impressions",
        "__advertised_asin" AS "product_asin",
        "__advertised_sku" AS "product_sku"
    FROM "advertised_product_report_data_projected"
),

"advertised_product_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- product_asin: from DECIMAL to VARCHAR
    -- product_sku: from DECIMAL to VARCHAR
    -- report_date: from VARCHAR to DATE
    SELECT
        "ad_group_id",
        "ad_id",
        "campaign_id",
        "daily_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "ad_spend",
        "impressions",
        CAST("product_asin" AS VARCHAR) 
        AS "product_asin",
        CAST("product_sku" AS VARCHAR) 
        AS "product_sku",
        CAST("report_date" AS DATE) 
        AS "report_date"
    FROM "advertised_product_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "advertised_product_report_data_projected_renamed_casted"