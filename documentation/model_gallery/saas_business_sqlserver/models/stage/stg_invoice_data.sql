-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:45:21.730586+00:00
WITH 
"invoice_data_projected" AS (
    -- Projection: Selecting 17 out of 18 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "amount",
        "currency",
        "customer_id",
        "date_",
        "description",
        "discountable",
        "invoice_id",
        "is_deleted",
        "livemode",
        "period_end",
        "period_start",
        "proration",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "unit_amount"
    FROM "MyAppDB"."dbo"."invoice_data"
),

"invoice_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> line_item_id
    -- date_ -> item_date
    -- discountable -> is_discountable
    -- livemode -> is_live_mode
    -- period_end -> billing_period_end
    -- period_start -> billing_period_start
    -- proration -> is_prorated
    -- unit_amount -> unit_price
    SELECT 
        "id" AS "line_item_id",
        "amount",
        "currency",
        "customer_id",
        "date_" AS "item_date",
        "description",
        "discountable" AS "is_discountable",
        "invoice_id",
        "is_deleted",
        "livemode" AS "is_live_mode",
        "period_end" AS "billing_period_end",
        "period_start" AS "billing_period_start",
        "proration" AS "is_prorated",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "unit_amount" AS "unit_price"
    FROM "invoice_data_projected"
),

"invoice_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- description: The problem is that 'description_here' is a placeholder value and not actual descriptive content. This indicates that real descriptions are missing from the dataset. The correct values should be actual descriptions of the items or events, but since we don't have that information, the best approach is to map this placeholder to an empty string to indicate missing data.
    SELECT
        "line_item_id",
        "amount",
        "currency",
        "customer_id",
        "item_date",
        CASE
            WHEN "description" = 'description_here' THEN NULL
            ELSE "description"
        END AS "description",
        "is_discountable",
        "invoice_id",
        "is_deleted",
        "is_live_mode",
        "billing_period_end",
        "billing_period_start",
        "is_prorated",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "unit_price"
    FROM "invoice_data_projected_renamed"
),

"invoice_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- amount: from INT to DECIMAL
    -- billing_period_end: from VARCHAR to DATETIME
    -- billing_period_start: from VARCHAR to DATETIME
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_discountable: from VARCHAR to BOOLEAN
    -- is_live_mode: from VARCHAR to BOOLEAN
    -- is_prorated: from VARCHAR to BOOLEAN
    -- item_date: from FLOAT to DATE
    -- unit_price: from INT to DECIMAL
    SELECT
        "line_item_id",
        "currency",
        "customer_id",
        "description",
        "invoice_id",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        CAST("amount" AS DECIMAL) 
        AS "amount",
        CAST("billing_period_end" AS DATETIME) 
        AS "billing_period_end",
        CAST("billing_period_start" AS DATETIME) 
        AS "billing_period_start",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CAST("is_discountable" AS BIT) 
        AS "is_discountable",
        CAST("is_live_mode" AS BIT) 
        AS "is_live_mode",
        CASE WHEN "is_prorated" = '0' THEN 0 ELSE 1 END 
        AS "is_prorated",
        CAST(DATEADD(day, CAST("item_date" AS INT), '1900-01-01') AS DATE) 
        AS "item_date",
        CAST("unit_price" AS DECIMAL) 
        AS "unit_price"
    FROM "invoice_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "invoice_data_projected_renamed_cleaned_casted"