-- Slowly Changing Dimension: Dimension keys are "patient_id", "condition_code"
-- Version columns are start_date, end_date, encounter_id
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "condition_description",
    "condition_code",
    "patient_id"
FROM "stg_conditions"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "patient_id", "condition_code"
    ORDER BY
        CASE WHEN end_date IS NULL THEN 0 ELSE 1 END,
        end_date DESC NULLS FIRST,
        start_date DESC,
        encounter_id DESC
) = 1