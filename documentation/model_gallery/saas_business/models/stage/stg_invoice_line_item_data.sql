-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"invoice_line_item_data_projected" AS (
    -- Projection: Selecting 17 out of 18 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "invoice_id",
        "amount",
        "currency",
        "description",
        "discountable",
        "livemode",
        "period_end",
        "period_start",
        "plan_id",
        "proration",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "type",
        "unique_id",
        "metadata"
    FROM "invoice_line_item_data"
),

"invoice_line_item_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> line_item_id
    -- discountable -> is_discountable
    -- livemode -> is_live_mode
    -- period_end -> billing_period_end
    -- period_start -> billing_period_start
    -- proration -> is_prorated
    -- type -> line_item_type
    -- unique_id -> alternate_item_id
    SELECT 
        "id" AS "line_item_id",
        "invoice_id",
        "amount",
        "currency",
        "description",
        "discountable" AS "is_discountable",
        "livemode" AS "is_live_mode",
        "period_end" AS "billing_period_end",
        "period_start" AS "billing_period_start",
        "plan_id",
        "proration" AS "is_prorated",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "type" AS "line_item_type",
        "unique_id" AS "alternate_item_id",
        "metadata"
    FROM "invoice_line_item_data_projected"
),

"invoice_line_item_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- description: The problem is that 'description_here' is a placeholder value and not actual descriptive content. It appears to be the only value present in the description column, which suggests that real descriptions are missing. The correct values should be actual, meaningful descriptions of the items or entities being described. However, since we don't have access to the real descriptions, we can't provide them. 
    SELECT
        "line_item_id",
        "invoice_id",
        "amount",
        "currency",
        CASE
            WHEN "description" = '''description_here''' THEN ''''
            ELSE "description"
        END AS "description",
        "is_discountable",
        "is_live_mode",
        "billing_period_end",
        "billing_period_start",
        "plan_id",
        "is_prorated",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "line_item_type",
        "alternate_item_id",
        "metadata"
    FROM "invoice_line_item_data_projected_renamed"
),

"invoice_line_item_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- metadata: ['{}']
    SELECT 
        CASE
            WHEN "metadata" = '{}' THEN NULL
            ELSE "metadata"
        END AS "metadata",
        "line_item_type",
        "line_item_id",
        "subscription_item_id",
        "alternate_item_id",
        "invoice_id",
        "quantity",
        "is_live_mode",
        "amount",
        "currency",
        "billing_period_end",
        "billing_period_start",
        "subscription_id",
        "plan_id",
        "is_prorated",
        "description",
        "is_discountable"
    FROM "invoice_line_item_data_projected_renamed_cleaned"
),

"invoice_line_item_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- amount: from INT to DECIMAL
    -- billing_period_end: from VARCHAR to TIMESTAMP
    -- billing_period_start: from VARCHAR to TIMESTAMP
    -- line_item_type: from DECIMAL to VARCHAR
    -- metadata: from VARCHAR to JSON
    SELECT
        "line_item_id",
        "subscription_item_id",
        "alternate_item_id",
        "invoice_id",
        "quantity",
        "is_live_mode",
        "currency",
        "subscription_id",
        "plan_id",
        "is_prorated",
        "description",
        "is_discountable",
        CAST("amount" AS DECIMAL) AS "amount",
        CAST("billing_period_end" AS TIMESTAMP) AS "billing_period_end",
        CAST("billing_period_start" AS TIMESTAMP) AS "billing_period_start",
        CAST("line_item_type" AS VARCHAR) AS "line_item_type",
        CAST("metadata" AS JSON) AS "metadata"
    FROM "invoice_line_item_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "invoice_line_item_data_projected_renamed_cleaned_null_casted"