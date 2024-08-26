-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 00:54:34.603382+00:00
WITH 
"claims_transactions_renamed" AS (
    -- Rename: Renaming columns
    -- ID -> transaction_id
    -- CLAIMID -> claim_id
    -- CHARGEID -> charge_id
    -- PATIENTID -> patient_id
    -- TYPE -> transaction_type
    -- AMOUNT -> transaction_amount
    -- METHOD -> payment_method
    -- FROMDATE -> service_start_datetime
    -- TODATE -> service_end_datetime
    -- PLACEOFSERVICE -> service_location_id
    -- PROCEDURECODE -> procedure_code
    -- MODIFIER1 -> procedure_modifier_1
    -- MODIFIER2 -> procedure_modifier_2
    -- DIAGNOSISREF1 -> primary_diagnosis_ref
    -- DIAGNOSISREF2 -> secondary_diagnosis_ref
    -- DIAGNOSISREF3 -> tertiary_diagnosis_ref
    -- DIAGNOSISREF4 -> quaternary_diagnosis_ref
    -- UNITS -> service_units
    -- DEPARTMENTID -> department_id
    -- NOTES -> service_description
    -- UNITAMOUNT -> unit_cost
    -- TRANSFEROUTID -> transfer_out_id
    -- TRANSFERTYPE -> transfer_type
    -- PAYMENTS -> payment_amount
    -- ADJUSTMENTS -> adjustment_amount
    -- TRANSFERS -> transfer_amount
    -- OUTSTANDING -> outstanding_balance
    -- APPOINTMENTID -> appointment_id
    -- LINENOTE -> line_note
    -- PATIENTINSURANCEID -> patient_insurance_id
    -- FEESCHEDULEID -> fee_schedule_id
    -- PROVIDERID -> provider_id
    -- SUPERVISINGPROVIDERID -> supervising_provider_id
    SELECT 
        "ID" AS "transaction_id",
        "CLAIMID" AS "claim_id",
        "CHARGEID" AS "charge_id",
        "PATIENTID" AS "patient_id",
        "TYPE" AS "transaction_type",
        "AMOUNT" AS "transaction_amount",
        "METHOD" AS "payment_method",
        "FROMDATE" AS "service_start_datetime",
        "TODATE" AS "service_end_datetime",
        "PLACEOFSERVICE" AS "service_location_id",
        "PROCEDURECODE" AS "procedure_code",
        "MODIFIER1" AS "procedure_modifier_1",
        "MODIFIER2" AS "procedure_modifier_2",
        "DIAGNOSISREF1" AS "primary_diagnosis_ref",
        "DIAGNOSISREF2" AS "secondary_diagnosis_ref",
        "DIAGNOSISREF3" AS "tertiary_diagnosis_ref",
        "DIAGNOSISREF4" AS "quaternary_diagnosis_ref",
        "UNITS" AS "service_units",
        "DEPARTMENTID" AS "department_id",
        "NOTES" AS "service_description",
        "UNITAMOUNT" AS "unit_cost",
        "TRANSFEROUTID" AS "transfer_out_id",
        "TRANSFERTYPE" AS "transfer_type",
        "PAYMENTS" AS "payment_amount",
        "ADJUSTMENTS" AS "adjustment_amount",
        "TRANSFERS" AS "transfer_amount",
        "OUTSTANDING" AS "outstanding_balance",
        "APPOINTMENTID" AS "appointment_id",
        "LINENOTE" AS "line_note",
        "PATIENTINSURANCEID" AS "patient_insurance_id",
        "FEESCHEDULEID" AS "fee_schedule_id",
        "PROVIDERID" AS "provider_id",
        "SUPERVISINGPROVIDERID" AS "supervising_provider_id"
    FROM "memory"."main"."claims_transactions"
),

"claims_transactions_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- service_description: 'Encounter for problem' and 'Encounter for problem (procedure)' are redundant. Inconsistent use of '(procedure)' suffix.
    -- transfer_type: The problem is that the transfer_type column contains a mix of numeric and alphabetic values. The value 'p' is unusual because it's alphabetic while the others ('1' and '2') are numeric. Without more context, it's unclear what 'p' represents. However, since '1' is the most frequent value and the column seems to be intended for numeric codes, it's reasonable to map 'p' to '1'.
    SELECT
        "transaction_id",
        "claim_id",
        "charge_id",
        "patient_id",
        "transaction_type",
        "transaction_amount",
        "payment_method",
        "service_start_datetime",
        "service_end_datetime",
        "service_location_id",
        "procedure_code",
        "procedure_modifier_1",
        "procedure_modifier_2",
        "primary_diagnosis_ref",
        "secondary_diagnosis_ref",
        "tertiary_diagnosis_ref",
        "quaternary_diagnosis_ref",
        "service_units",
        "department_id",
        "service_description",
        "unit_cost",
        "transfer_out_id",
        CASE
            WHEN "transfer_type" = 'p' THEN '1'
            ELSE "transfer_type"
        END AS "transfer_type",
        "payment_amount",
        "adjustment_amount",
        "transfer_amount",
        "outstanding_balance",
        "appointment_id",
        "line_note",
        "patient_insurance_id",
        "fee_schedule_id",
        "provider_id",
        "supervising_provider_id"
    FROM "claims_transactions_renamed"
),

