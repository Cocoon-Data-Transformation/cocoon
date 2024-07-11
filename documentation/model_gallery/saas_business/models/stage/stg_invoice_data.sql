-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "invoice_data"
),

"invoice_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> line_item_id
    -- date_ -> transaction_date
    -- discountable -> is_discountable
    -- livemode -> is_live_transaction
    -- period_end -> billing_period_end
    -- period_start -> billing_period_start
    -- proration -> is_prorated
    -- unit_amount -> unit_price
    SELECT 
        "id" AS "line_item_id",
        "amount",
        "currency",
        "customer_id",
        "date_" AS "transaction_date",
        "description",
        "discountable" AS "is_discountable",
        "invoice_id",
        "is_deleted",
        "livemode" AS "is_live_transaction",
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
    -- description: The problem is that 'description_here' is a placeholder value and not actual descriptive content. It appears to be the only value present in the description column, which suggests that real descriptions are missing. The correct values should be actual, meaningful descriptions of the items or entities being described. However, since we don't have access to the real descriptions, we can't provide them. 
    SELECT
        "line_item_id",
        "amount",
        "currency",
        "customer_id",
        "transaction_date",
        CASE
            WHEN "description" = '''description_here''' THEN ''''
            ELSE "description"
        END AS "description",
        "is_discountable",
        "invoice_id",
        "is_deleted",
        "is_live_transaction",
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
    -- billing_period_end: from VARCHAR to TIMESTAMP
    -- billing_period_start: from VARCHAR to TIMESTAMP
    -- transaction_date: from DECIMAL to DATE
    -- unit_price: from INT to DECIMAL
    SELECT
        "line_item_id",
        "currency",
        "customer_id",
        "description",
        "is_discountable",
        "invoice_id",
        "is_deleted",
        "is_live_transaction",
        "is_prorated",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        CAST("amount" AS DECIMAL) AS "amount",
        CAST("billing_period_end" AS TIMESTAMP) AS "billing_period_end",
        CAST("billing_period_start" AS TIMESTAMP) AS "billing_period_start",
        CAST("transaction_date" AS DATE) AS "transaction_date",
        CAST("unit_price" AS DECIMAL) AS "unit_price"
    FROM "invoice_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "invoice_data_projected_renamed_cleaned_casted"