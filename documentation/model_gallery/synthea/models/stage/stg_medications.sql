-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:03:31.386317+00:00
WITH 
"medications_renamed" AS (
    -- Rename: Renaming columns
    -- START -> order_start_datetime
    -- STOP -> order_end_datetime
    -- PATIENT -> patient_id
    -- PAYER -> payer_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> medication_code
    -- DESCRIPTION -> medication_description
    -- BASE_COST -> base_cost
    -- PAYER_COVERAGE -> payer_coverage_amount
    -- DISPENSES -> dispense_count
    -- TOTALCOST -> total_cost
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "START" AS "order_start_datetime",
        "STOP" AS "order_end_datetime",
        "PATIENT" AS "patient_id",
        "PAYER" AS "payer_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "medication_code",
        "DESCRIPTION" AS "medication_description",
        "BASE_COST" AS "base_cost",
        "PAYER_COVERAGE" AS "payer_coverage_amount",
        "DISPENSES" AS "dispense_count",
        "TOTALCOST" AS "total_cost",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "memory"."main"."medications"
),

"medications_renamed_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- medication_code: from INT to VARCHAR
    -- order_end_datetime: from VARCHAR to TIMESTAMP
    -- order_start_datetime: from VARCHAR to TIMESTAMP
    -- patient_id: from VARCHAR to UUID
    -- payer_id: from VARCHAR to UUID
    -- reason_code: from DECIMAL to VARCHAR
    SELECT
        "medication_description",
        "base_cost",
        "payer_coverage_amount",
        "dispense_count",
        "total_cost",
        "reason_description",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("medication_code" AS VARCHAR) 
        AS "medication_code",
        CAST("order_end_datetime" AS TIMESTAMP) 
        AS "order_end_datetime",
        CAST("order_start_datetime" AS TIMESTAMP) 
        AS "order_start_datetime",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("payer_id" AS UUID) 
        AS "payer_id",
        CAST("reason_code" AS VARCHAR) 
        AS "reason_code"
    FROM "medications_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "medications_renamed_casted"