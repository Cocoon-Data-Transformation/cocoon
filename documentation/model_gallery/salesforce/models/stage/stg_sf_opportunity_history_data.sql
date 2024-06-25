-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_opportunity_history_data_projected" AS (
    -- Projection: Selecting 34 out of 35 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "_fivetran_start",
        "_fivetran_end",
        "account_id",
        "amount",
        "campaign_id",
        "close_date",
        "created_date",
        "description",
        "expected_revenue",
        "fiscal",
        "fiscal_quarter",
        "fiscal_year",
        "forecast_category",
        "forecast_category_name",
        "has_open_activity",
        "has_opportunity_line_item",
        "has_overdue_task",
        "id",
        "is_closed",
        "is_deleted",
        "is_won",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "lead_source",
        "name",
        "next_step",
        "owner_id",
        "probability",
        "record_type_id",
        "stage_name",
        "synced_quote_id",
        "type"
    FROM "sf_opportunity_history_data"
),

"sf_opportunity_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- _fivetran_start -> validity_start_date
    -- _fivetran_end -> validity_end_date
    -- amount -> opportunity_amount
    -- fiscal -> fiscal_period
    -- forecast_category -> forecast_category_id
    -- has_opportunity_line_item -> has_line_items
    -- id -> opportunity_id
    -- lead_source -> lead_source_id
    -- name -> opportunity_name
    -- probability -> win_probability
    -- record_type_id -> opportunity_type_id
    -- type -> opportunity_category
    SELECT 
        "_fivetran_active" AS "is_active",
        "_fivetran_start" AS "validity_start_date",
        "_fivetran_end" AS "validity_end_date",
        "account_id",
        "amount" AS "opportunity_amount",
        "campaign_id",
        "close_date",
        "created_date",
        "description",
        "expected_revenue",
        "fiscal" AS "fiscal_period",
        "fiscal_quarter",
        "fiscal_year",
        "forecast_category" AS "forecast_category_id",
        "forecast_category_name",
        "has_open_activity",
        "has_opportunity_line_item" AS "has_line_items",
        "has_overdue_task",
        "id" AS "opportunity_id",
        "is_closed",
        "is_deleted",
        "is_won",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "lead_source" AS "lead_source_id",
        "name" AS "opportunity_name",
        "next_step",
        "owner_id",
        "probability" AS "win_probability",
        "record_type_id" AS "opportunity_type_id",
        "stage_name",
        "synced_quote_id",
        "type" AS "opportunity_category"
    FROM "sf_opportunity_history_data_projected"
),

"sf_opportunity_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- fiscal_period: The problem is that the fiscal_period column contains an encoded value 'JxJ3Au0JjyhOOUE/UvIeOw==' which is not a standard fiscal period format. This appears to be a Base64 encoded string, possibly used for data obfuscation or compression. Without knowing the decoding method or the original intended value, it's impossible to determine the correct fiscal period. The correct values for fiscal periods are typically in formats like 'Q1 2023', 'FY2023', or specific date ranges. 
    -- opportunity_name: The problem is that 'Blue Test -' has a trailing dash which should be removed.  'lu test 1', 'lu test 2', 'lu test 3' are redundant entries that should be consolidated.  The other values seem to be legitimate opportunity names and don't require changes.  The correct values should remove the trailing dash from 'Blue Test -' and consolidate the 'lu test' entries into a single value. 
    SELECT
        "is_active",
        "validity_start_date",
        "validity_end_date",
        "account_id",
        "opportunity_amount",
        "campaign_id",
        "close_date",
        "created_date",
        "description",
        "expected_revenue",
        CASE
            WHEN "fiscal_period" = 'JxJ3Au0JjyhOOUE/UvIeOw==' THEN ''
            ELSE "fiscal_period"
        END AS "fiscal_period",
        "fiscal_quarter",
        "fiscal_year",
        "forecast_category_id",
        "forecast_category_name",
        "has_open_activity",
        "has_line_items",
        "has_overdue_task",
        "opportunity_id",
        "is_closed",
        "is_deleted",
        "is_won",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "lead_source_id",
        CASE
            WHEN "opportunity_name" = 'Blue Test -' THEN 'Blue Test'
            WHEN "opportunity_name" = 'lu test 1' THEN 'lu test'
            WHEN "opportunity_name" = 'lu test 2' THEN 'lu test'
            WHEN "opportunity_name" = 'lu test 3' THEN 'lu test'
            ELSE "opportunity_name"
        END AS "opportunity_name",
        "next_step",
        "owner_id",
        "win_probability",
        "opportunity_type_id",
        "stage_name",
        "synced_quote_id",
        "opportunity_category"
    FROM "sf_opportunity_history_data_projected_renamed"
),

