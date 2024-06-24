-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sales_subscription_summary_projected" AS (
    -- Projection: Selecting 30 out of 31 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_filename",
        "account_number",
        "vendor_number",
        "_index",
        "developer_proceeds",
        "app_name",
        "free_trial_promotional_offer_subscriptions",
        "proceeds_currency",
        "subscription_name",
        "pay_as_you_go_promotional_offer_subscriptions",
        "customer_currency",
        "marketing_opt_ins",
        "pay_up_front_promotional_offer_subscriptions",
        "billing_retry",
        "proceeds_reason",
        "subscription_apple_id",
        "active_standard_price_subscriptions",
        "standard_subscription_duration",
        "grace_period",
        "device",
        "active_pay_up_front_introductory_offer_subscriptions",
        "customer_price",
        "promotional_offer_name",
        "state",
        "active_pay_as_you_go_introductory_offer_subscriptions",
        "subscription_group_id",
        "country",
        "active_free_trial_introductory_offer_subscriptions",
        "promotional_offer_id",
        "app_apple_id"
    FROM "sales_subscription_summary"
),

"sales_subscription_summary_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _filename -> source_file
    -- _index -> row_index
    -- free_trial_promotional_offer_subscriptions -> free_trial_promo_subs
    -- pay_as_you_go_promotional_offer_subscriptions -> pay_as_you_go_promo_subs
    -- marketing_opt_ins -> marketing_opt_in_count
    -- pay_up_front_promotional_offer_subscriptions -> pay_up_front_promo_subs
    -- billing_retry -> billing_retry_count
    -- active_standard_price_subscriptions -> active_standard_subs
    -- standard_subscription_duration -> standard_sub_duration
    -- grace_period -> grace_period_days
    -- device -> device_type
    -- active_pay_up_front_introductory_offer_subscriptions -> active_pay_up_front_intro_subs
    -- promotional_offer_name -> promo_offer_name
    -- state -> customer_state
    -- active_pay_as_you_go_introductory_offer_subscriptions -> active_pay_as_you_go_intro_subs
    -- country -> customer_country
    -- active_free_trial_introductory_offer_subscriptions -> active_free_trial_intro_subs
    -- promotional_offer_id -> promo_offer_id
    SELECT 
        _filename AS source_file,
        account_number,
        vendor_number,
        _index AS row_index,
        developer_proceeds,
        app_name,
        free_trial_promotional_offer_subscriptions AS free_trial_promo_subs,
        proceeds_currency,
        subscription_name,
        pay_as_you_go_promotional_offer_subscriptions AS pay_as_you_go_promo_subs,
        customer_currency,
        marketing_opt_ins AS marketing_opt_in_count,
        pay_up_front_promotional_offer_subscriptions AS pay_up_front_promo_subs,
        billing_retry AS billing_retry_count,
        proceeds_reason,
        subscription_apple_id,
        active_standard_price_subscriptions AS active_standard_subs,
        standard_subscription_duration AS standard_sub_duration,
        grace_period AS grace_period_days,
        device AS device_type,
        active_pay_up_front_introductory_offer_subscriptions AS active_pay_up_front_intro_subs,
        customer_price,
        promotional_offer_name AS promo_offer_name,
        state AS customer_state,
        active_pay_as_you_go_introductory_offer_subscriptions AS active_pay_as_you_go_intro_subs,
        subscription_group_id,
        country AS customer_country,
        active_free_trial_introductory_offer_subscriptions AS active_free_trial_intro_subs,
        promotional_offer_id AS promo_offer_id,
        app_apple_id
    FROM sales_subscription_summary_projected
),

"sales_subscription_summary_projected_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "source_file",
        "account_number",
        "vendor_number",
        "row_index",
        "developer_proceeds",
        "app_name",
        "free_trial_promo_subs",
        "subscription_name",
        "pay_as_you_go_promo_subs",
        "customer_currency",
        "marketing_opt_in_count",
        "pay_up_front_promo_subs",
        "billing_retry_count",
        "proceeds_reason",
        "subscription_apple_id",
        "active_standard_subs",
        "standard_sub_duration",
        "grace_period_days",
        "device_type",
        "active_pay_up_front_intro_subs",
        "customer_price",
        "active_pay_as_you_go_intro_subs",
        "subscription_group_id",
        "customer_country",
        "active_free_trial_intro_subs",
        "app_apple_id",
        TRIM("proceeds_currency") AS "proceeds_currency",
        TRIM("promo_offer_name") AS "promo_offer_name",
        TRIM("customer_state") AS "customer_state",
        TRIM("promo_offer_id") AS "promo_offer_id"
    FROM "sales_subscription_summary_projected_renamed"
),

