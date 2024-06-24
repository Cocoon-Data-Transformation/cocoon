-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sales_subscription_events_projected" AS (
    -- Projection: Selecting 29 out of 30 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_filename",
        "account_number",
        "vendor_number",
        "_index",
        "event_date",
        "app_name",
        "days_canceled",
        "subscription_name",
        "consecutive_paid_periods",
        "previous_subscription_name",
        "cancellation_reason",
        "proceeds_reason",
        "subscription_apple_id",
        "standard_subscription_duration",
        "original_start_date",
        "device",
        "days_before_canceling",
        "quantity",
        "marketing_opt_in_duration",
        "promotional_offer_name",
        "state",
        "previous_subscription_apple_id",
        "event",
        "subscription_group_id",
        "country",
        "promotional_offer_id",
        "app_apple_id",
        "subscription_offer_type",
        "subscription_offer_duration"
    FROM "sales_subscription_events"
),

"sales_subscription_events_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _filename -> source_file
    -- _index -> row_index
    -- device -> device_type
    -- quantity -> subscription_quantity
    -- state -> user_state
    -- event -> event_type
    -- country -> country_code
    SELECT 
        _filename AS source_file,
        account_number,
        vendor_number,
        _index AS row_index,
        event_date,
        app_name,
        days_canceled,
        subscription_name,
        consecutive_paid_periods,
        previous_subscription_name,
        cancellation_reason,
        proceeds_reason,
        subscription_apple_id,
        standard_subscription_duration,
        original_start_date,
        device AS device_type,
        days_before_canceling,
        quantity AS subscription_quantity,
        marketing_opt_in_duration,
        promotional_offer_name,
        state AS user_state,
        previous_subscription_apple_id,
        event AS event_type,
        subscription_group_id,
        country AS country_code,
        promotional_offer_id,
        app_apple_id,
        subscription_offer_type,
        subscription_offer_duration
    FROM sales_subscription_events_projected
),

"sales_subscription_events_projected_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "source_file",
        "account_number",
        "vendor_number",
        "row_index",
        "event_date",
        "app_name",
        "subscription_name",
        "consecutive_paid_periods",
        "previous_subscription_name",
        "proceeds_reason",
        "subscription_apple_id",
        "standard_subscription_duration",
        "original_start_date",
        "device_type",
        "subscription_quantity",
        "event_type",
        "subscription_group_id",
        "country_code",
        "app_apple_id",
        "subscription_offer_type",
        "subscription_offer_duration",
        TRIM("days_canceled") AS "days_canceled",
        TRIM("cancellation_reason") AS "cancellation_reason",
        TRIM("days_before_canceling") AS "days_before_canceling",
        TRIM("marketing_opt_in_duration") AS "marketing_opt_in_duration",
        TRIM("promotional_offer_name") AS "promotional_offer_name",
        TRIM("user_state") AS "user_state",
        TRIM("previous_subscription_apple_id") AS "previous_subscription_apple_id",
        TRIM("promotional_offer_id") AS "promotional_offer_id"
    FROM "sales_subscription_events_projected_renamed"
),

"sales_subscription_events_projected_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- user_state: The problem is that this column contains non-standard US state abbreviations and empty values. 'KA' is likely a typo for 'KS' (Kansas). 'ON' is not a US state abbreviation, but could represent Ontario, Canada. Empty values should be preserved as they might represent missing data. The correct values should be standard US state abbreviations or empty strings for missing data. 
    SELECT
        "source_file",
        "account_number",
        "vendor_number",
        "row_index",
        "event_date",
        "app_name",
        "subscription_name",
        "consecutive_paid_periods",
        "previous_subscription_name",
        "proceeds_reason",
        "subscription_apple_id",
        "standard_subscription_duration",
        "original_start_date",
        "device_type",
        "subscription_quantity",
        "event_type",
        "subscription_group_id",
        "country_code",
        "app_apple_id",
        "subscription_offer_type",
        "subscription_offer_duration",
        "days_canceled",
        "cancellation_reason",
        "days_before_canceling",
        "marketing_opt_in_duration",
        "promotional_offer_name",
        CASE
            WHEN "user_state" = 'KA' THEN 'KS'
            WHEN "user_state" = 'ON' THEN ''
            ELSE "user_state"
        END AS "user_state",
        "previous_subscription_apple_id",
        "promotional_offer_id"
    FROM "sales_subscription_events_projected_renamed_trimmed"
),

