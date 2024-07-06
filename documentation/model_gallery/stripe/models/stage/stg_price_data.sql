-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "price_data"
),

"price_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> price_id
    -- active -> is_active
    -- created -> creation_date
    -- currency -> currency_code
    -- livemode -> is_live_mode
    -- nickname -> friendly_name
    -- recurring_aggregate_usage -> recurring_usage_aggregation
    -- transform_quantity_divide_by -> quantity_divide_by
    -- transform_quantity_round -> quantity_round
    -- type -> price_type
    SELECT 
        "id" AS "price_id",
        "active" AS "is_active",
        "billing_scheme",
        "created" AS "creation_date",
        "currency" AS "currency_code",
        "invoice_item_id",
        "is_deleted",
        "livemode" AS "is_live_mode",
        "lookup_key",
        "metadata",
        "nickname" AS "friendly_name",
        "product_id",
        "recurring_aggregate_usage" AS "recurring_usage_aggregation",
        "recurring_interval",
        "recurring_interval_count",
        "recurring_usage_type",
        "tiers_mode",
        "transform_quantity_divide_by" AS "quantity_divide_by",
        "transform_quantity_round" AS "quantity_round",
        "type" AS "price_type",
        "unit_amount",
        "unit_amount_decimal"
    FROM "price_data_projected"
),

"price_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to TIMESTAMP
    -- friendly_name: from DECIMAL to VARCHAR
    -- lookup_key: from DECIMAL to VARCHAR
    -- metadata: from VARCHAR to JSON
    -- quantity_divide_by: from DECIMAL to VARCHAR
    -- quantity_round: from DECIMAL to VARCHAR
    -- recurring_interval: from DECIMAL to VARCHAR
    -- recurring_interval_count: from DECIMAL to VARCHAR
    -- recurring_usage_aggregation: from DECIMAL to VARCHAR
    -- recurring_usage_type: from DECIMAL to VARCHAR
    -- tiers_mode: from DECIMAL to VARCHAR
    -- unit_amount_decimal: from INT to DECIMAL
    SELECT
        "price_id",
        "is_active",
        "billing_scheme",
        "currency_code",
        "invoice_item_id",
        "is_deleted",
        "is_live_mode",
        "product_id",
        "price_type",
        "unit_amount",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("friendly_name" AS VARCHAR) AS "friendly_name",
        CAST("lookup_key" AS VARCHAR) AS "lookup_key",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("quantity_divide_by" AS VARCHAR) AS "quantity_divide_by",
        CAST("quantity_round" AS VARCHAR) AS "quantity_round",
        CAST("recurring_interval" AS VARCHAR) AS "recurring_interval",
        CAST("recurring_interval_count" AS VARCHAR) AS "recurring_interval_count",
        CAST("recurring_usage_aggregation" AS VARCHAR) AS "recurring_usage_aggregation",
        CAST("recurring_usage_type" AS VARCHAR) AS "recurring_usage_type",
        CAST("tiers_mode" AS VARCHAR) AS "tiers_mode",
        CAST("unit_amount_decimal" AS DECIMAL(10,2)) AS "unit_amount_decimal"
    FROM "price_data_projected_renamed"
),

"price_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- friendly_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lookup_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_divide_by has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_round has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "price_id",
        "is_active",
        "billing_scheme",
        "currency_code",
        "invoice_item_id",
        "is_deleted",
        "is_live_mode",
        "product_id",
        "price_type",
        "unit_amount",
        "creation_date",
        "metadata",
        "recurring_interval",
        "recurring_interval_count",
        "recurring_usage_aggregation",
        "recurring_usage_type",
        "tiers_mode",
        "unit_amount_decimal"
    FROM "price_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "price_data_projected_renamed_casted_missing_handled"