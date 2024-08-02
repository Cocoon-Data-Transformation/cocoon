-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:18:09.734742+00:00
WITH 
"encounters_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> encounter_id
    -- START -> encounter_start_time
    -- STOP -> encounter_end_time
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
        "START" AS "encounter_start_time",
        "STOP" AS "encounter_end_time",
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
    -- procedure_description: The procedure_description column has several issues: 1. Redundancy: 'Encounter for problem' and 'Encounter for problem (procedure)' represent the same thing. 2. Inconsistent spellings: 'check up' and 'check-up' are used interchangeably. 3. Inconsistent use of '(procedure)' suffix: Some entries have it while others don't. 4. Capitalization inconsistencies: Some entries start with capital letters while others don't. 5. Quotation marks: One entry uses quotation marks unnecessarily. The correct values should use consistent spelling, remove redundancy, use the '(procedure)' suffix consistently for procedural entries, and use consistent capitalization.
    SELECT
        "encounter_id",
        "encounter_start_time",
        "encounter_end_time",
        "patient_id",
        "organization_id",
        "provider_id",
        "payer_id",
        "encounter_type",
        "procedure_code",
        CASE
            WHEN "procedure_description" = 'Encounter for problem' THEN 'Encounter for problem (procedure)'
            WHEN "procedure_description" = 'Encounter for check up (procedure)' THEN 'Encounter for check-up (procedure)'
            WHEN "procedure_description" = 'Encounter for ''check-up''' THEN 'Encounter for check-up (procedure)'
            WHEN "procedure_description" = 'Patient encounter procedure' THEN 'Patient encounter procedure (procedure)'
            WHEN "procedure_description" = 'Emergency room admission (procedure)' THEN 'Emergency Room Admission (procedure)'
            WHEN "procedure_description" = 'Emergency Room Admission' THEN 'Emergency Room Admission (procedure)'
            WHEN "procedure_description" = 'Encounter for symptom' THEN 'Encounter for symptom (procedure)'
            WHEN "procedure_description" = 'Follow-up encounter' THEN 'Follow-up encounter (procedure)'
            WHEN "procedure_description" = 'Asthma follow-up' THEN 'Asthma follow-up (procedure)'
            WHEN "procedure_description" = 'Death Certification' THEN 'Death Certification (procedure)'
            WHEN "procedure_description" = 'Encounter Inpatient' THEN 'Inpatient encounter (procedure)'
            WHEN "procedure_description" = 'Office Visit' THEN 'Office visit (procedure)'
            WHEN "procedure_description" = 'Emergency Encounter' THEN 'Emergency encounter (procedure)'
            WHEN "procedure_description" = 'Encounter for Problem' THEN 'Encounter for problem (procedure)'
            WHEN "procedure_description" = 'posttraumatic stress disorder' THEN 'Posttraumatic stress disorder encounter (procedure)'
            ELSE "procedure_description"
        END AS "procedure_description",
        "base_cost",
        "total_cost",
        "payer_coverage",
        "reason_code",
        "reason_description"
    FROM "encounters_renamed"
),

"encounters_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_end_time: from VARCHAR to TIMESTAMP
    -- encounter_id: from VARCHAR to UUID
    -- encounter_start_time: from VARCHAR to TIMESTAMP
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
        CAST("encounter_end_time" AS TIMESTAMP) 
        AS "encounter_end_time",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("encounter_start_time" AS TIMESTAMP) 
        AS "encounter_start_time",
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