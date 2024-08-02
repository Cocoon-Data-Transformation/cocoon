-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:23:42.396054+00:00
WITH 
"medications_renamed" AS (
    -- Rename: Renaming columns
    -- START -> prescription_start
    -- STOP -> prescription_end
    -- PATIENT -> patient_id
    -- PAYER -> payer_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> medication_code
    -- DESCRIPTION -> medication_description
    -- BASE_COST -> base_cost
    -- PAYER_COVERAGE -> payer_coverage
    -- DISPENSES -> dispense_count
    -- TOTALCOST -> total_cost
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "START" AS "prescription_start",
        "STOP" AS "prescription_end",
        "PATIENT" AS "patient_id",
        "PAYER" AS "payer_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "medication_code",
        "DESCRIPTION" AS "medication_description",
        "BASE_COST" AS "base_cost",
        "PAYER_COVERAGE" AS "payer_coverage",
        "DISPENSES" AS "dispense_count",
        "TOTALCOST" AS "total_cost",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "memory"."main"."medications"
),

"medications_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- reason_description: The problem is inconsistent use of the '(disorder)' suffix and an extra space in one entry. The correct values should have consistent formatting, either all with '(disorder)' suffix or all without. Since the majority of entries do not have the suffix, we'll remove it from those that do. We'll also remove the extra space in 'Acute myeloid leukemia  disease (disorder)'.
    SELECT
        "prescription_start",
        "prescription_end",
        "patient_id",
        "payer_id",
        "encounter_id",
        "medication_code",
        "medication_description",
        "base_cost",
        "payer_coverage",
        "dispense_count",
        "total_cost",
        "reason_code",
        CASE
            WHEN "reason_description" = 'Pulmonary emphysema (disorder)' THEN 'Pulmonary emphysema'
            WHEN "reason_description" = 'Acute bronchitis (disorder)' THEN 'Acute bronchitis'
            WHEN "reason_description" = 'Chronic congestive heart failure (disorder)' THEN 'Chronic congestive heart failure'
            WHEN "reason_description" = 'Osteoporosis (disorder)' THEN 'Osteoporosis'
            WHEN "reason_description" = 'Streptococcal sore throat (disorder)' THEN 'Streptococcal sore throat'
            WHEN "reason_description" = 'Viral sinusitis (disorder)' THEN 'Viral sinusitis'
            WHEN "reason_description" = 'Alzheimer''s disease (disorder)' THEN 'Alzheimer''s disease'
            WHEN "reason_description" = 'Acute myeloid leukemia  disease (disorder)' THEN 'Acute myeloid leukemia disease'
            WHEN "reason_description" = 'Acute viral pharyngitis (disorder)' THEN 'Acute viral pharyngitis'
            WHEN "reason_description" = 'Sinusitis (disorder)' THEN 'Sinusitis'
            ELSE "reason_description"
        END AS "reason_description"
    FROM "medications_renamed"
),

"medications_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- medication_code: from INT to VARCHAR
    -- patient_id: from VARCHAR to UUID
    -- payer_id: from VARCHAR to UUID
    -- prescription_end: from VARCHAR to TIMESTAMP
    -- prescription_start: from VARCHAR to TIMESTAMP
    -- reason_code: from DECIMAL to VARCHAR
    SELECT
        "medication_description",
        "base_cost",
        "payer_coverage",
        "dispense_count",
        "total_cost",
        "reason_description",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("medication_code" AS VARCHAR) 
        AS "medication_code",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("payer_id" AS UUID) 
        AS "payer_id",
        CAST("prescription_end" AS TIMESTAMP) 
        AS "prescription_end",
        CAST("prescription_start" AS TIMESTAMP) 
        AS "prescription_start",
        CAST("reason_code" AS VARCHAR) 
        AS "reason_code"
    FROM "medications_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "medications_renamed_cleaned_casted"