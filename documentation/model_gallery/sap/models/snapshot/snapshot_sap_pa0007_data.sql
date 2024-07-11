-- Slowly Changing Dimension: Dimension keys are "client_id", "employee_id"
-- Effective date columns are "last_modified_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "client_id",
    "employee_id",
    "sequence_number",
    "last_modified_by",
    "schedule_type",
    "time_recording_indicator",
    "employment_percentage",
    "monthly_hours",
    "weekly_hours",
    "daily_hours",
    "workdays_per_week",
    "yearly_hours",
    "min_daily_hours",
    "max_daily_hours",
    "min_weekly_hours",
    "max_weekly_hours",
    "min_monthly_hours",
    "max_monthly_hours",
    "min_yearly_hours",
    "max_yearly_hours",
    "row_id",
    "is_deleted",
    "dynamic_scheduling",
    "valid_from_date",
    "valid_to_date"
FROM (
     SELECT 
            "client_id",
            "employee_id",
            "sequence_number",
            "last_modified_by",
            "schedule_type",
            "time_recording_indicator",
            "employment_percentage",
            "monthly_hours",
            "weekly_hours",
            "daily_hours",
            "workdays_per_week",
            "yearly_hours",
            "min_daily_hours",
            "max_daily_hours",
            "min_weekly_hours",
            "max_weekly_hours",
            "min_monthly_hours",
            "max_monthly_hours",
            "min_yearly_hours",
            "max_yearly_hours",
            "row_id",
            "is_deleted",
            "dynamic_scheduling",
            "valid_from_date",
            "valid_to_date",
            ROW_NUMBER() OVER (
                PARTITION BY "client_id", "employee_id" 
                ORDER BY "last_modified_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_sap_pa0007_data"
) ranked
WHERE "cocoon_rn" = 1