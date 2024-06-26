-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"procedures_renamed" AS (
    -- Rename: Renaming columns
    -- START -> procedure_start_time
    -- STOP -> procedure_end_time
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> procedure_code
    -- DESCRIPTION -> procedure_description
    -- BASE_COST -> procedure_cost
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "START" AS "procedure_start_time",
        "STOP" AS "procedure_end_time",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "procedure_code",
        "DESCRIPTION" AS "procedure_description",
        "BASE_COST" AS "procedure_cost",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "procedures"
),

"procedures_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- reason_description: The problem is inconsistent formatting and some missing parenthetical classifications. Most entries follow the pattern of "Description (classification)", but a few deviate from this. The correct values should maintain consistency by adding missing classifications and fixing spacing issues. 
    SELECT
        "procedure_start_time",
        "procedure_end_time",
        "patient_id",
        "encounter_id",
        "procedure_code",
        "procedure_description",
        "procedure_cost",
        "reason_code",
        CASE
            WHEN "reason_description" = 'Acute myeloid leukemia  disease (disorder)' THEN 'Acute myeloid leukemia disease (disorder)'
            WHEN "reason_description" = 'Overlapping malignant neoplasm of colon' THEN 'Overlapping malignant neoplasm of colon (disorder)'
            WHEN "reason_description" = 'Polyp of colon' THEN 'Polyp of colon (disorder)'
            WHEN "reason_description" = 'Fracture of ankle' THEN 'Fracture of ankle (disorder)'
            WHEN "reason_description" = 'Fracture of clavicle' THEN 'Fracture of clavicle (disorder)'
            WHEN "reason_description" = 'Laceration of foot' THEN 'Laceration of foot (disorder)'
            WHEN "reason_description" = 'Laceration of thigh' THEN 'Laceration of thigh (disorder)'
            WHEN "reason_description" = 'Suspected COVID-19' THEN 'Suspected COVID-19 (situation)'
            WHEN "reason_description" = 'Facial laceration' THEN 'Facial laceration (disorder)'
            WHEN "reason_description" = 'Laceration of forearm' THEN 'Laceration of forearm (disorder)'
            WHEN "reason_description" = 'Asthma' THEN 'Asthma (disorder)'
            WHEN "reason_description" = 'Fracture of forearm' THEN 'Fracture of forearm (disorder)'
            WHEN "reason_description" = 'Fracture subluxation of wrist' THEN 'Fracture subluxation of wrist (disorder)'
            WHEN "reason_description" = 'Injury of medial collateral ligament of knee' THEN 'Injury of medial collateral ligament of knee (disorder)'
            WHEN "reason_description" = 'Neoplasm of prostate' THEN 'Neoplasm of prostate (disorder)'
            WHEN "reason_description" = 'Recurrent rectal polyp' THEN 'Recurrent rectal polyp (disorder)'
            ELSE "reason_description"
        END AS "reason_description"
    FROM "procedures_renamed"
),

"procedures_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- procedure_code: from INT to VARCHAR
    -- procedure_end_time: from VARCHAR to TIMESTAMP
    -- procedure_start_time: from VARCHAR to TIMESTAMP
    -- reason_code: from DECIMAL to VARCHAR
    SELECT
        "procedure_description",
        "procedure_cost",
        "reason_description",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("procedure_code" AS VARCHAR) AS "procedure_code",
        CAST("procedure_end_time" AS TIMESTAMP) AS "procedure_end_time",
        CAST("procedure_start_time" AS TIMESTAMP) AS "procedure_start_time",
        CAST("reason_code" AS VARCHAR) AS "reason_code"
    FROM "procedures_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "procedures_renamed_cleaned_casted"