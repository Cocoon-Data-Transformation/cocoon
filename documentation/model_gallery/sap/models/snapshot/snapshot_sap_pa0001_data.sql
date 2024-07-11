-- Slowly Changing Dimension: Dimension keys are "employee_id"
-- Effective date columns are "last_changed_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "employee_id",
    "sequence_number",
    "user_name",
    "personnel_area",
    "persg",
    "employee_subgroup",
    "personnel_subarea",
    "work_schedule_rule",
    "sachp",
    "sname",
    "ename",
    "object_type",
    "payroll_modifier",
    "row_id",
    "is_deleted",
    "client",
    "company_code",
    "controlling_area",
    "distribution_key",
    "is_historical",
    "job_id",
    "lock_indicator",
    "org_unit_id",
    "position_id",
    "processing_reason",
    "valid_from",
    "valid_to"
FROM (
     SELECT 
            "employee_id",
            "sequence_number",
            "user_name",
            "personnel_area",
            "persg",
            "employee_subgroup",
            "personnel_subarea",
            "work_schedule_rule",
            "sachp",
            "sname",
            "ename",
            "object_type",
            "payroll_modifier",
            "row_id",
            "is_deleted",
            "client",
            "company_code",
            "controlling_area",
            "distribution_key",
            "is_historical",
            "job_id",
            "lock_indicator",
            "org_unit_id",
            "position_id",
            "processing_reason",
            "valid_from",
            "valid_to",
            ROW_NUMBER() OVER (
                PARTITION BY "employee_id" 
                ORDER BY "last_changed_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_sap_pa0001_data"
) ranked
WHERE "cocoon_rn" = 1