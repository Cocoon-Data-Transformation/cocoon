-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:32:44.998118+00:00
WITH 
"campaign_level_report_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['campaign_id', 'date_', '_fivetran_synced', 'campaign_applicable_budget_rule_id', 'campaign_applicable_budget_rule_name', 'campaign_bidding_strategy', 'campaign_budget_amount', 'campaign_budget_currency_code', 'campaign_budget_type', 'clicks', 'cost', 'impressions', 'campaign_rule_based_budget_amount']
    SELECT 
        "campaign_id",
        "date_",
        "campaign_applicable_budget_rule_id",
        "campaign_applicable_budget_rule_name",
        "campaign_bidding_strategy",
        "campaign_budget_amount",
        "campaign_budget_currency_code",
        "campaign_budget_type",
        "clicks",
        "cost",
        "impressions",
        "campaign_rule_based_budget_amount"
    FROM "memory"."main"."campaign_level_report_data"
),

"campaign_level_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- campaign_applicable_budget_rule_id -> budget_rule_id
    -- campaign_applicable_budget_rule_name -> budget_rule_name
    -- campaign_bidding_strategy -> bidding_strategy
    -- campaign_budget_amount -> daily_budget_amount
    -- campaign_budget_currency_code -> budget_currency
    -- campaign_budget_type -> budget_type
    -- campaign_rule_based_budget_amount -> rule_based_budget_amount
    SELECT 
        "campaign_id",
        "date_" AS "report_date",
        "campaign_applicable_budget_rule_id" AS "budget_rule_id",
        "campaign_applicable_budget_rule_name" AS "budget_rule_name",
        "campaign_bidding_strategy" AS "bidding_strategy",
        "campaign_budget_amount" AS "daily_budget_amount",
        "campaign_budget_currency_code" AS "budget_currency",
        "campaign_budget_type" AS "budget_type",
        "clicks",
        "cost",
        "impressions",
        "campaign_rule_based_budget_amount" AS "rule_based_budget_amount"
    FROM "campaign_level_report_data_projected"
),

"campaign_level_report_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- budget_type: The problem is that 'DAILY_BUDGET0.0' appears to be a redundant version of 'DAILY_BUDGET' with an unnecessary '0.0' appended to it. This is likely due to a data entry error or a glitch in the system that recorded the budget types. The correct value should be 'DAILY_BUDGET' for all entries, as this is the most frequent and logically correct representation of a daily budget type.
    SELECT
        "campaign_id",
        "report_date",
        "budget_rule_id",
        "budget_rule_name",
        "bidding_strategy",
        "daily_budget_amount",
        "budget_currency",
        CASE
            WHEN "budget_type" = 'DAILY_BUDGET0.0' THEN 'DAILY_BUDGET'
            ELSE "budget_type"
        END AS "budget_type",
        "clicks",
        "cost",
        "impressions",
        "rule_based_budget_amount"
    FROM "campaign_level_report_data_projected_renamed"
),

"campaign_level_report_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- budget_rule_id: from DECIMAL to VARCHAR
    -- budget_rule_name: from DECIMAL to VARCHAR
    -- impressions: from DECIMAL to VARCHAR
    -- report_date: from VARCHAR to DATE
    -- rule_based_budget_amount: from DECIMAL to VARCHAR
    SELECT
        "campaign_id",
        "bidding_strategy",
        "daily_budget_amount",
        "budget_currency",
        "budget_type",
        "clicks",
        "cost",
        CAST("budget_rule_id" AS VARCHAR) 
        AS "budget_rule_id",
        CAST("budget_rule_name" AS VARCHAR) 
        AS "budget_rule_name",
        CAST("impressions" AS VARCHAR) 
        AS "impressions",
        CAST("report_date" AS DATE) 
        AS "report_date",
        CAST("rule_based_budget_amount" AS VARCHAR) 
        AS "rule_based_budget_amount"
    FROM "campaign_level_report_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "campaign_level_report_data_projected_renamed_cleaned_casted"