"sf_opportunity_history_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- validity_end_date: ['9999-12-31 23:59:59']
    -- fiscal_period: ['']
    SELECT 
        CASE
            WHEN "validity_end_date" = '9999-12-31 23:59:59' THEN NULL
            ELSE "validity_end_date"
        END AS "validity_end_date",
        CASE
            WHEN "fiscal_period" = '' THEN NULL
            ELSE "fiscal_period"
        END AS "fiscal_period",
        "forecast_category_id",
        "is_closed",
        "last_referenced_date",
        "opportunity_category",
        "next_step",
        "opportunity_type_id",
        "fiscal_quarter",
        "last_viewed_date",
        "validity_start_date",
        "has_overdue_task",
        "opportunity_amount",
        "is_deleted",
        "is_won",
        "last_activity_date",
        "expected_revenue",
        "description",
        "fiscal_year",
        "opportunity_id",
        "is_active",
        "account_id",
        "lead_source_id",
        "win_probability",
        "stage_name",
        "has_line_items",
        "owner_id",
        "close_date",
        "synced_quote_id",
        "created_date",
        "campaign_id",
        "forecast_category_name",
        "opportunity_name",
        "has_open_activity"
    FROM "sf_opportunity_history_data_projected_renamed_cleaned"
),

"sf_opportunity_history_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- campaign_id: from DECIMAL to VARCHAR
    -- close_date: from VARCHAR to DATE
    -- created_date: from VARCHAR to TIMESTAMP
    -- description: from DECIMAL to VARCHAR
    -- expected_revenue: from DECIMAL to VARCHAR
    -- fiscal_quarter: from INT to VARCHAR
    -- fiscal_year: from INT to VARCHAR
    -- last_activity_date: from DECIMAL to VARCHAR
    -- last_referenced_date: from DECIMAL to VARCHAR
    -- last_viewed_date: from DECIMAL to VARCHAR
    -- next_step: from DECIMAL to VARCHAR
    -- synced_quote_id: from DECIMAL to VARCHAR
    -- validity_end_date: from VARCHAR to TIMESTAMP
    -- validity_start_date: from VARCHAR to TIMESTAMP
    SELECT
        "fiscal_period",
        "forecast_category_id",
        "is_closed",
        "opportunity_category",
        "opportunity_type_id",
        "has_overdue_task",
        "opportunity_amount",
        "is_deleted",
        "is_won",
        "opportunity_id",
        "is_active",
        "account_id",
        "lead_source_id",
        "win_probability",
        "stage_name",
        "has_line_items",
        "owner_id",
        "forecast_category_name",
        "opportunity_name",
        "has_open_activity",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("close_date" AS DATE) AS "close_date",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("description" AS VARCHAR) AS "description",
        CAST("expected_revenue" AS VARCHAR) AS "expected_revenue",
        CAST("fiscal_quarter" AS VARCHAR) AS "fiscal_quarter",
        CAST("fiscal_year" AS VARCHAR) AS "fiscal_year",
        CAST("last_activity_date" AS VARCHAR) AS "last_activity_date",
        CAST("last_referenced_date" AS VARCHAR) AS "last_referenced_date",
        CAST("last_viewed_date" AS VARCHAR) AS "last_viewed_date",
        CAST("next_step" AS VARCHAR) AS "next_step",
        CAST("synced_quote_id" AS VARCHAR) AS "synced_quote_id",
        CAST("validity_end_date" AS TIMESTAMP) AS "validity_end_date",
        CAST("validity_start_date" AS TIMESTAMP) AS "validity_start_date"
    FROM "sf_opportunity_history_data_projected_renamed_cleaned_null"
),

"sf_opportunity_history_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 11 columns with unacceptable missing values
    -- description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- expected_revenue has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fiscal_period has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lead_source_id has 10.0 percent missing. Strategy: 🔄 Unchanged
    -- next_step has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opportunity_amount has 60.0 percent missing. Strategy: 🔄 Unchanged
    -- synced_quote_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- validity_end_date has 80.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "forecast_category_id",
        "is_closed",
        "opportunity_category",
        "opportunity_type_id",
        "has_overdue_task",
        "opportunity_amount",
        "is_deleted",
        "is_won",
        "opportunity_id",
        "is_active",
        "account_id",
        "lead_source_id",
        "win_probability",
        "stage_name",
        "has_line_items",
        "owner_id",
        "forecast_category_name",
        "opportunity_name",
        "has_open_activity",
        "campaign_id",
        "close_date",
        "created_date",
        "fiscal_quarter",
        "fiscal_year",
        "validity_end_date",
        "validity_start_date"
    FROM "sf_opportunity_history_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_opportunity_history_data_projected_renamed_cleaned_null_casted_missing_handled"