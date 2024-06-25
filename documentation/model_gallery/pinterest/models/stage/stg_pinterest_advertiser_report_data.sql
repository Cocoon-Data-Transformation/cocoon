-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_advertiser_report_data_projected" AS (
    -- Projection: Selecting 19 out of 20 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "advertiser_id",
        "date_",
        "clickthrough_1",
        "clickthrough_1_gross",
        "cpc_in_micro_dollar",
        "cpm_in_micro_dollar",
        "ctr",
        "ecpc_in_micro_dollar",
        "ecpm_in_micro_dollar",
        "ectr",
        "engagement_1",
        "impression_1",
        "impression_1_gross",
        "outbound_click_1",
        "paid_impression",
        "spend_in_micro_dollar",
        "total_engagement",
        "total_impression_frequency",
        "total_impression_user"
    FROM "pinterest_advertiser_report_data"
),

"pinterest_advertiser_report_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> report_date
    -- clickthrough_1 -> click_count
    -- clickthrough_1_gross -> total_click_count
    -- cpc_in_micro_dollar -> cost_per_click_micro
    -- cpm_in_micro_dollar -> cost_per_mille_micro
    -- ctr -> click_through_rate
    -- ecpc_in_micro_dollar -> effective_cost_per_click_micro
    -- ecpm_in_micro_dollar -> effective_cost_per_mille_micro
    -- ectr -> effective_click_through_rate
    -- engagement_1 -> engagement_count
    -- impression_1 -> impression_count
    -- impression_1_gross -> total_impression_count
    -- outbound_click_1 -> outbound_click_count
    -- paid_impression -> paid_impression_count
    -- spend_in_micro_dollar -> total_spend_micro
    -- total_engagement -> total_engagement_count
    -- total_impression_frequency -> average_impression_frequency
    -- total_impression_user -> unique_user_reach
    SELECT 
        "advertiser_id",
        "date_" AS "report_date",
        "clickthrough_1" AS "click_count",
        "clickthrough_1_gross" AS "total_click_count",
        "cpc_in_micro_dollar" AS "cost_per_click_micro",
        "cpm_in_micro_dollar" AS "cost_per_mille_micro",
        "ctr" AS "click_through_rate",
        "ecpc_in_micro_dollar" AS "effective_cost_per_click_micro",
        "ecpm_in_micro_dollar" AS "effective_cost_per_mille_micro",
        "ectr" AS "effective_click_through_rate",
        "engagement_1" AS "engagement_count",
        "impression_1" AS "impression_count",
        "impression_1_gross" AS "total_impression_count",
        "outbound_click_1" AS "outbound_click_count",
        "paid_impression" AS "paid_impression_count",
        "spend_in_micro_dollar" AS "total_spend_micro",
        "total_engagement" AS "total_engagement_count",
        "total_impression_frequency" AS "average_impression_frequency",
        "total_impression_user" AS "unique_user_reach"
    FROM "pinterest_advertiser_report_data_projected"
),

"pinterest_advertiser_report_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- advertiser_id: from INT to VARCHAR
    -- click_count: from DECIMAL to INT
    -- outbound_click_count: from DECIMAL to INT
    -- report_date: from VARCHAR to TIMESTAMP
    -- total_click_count: from DECIMAL to INT
    SELECT
        "cost_per_click_micro",
        "cost_per_mille_micro",
        "click_through_rate",
        "effective_cost_per_click_micro",
        "effective_cost_per_mille_micro",
        "effective_click_through_rate",
        "engagement_count",
        "impression_count",
        "total_impression_count",
        "paid_impression_count",
        "total_spend_micro",
        "total_engagement_count",
        "average_impression_frequency",
        "unique_user_reach",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        CAST("click_count" AS INT) AS "click_count",
        CAST("outbound_click_count" AS INT) AS "outbound_click_count",
        CAST("report_date" AS TIMESTAMP) AS "report_date",
        CAST("total_click_count" AS INT) AS "total_click_count"
    FROM "pinterest_advertiser_report_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_advertiser_report_data_projected_renamed_casted"