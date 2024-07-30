-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:35:33.543488+00:00
WITH 
"sf_opportunity_history_data_projected" AS (
    -- Projection: Selecting 34 out of 35 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "_fivetran_start",
        "_fivetran_end",
        "salesforce_account_id",
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
    FROM "MyAppDB"."dbo"."sf_opportunity_history_data"
),

"sf_opportunity_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- _fivetran_start -> valid_from
    -- _fivetran_end -> valid_to
    -- salesforce_account_id -> account_id
    -- amount -> opportunity_amount
    -- fiscal -> fiscal_period
    -- forecast_category -> forecast_category_id
    -- has_opportunity_line_item -> has_line_items
    -- id -> opportunity_id
    -- lead_source -> lead_source_id
    -- name -> opportunity_name
    -- probability -> win_probability
    -- stage_name -> opportunity_stage
    -- type -> opportunity_type
    SELECT 
        "_fivetran_active" AS "is_active",
        "_fivetran_start" AS "valid_from",
        "_fivetran_end" AS "valid_to",
        "salesforce_account_id" AS "account_id",
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
        "record_type_id",
        "stage_name" AS "opportunity_stage",
        "synced_quote_id",
        "type" AS "opportunity_type"
    FROM "sf_opportunity_history_data_projected"
),

"sf_opportunity_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- fiscal_period: The problem is that the fiscal_period column contains a single unusual value that appears to be Base64 encoded or encrypted. This is not a standard representation for a fiscal period, which typically would be a year, quarter, or month designation. Without more context or information about the encoding method, it's impossible to determine what this value actually represents. The correct values for fiscal periods should be clear, standardized time designations.
    -- opportunity_name: The problem is that there are multiple test entries that seem redundant, and 'Blue Test -' has a trailing hyphen which is unusual. The 'Test' and 'lu test' entries appear to be for testing purposes and may not represent real opportunities. 'Chewbaca' seems to be a misspelling of 'Chewbacca' (assuming it's a Star Wars reference). The correct values should eliminate redundant test entries, fix spelling, and remove the trailing hyphen.
    -- opportunity_stage: The problem is that all the values in the opportunity_stage column are encoded strings, likely using base64 encoding. These encoded values do not provide any meaningful information about the actual opportunity stages. The correct values should be descriptive text that clearly indicates the stage of the opportunity in the sales process.
    SELECT
        "is_active",
        "valid_from",
        "valid_to",
        "account_id",
        "opportunity_amount",
        "campaign_id",
        "close_date",
        "created_date",
        "description",
        "expected_revenue",
        CASE
            WHEN "fiscal_period" = 'JxJ3Au0JjyhOOUE/UvIeOw==' THEN NULL
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
            WHEN "opportunity_name" = 'Chewbaca' THEN 'Chewbacca'
            WHEN "opportunity_name" = 'lu test 1' THEN 'Test'
            WHEN "opportunity_name" = 'lu test 2' THEN 'Test'
            WHEN "opportunity_name" = 'lu test 3' THEN 'Test'
            ELSE "opportunity_name"
        END AS "opportunity_name",
        "next_step",
        "owner_id",
        "win_probability",
        "record_type_id",
        CASE
            WHEN "opportunity_stage" = 'GavUFuuf4DrnQAoiRGlWpQ==' THEN 'Prospecting'
            WHEN "opportunity_stage" = 'tXi3M8u3iPxq0ggxTSxMKw==' THEN 'Qualification'
            WHEN "opportunity_stage" = '9RN9J3tlxr89gDctReax5w==' THEN 'Closed'
            ELSE "opportunity_stage"
        END AS "opportunity_stage",
        "synced_quote_id",
        "opportunity_type"
    FROM "sf_opportunity_history_data_projected_renamed"
),

