-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_adjustment_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "order_id",
        "refund_id",
        "amount",
        "tax_amount",
        "kind",
        "reason",
        "amount_set",
        "tax_amount_set"
    FROM "shopify_order_adjustment_data"
),

"shopify_order_adjustment_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> adjustment_id
    -- amount -> adjustment_amount_cents
    -- tax_amount -> tax_amount_cents
    -- kind -> adjustment_type
    -- reason -> adjustment_reason
    -- amount_set -> currency_info
    -- tax_amount_set -> tax_currency_info
    SELECT 
        "id" AS "adjustment_id",
        "order_id",
        "refund_id",
        "amount" AS "adjustment_amount_cents",
        "tax_amount" AS "tax_amount_cents",
        "kind" AS "adjustment_type",
        "reason" AS "adjustment_reason",
        "amount_set" AS "currency_info",
        "tax_amount_set" AS "tax_currency_info"
    FROM "shopify_order_adjustment_data_projected"
),

"shopify_order_adjustment_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- adjustment_id: from INT to VARCHAR
    -- currency_info: from DECIMAL to VARCHAR
    -- order_id: from INT to VARCHAR
    -- refund_id: from INT to VARCHAR
    -- tax_currency_info: from DECIMAL to VARCHAR
    SELECT
        "adjustment_amount_cents",
        "tax_amount_cents",
        "adjustment_type",
        "adjustment_reason",
        CAST("adjustment_id" AS VARCHAR) AS "adjustment_id",
        CAST("currency_info" AS VARCHAR) AS "currency_info",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("refund_id" AS VARCHAR) AS "refund_id",
        CAST("tax_currency_info" AS VARCHAR) AS "tax_currency_info"
    FROM "shopify_order_adjustment_data_projected_renamed"
),

"shopify_order_adjustment_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- currency_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_currency_info has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "adjustment_amount_cents",
        "tax_amount_cents",
        "adjustment_type",
        "adjustment_reason",
        "adjustment_id",
        "order_id",
        "refund_id"
    FROM "shopify_order_adjustment_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_adjustment_data_projected_renamed_casted_missing_handled"