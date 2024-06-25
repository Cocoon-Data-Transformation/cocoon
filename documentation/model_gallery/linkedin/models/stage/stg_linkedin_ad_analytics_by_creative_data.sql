-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"linkedin_ad_analytics_by_creative_data_renamed" AS (
    -- Rename: Renaming columns
    -- day_ -> date_
    -- clicks -> click_count
    -- impressions -> impression_count
    -- cost_in_local_currency -> local_currency_cost
    -- cost_in_usd -> usd_cost
    SELECT 
        "creative_id",
        "day_" AS "date_",
        "clicks" AS "click_count",
        "impressions" AS "impression_count",
        "cost_in_local_currency" AS "local_currency_cost",
        "cost_in_usd" AS "usd_cost"
    FROM "linkedin_ad_analytics_by_creative_data"
),

"linkedin_ad_analytics_by_creative_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- click_count: from DECIMAL to INT
    -- creative_id: from INT to VARCHAR
    -- date_: from VARCHAR to TIMESTAMP
    -- impression_count: from DECIMAL to INT
    SELECT
        "local_currency_cost",
        "usd_cost",
        CAST("click_count" AS INT) AS "click_count",
        CAST("creative_id" AS VARCHAR) AS "creative_id",
        CAST("date_" AS TIMESTAMP) AS "date_",
        CAST("impression_count" AS INT) AS "impression_count"
    FROM "linkedin_ad_analytics_by_creative_data_renamed"
),

"linkedin_ad_analytics_by_creative_data_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- click_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- impression_count has 29.0 percent missing. Strategy: 🔄 Unchanged
    -- usd_cost has 29.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "local_currency_cost",
        "usd_cost",
        "creative_id",
        "date_",
        "impression_count"
    FROM "linkedin_ad_analytics_by_creative_data_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "linkedin_ad_analytics_by_creative_data_renamed_casted_missing_handled"