-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"encounters_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> encounter_id
    -- START -> start_time
    -- STOP -> end_time
    -- PATIENT -> patient_id
    -- ORGANIZATION -> organization_id
    -- PROVIDER -> provider_id
    -- PAYER -> payer_id
    -- ENCOUNTERCLASS -> encounter_type
    -- CODE -> medical_code
    -- DESCRIPTION -> procedure_description
    -- BASE_ENCOUNTER_COST -> base_cost
    -- TOTAL_CLAIM_COST -> total_cost
    -- PAYER_COVERAGE -> payer_coverage_amount
    -- REASONCODE -> reason_code
    -- REASONDESCRIPTION -> reason_description
    SELECT 
        "Id" AS "encounter_id",
        "START" AS "start_time",
        "STOP" AS "end_time",
        "PATIENT" AS "patient_id",
        "ORGANIZATION" AS "organization_id",
        "PROVIDER" AS "provider_id",
        "PAYER" AS "payer_id",
        "ENCOUNTERCLASS" AS "encounter_type",
        "CODE" AS "medical_code",
        "DESCRIPTION" AS "procedure_description",
        "BASE_ENCOUNTER_COST" AS "base_cost",
        "TOTAL_CLAIM_COST" AS "total_cost",
        "PAYER_COVERAGE" AS "payer_coverage_amount",
        "REASONCODE" AS "reason_code",
        "REASONDESCRIPTION" AS "reason_description"
    FROM "encounters"
),

"encounters_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- procedure_description: The main problems are: 1) Inconsistent use of '(procedure)' suffix across similar concepts. 2) Inconsistent capitalization. 3) Use of single quotes in "Encounter for 'check-up'". The correct values should consistently use '(procedure)' suffix where appropriate, have consistent capitalization (starting with uppercase), and avoid single quotes. 
    SELECT
        "encounter_id",
        "start_time",
        "end_time",
        "patient_id",
        "organization_id",
        "provider_id",
        "payer_id",
        "encounter_type",
        "medical_code",
        CASE
            WHEN "procedure_description" = 'Encounter for symptom' THEN 'Encounter for symptom (procedure)'
            WHEN "procedure_description" = 'Follow-up encounter' THEN 'Follow-up encounter (procedure)'
            WHEN "procedure_description" = 'Encounter for problem' THEN 'Encounter for problem (procedure)'
            WHEN "procedure_description" = 'Outpatient procedure' THEN 'Outpatient procedure (procedure)'
            WHEN "procedure_description" = 'Prenatal visit' THEN 'Prenatal visit (procedure)'
            WHEN "procedure_description" = 'Patient encounter procedure' THEN 'Patient encounter procedure (procedure)'
            WHEN "procedure_description" = 'Emergency room admission (procedure)' THEN 'Emergency Room Admission (procedure)'
            WHEN "procedure_description" = 'Encounter for ''check-up''' THEN 'Encounter for check up (procedure)'
            WHEN "procedure_description" = 'Telemedicine consultation with patient' THEN 'Telemedicine consultation with patient (procedure)'
            WHEN "procedure_description" = 'Consultation for treatment' THEN 'Consultation for treatment (procedure)'
            WHEN "procedure_description" = 'Prenatal initial visit' THEN 'Prenatal initial visit (procedure)'
            WHEN "procedure_description" = 'Hypertension follow-up encounter' THEN 'Hypertension follow-up encounter (procedure)'
            WHEN "procedure_description" = 'Emergency Room Admission' THEN 'Emergency Room Admission (procedure)'
            WHEN "procedure_description" = 'Asthma follow-up' THEN 'Asthma follow-up (procedure)'
            WHEN "procedure_description" = 'Obstetric emergency hospital admission' THEN 'Obstetric emergency hospital admission (procedure)'
            WHEN "procedure_description" = 'Postnatal visit' THEN 'Postnatal visit (procedure)'
            WHEN "procedure_description" = 'Death Certification' THEN 'Death Certification (procedure)'
            WHEN "procedure_description" = 'Gynecology service (qualifier value)' THEN 'Gynecology service (procedure)'
            WHEN "procedure_description" = 'Screening surveillance (regime/therapy)' THEN 'Screening surveillance (procedure)'
            WHEN "procedure_description" = 'Encounter Inpatient' THEN 'Encounter Inpatient (procedure)'
            WHEN "procedure_description" = 'Drug rehabilitation and detoxification' THEN 'Drug rehabilitation and detoxification (procedure)'
            WHEN "procedure_description" = 'Office Visit' THEN 'Office Visit (procedure)'
            WHEN "procedure_description" = 'Allergic disorder initial assessment' THEN 'Allergic disorder initial assessment (procedure)'
            WHEN "procedure_description" = 'Allergic disorder follow-up assessment' THEN 'Allergic disorder follow-up assessment (procedure)'
            WHEN "procedure_description" = 'Emergency Encounter' THEN 'Emergency Encounter (procedure)'
            WHEN "procedure_description" = 'Emergency hospital admission for asthma' THEN 'Emergency hospital admission for asthma (procedure)'
            WHEN "procedure_description" = 'Encounter for Problem' THEN 'Encounter for problem (procedure)'
            WHEN "procedure_description" = 'Patient-initiated encounter' THEN 'Patient-initiated encounter (procedure)'
            WHEN "procedure_description" = 'Admission to thoracic surgery department' THEN 'Admission to thoracic surgery department (procedure)'
            WHEN "procedure_description" = 'posttraumatic stress disorder' THEN 'Posttraumatic stress disorder (procedure)'
            WHEN "procedure_description" = 'Initial Psychiatric Interview with mental status evaluation' THEN 'Initial Psychiatric Interview with mental status evaluation (procedure)'
            ELSE "procedure_description"
        END AS "procedure_description",
        "base_cost",
        "total_cost",
        "payer_coverage_amount",
        "reason_code",
        "reason_description"
    FROM "encounters_renamed"
),

"encounters_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- end_time: from VARCHAR to TIMESTAMP
    -- medical_code: from INT to VARCHAR
    -- organization_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- payer_id: from VARCHAR to UUID
    -- provider_id: from VARCHAR to UUID
    -- reason_code: from DECIMAL to VARCHAR
    -- start_time: from VARCHAR to TIMESTAMP
    SELECT
        "encounter_type",
        "procedure_description",
        "base_cost",
        "total_cost",
        "payer_coverage_amount",
        "reason_description",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CAST("end_time" AS TIMESTAMP) AS "end_time",
        CAST("medical_code" AS VARCHAR) AS "medical_code",
        CAST("organization_id" AS UUID) AS "organization_id",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("payer_id" AS UUID) AS "payer_id",
        CAST("provider_id" AS UUID) AS "provider_id",
        CAST("reason_code" AS VARCHAR) AS "reason_code",
        CAST("start_time" AS TIMESTAMP) AS "start_time"
    FROM "encounters_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "encounters_renamed_cleaned_casted"