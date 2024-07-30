-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 03:18:41.588071+00:00
WITH 
"subscription_data_projected" AS (
    -- Projection: Selecting 24 out of 25 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "application_fee_percent",
        "billing",
        "billing_cycle_anchor",
        "billing_threshold_amount_gte",
        "billing_threshold_reset_billing_cycle_anchor",
        "cancel_at",
        "cancel_at_period_end",
        "canceled_at",
        "created",
        "current_period_end",
        "current_period_start",
        "customer_id",
        "days_until_due",
        "default_source_id",
        "ended_at",
        "livemode",
        "metadata",
        "quantity",
        "start_date",
        "status",
        "tax_percent",
        "trial_end",
        "trial_start"
    FROM "MyAppDB"."dbo"."subscription_data"
),

"subscription_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> subscription_id
    -- billing -> billing_method
    -- billing_cycle_anchor -> billing_cycle_start
    -- billing_threshold_amount_gte -> billing_threshold_amount
    -- billing_threshold_reset_billing_cycle_anchor -> reset_billing_cycle_on_threshold
    -- cancel_at -> scheduled_cancellation_date
    -- canceled_at -> cancellation_date
    -- created -> creation_date
    -- default_source_id -> default_payment_source_id
    -- ended_at -> end_date
    -- livemode -> is_live
    -- trial_end -> trial_end_date
    -- trial_start -> trial_start_date
    SELECT 
        "id" AS "subscription_id",
        "application_fee_percent",
        "billing" AS "billing_method",
        "billing_cycle_anchor" AS "billing_cycle_start",
        "billing_threshold_amount_gte" AS "billing_threshold_amount",
        "billing_threshold_reset_billing_cycle_anchor" AS "reset_billing_cycle_on_threshold",
        "cancel_at" AS "scheduled_cancellation_date",
        "cancel_at_period_end",
        "canceled_at" AS "cancellation_date",
        "created" AS "creation_date",
        "current_period_end",
        "current_period_start",
        "customer_id",
        "days_until_due",
        "default_source_id" AS "default_payment_source_id",
        "ended_at" AS "end_date",
        "livemode" AS "is_live",
        "metadata",
        "quantity",
        "start_date",
        "status",
        "tax_percent",
        "trial_end" AS "trial_end_date",
        "trial_start" AS "trial_start_date"
    FROM "subscription_data_projected"
),

"subscription_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_method: The problem is that both values in the billing_method column ('fdfjk' and 'fdsiew') are nonsensical strings that don't represent valid billing methods. These appear to be random character combinations with no meaningful interpretation in the context of billing. The correct values for a billing method column would typically include options like 'credit card', 'debit card', 'PayPal', 'bank transfer', 'cash', etc. Since we don't have any information about what the actual billing methods should be, and both existing values are meaningless, we should map them to an empty string to indicate missing or invalid data.
    -- is_live: The problem is that the is_live column appears to be a boolean column, but it only contains the value '1'. This is unusual because a boolean column typically has both '0' and '1' values to represent false and true states respectively. The absence of '0' values suggests that either all entries are live (which is possible but uncommon), or that non-live entries are being represented in a different way (perhaps as NULL or an empty string, which are not shown in the provided value list).
    SELECT
        "subscription_id",
        "application_fee_percent",
        CASE
            WHEN "billing_method" = 'fdfjk' THEN NULL
            WHEN "billing_method" = 'fdsiew' THEN NULL
            ELSE "billing_method"
        END AS "billing_method",
        "billing_cycle_start",
        "billing_threshold_amount",
        "reset_billing_cycle_on_threshold",
        "scheduled_cancellation_date",
        "cancel_at_period_end",
        "cancellation_date",
        "creation_date",
        "current_period_end",
        "current_period_start",
        "customer_id",
        "days_until_due",
        "default_payment_source_id",
        "end_date",
        "is_live",
        "metadata",
        "quantity",
        "start_date",
        "status",
        "tax_percent",
        "trial_end_date",
        "trial_start_date"
    FROM "subscription_data_projected_renamed"
),

"subscription_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- application_fee_percent: from INT to DECIMAL
    -- billing_cycle_start: from VARCHAR to DATETIME
    -- billing_threshold_amount: from INT to DECIMAL
    -- cancel_at_period_end: from VARCHAR to BOOLEAN
    -- cancellation_date: from VARCHAR to DATETIME
    -- creation_date: from VARCHAR to DATETIME
    -- current_period_end: from VARCHAR to DATETIME
    -- current_period_start: from VARCHAR to DATETIME
    -- end_date: from VARCHAR to DATETIME
    -- is_live: from VARCHAR to BOOLEAN
    -- metadata: from VARCHAR to JSON
    -- reset_billing_cycle_on_threshold: from VARCHAR to BOOLEAN
    -- scheduled_cancellation_date: from VARCHAR to DATETIME
    -- start_date: from VARCHAR to DATETIME
    -- tax_percent: from INT to DECIMAL
    -- trial_end_date: from VARCHAR to DATETIME
    -- trial_start_date: from VARCHAR to DATETIME
    SELECT
        "subscription_id",
        "billing_method",
        "customer_id",
        "days_until_due",
        "default_payment_source_id",
        "quantity",
        "status",
        CAST("application_fee_percent" AS DECIMAL) 
        AS "application_fee_percent",
        CAST("billing_cycle_start" AS DATETIME) 
        AS "billing_cycle_start",
        CAST("billing_threshold_amount" AS DECIMAL) 
        AS "billing_threshold_amount",
        CAST("cancel_at_period_end" AS BIT) 
        AS "cancel_at_period_end",
        CAST("cancellation_date" AS DATETIME) 
        AS "cancellation_date",
        CAST("creation_date" AS DATETIME) 
        AS "creation_date",
        CAST("current_period_end" AS DATETIME) 
        AS "current_period_end",
        CAST("current_period_start" AS DATETIME) 
        AS "current_period_start",
        CAST("end_date" AS DATETIME) 
        AS "end_date",
        CAST("is_live" AS BIT) 
        AS "is_live",
        "metadata" 
        AS "metadata",
        CAST(CASE WHEN "reset_billing_cycle_on_threshold" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "reset_billing_cycle_on_threshold",
        CAST("scheduled_cancellation_date" AS DATETIME) 
        AS "scheduled_cancellation_date",
        CAST("start_date" AS DATETIME) 
        AS "start_date",
        CAST("tax_percent" AS DECIMAL(3,1)) 
        AS "tax_percent",
        CAST("trial_end_date" AS DATETIME) 
        AS "trial_end_date",
        CAST("trial_start_date" AS DATETIME) 
        AS "trial_start_date"
    FROM "subscription_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "subscription_data_projected_renamed_cleaned_casted"