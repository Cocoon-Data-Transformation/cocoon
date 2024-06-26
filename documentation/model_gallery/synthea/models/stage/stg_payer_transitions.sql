-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"payer_transitions_renamed" AS (
    -- Rename: Renaming columns
    -- PATIENT -> patient_id
    -- MEMBERID -> member_id
    -- START_DATE -> coverage_start_date
    -- END_DATE -> coverage_end_date
    -- PAYER -> payer_id
    -- SECONDARY_PAYER -> secondary_payer_id
    -- PLAN_OWNERSHIP -> plan_ownership
    -- OWNER_NAME -> policy_owner_name
    SELECT 
        "PATIENT" AS "patient_id",
        "MEMBERID" AS "member_id",
        "START_DATE" AS "coverage_start_date",
        "END_DATE" AS "coverage_end_date",
        "PAYER" AS "payer_id",
        "SECONDARY_PAYER" AS "secondary_payer_id",
        "PLAN_OWNERSHIP" AS "plan_ownership",
        "OWNER_NAME" AS "policy_owner_name"
    FROM "payer_transitions"
),

"payer_transitions_renamed_casted" AS (
    -- Column Type Casting: 
    -- coverage_end_date: from VARCHAR to TIMESTAMP
    -- coverage_start_date: from VARCHAR to TIMESTAMP
    -- member_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- payer_id: from VARCHAR to UUID
    SELECT
        "secondary_payer_id",
        "plan_ownership",
        "policy_owner_name",
        CAST("coverage_end_date" AS TIMESTAMP) AS "coverage_end_date",
        CASE
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T13:42:04Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T03:41:07Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T19:43:25Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
            ELSE "coverage_start_date"
        END AS "coverage_start_date",
        CAST("member_id" AS UUID) AS "member_id",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("payer_id" AS UUID) AS "payer_id"
    FROM "payer_transitions_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "payer_transitions_renamed_casted"