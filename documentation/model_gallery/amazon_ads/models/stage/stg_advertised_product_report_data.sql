-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"advertised_product_report_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
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
    FROM "advertised_product_report_data"
),

"advertised_product_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- campaign_budget_currency_code -> budget_currency
    -- campaign_budget_type -> budget_type
    -- __advertised_asin -> advertised_asin
    -- __advertised_sku -> advertised_sku
    SELECT 
        ad_group_id,
        ad_id,
        campaign_id,
        date_ AS report_date,
        campaign_budget_amount,
        campaign_budget_currency_code AS budget_currency,
        campaign_budget_type AS budget_type,
        clicks,
        cost,
        impressions,
        __advertised_asin AS advertised_asin,
        __advertised_sku AS advertised_sku
    FROM advertised_product_report_data_projected
),

"advertised_product_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- advertised_asin: from DECIMAL to VARCHAR
    -- advertised_sku: from DECIMAL to VARCHAR
    -- report_date: from VARCHAR to DATE
    SELECT
        "ad_group_id",
        "ad_id",
        "campaign_id",
        "campaign_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "cost",
        "impressions",
        CAST("advertised_asin" AS VARCHAR) AS "advertised_asin",
        CAST("advertised_sku" AS VARCHAR) AS "advertised_sku",
        CAST("report_date" AS DATE) AS "report_date"
    FROM "advertised_product_report_data_projected_renamed"
),

"advertised_product_report_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- advertised_asin has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- advertised_sku has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "ad_group_id",
        "ad_id",
        "campaign_id",
        "campaign_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "cost",
        "impressions",
        "report_date"
    FROM "advertised_product_report_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "advertised_product_report_data_projected_renamed_casted_missing_handled"