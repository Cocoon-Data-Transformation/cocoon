-- Slowly Changing Dimension: Dimension keys are "employee_number", "subty"
-- Effective date columns are "last_change_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "employee_number",
    "seqnr",
    "subty",
    "uname",
    "row_id",
    "is_deleted",
    "company_code",
    "end_date",
    "flag_1",
    "flag_2",
    "flag_3",
    "flag_4",
    "reference_field_1",
    "start_date"
FROM (
     SELECT 
            "employee_number",
            "seqnr",
            "subty",
            "uname",
            "row_id",
            "is_deleted",
            "company_code",
            "end_date",
            "flag_1",
            "flag_2",
            "flag_3",
            "flag_4",
            "reference_field_1",
            "start_date",
            ROW_NUMBER() OVER (
                PARTITION BY "employee_number", "subty" 
                ORDER BY "last_change_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_sap_pa0031_data"
) ranked
WHERE "cocoon_rn" = 1