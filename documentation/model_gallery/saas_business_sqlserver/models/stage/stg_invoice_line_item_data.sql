-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:45:50.828909+00:00
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
    FROM "MyAppDB"."dbo"."invoice_line_item_data"
),

"invoice_line_item_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> line_item_id
    -- discountable -> is_discountable
    -- livemode -> is_live
    -- period_end -> billing_period_end
    -- period_start -> billing_period_start
    -- proration -> is_prorated
    -- type -> item_type
    -- unique_id -> alternate_item_id
    SELECT 
        "id" AS "line_item_id",
        "invoice_id",
        "amount",
        "currency",
        "description",
        "discountable" AS "is_discountable",
        "livemode" AS "is_live",
        "period_end" AS "billing_period_end",
        "period_start" AS "billing_period_start",
        "plan_id",
        "proration" AS "is_prorated",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "type" AS "item_type",
        "unique_id" AS "alternate_item_id",
        "metadata"
    FROM "invoice_line_item_data_projected"
),

"invoice_line_item_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- description: The problem is that 'description_here' is a placeholder value and not actual descriptive content. This indicates that real descriptions are missing from the dataset. The correct values should be actual descriptions of the items or events, but since we don't have that information, the best approach is to map this placeholder to an empty string to indicate missing data.
    -- is_live: The problem is that the is_live column appears to be a boolean column, but it only contains the value '1'. This is unusual because a boolean column typically has both '0' and '1' values to represent false and true states respectively. The absence of '0' values suggests that either all entries are live (which is possible but uncommon), or that non-live entries are being represented in a different way (perhaps as NULL or an empty string, which are not shown in the provided value list).
    SELECT
        "line_item_id",
        "invoice_id",
        "amount",
        "currency",
        CASE
            WHEN "description" = 'description_here' THEN NULL
            ELSE "description"
        END AS "description",
        "is_discountable",
        "is_live",
        "billing_period_end",
        "billing_period_start",
        "plan_id",
        "is_prorated",
        "quantity",
        "subscription_id",
        "subscription_item_id",
        "item_type",
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
        "is_prorated",
        "invoice_id",
        "quantity",
        "item_type",
        "is_discountable",
        "plan_id",
        "subscription_id",
        "description",
        "amount",
        "alternate_item_id",
        "billing_period_start",
        "line_item_id",
        "currency",
        "is_live",
        "billing_period_end",
        "subscription_item_id"
    FROM "invoice_line_item_data_projected_renamed_cleaned"
),

"invoice_line_item_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- amount: from INT to DECIMAL
    -- billing_period_end: from VARCHAR to DATETIME
    -- billing_period_start: from VARCHAR to DATETIME
    -- is_discountable: from VARCHAR to BOOLEAN
    -- is_live: from VARCHAR to BOOLEAN
    -- is_prorated: from VARCHAR to BOOLEAN
    -- item_type: from FLOAT to VARCHAR
    -- metadata: from VARCHAR to JSON
    SELECT
        "invoice_id",
        "quantity",
        "plan_id",
        "subscription_id",
        "description",
        "alternate_item_id",
        "line_item_id",
        "currency",
        "subscription_item_id",
        CAST("amount" AS DECIMAL) 
        AS "amount",
        CAST("billing_period_end" AS DATETIME) 
        AS "billing_period_end",
        CAST("billing_period_start" AS DATETIME) 
        AS "billing_period_start",
        CAST("is_discountable" AS BIT) 
        AS "is_discountable",
        CAST("is_live" AS BIT) 
        AS "is_live",
        CASE WHEN "is_prorated" = '0' THEN 0 ELSE 1 END 
        AS "is_prorated",
        CAST("item_type" AS VARCHAR) 
        AS "item_type",
        "metadata" 
        AS "metadata"
    FROM "invoice_line_item_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "invoice_line_item_data_projected_renamed_cleaned_null_casted"