"sales_subscription_summary_projected_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- customer_state: The problem is that some values in the customer_state column don't conform to standard US state abbreviations. The correct values should be two-letter US state codes, with the exception of 'DC' for District of Columbia. The empty string (''), 'AA', 'PO', and '부산' are unusual. 'AA' might be a typo for 'AZ' (Arizona), which is already present. 'PO' could be a typo for a state abbreviation but it's unclear which one. '부산' is a Korean city name and doesn't correspond to any US state. The empty string might indicate missing data. 
    -- promo_offer_id: The promo_offer_id column only contains empty strings, which do not identify any promotional offers. Since there are no other values to map to, we will leave the values as empty strings. 
    SELECT
        "source_file",
        "account_number",
        "vendor_number",
        "row_index",
        "developer_proceeds",
        "app_name",
        "free_trial_promo_subs",
        "subscription_name",
        "pay_as_you_go_promo_subs",
        "customer_currency",
        "marketing_opt_in_count",
        "pay_up_front_promo_subs",
        "billing_retry_count",
        "proceeds_reason",
        "subscription_apple_id",
        "active_standard_subs",
        "standard_sub_duration",
        "grace_period_days",
        "device_type",
        "active_pay_up_front_intro_subs",
        "customer_price",
        "active_pay_as_you_go_intro_subs",
        "subscription_group_id",
        "customer_country",
        "active_free_trial_intro_subs",
        "app_apple_id",
        "proceeds_currency",
        "promo_offer_name",
        CASE
            WHEN "customer_state" = 'AA' THEN 'AZ'
            WHEN "customer_state" = 'PO' THEN ''
            WHEN "customer_state" = '부산' THEN ''
            ELSE "customer_state"
        END AS "customer_state",
        "promo_offer_id"
    FROM "sales_subscription_summary_projected_renamed_trimmed"
),

"sales_subscription_summary_projected_renamed_trimmed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- proceeds_currency: ['']
    -- promo_offer_name: ['']
    -- customer_state: ['']
    -- promo_offer_id: ['']
    SELECT 
        CASE
            WHEN "proceeds_currency" = '' THEN NULL
            ELSE "proceeds_currency"
        END AS "proceeds_currency",
        CASE
            WHEN "promo_offer_name" = '' THEN NULL
            ELSE "promo_offer_name"
        END AS "promo_offer_name",
        CASE
            WHEN "customer_state" = '' THEN NULL
            ELSE "customer_state"
        END AS "customer_state",
        CASE
            WHEN "promo_offer_id" = '' THEN NULL
            ELSE "promo_offer_id"
        END AS "promo_offer_id",
        "grace_period_days",
        "subscription_name",
        "pay_as_you_go_promo_subs",
        "app_apple_id",
        "standard_sub_duration",
        "active_pay_as_you_go_intro_subs",
        "subscription_apple_id",
        "subscription_group_id",
        "source_file",
        "customer_country",
        "pay_up_front_promo_subs",
        "active_pay_up_front_intro_subs",
        "free_trial_promo_subs",
        "account_number",
        "developer_proceeds",
        "device_type",
        "marketing_opt_in_count",
        "proceeds_reason",
        "customer_price",
        "active_free_trial_intro_subs",
        "vendor_number",
        "active_standard_subs",
        "customer_currency",
        "billing_retry_count",
        "row_index",
        "app_name"
    FROM "sales_subscription_summary_projected_renamed_trimmed_cleaned"
),

"sales_subscription_summary_projected_renamed_trimmed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_number: from INT to VARCHAR
    -- app_apple_id: from INT to VARCHAR
    -- subscription_apple_id: from INT to VARCHAR
    -- subscription_group_id: from INT to VARCHAR
    -- vendor_number: from INT to VARCHAR
    SELECT
        "proceeds_currency",
        "promo_offer_name",
        "customer_state",
        "promo_offer_id",
        "grace_period_days",
        "subscription_name",
        "pay_as_you_go_promo_subs",
        "standard_sub_duration",
        "active_pay_as_you_go_intro_subs",
        "source_file",
        "customer_country",
        "pay_up_front_promo_subs",
        "active_pay_up_front_intro_subs",
        "free_trial_promo_subs",
        "developer_proceeds",
        "device_type",
        "marketing_opt_in_count",
        "proceeds_reason",
        "customer_price",
        "active_free_trial_intro_subs",
        "active_standard_subs",
        "customer_currency",
        "billing_retry_count",
        "row_index",
        "app_name",
        CAST("account_number" AS VARCHAR) AS "account_number",
        CAST("app_apple_id" AS VARCHAR) AS "app_apple_id",
        CAST("subscription_apple_id" AS VARCHAR) AS "subscription_apple_id",
        CAST("subscription_group_id" AS VARCHAR) AS "subscription_group_id",
        CAST("vendor_number" AS VARCHAR) AS "vendor_number"
    FROM "sales_subscription_summary_projected_renamed_trimmed_cleaned_null"
),

"sales_subscription_summary_projected_renamed_trimmed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- proceeds_currency has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- proceeds_reason has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- promo_offer_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- promo_offer_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "proceeds_currency",
        "customer_state",
        "grace_period_days",
        "subscription_name",
        "pay_as_you_go_promo_subs",
        "standard_sub_duration",
        "active_pay_as_you_go_intro_subs",
        "source_file",
        "customer_country",
        "pay_up_front_promo_subs",
        "active_pay_up_front_intro_subs",
        "free_trial_promo_subs",
        "developer_proceeds",
        "device_type",
        "marketing_opt_in_count",
        "proceeds_reason",
        "customer_price",
        "active_free_trial_intro_subs",
        "active_standard_subs",
        "customer_currency",
        "billing_retry_count",
        "row_index",
        "app_name",
        "account_number",
        "app_apple_id",
        "subscription_apple_id",
        "subscription_group_id",
        "vendor_number"
    FROM "sales_subscription_summary_projected_renamed_trimmed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sales_subscription_summary_projected_renamed_trimmed_cleaned_null_casted_missing_handled"