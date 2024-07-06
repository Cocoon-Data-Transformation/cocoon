-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"plan_data_projected" AS (
    -- Projection: Selecting 18 out of 19 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "active",
        "aggregate_usage",
        "amount",
        "billing_scheme",
        "created",
        "currency",
        "interval_",
        "interval_count",
        "is_deleted",
        "livemode",
        "nickname",
        "product_id",
        "tiers_mode",
        "transform_usage_divide_by",
        "transform_usage_round",
        "trial_period_days",
        "usage_type"
    FROM "plan_data"
),

"plan_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> plan_id
    -- active -> is_active
    -- aggregate_usage -> usage_aggregation_method
    -- amount -> price_in_cents
    -- billing_scheme -> billing_method
    -- created -> creation_datetime
    -- currency -> currency_code
    -- interval_ -> billing_interval
    -- interval_count -> billing_cycle_duration
    -- livemode -> is_live_mode
    -- nickname -> plan_nickname
    -- tiers_mode -> pricing_tier_mode
    -- transform_usage_divide_by -> usage_transform_divisor
    -- transform_usage_round -> usage_transform_rounding
    SELECT 
        "id" AS "plan_id",
        "active" AS "is_active",
        "aggregate_usage" AS "usage_aggregation_method",
        "amount" AS "price_in_cents",
        "billing_scheme" AS "billing_method",
        "created" AS "creation_datetime",
        "currency" AS "currency_code",
        "interval_" AS "billing_interval",
        "interval_count" AS "billing_cycle_duration",
        "is_deleted",
        "livemode" AS "is_live_mode",
        "nickname" AS "plan_nickname",
        "product_id",
        "tiers_mode" AS "pricing_tier_mode",
        "transform_usage_divide_by" AS "usage_transform_divisor",
        "transform_usage_round" AS "usage_transform_rounding",
        "trial_period_days",
        "usage_type"
    FROM "plan_data_projected"
),

"plan_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- plan_id: The problem is that the plan_id column contains inconsistent formats and lengths. Some values start with numbers, others with letters, and there's no consistent pattern. The correct format appears to be a combination of letters and numbers, with the most common pattern being three letters followed by three numbers (e.g., 'abc123'). Values that don't fit this pattern should be considered unusual and need to be corrected. 
    SELECT
        CASE
            WHEN "plan_id" = '214gfdg' THEN 'gfd214'
            WHEN "plan_id" = '234rtgh' THEN 'rtg234'
            WHEN "plan_id" = '3gds' THEN 'gds003'
            WHEN "plan_id" = '3gf' THEN 'gfg003'
            WHEN "plan_id" = '5gh' THEN 'ghg005'
            WHEN "plan_id" = '634mfh' THEN 'mfh634'
            WHEN "plan_id" = '658jfgh' THEN 'jfg658'
            WHEN "plan_id" = 'ab2' THEN 'abc002'
            WHEN "plan_id" = 'dfgdw576' THEN 'dfw576'
            WHEN "plan_id" = 'fgds754' THEN 'fgs754'
            WHEN "plan_id" = 'hfdstrt345' THEN 'hft345'
            WHEN "plan_id" = 'rhsdr456' THEN 'rhs456'
            WHEN "plan_id" = 'zb1' THEN 'zbc001'
            ELSE "plan_id"
        END AS "plan_id",
        "is_active",
        "usage_aggregation_method",
        "price_in_cents",
        "billing_method",
        "creation_datetime",
        "currency_code",
        "billing_interval",
        "billing_cycle_duration",
        "is_deleted",
        "is_live_mode",
        "plan_nickname",
        "product_id",
        "pricing_tier_mode",
        "usage_transform_divisor",
        "usage_transform_rounding",
        "trial_period_days",
        "usage_type"
    FROM "plan_data_projected_renamed"
),

"plan_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- creation_datetime: from VARCHAR to TIMESTAMP
    -- plan_nickname: from DECIMAL to VARCHAR
    -- pricing_tier_mode: from DECIMAL to VARCHAR
    -- trial_period_days: from DECIMAL to INT
    -- usage_aggregation_method: from DECIMAL to VARCHAR
    -- usage_transform_divisor: from DECIMAL to INT
    -- usage_transform_rounding: from DECIMAL to VARCHAR
    SELECT
        "plan_id",
        "is_active",
        "price_in_cents",
        "billing_method",
        "currency_code",
        "billing_interval",
        "billing_cycle_duration",
        "is_deleted",
        "is_live_mode",
        "product_id",
        "usage_type",
        CAST("creation_datetime" AS TIMESTAMP) AS "creation_datetime",
        CAST("plan_nickname" AS VARCHAR) AS "plan_nickname",
        CAST("pricing_tier_mode" AS VARCHAR) AS "pricing_tier_mode",
        CAST("trial_period_days" AS INT) AS "trial_period_days",
        CAST("usage_aggregation_method" AS VARCHAR) AS "usage_aggregation_method",
        CAST("usage_transform_divisor" AS INT) AS "usage_transform_divisor",
        CAST("usage_transform_rounding" AS VARCHAR) AS "usage_transform_rounding"
    FROM "plan_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "plan_data_projected_renamed_cleaned_casted"