-- Slowly Changing Dimension: Dimension keys are "patient_id", "member_id"
-- Version columns are coverage_start_date, coverage_end_date
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "plan_ownership",
    "owner_name",
    "member_id",
    "patient_id",
    "primary_payer_id",
    "secondary_payer_id"
FROM "stg_payer_transitions"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "patient_id", "member_id"
    ORDER BY
        coverage_end_date DESC NULLS LAST,
        coverage_start_date DESC
) = 1