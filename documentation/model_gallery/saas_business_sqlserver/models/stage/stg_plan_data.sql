-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:46:06.645685+00:00
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
    FROM "MyAppDB"."dbo"."plan_data"
),

"plan_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> plan_id
    -- active -> is_active
    -- amount -> price_cents
    -- created -> creation_date
    -- interval_ -> billing_interval
    -- interval_count -> billing_cycle_length
    -- livemode -> is_live
    -- transform_usage_divide_by -> usage_divisor
    -- transform_usage_round -> usage_rounding
    -- trial_period_days -> trial_days
    SELECT 
        "id" AS "plan_id",
        "active" AS "is_active",
        "aggregate_usage",
        "amount" AS "price_cents",
        "billing_scheme",
        "created" AS "creation_date",
        "currency",
        "interval_" AS "billing_interval",
        "interval_count" AS "billing_cycle_length",
        "is_deleted",
        "livemode" AS "is_live",
        "nickname",
        "product_id",
        "tiers_mode",
        "transform_usage_divide_by" AS "usage_divisor",
        "transform_usage_round" AS "usage_rounding",
        "trial_period_days" AS "trial_days",
        "usage_type"
    FROM "plan_data_projected"
),

"plan_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- aggregate_usage: from FLOAT to VARCHAR
    -- creation_date: from VARCHAR to DATETIME
    -- is_active: from VARCHAR to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_live: from VARCHAR to BOOLEAN
    -- nickname: from FLOAT to VARCHAR
    -- tiers_mode: from FLOAT to VARCHAR
    -- trial_days: from FLOAT to INT
    -- usage_divisor: from FLOAT to INT
    -- usage_rounding: from FLOAT to VARCHAR
    SELECT
        "plan_id",
        "price_cents",
        "billing_scheme",
        "currency",
        "billing_interval",
        "billing_cycle_length",
        "product_id",
        "usage_type",
        CAST("aggregate_usage" AS VARCHAR) 
        AS "aggregate_usage",
        CAST("creation_date" AS DATETIME) 
        AS "creation_date",
        CAST("is_active" AS BIT) 
        AS "is_active",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CAST("is_live" AS BIT) 
        AS "is_live",
        CAST("nickname" AS VARCHAR) 
        AS "nickname",
        CAST("tiers_mode" AS VARCHAR) 
        AS "tiers_mode",
        CAST("trial_days" AS INT) 
        AS "trial_days",
        CAST("usage_divisor" AS INT) 
        AS "usage_divisor",
        CAST("usage_rounding" AS VARCHAR) 
        AS "usage_rounding"
    FROM "plan_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "plan_data_projected_renamed_casted"