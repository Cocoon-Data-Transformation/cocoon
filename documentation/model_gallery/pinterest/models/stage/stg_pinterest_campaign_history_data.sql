-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_campaign_history_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_time",
        "name",
        "status",
        "advertiser_id",
        "default_ad_group_budget_in_micro_currency",
        "is_automated_campaign",
        "is_campaign_budget_optimization",
        "is_flexible_daily_budgets"
    FROM "pinterest_campaign_history_data"
),

"pinterest_campaign_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> campaign_id
    -- created_time -> campaign_creation_time
    -- name -> campaign_name
    -- status -> campaign_status
    -- default_ad_group_budget_in_micro_currency -> default_ad_group_budget_micro
    -- is_automated_campaign -> is_automated
    -- is_campaign_budget_optimization -> has_budget_optimization
    -- is_flexible_daily_budgets -> has_flexible_daily_budgets
    SELECT 
        "id" AS "campaign_id",
        "created_time" AS "campaign_creation_time",
        "name" AS "campaign_name",
        "status" AS "campaign_status",
        "advertiser_id",
        "default_ad_group_budget_in_micro_currency" AS "default_ad_group_budget_micro",
        "is_automated_campaign" AS "is_automated",
        "is_campaign_budget_optimization" AS "has_budget_optimization",
        "is_flexible_daily_budgets" AS "has_flexible_daily_budgets"
    FROM "pinterest_campaign_history_data_projected"
),

"pinterest_campaign_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- campaign_name: The problem is that the campaign_name column contains a single hexadecimal string value ('19e757f946601de26307d8182635b716') which appears to be a hash or unique identifier rather than a descriptive campaign name. This is unusual for a campaign name column, which typically contains human-readable text describing the campaign. The correct value should be a meaningful campaign name, but since we don't have that information, we'll map it to an empty string to indicate missing data. 
    SELECT
        "campaign_id",
        "campaign_creation_time",
        CASE
            WHEN "campaign_name" = '19e757f946601de26307d8182635b716' THEN ''
            ELSE "campaign_name"
        END AS "campaign_name",
        "campaign_status",
        "advertiser_id",
        "default_ad_group_budget_micro",
        "is_automated",
        "has_budget_optimization",
        "has_flexible_daily_budgets"
    FROM "pinterest_campaign_history_data_projected_renamed"
),

"pinterest_campaign_history_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- campaign_name: ['']
    SELECT 
        CASE
            WHEN "campaign_name" = '' THEN NULL
            ELSE "campaign_name"
        END AS "campaign_name",
        "campaign_id",
        "is_automated",
        "has_flexible_daily_budgets",
        "campaign_status",
        "default_ad_group_budget_micro",
        "advertiser_id",
        "has_budget_optimization",
        "campaign_creation_time"
    FROM "pinterest_campaign_history_data_projected_renamed_cleaned"
),

"pinterest_campaign_history_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- advertiser_id: from INT to VARCHAR
    -- campaign_creation_time: from VARCHAR to TIMESTAMP
    -- campaign_id: from INT to VARCHAR
    SELECT
        "campaign_name",
        "is_automated",
        "has_flexible_daily_budgets",
        "campaign_status",
        "default_ad_group_budget_micro",
        "has_budget_optimization",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        strptime("campaign_creation_time", '%Y-%m-%d %H:%M:%S.%f %z') AS "campaign_creation_time",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id"
    FROM "pinterest_campaign_history_data_projected_renamed_cleaned_null"
),

"pinterest_campaign_history_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- campaign_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_automated",
        "has_flexible_daily_budgets",
        "campaign_status",
        "default_ad_group_budget_micro",
        "has_budget_optimization",
        "advertiser_id",
        "campaign_creation_time",
        "campaign_id"
    FROM "pinterest_campaign_history_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_campaign_history_data_projected_renamed_cleaned_null_casted_missing_handled"