-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:46:10.136317+00:00
WITH 
"price_data_projected" AS (
    -- Projection: Selecting 22 out of 23 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "active",
        "billing_scheme",
        "created",
        "currency",
        "invoice_item_id",
        "is_deleted",
        "livemode",
        "lookup_key",
        "metadata",
        "nickname",
        "product_id",
        "recurring_aggregate_usage",
        "recurring_interval",
        "recurring_interval_count",
        "recurring_usage_type",
        "tiers_mode",
        "transform_quantity_divide_by",
        "transform_quantity_round",
        "type",
        "unit_amount",
        "unit_amount_decimal"
    FROM "MyAppDB"."dbo"."price_data"
),

"price_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> price_id
    -- active -> is_active
    -- created -> creation_date
    -- currency -> currency_code
    -- livemode -> is_live
    -- transform_quantity_divide_by -> quantity_transform_divisor
    -- transform_quantity_round -> quantity_transform_rounding
    -- type -> price_type
    SELECT 
        "id" AS "price_id",
        "active" AS "is_active",
        "billing_scheme",
        "created" AS "creation_date",
        "currency" AS "currency_code",
        "invoice_item_id",
        "is_deleted",
        "livemode" AS "is_live",
        "lookup_key",
        "metadata",
        "nickname",
        "product_id",
        "recurring_aggregate_usage",
        "recurring_interval",
        "recurring_interval_count",
        "recurring_usage_type",
        "tiers_mode",
        "transform_quantity_divide_by" AS "quantity_transform_divisor",
        "transform_quantity_round" AS "quantity_transform_rounding",
        "type" AS "price_type",
        "unit_amount",
        "unit_amount_decimal"
    FROM "price_data_projected"
),

"price_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to DATETIME
    -- is_active: from VARCHAR to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_live: from VARCHAR to BOOLEAN
    -- lookup_key: from FLOAT to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- nickname: from FLOAT to VARCHAR
    -- quantity_transform_divisor: from FLOAT to DECIMAL
    -- quantity_transform_rounding: from FLOAT to VARCHAR
    -- recurring_aggregate_usage: from FLOAT to VARCHAR
    -- recurring_interval: from FLOAT to VARCHAR
    -- recurring_interval_count: from FLOAT to INT
    -- recurring_usage_type: from FLOAT to VARCHAR
    -- tiers_mode: from FLOAT to VARCHAR
    -- unit_amount_decimal: from INT to DECIMAL
    SELECT
        "price_id",
        "billing_scheme",
        "currency_code",
        "invoice_item_id",
        "product_id",
        "price_type",
        "unit_amount",
        CAST("creation_date" AS DATETIME) 
        AS "creation_date",
        CAST("is_active" AS BIT) 
        AS "is_active",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CAST("is_live" AS BIT) 
        AS "is_live",
        CAST("lookup_key" AS VARCHAR) 
        AS "lookup_key",
        "metadata" 
        AS "metadata",
        CAST("nickname" AS VARCHAR) 
        AS "nickname",
        CAST("quantity_transform_divisor" AS DECIMAL) 
        AS "quantity_transform_divisor",
        CAST("quantity_transform_rounding" AS VARCHAR) 
        AS "quantity_transform_rounding",
        CAST("recurring_aggregate_usage" AS VARCHAR) 
        AS "recurring_aggregate_usage",
        CAST("recurring_interval" AS VARCHAR) 
        AS "recurring_interval",
        CAST("recurring_interval_count" AS INT) 
        AS "recurring_interval_count",
        CAST("recurring_usage_type" AS VARCHAR) 
        AS "recurring_usage_type",
        CAST("tiers_mode" AS VARCHAR) 
        AS "tiers_mode",
        CAST("unit_amount_decimal" AS DECIMAL(10,2)) 
        AS "unit_amount_decimal"
    FROM "price_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "price_data_projected_renamed_casted"