"claims_transactions_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- service_end_datetime: ['1970-01-01T00:00:00Z']
    SELECT 
        CASE
            WHEN "service_end_datetime" = '1970-01-01T00:00:00Z' THEN NULL
            ELSE "service_end_datetime"
        END AS "service_end_datetime",
        "service_description",
        "patient_insurance_id",
        "quaternary_diagnosis_ref",
        "claim_id",
        "procedure_code",
        "outstanding_balance",
        "provider_id",
        "charge_id",
        "appointment_id",
        "primary_diagnosis_ref",
        "line_note",
        "patient_id",
        "service_units",
        "department_id",
        "transfer_type",
        "payment_amount",
        "unit_cost",
        "service_start_datetime",
        "adjustment_amount",
        "transaction_id",
        "service_location_id",
        "transaction_amount",
        "supervising_provider_id",
        "procedure_modifier_2",
        "tertiary_diagnosis_ref",
        "transaction_type",
        "secondary_diagnosis_ref",
        "payment_method",
        "procedure_modifier_1",
        "transfer_amount",
        "transfer_out_id",
        "fee_schedule_id"
    FROM "claims_transactions_renamed_cleaned"
),

"claims_transactions_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- appointment_id: from VARCHAR to UUID
    -- claim_id: from VARCHAR to UUID
    -- line_note: from DECIMAL to VARCHAR
    -- patient_id: from VARCHAR to UUID
    -- primary_diagnosis_ref: from INT to VARCHAR
    -- procedure_code: from INT to VARCHAR
    -- procedure_modifier_1: from DECIMAL to VARCHAR
    -- procedure_modifier_2: from DECIMAL to VARCHAR
    -- provider_id: from VARCHAR to UUID
    -- quaternary_diagnosis_ref: from DECIMAL to VARCHAR
    -- secondary_diagnosis_ref: from DECIMAL to VARCHAR
    -- service_end_datetime: from VARCHAR to TIMESTAMP
    -- service_location_id: from VARCHAR to UUID
    -- service_start_datetime: from VARCHAR to TIMESTAMP
    -- supervising_provider_id: from VARCHAR to UUID
    -- tertiary_diagnosis_ref: from DECIMAL to VARCHAR
    -- transaction_id: from VARCHAR to UUID
    -- transfer_out_id: from DECIMAL to VARCHAR
    SELECT
        "service_description",
        "patient_insurance_id",
        "outstanding_balance",
        "charge_id",
        "service_units",
        "department_id",
        "transfer_type",
        "payment_amount",
        "unit_cost",
        "adjustment_amount",
        "transaction_amount",
        "transaction_type",
        "payment_method",
        "transfer_amount",
        "fee_schedule_id",
        CAST("appointment_id" AS UUID) 
        AS "appointment_id",
        CAST("claim_id" AS UUID) 
        AS "claim_id",
        CAST("line_note" AS VARCHAR) 
        AS "line_note",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("primary_diagnosis_ref" AS VARCHAR) 
        AS "primary_diagnosis_ref",
        CAST("procedure_code" AS VARCHAR) 
        AS "procedure_code",
        CAST("procedure_modifier_1" AS VARCHAR) 
        AS "procedure_modifier_1",
        CAST("procedure_modifier_2" AS VARCHAR) 
        AS "procedure_modifier_2",
        CAST("provider_id" AS UUID) 
        AS "provider_id",
        CAST("quaternary_diagnosis_ref" AS VARCHAR) 
        AS "quaternary_diagnosis_ref",
        CAST("secondary_diagnosis_ref" AS VARCHAR) 
        AS "secondary_diagnosis_ref",
        CAST("service_end_datetime" AS TIMESTAMP) 
        AS "service_end_datetime",
        CAST("service_location_id" AS UUID) 
        AS "service_location_id",
        CAST("service_start_datetime" AS TIMESTAMP) 
        AS "service_start_datetime",
        CAST("supervising_provider_id" AS UUID) 
        AS "supervising_provider_id",
        CAST("tertiary_diagnosis_ref" AS VARCHAR) 
        AS "tertiary_diagnosis_ref",
        CAST("transaction_id" AS UUID) 
        AS "transaction_id",
        CAST("transfer_out_id" AS VARCHAR) 
        AS "transfer_out_id"
    FROM "claims_transactions_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "claims_transactions_renamed_cleaned_null_casted"