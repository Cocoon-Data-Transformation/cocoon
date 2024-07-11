-- Slowly Changing Dimension: Dimension keys are "employee_id"
-- Effective date columns are "last_change_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "employee_id",
    "sequence_number",
    "username",
    "row_id",
    "is_deleted",
    "action_type",
    "client_code",
    "end_date",
    "lock_indicator",
    "start_date",
    "status_2",
    "status_3"
FROM (
     SELECT 
            "employee_id",
            "sequence_number",
            "username",
            "row_id",
            "is_deleted",
            "action_type",
            "client_code",
            "end_date",
            "lock_indicator",
            "start_date",
            "status_2",
            "status_3",
            ROW_NUMBER() OVER (
                PARTITION BY "employee_id" 
                ORDER BY "last_change_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_sap_pa0000_data"
) ranked
WHERE "cocoon_rn" = 1