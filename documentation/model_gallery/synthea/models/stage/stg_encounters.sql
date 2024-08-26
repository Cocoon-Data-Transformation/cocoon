-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 00:59:11.305102+00:00
WITH 
"encounters_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> encounter_id
    -- START -> encounter_start
    -- STOP -> encounter_end
    -- PATIENT -> patient_id
    -- ORGANIZATION -> organization_id
    -- PROVIDER -> provider_id
    -- PAYER -> payer_id
    -- ENCOUNTERCLASS -> encounter_type
    -- CODE -> procedure_code
    -- DESCRIPTION -> procedure_description
    -- BASE_ENCOUNTER_COST -> base_cost
    -- TOTAL_CLAIM_COST -> total_cost
    -- PAYER_COVERAGE -> payer_coverage
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "Id" AS "encounter_id",
        "START" AS "encounter_start",
        "STOP" AS "encounter_end",
        "PATIENT" AS "patient_id",
        "ORGANIZATION" AS "organization_id",
        "PROVIDER" AS "provider_id",
        "PAYER" AS "payer_id",
        "ENCOUNTERCLASS" AS "encounter_type",
        "CODE" AS "procedure_code",
        "DESCRIPTION" AS "procedure_description",
        "BASE_ENCOUNTER_COST" AS "base_cost",
        "TOTAL_CLAIM_COST" AS "total_cost",
        "PAYER_COVERAGE" AS "payer_coverage",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "memory"."main"."encounters"
),

