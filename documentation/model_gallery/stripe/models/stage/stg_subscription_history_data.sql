-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"subscription_history_data_projected" AS (
    -- Projection: Selecting 25 out of 26 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_active",
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
    FROM "subscription_history_data"
),

"subscription_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> subscription_id
    -- _fivetran_active -> is_active
    -- application_fee_percent -> app_fee_percentage
    -- billing -> billing_method
    -- billing_cycle_anchor -> billing_cycle_start
    -- billing_threshold_amount_gte -> billing_threshold
    -- billing_threshold_reset_billing_cycle_anchor -> reset_billing_cycle_on_threshold
    -- cancel_at -> scheduled_cancellation_date
    -- canceled_at -> cancellation_date
    -- created -> creation_date
    -- days_until_due -> payment_due_days
    -- default_source_id -> default_payment_source_id
    -- ended_at -> end_date
    -- livemode -> is_live_mode
    -- quantity -> subscription_quantity
    -- status -> subscription_status
    -- tax_percent -> tax_percentage
    -- trial_end -> trial_end_date
    -- trial_start -> trial_start_date
    SELECT 
        "id" AS "subscription_id",
        "_fivetran_active" AS "is_active",
        "application_fee_percent" AS "app_fee_percentage",
        "billing" AS "billing_method",
        "billing_cycle_anchor" AS "billing_cycle_start",
        "billing_threshold_amount_gte" AS "billing_threshold",
        "billing_threshold_reset_billing_cycle_anchor" AS "reset_billing_cycle_on_threshold",
        "cancel_at" AS "scheduled_cancellation_date",
        "cancel_at_period_end",
        "canceled_at" AS "cancellation_date",
        "created" AS "creation_date",
        "current_period_end",
        "current_period_start",
        "customer_id",
        "days_until_due" AS "payment_due_days",
        "default_source_id" AS "default_payment_source_id",
        "ended_at" AS "end_date",
        "livemode" AS "is_live_mode",
        "metadata",
        "quantity" AS "subscription_quantity",
        "start_date",
        "status" AS "subscription_status",
        "tax_percent" AS "tax_percentage",
        "trial_end" AS "trial_end_date",
        "trial_start" AS "trial_start_date"
    FROM "subscription_history_data_projected"
),

"subscription_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_method: The problem is that both values 'fdfjk' and 'fdsiew' in the billing_method column are meaningless strings that do not represent valid billing methods. These appear to be random character combinations with no discernible meaning or pattern. The correct values for a billing method column should be actual payment methods like 'credit card', 'debit card', 'PayPal', 'bank transfer', etc. Since we don't have information about the correct billing methods, we'll map these meaningless strings to an empty string. 
    SELECT
        "subscription_id",
        "is_active",
        "app_fee_percentage",
        CASE
            WHEN "billing_method" = '''fdfjk''' THEN ''''
            WHEN "billing_method" = '''fdsiew''' THEN ''''
            ELSE "billing_method"
        END AS "billing_method",
        "billing_cycle_start",
        "billing_threshold",
        "reset_billing_cycle_on_threshold",
        "scheduled_cancellation_date",
        "cancel_at_period_end",
        "cancellation_date",
        "creation_date",
        "current_period_end",
        "current_period_start",
        "customer_id",
        "payment_due_days",
        "default_payment_source_id",
        "end_date",
        "is_live_mode",
        "metadata",
        "subscription_quantity",
        "start_date",
        "subscription_status",
        "tax_percentage",
        "trial_end_date",
        "trial_start_date"
    FROM "subscription_history_data_projected_renamed"
),

"subscription_history_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- app_fee_percentage: from INT to DECIMAL
    -- billing_cycle_start: from VARCHAR to TIMESTAMP
    -- cancellation_date: from VARCHAR to TIMESTAMP
    -- creation_date: from VARCHAR to TIMESTAMP
    -- current_period_end: from VARCHAR to TIMESTAMP
    -- current_period_start: from VARCHAR to TIMESTAMP
    -- end_date: from VARCHAR to TIMESTAMP
    -- metadata: from VARCHAR to JSON
    -- scheduled_cancellation_date: from VARCHAR to TIMESTAMP
    -- start_date: from VARCHAR to TIMESTAMP
    -- tax_percentage: from INT to DECIMAL
    -- trial_end_date: from VARCHAR to TIMESTAMP
    -- trial_start_date: from VARCHAR to TIMESTAMP
    SELECT
        "subscription_id",
        "is_active",
        "billing_method",
        "billing_threshold",
        "reset_billing_cycle_on_threshold",
        "cancel_at_period_end",
        "customer_id",
        "payment_due_days",
        "default_payment_source_id",
        "is_live_mode",
        "subscription_quantity",
        "subscription_status",
        CAST("app_fee_percentage" AS DECIMAL) AS "app_fee_percentage",
        CAST("billing_cycle_start" AS TIMESTAMP) AS "billing_cycle_start",
        CAST("cancellation_date" AS TIMESTAMP) AS "cancellation_date",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("current_period_end" AS TIMESTAMP) AS "current_period_end",
        CAST("current_period_start" AS TIMESTAMP) AS "current_period_start",
        CAST("end_date" AS TIMESTAMP) AS "end_date",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("scheduled_cancellation_date" AS TIMESTAMP) AS "scheduled_cancellation_date",
        CAST("start_date" AS TIMESTAMP) AS "start_date",
        CAST("tax_percentage" AS DECIMAL) AS "tax_percentage",
        CAST("trial_end_date" AS TIMESTAMP) AS "trial_end_date",
        CAST("trial_start_date" AS TIMESTAMP) AS "trial_start_date"
    FROM "subscription_history_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "subscription_history_data_projected_renamed_cleaned_casted"