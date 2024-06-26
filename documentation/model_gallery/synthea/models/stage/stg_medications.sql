-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"medications_renamed" AS (
    -- Rename: Renaming columns
    -- START -> order_start_datetime
    -- STOP -> order_stop_datetime
    -- PATIENT -> patient_id
    -- PAYER -> payer_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> medication_code
    -- DESCRIPTION -> medication_description
    -- BASE_COST -> unit_cost
    -- PAYER_COVERAGE -> payer_coverage_amount
    -- DISPENSES -> dispense_count
    -- TOTALCOST -> total_cost
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "START" AS "order_start_datetime",
        "STOP" AS "order_stop_datetime",
        "PATIENT" AS "patient_id",
        "PAYER" AS "payer_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "medication_code",
        "DESCRIPTION" AS "medication_description",
        "BASE_COST" AS "unit_cost",
        "PAYER_COVERAGE" AS "payer_coverage_amount",
        "DISPENSES" AS "dispense_count",
        "TOTALCOST" AS "total_cost",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "medications"
),

"medications_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- reason_description: The problem is inconsistent use of the '(disorder)' suffix and varying levels of specificity in the descriptions. Some conditions have the '(disorder)' suffix while others don't, and some are more specific (e.g., 'Childhood asthma') while others are more general (e.g., 'Asthma'). The correct values should have consistent formatting and specificity. In this case, we'll remove the '(disorder)' suffix where present and use the more general term where applicable. 
    SELECT
        "order_start_datetime",
        "order_stop_datetime",
        "patient_id",
        "payer_id",
        "encounter_id",
        "medication_code",
        "medication_description",
        "unit_cost",
        "payer_coverage_amount",
        "dispense_count",
        "total_cost",
        "reason_code",
        CASE
            WHEN "reason_description" = 'Pulmonary emphysema (disorder)' THEN 'Pulmonary emphysema'
            WHEN "reason_description" = 'Childhood asthma' THEN 'Asthma'
            WHEN "reason_description" = 'Acute bronchitis (disorder)' THEN 'Acute bronchitis'
            WHEN "reason_description" = 'Chronic congestive heart failure (disorder)' THEN 'Chronic congestive heart failure'
            WHEN "reason_description" = 'Osteoporosis (disorder)' THEN 'Osteoporosis'
            WHEN "reason_description" = 'Streptococcal sore throat (disorder)' THEN 'Streptococcal sore throat'
            WHEN "reason_description" = 'Viral sinusitis (disorder)' THEN 'Viral sinusitis'
            WHEN "reason_description" = 'Alzheimer''s disease (disorder)' THEN 'Alzheimer''s disease'
            WHEN "reason_description" = 'Neoplasm of prostate' THEN 'Prostate cancer'
            WHEN "reason_description" = 'Acute myeloid leukemia  disease (disorder)' THEN 'Acute myeloid leukemia'
            WHEN "reason_description" = 'Acute viral pharyngitis (disorder)' THEN 'Acute viral pharyngitis'
            WHEN "reason_description" = 'Child attention deficit disorder' THEN 'Attention deficit disorder'
            WHEN "reason_description" = 'Localized  primary osteoarthritis of the hand' THEN 'Osteoarthritis of hand'
            WHEN "reason_description" = 'Sinusitis (disorder)' THEN 'Sinusitis'
            ELSE "reason_description"
        END AS "reason_description"
    FROM "medications_renamed"
),

"medications_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- medication_code: from INT to VARCHAR
    -- order_start_datetime: from VARCHAR to TIMESTAMP
    -- order_stop_datetime: from VARCHAR to TIMESTAMP
    -- patient_id: from VARCHAR to UUID
    -- payer_id: from VARCHAR to UUID
    -- reason_code: from DECIMAL to VARCHAR
    SELECT
        "medication_description",
        "unit_cost",
        "payer_coverage_amount",
        "dispense_count",
        "total_cost",
        "reason_description",
        CASE
            WHEN regexp_full_match("encounter_id", '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}') THEN CAST("encounter_id" AS UUID)
            WHEN regexp_full_match("encounter_id", '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}') THEN CAST("encounter_id" AS UUID)
            ELSE "encounter_id"
        END AS "encounter_id",
        CAST("medication_code" AS VARCHAR) AS "medication_code",
        CAST("order_start_datetime" AS TIMESTAMP) AS "order_start_datetime",
        CAST("order_stop_datetime" AS TIMESTAMP) AS "order_stop_datetime",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("payer_id" AS UUID) AS "payer_id",
        CAST("reason_code" AS VARCHAR) AS "reason_code"
    FROM "medications_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "medications_renamed_cleaned_casted"