"sales_subscription_events_projected_renamed_trimmed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- days_canceled: ['']
    -- cancellation_reason: ['']
    -- days_before_canceling: ['']
    -- marketing_opt_in_duration: ['']
    -- promotional_offer_name: ['']
    -- user_state: ['']
    -- previous_subscription_apple_id: ['']
    -- promotional_offer_id: ['']
    SELECT 
        CASE
            WHEN "days_canceled" = '' THEN NULL
            ELSE "days_canceled"
        END AS "days_canceled",
        CASE
            WHEN "cancellation_reason" = '' THEN NULL
            ELSE "cancellation_reason"
        END AS "cancellation_reason",
        CASE
            WHEN "days_before_canceling" = '' THEN NULL
            ELSE "days_before_canceling"
        END AS "days_before_canceling",
        CASE
            WHEN "marketing_opt_in_duration" = '' THEN NULL
            ELSE "marketing_opt_in_duration"
        END AS "marketing_opt_in_duration",
        CASE
            WHEN "promotional_offer_name" = '' THEN NULL
            ELSE "promotional_offer_name"
        END AS "promotional_offer_name",
        CASE
            WHEN "user_state" = '' THEN NULL
            ELSE "user_state"
        END AS "user_state",
        CASE
            WHEN "previous_subscription_apple_id" = '' THEN NULL
            ELSE "previous_subscription_apple_id"
        END AS "previous_subscription_apple_id",
        CASE
            WHEN "promotional_offer_id" = '' THEN NULL
            ELSE "promotional_offer_id"
        END AS "promotional_offer_id",
        "subscription_name",
        "app_apple_id",
        "row_index",
        "subscription_apple_id",
        "subscription_group_id",
        "previous_subscription_name",
        "source_file",
        "subscription_offer_duration",
        "consecutive_paid_periods",
        "account_number",
        "event_type",
        "device_type",
        "original_start_date",
        "standard_subscription_duration",
        "proceeds_reason",
        "country_code",
        "subscription_offer_type",
        "vendor_number",
        "event_date",
        "subscription_quantity",
        "app_name"
    FROM "sales_subscription_events_projected_renamed_trimmed_cleaned"
),

"sales_subscription_events_projected_renamed_trimmed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_number: from INT to VARCHAR
    -- app_apple_id: from INT to VARCHAR
    -- days_before_canceling: from VARCHAR to INT
    -- days_canceled: from VARCHAR to INT
    -- event_date: from VARCHAR to DATE
    -- original_start_date: from VARCHAR to DATE
    -- previous_subscription_name: from DECIMAL to VARCHAR
    -- subscription_apple_id: from INT to VARCHAR
    -- subscription_group_id: from INT to VARCHAR
    -- subscription_offer_duration: from DECIMAL to VARCHAR
    -- subscription_offer_type: from DECIMAL to VARCHAR
    -- vendor_number: from INT to VARCHAR
    SELECT
        "cancellation_reason",
        "marketing_opt_in_duration",
        "promotional_offer_name",
        "user_state",
        "previous_subscription_apple_id",
        "promotional_offer_id",
        "subscription_name",
        "row_index",
        "source_file",
        "consecutive_paid_periods",
        "event_type",
        "device_type",
        "standard_subscription_duration",
        "proceeds_reason",
        "country_code",
        "subscription_quantity",
        "app_name",
        CAST("account_number" AS VARCHAR) AS "account_number",
        CAST("app_apple_id" AS VARCHAR) AS "app_apple_id",
        CAST("days_before_canceling" AS INT) AS "days_before_canceling",
        CAST("days_canceled" AS INT) AS "days_canceled",
        CAST("event_date" AS DATE) AS "event_date",
        CAST("original_start_date" AS DATE) AS "original_start_date",
        CAST("previous_subscription_name" AS VARCHAR) AS "previous_subscription_name",
        CAST("subscription_apple_id" AS VARCHAR) AS "subscription_apple_id",
        CAST("subscription_group_id" AS VARCHAR) AS "subscription_group_id",
        CAST("subscription_offer_duration" AS VARCHAR) AS "subscription_offer_duration",
        CAST("subscription_offer_type" AS VARCHAR) AS "subscription_offer_type",
        CAST("vendor_number" AS VARCHAR) AS "vendor_number"
    FROM "sales_subscription_events_projected_renamed_trimmed_cleaned_null"
),

"sales_subscription_events_projected_renamed_trimmed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- marketing_opt_in_duration has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- proceeds_reason has 60.0 percent missing. Strategy: 🔄 Unchanged
    -- user_state has 30.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "cancellation_reason",
        "promotional_offer_name",
        "user_state",
        "previous_subscription_apple_id",
        "promotional_offer_id",
        "subscription_name",
        "row_index",
        "source_file",
        "consecutive_paid_periods",
        "event_type",
        "device_type",
        "standard_subscription_duration",
        "proceeds_reason",
        "country_code",
        "subscription_quantity",
        "app_name",
        "account_number",
        "app_apple_id",
        "days_before_canceling",
        "days_canceled",
        "event_date",
        "original_start_date",
        "previous_subscription_name",
        "subscription_apple_id",
        "subscription_group_id",
        "subscription_offer_duration",
        "subscription_offer_type",
        "vendor_number"
    FROM "sales_subscription_events_projected_renamed_trimmed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sales_subscription_events_projected_renamed_trimmed_cleaned_null_casted_missing_handled"