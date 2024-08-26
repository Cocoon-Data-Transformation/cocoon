-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:13:46.432396+00:00
WITH 
"payer_transitions_renamed" AS (
    -- Rename: Renaming columns
    -- PATIENT -> patient_id
    -- MEMBERID -> member_id
    -- START_DATE -> coverage_start_date
    -- END_DATE -> coverage_end_date
    -- PAYER -> primary_payer_id
    -- SECONDARY_PAYER -> secondary_payer_id
    -- PLAN_OWNERSHIP -> plan_ownership
    -- OWNER_NAME -> owner_name
    SELECT 
        "PATIENT" AS "patient_id",
        "MEMBERID" AS "member_id",
        "START_DATE" AS "coverage_start_date",
        "END_DATE" AS "coverage_end_date",
        "PAYER" AS "primary_payer_id",
        "SECONDARY_PAYER" AS "secondary_payer_id",
        "PLAN_OWNERSHIP" AS "plan_ownership",
        "OWNER_NAME" AS "owner_name"
    FROM "memory"."main"."payer_transitions"
),

"payer_transitions_renamed_casted" AS (
    -- Column Type Casting: 
    -- coverage_end_date: from VARCHAR to TIMESTAMP
    -- coverage_start_date: from VARCHAR to TIMESTAMP
    -- member_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- primary_payer_id: from VARCHAR to UUID
    -- secondary_payer_id: from VARCHAR to UUID
    SELECT
        "plan_ownership",
        "owner_name",
        CASE
            WHEN regexp_full_match("coverage_end_date", '\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:04Z') THEN CAST("coverage_end_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_end_date", '\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:07Z') THEN CAST("coverage_end_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_end_date", '\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z') THEN CAST("coverage_end_date" AS TIMESTAMP)
        END 
        AS "coverage_end_date",
        CASE
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T13:42:04Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T03:41:07Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T19:43:25Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
            WHEN regexp_full_match("coverage_start_date", '\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z') THEN CAST("coverage_start_date" AS TIMESTAMP)
        END 
        AS "coverage_start_date",
        CAST("member_id" AS UUID) 
        AS "member_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("primary_payer_id" AS UUID) 
        AS "primary_payer_id",
        CAST("secondary_payer_id" AS UUID) 
        AS "secondary_payer_id"
    FROM "payer_transitions_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "payer_transitions_renamed_casted"