"encounters_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- procedure_description: The procedure_description column has several inconsistencies: 1. Some entries have "(procedure)" appended while others don't. 2. There are redundant entries like "Encounter for problem" and "Encounter for problem (procedure)". 3. Some entries have inconsistent capitalization or punctuation. 4. A few entries seem out of place or too specific compared to others.The correct values should follow a consistent pattern, preferably with "(procedure)" appended where appropriate, and use consistent capitalization and punctuation.
    -- reason_description: The problem is inconsistent labeling of medical conditions. Some values include '(disorder)' at the end while others don't. Additionally, some conditions are labeled as '(finding)' or '(situation)'. The correct values should consistently use the base condition name without these suffixes for uniformity.
    SELECT
        "encounter_id",
        "encounter_start",
        "encounter_end",
        "patient_id",
        "organization_id",
        "provider_id",
        "payer_id",
        "encounter_type",
        "procedure_code",
        CASE
            WHEN "procedure_description" = 'Follow-up encounter' THEN 'Follow-up encounter (procedure)'
            WHEN "procedure_description" = 'Encounter for problem' THEN 'Encounter for problem (procedure)'
            WHEN "procedure_description" = 'Prenatal visit' THEN 'Prenatal visit (procedure)'
            WHEN "procedure_description" = 'Patient encounter procedure' THEN 'Patient encounter procedure (procedure)'
            WHEN "procedure_description" = 'Encounter for ''check-up''' THEN 'Encounter for check up (procedure)'
            WHEN "procedure_description" = 'Emergency room admission (procedure)' THEN 'Emergency Room Admission (procedure)'
            WHEN "procedure_description" = 'Emergency Room Admission' THEN 'Emergency Room Admission (procedure)'
            WHEN "procedure_description" = 'Encounter for symptom' THEN 'Encounter for symptom (procedure)'
            WHEN "procedure_description" = 'Asthma follow-up' THEN 'Asthma follow-up (procedure)'
            WHEN "procedure_description" = 'Postnatal visit' THEN 'Postnatal visit (procedure)'
            WHEN "procedure_description" = 'Death Certification' THEN 'Death Certification (procedure)'
            WHEN "procedure_description" = 'Gynecology service (qualifier value)' THEN 'Gynecology service (procedure)'
            WHEN "procedure_description" = 'Screening surveillance (regime/therapy)' THEN 'Screening surveillance (procedure)'
            WHEN "procedure_description" = 'Encounter Inpatient' THEN 'Inpatient encounter (procedure)'
            WHEN "procedure_description" = 'Drug rehabilitation and detoxification' THEN 'Drug rehabilitation and detoxification (procedure)'
            WHEN "procedure_description" = 'Office Visit' THEN 'Office visit (procedure)'
            WHEN "procedure_description" = 'Emergency Encounter' THEN 'Emergency encounter (procedure)'
            WHEN "procedure_description" = 'Encounter for Problem' THEN 'Encounter for problem (procedure)'
            WHEN "procedure_description" = 'Patient-initiated encounter' THEN 'Patient-initiated encounter (procedure)'
            WHEN "procedure_description" = 'Admission to thoracic surgery department' THEN 'Admission to thoracic surgery department (procedure)'
            WHEN "procedure_description" = 'posttraumatic stress disorder' THEN 'Posttraumatic stress disorder follow-up (procedure)'
            WHEN "procedure_description" = 'Initial Psychiatric Interview with mental status evaluation' THEN 'Initial psychiatric interview (procedure)'
            ELSE "procedure_description"
        END AS "procedure_description",
        "base_cost",
        "total_cost",
        "payer_coverage",
        "reason_code",
        CASE
            WHEN "reason_description" = 'Chronic congestive heart failure (disorder)' THEN 'Chronic congestive heart failure'
            WHEN "reason_description" = 'Viral sinusitis (disorder)' THEN 'Viral sinusitis'
            WHEN "reason_description" = 'Acute bronchitis (disorder)' THEN 'Acute bronchitis'
            WHEN "reason_description" = 'Acute viral pharyngitis (disorder)' THEN 'Acute viral pharyngitis'
            WHEN "reason_description" = 'Malignant neoplasm of breast (disorder)' THEN 'Malignant neoplasm of breast'
            WHEN "reason_description" = 'Ischemic heart disease (disorder)' THEN 'Ischemic heart disease'
            WHEN "reason_description" = 'Anemia (disorder)' THEN 'Anemia'
            WHEN "reason_description" = 'Sinusitis (disorder)' THEN 'Sinusitis'
            WHEN "reason_description" = 'Sleep disorder (disorder)' THEN 'Sleep disorder'
            WHEN "reason_description" = 'Acute bacterial sinusitis (disorder)' THEN 'Acute bacterial sinusitis'
            WHEN "reason_description" = 'Streptococcal sore throat (disorder)' THEN 'Streptococcal sore throat'
            WHEN "reason_description" = 'Acute myeloid leukemia  disease (disorder)' THEN 'Acute myeloid leukemia'
            WHEN "reason_description" = 'Alzheimer''s disease (disorder)' THEN 'Alzheimer''s disease'
            WHEN "reason_description" = 'History of coronary artery bypass grafting (situation)' THEN 'History of coronary artery bypass grafting'
            WHEN "reason_description" = 'Abnormal findings diagnostic imaging heart+coronary circulat (finding)' THEN 'Abnormal findings diagnostic imaging heart and coronary circulation'
            WHEN "reason_description" = 'Acute ST segment elevation myocardial infarction (disorder)' THEN 'Acute ST segment elevation myocardial infarction'
            WHEN "reason_description" = 'Acute non-ST segment elevation myocardial infarction (disorder)' THEN 'Acute non-ST segment elevation myocardial infarction'
            WHEN "reason_description" = 'Pulmonary emphysema (disorder)' THEN 'Pulmonary emphysema'
            WHEN "reason_description" = 'Aortic valve stenosis (disorder)' THEN 'Aortic valve stenosis'
            WHEN "reason_description" = 'Sepsis (disorder)' THEN 'Sepsis'
            WHEN "reason_description" = 'Chronic obstructive bronchitis (disorder)' THEN 'Chronic obstructive bronchitis'
            WHEN "reason_description" = 'Fracture of forearm' THEN 'Fracture of Forearm'
            WHEN "reason_description" = 'Fracture subluxation of wrist' THEN 'Fracture Subluxation of Wrist'
            WHEN "reason_description" = 'Injury of medial collateral ligament of knee' THEN 'Injury of Medial Collateral Ligament of Knee'
            WHEN "reason_description" = 'Localized  primary osteoarthritis of the hand' THEN 'Localized Primary Osteoarthritis of the Hand'
            WHEN "reason_description" = 'Perennial allergic rhinitis' THEN 'Perennial Allergic Rhinitis'
            WHEN "reason_description" = 'Perennial allergic rhinitis with seasonal variation' THEN 'Perennial Allergic Rhinitis with Seasonal Variation'
            WHEN "reason_description" = 'Polyp of colon' THEN 'Polyp of Colon'
            ELSE "reason_description"
        END AS "reason_description"
    FROM "encounters_renamed"
),

"encounters_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_end: from VARCHAR to TIMESTAMP
    -- encounter_id: from VARCHAR to UUID
    -- encounter_start: from VARCHAR to TIMESTAMP
    -- organization_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- payer_id: from VARCHAR to UUID
    -- procedure_code: from INT to VARCHAR
    -- provider_id: from VARCHAR to UUID
    -- reason_code: from DECIMAL to VARCHAR
    SELECT
        "encounter_type",
        "procedure_description",
        "base_cost",
        "total_cost",
        "payer_coverage",
        "reason_description",
        CAST("encounter_end" AS TIMESTAMP) 
        AS "encounter_end",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("encounter_start" AS TIMESTAMP) 
        AS "encounter_start",
        CAST("organization_id" AS UUID) 
        AS "organization_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("payer_id" AS UUID) 
        AS "payer_id",
        CAST("procedure_code" AS VARCHAR) 
        AS "procedure_code",
        CAST("provider_id" AS UUID) 
        AS "provider_id",
        CAST("reason_code" AS VARCHAR) 
        AS "reason_code"
    FROM "encounters_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "encounters_renamed_cleaned_casted"