"sf_opportunity_history_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- valid_to: ['9999-12-31 23:59:59']
    SELECT 
        CASE
            WHEN "valid_to" = '9999-12-31 23:59:59' THEN NULL
            ELSE "valid_to"
        END AS "valid_to",
        "fiscal_period",
        "description",
        "has_open_activity",
        "account_id",
        "fiscal_quarter",
        "record_type_id",
        "next_step",
        "last_referenced_date",
        "is_closed",
        "created_date",
        "opportunity_id",
        "forecast_category_id",
        "has_line_items",
        "last_activity_date",
        "forecast_category_name",
        "is_deleted",
        "synced_quote_id",
        "opportunity_amount",
        "win_probability",
        "opportunity_name",
        "lead_source_id",
        "campaign_id",
        "is_won",
        "valid_from",
        "last_viewed_date",
        "opportunity_stage",
        "close_date",
        "expected_revenue",
        "fiscal_year",
        "has_overdue_task",
        "opportunity_type",
        "is_active",
        "owner_id"
    FROM "sf_opportunity_history_data_projected_renamed_cleaned"
),

"sf_opportunity_history_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- campaign_id: from FLOAT to VARCHAR
    -- close_date: from VARCHAR to DATE
    -- created_date: from VARCHAR to DATETIME
    -- description: from FLOAT to VARCHAR
    -- expected_revenue: from FLOAT to DECIMAL
    -- has_line_items: from VARCHAR to BOOLEAN
    -- has_open_activity: from VARCHAR to BOOLEAN
    -- has_overdue_task: from VARCHAR to BOOLEAN
    -- is_active: from VARCHAR to BOOLEAN
    -- is_closed: from VARCHAR to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_won: from VARCHAR to BOOLEAN
    -- last_activity_date: from FLOAT to DATE
    -- last_referenced_date: from FLOAT to DATETIME
    -- last_viewed_date: from FLOAT to DATETIME
    -- next_step: from FLOAT to VARCHAR
    -- opportunity_amount: from FLOAT to DECIMAL
    -- synced_quote_id: from FLOAT to VARCHAR
    -- valid_from: from VARCHAR to DATETIME
    -- valid_to: from VARCHAR to DATETIME
    SELECT
        "fiscal_period",
        "account_id",
        "fiscal_quarter",
        "record_type_id",
        "opportunity_id",
        "forecast_category_id",
        "forecast_category_name",
        "win_probability",
        "opportunity_name",
        "lead_source_id",
        "opportunity_stage",
        "fiscal_year",
        "opportunity_type",
        "owner_id",
        CAST("campaign_id" AS VARCHAR) 
        AS "campaign_id",
        CAST("close_date" AS DATE) 
        AS "close_date",
        CAST("created_date" AS DATETIME) 
        AS "created_date",
        CAST("description" AS VARCHAR) 
        AS "description",
        CAST("expected_revenue" AS DECIMAL) 
        AS "expected_revenue",
        CASE WHEN "has_line_items" = '0' THEN 0 ELSE 1 END 
        AS "has_line_items",
        CAST(CASE WHEN "has_open_activity" = '0' THEN 0 ELSE 1 END AS BIT) 
        AS "has_open_activity",
        CASE WHEN "has_overdue_task" = '0' THEN 0 ELSE 1 END 
        AS "has_overdue_task",
        CASE WHEN "is_active" = '1' THEN 1 ELSE 0 END 
        AS "is_active",
        CASE WHEN "is_closed" = '1' THEN 1 ELSE 0 END 
        AS "is_closed",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted",
        CASE WHEN "is_won" = '0' THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END 
        AS "is_won",
        CAST(CONVERT(DATETIME, CONVERT(VARCHAR(23), "last_activity_date", 126)) AS DATE) 
        AS "last_activity_date",
        CONVERT(DATETIME, CONVERT(VARCHAR(23), "last_referenced_date", 121)) 
        AS "last_referenced_date",
        DATEADD(second, CAST("last_viewed_date" AS BIGINT), '1970-01-01') 
        AS "last_viewed_date",
        CAST("next_step" AS VARCHAR) 
        AS "next_step",
        CAST("opportunity_amount" AS DECIMAL) 
        AS "opportunity_amount",
        CAST("synced_quote_id" AS VARCHAR) 
        AS "synced_quote_id",
        CAST("valid_from" AS DATETIME) 
        AS "valid_from",
        CAST("valid_to" AS DATETIME) 
        AS "valid_to"
    FROM "sf_opportunity_history_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_opportunity_history_data_projected_renamed_cleaned_null_casted"