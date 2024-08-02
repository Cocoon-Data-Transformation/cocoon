-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:08:52.648367+00:00
WITH 
"claims_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> claim_id
    -- PATIENTID -> patient_id
    -- PROVIDERID -> provider_id
    -- PRIMARYPATIENTINSURANCEID -> primary_insurance_id
    -- SECONDARYPATIENTINSURANCEID -> secondary_insurance_id
    -- DEPARTMENTID -> department_id
    -- PATIENTDEPARTMENTID -> patient_department_id
    -- DIAGNOSIS1 -> primary_diagnosis
    -- DIAGNOSIS2 -> secondary_diagnosis
    -- DIAGNOSIS3 -> tertiary_diagnosis
    -- DIAGNOSIS4 -> diagnosis_4
    -- DIAGNOSIS5 -> diagnosis_5
    -- DIAGNOSIS6 -> diagnosis_6
    -- DIAGNOSIS7 -> diagnosis_7
    -- DIAGNOSIS8 -> diagnosis_8
    -- REFERRINGPROVIDERID -> referring_provider_id
    -- APPOINTMENTID -> appointment_id
    -- CURRENTILLNESSDATE -> illness_onset_date
    -- SERVICEDATE -> service_date
    -- SUPERVISINGPROVIDERID -> supervising_provider_id
    -- STATUS1 -> primary_claim_status
    -- STATUS2 -> secondary_claim_status
    -- STATUSP -> patient_claim_status
    -- OUTSTANDING1 -> primary_outstanding_amount
    -- OUTSTANDING2 -> secondary_outstanding_amount
    -- OUTSTANDINGP -> patient_outstanding_amount
    -- LASTBILLEDDATE1 -> primary_last_billed_date
    -- LASTBILLEDDATE2 -> secondary_last_billed_date
    -- LASTBILLEDDATEP -> patient_last_billed_date
    -- HEALTHCARECLAIMTYPEID1 -> healthcare_claim_type_id
    -- HEALTHCARECLAIMTYPEID2 -> claim_type_id
    SELECT 
        "Id" AS "claim_id",
        "PATIENTID" AS "patient_id",
        "PROVIDERID" AS "provider_id",
        "PRIMARYPATIENTINSURANCEID" AS "primary_insurance_id",
        "SECONDARYPATIENTINSURANCEID" AS "secondary_insurance_id",
        "DEPARTMENTID" AS "department_id",
        "PATIENTDEPARTMENTID" AS "patient_department_id",
        "DIAGNOSIS1" AS "primary_diagnosis",
        "DIAGNOSIS2" AS "secondary_diagnosis",
        "DIAGNOSIS3" AS "tertiary_diagnosis",
        "DIAGNOSIS4" AS "diagnosis_4",
        "DIAGNOSIS5" AS "diagnosis_5",
        "DIAGNOSIS6" AS "diagnosis_6",
        "DIAGNOSIS7" AS "diagnosis_7",
        "DIAGNOSIS8" AS "diagnosis_8",
        "REFERRINGPROVIDERID" AS "referring_provider_id",
        "APPOINTMENTID" AS "appointment_id",
        "CURRENTILLNESSDATE" AS "illness_onset_date",
        "SERVICEDATE" AS "service_date",
        "SUPERVISINGPROVIDERID" AS "supervising_provider_id",
        "STATUS1" AS "primary_claim_status",
        "STATUS2" AS "secondary_claim_status",
        "STATUSP" AS "patient_claim_status",
        "OUTSTANDING1" AS "primary_outstanding_amount",
        "OUTSTANDING2" AS "secondary_outstanding_amount",
        "OUTSTANDINGP" AS "patient_outstanding_amount",
        "LASTBILLEDDATE1" AS "primary_last_billed_date",
        "LASTBILLEDDATE2" AS "secondary_last_billed_date",
        "LASTBILLEDDATEP" AS "patient_last_billed_date",
        "HEALTHCARECLAIMTYPEID1" AS "healthcare_claim_type_id",
        "HEALTHCARECLAIMTYPEID2" AS "claim_type_id"
    FROM "memory"."main"."claims"
),

"claims_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- primary_insurance_id: The problem is that the '0' value in the primary_insurance_id column does not conform to the UUID format used by other entries. All other values appear to be valid UUIDs. The '0' is likely a placeholder or default value used when no primary insurance ID was available. The correct values should all be in UUID format or empty if no valid ID exists.
    SELECT
        "claim_id",
        "patient_id",
        "provider_id",
        CASE
            WHEN "primary_insurance_id" = '0' THEN NULL
            ELSE "primary_insurance_id"
        END AS "primary_insurance_id",
        "secondary_insurance_id",
        "department_id",
        "patient_department_id",
        "primary_diagnosis",
        "secondary_diagnosis",
        "tertiary_diagnosis",
        "diagnosis_4",
        "diagnosis_5",
        "diagnosis_6",
        "diagnosis_7",
        "diagnosis_8",
        "referring_provider_id",
        "appointment_id",
        "illness_onset_date",
        "service_date",
        "supervising_provider_id",
        "primary_claim_status",
        "secondary_claim_status",
        "patient_claim_status",
        "primary_outstanding_amount",
        "secondary_outstanding_amount",
        "patient_outstanding_amount",
        "primary_last_billed_date",
        "secondary_last_billed_date",
        "patient_last_billed_date",
        "healthcare_claim_type_id",
        "claim_type_id"
    FROM "claims_renamed"
),

