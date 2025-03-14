-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 00:51:17.265171+00:00
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
    -- DIAGNOSIS4 -> quaternary_diagnosis
    -- DIAGNOSIS5 -> quinary_diagnosis
    -- DIAGNOSIS6 -> senary_diagnosis
    -- DIAGNOSIS7 -> septenary_diagnosis
    -- DIAGNOSIS8 -> octonary_diagnosis
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
    -- HEALTHCARECLAIMTYPEID1 -> primary_claim_type_id
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
        "DIAGNOSIS4" AS "quaternary_diagnosis",
        "DIAGNOSIS5" AS "quinary_diagnosis",
        "DIAGNOSIS6" AS "senary_diagnosis",
        "DIAGNOSIS7" AS "septenary_diagnosis",
        "DIAGNOSIS8" AS "octonary_diagnosis",
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
        "HEALTHCARECLAIMTYPEID1" AS "primary_claim_type_id",
        "HEALTHCARECLAIMTYPEID2" AS "claim_type_id"
    FROM "memory"."main"."claims"
),

"claims_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- primary_insurance_id: The problem is that the '0' value does not match the UUID format of the other values in the primary_insurance_id column. All other values are valid UUIDs in the format of 8-4-4-4-12 hexadecimal characters. The '0' value is likely a placeholder or default value used when no valid UUID was available. The correct values should all be valid UUIDs or an empty string if no valid UUID is available.
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
        "quaternary_diagnosis",
        "quinary_diagnosis",
        "senary_diagnosis",
        "septenary_diagnosis",
        "octonary_diagnosis",
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
        "primary_claim_type_id",
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
        "patient_last_billed_date",
        "claim_id",
        "primary_claim_type_id",
        "patient_outstanding_amount",
        "primary_diagnosis",
        "provider_id",
        "claim_type_id",
        "secondary_outstanding_amount",
        "illness_onset_date",
        "appointment_id",
        "secondary_last_billed_date",
        "senary_diagnosis",
        "service_date",
        "quaternary_diagnosis",
        "patient_id",
        "primary_claim_status",
        "primary_insurance_id",
        "department_id",
        "octonary_diagnosis",
        "septenary_diagnosis",
        "patient_claim_status",
        "secondary_claim_status",
        "primary_last_billed_date",
        "primary_outstanding_amount",
        "patient_department_id",
        "referring_provider_id",
        "supervising_provider_id",
        "secondary_diagnosis",
        "quinary_diagnosis",
        "tertiary_diagnosis"
    FROM "claims_renamed_cleaned"
),

"claims_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- appointment_id: from VARCHAR to UUID
    -- claim_id: from VARCHAR to UUID
    -- illness_onset_date: from VARCHAR to TIMESTAMP
    -- octonary_diagnosis: from DECIMAL to VARCHAR
    -- patient_id: from VARCHAR to UUID
    -- patient_last_billed_date: from VARCHAR to TIMESTAMP
    -- primary_diagnosis: from INT to VARCHAR
    -- primary_insurance_id: from VARCHAR to UUID
    -- primary_last_billed_date: from VARCHAR to TIMESTAMP
    -- provider_id: from VARCHAR to UUID
    -- quaternary_diagnosis: from DECIMAL to VARCHAR
    -- quinary_diagnosis: from DECIMAL to VARCHAR
    -- referring_provider_id: from DECIMAL to VARCHAR
    -- secondary_diagnosis: from DECIMAL to VARCHAR
    -- secondary_last_billed_date: from VARCHAR to TIMESTAMP
    -- senary_diagnosis: from DECIMAL to VARCHAR
    -- septenary_diagnosis: from DECIMAL to VARCHAR
    -- service_date: from VARCHAR to TIMESTAMP
    -- supervising_provider_id: from VARCHAR to UUID
    -- tertiary_diagnosis: from DECIMAL to VARCHAR
    SELECT
        "secondary_insurance_id",
        "primary_claim_type_id",
        "patient_outstanding_amount",
        "claim_type_id",
        "secondary_outstanding_amount",
        "primary_claim_status",
        "department_id",
        "patient_claim_status",
        "secondary_claim_status",
        "primary_outstanding_amount",
        "patient_department_id",
        CAST("appointment_id" AS UUID) 
        AS "appointment_id",
        CAST("claim_id" AS UUID) 
        AS "claim_id",
        CAST("illness_onset_date" AS TIMESTAMP) 
        AS "illness_onset_date",
        CAST("octonary_diagnosis" AS VARCHAR) 
        AS "octonary_diagnosis",
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
        CAST("quaternary_diagnosis" AS VARCHAR) 
        AS "quaternary_diagnosis",
        CAST("quinary_diagnosis" AS VARCHAR) 
        AS "quinary_diagnosis",
        CAST("referring_provider_id" AS VARCHAR) 
        AS "referring_provider_id",
        CAST("secondary_diagnosis" AS VARCHAR) 
        AS "secondary_diagnosis",
        CAST("secondary_last_billed_date" AS TIMESTAMP) 
        AS "secondary_last_billed_date",
        CAST("senary_diagnosis" AS VARCHAR) 
        AS "senary_diagnosis",
        CAST("septenary_diagnosis" AS VARCHAR) 
        AS "septenary_diagnosis",
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