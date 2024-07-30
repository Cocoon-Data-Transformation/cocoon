-- Slowly Changing Dimension: Dimension keys are "opportunity_id"
-- Version columns are valid_from, valid_to
-- We will create Type 1 SCD (latest snapshot)

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
    "campaign_id",
    "close_date",
    "created_date",
    "description",
    "expected_revenue",
    "has_line_items",
    "has_open_activity",
    "has_overdue_task",
    "is_active",
    "is_closed",
    "is_deleted",
    "is_won",
    "last_activity_date",
    "last_referenced_date",
    "last_viewed_date",
    "next_step",
    "opportunity_amount",
    "synced_quote_id"
FROM "stg_sf_opportunity_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "opportunity_id"
    ORDER BY
        CAST(valid_from AS DATETIME) DESC,
        CASE WHEN valid_to IS NULL THEN 1 ELSE 0 END DESC
) = 1