"claims_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- secondary_insurance_id: ['0']
    SELECT 
        CASE
            WHEN "secondary_insurance_id" = '0' THEN NULL
            ELSE "secondary_insurance_id"
        END AS "secondary_insurance_id",
        "patient_outstanding_amount",
        "appointment_id",
        "secondary_diagnosis",
        "illness_onset_date",
        "primary_claim_status",
        "claim_type_id",
        "secondary_outstanding_amount",
        "tertiary_diagnosis",
        "diagnosis_8",
        "healthcare_claim_type_id",
        "service_date",
        "diagnosis_7",
        "primary_diagnosis",
        "claim_id",
        "provider_id",
        "primary_insurance_id",
        "diagnosis_6",
        "primary_last_billed_date",
        "secondary_last_billed_date",
        "diagnosis_4",
        "patient_last_billed_date",
        "patient_claim_status",
        "primary_outstanding_amount",
        "supervising_provider_id",
        "department_id",
        "referring_provider_id",
        "patient_id",
        "diagnosis_5",
        "secondary_claim_status",
        "patient_department_id"
    FROM "claims_renamed_cleaned"
),

"claims_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- appointment_id: from VARCHAR to UUID
    -- claim_id: from VARCHAR to UUID
    -- diagnosis_4: from DECIMAL to VARCHAR
    -- diagnosis_5: from DECIMAL to VARCHAR
    -- diagnosis_6: from DECIMAL to VARCHAR
    -- diagnosis_7: from DECIMAL to VARCHAR
    -- diagnosis_8: from DECIMAL to VARCHAR
    -- illness_onset_date: from VARCHAR to TIMESTAMP
    -- patient_id: from VARCHAR to UUID
    -- patient_last_billed_date: from VARCHAR to TIMESTAMP
    -- primary_diagnosis: from INT to VARCHAR
    -- primary_insurance_id: from VARCHAR to UUID
    -- primary_last_billed_date: from VARCHAR to TIMESTAMP
    -- provider_id: from VARCHAR to UUID
    -- referring_provider_id: from DECIMAL to VARCHAR
    -- secondary_diagnosis: from DECIMAL to VARCHAR
    -- secondary_last_billed_date: from VARCHAR to TIMESTAMP
    -- service_date: from VARCHAR to TIMESTAMP
    -- supervising_provider_id: from VARCHAR to UUID
    -- tertiary_diagnosis: from DECIMAL to VARCHAR
    SELECT
        "secondary_insurance_id",
        "patient_outstanding_amount",
        "primary_claim_status",
        "claim_type_id",
        "secondary_outstanding_amount",
        "healthcare_claim_type_id",
        "patient_claim_status",
        "primary_outstanding_amount",
        "department_id",
        "secondary_claim_status",
        "patient_department_id",
        CAST("appointment_id" AS UUID) 
        AS "appointment_id",
        CAST("claim_id" AS UUID) 
        AS "claim_id",
        CAST("diagnosis_4" AS VARCHAR) 
        AS "diagnosis_4",
        CAST("diagnosis_5" AS VARCHAR) 
        AS "diagnosis_5",
        CAST("diagnosis_6" AS VARCHAR) 
        AS "diagnosis_6",
        CAST("diagnosis_7" AS VARCHAR) 
        AS "diagnosis_7",
        CAST("diagnosis_8" AS VARCHAR) 
        AS "diagnosis_8",
        CAST("illness_onset_date" AS TIMESTAMP) 
        AS "illness_onset_date",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("patient_last_billed_date" AS TIMESTAMP) 
        AS "patient_last_billed_date",
        CAST("primary_diagnosis" AS VARCHAR) 
        AS "primary_diagnosis",
        CAST("primary_insurance_id" AS UUID) 
        AS "primary_insurance_id",
        CAST("primary_last_billed_date" AS TIMESTAMP) 
        AS "primary_last_billed_date",
        CAST("provider_id" AS UUID) 
        AS "provider_id",
        CAST("referring_provider_id" AS VARCHAR) 
        AS "referring_provider_id",
        CAST("secondary_diagnosis" AS VARCHAR) 
        AS "secondary_diagnosis",
        CAST("secondary_last_billed_date" AS TIMESTAMP) 
        AS "secondary_last_billed_date",
        CAST("service_date" AS TIMESTAMP) 
        AS "service_date",
        CAST("supervising_provider_id" AS UUID) 
        AS "supervising_provider_id",
        CAST("tertiary_diagnosis" AS VARCHAR) 
        AS "tertiary_diagnosis"
    FROM "claims_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "claims_renamed_cleaned_null_casted"