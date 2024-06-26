-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"claims_transactions_renamed" AS (
    -- Rename: Renaming columns
    -- ID -> transaction_id
    -- CLAIMID -> claim_id
    -- CHARGEID -> charge_id
    -- PATIENTID -> patient_id
    -- TYPE -> transaction_type
    -- AMOUNT -> original_charge
    -- METHOD -> payment_method
    -- FROMDATE -> service_start_datetime
    -- TODATE -> service_end_datetime
    -- PLACEOFSERVICE -> place_of_service_id
    -- PROCEDURECODE -> procedure_code
    -- MODIFIER1 -> procedure_modifier_1
    -- MODIFIER2 -> procedure_modifier_2
    -- DIAGNOSISREF1 -> primary_diagnosis_code
    -- DIAGNOSISREF2 -> secondary_diagnosis_code
    -- DIAGNOSISREF3 -> tertiary_diagnosis_code
    -- DIAGNOSISREF4 -> quaternary_diagnosis_code
    -- UNITS -> unit_count
    -- DEPARTMENTID -> department_id
    -- NOTES -> transaction_notes
    -- UNITAMOUNT -> amount_per_unit
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
        "AMOUNT" AS "original_charge",
        "METHOD" AS "payment_method",
        "FROMDATE" AS "service_start_datetime",
        "TODATE" AS "service_end_datetime",
        "PLACEOFSERVICE" AS "place_of_service_id",
        "PROCEDURECODE" AS "procedure_code",
        "MODIFIER1" AS "procedure_modifier_1",
        "MODIFIER2" AS "procedure_modifier_2",
        "DIAGNOSISREF1" AS "primary_diagnosis_code",
        "DIAGNOSISREF2" AS "secondary_diagnosis_code",
        "DIAGNOSISREF3" AS "tertiary_diagnosis_code",
        "DIAGNOSISREF4" AS "quaternary_diagnosis_code",
        "UNITS" AS "unit_count",
        "DEPARTMENTID" AS "department_id",
        "NOTES" AS "transaction_notes",
        "UNITAMOUNT" AS "amount_per_unit",
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
    FROM "claims_transactions"
),

"claims_transactions_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- transaction_notes: Inconsistent capitalization (e.g., 'Influenza  seasonal  injectable' vs 'insulin human'). Inconsistent spacing in some entries.
    -- transfer_type: The problem is that the transfer_type column contains a mix of numeric values ('1' and '2') and a letter ('p'). This inconsistency suggests a coding error or data entry mistake. The correct values are likely intended to be numeric, representing different types of transfers. The 'p' is probably meant to be '1' or '2', but without more context, it's safest to map it to the most frequent value, which is '1'. 
    SELECT
        "transaction_id",
        "claim_id",
        "charge_id",
        "patient_id",
        "transaction_type",
        "original_charge",
        "payment_method",
        "service_start_datetime",
        "service_end_datetime",
        "place_of_service_id",
        "procedure_code",
        "procedure_modifier_1",
        "procedure_modifier_2",
        "primary_diagnosis_code",
        "secondary_diagnosis_code",
        "tertiary_diagnosis_code",
        "quaternary_diagnosis_code",
        "unit_count",
        "department_id",
        "transaction_notes",
        "amount_per_unit",
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
        "place_of_service_id",
        "patient_id",
        "original_charge",
        "fee_schedule_id",
        "appointment_id",
        "claim_id",
        "transaction_id",
        "quaternary_diagnosis_code",
        "transfer_type",
        "outstanding_balance",
        "unit_count",
        "procedure_code",
        "payment_amount",
        "supervising_provider_id",
        "charge_id",
        "transfer_out_id",
        "transfer_amount",
        "service_start_datetime",
        "payment_method",
        "adjustment_amount",
        "transaction_notes",
        "secondary_diagnosis_code",
        "tertiary_diagnosis_code",
        "procedure_modifier_1",
        "primary_diagnosis_code",
        "department_id",
        "transaction_type",
        "procedure_modifier_2",
        "line_note",
        "provider_id",
        "patient_insurance_id",
        "amount_per_unit"
    FROM "claims_transactions_renamed_cleaned"
),

"claims_transactions_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- appointment_id: from VARCHAR to UUID
    -- claim_id: from VARCHAR to UUID
    -- line_note: from DECIMAL to VARCHAR
    -- patient_id: from VARCHAR to UUID
    -- place_of_service_id: from VARCHAR to UUID
    -- primary_diagnosis_code: from INT to VARCHAR
    -- procedure_code: from INT to VARCHAR
    -- procedure_modifier_1: from DECIMAL to VARCHAR
    -- procedure_modifier_2: from DECIMAL to VARCHAR
    -- provider_id: from VARCHAR to UUID
    -- quaternary_diagnosis_code: from DECIMAL to VARCHAR
    -- secondary_diagnosis_code: from DECIMAL to VARCHAR
    -- service_end_datetime: from VARCHAR to TIMESTAMP
    -- service_start_datetime: from VARCHAR to TIMESTAMP
    -- supervising_provider_id: from VARCHAR to UUID
    -- tertiary_diagnosis_code: from DECIMAL to VARCHAR
    -- transaction_id: from VARCHAR to UUID
    -- transfer_amount: from DECIMAL to VARCHAR
    -- transfer_out_id: from DECIMAL to VARCHAR
    SELECT
        "original_charge",
        "fee_schedule_id",
        "transfer_type",
        "outstanding_balance",
        "unit_count",
        "payment_amount",
        "charge_id",
        "payment_method",
        "adjustment_amount",
        "transaction_notes",
        "department_id",
        "transaction_type",
        "patient_insurance_id",
        "amount_per_unit",
        CAST("appointment_id" AS UUID) AS "appointment_id",
        CAST("claim_id" AS UUID) AS "claim_id",
        CAST("line_note" AS VARCHAR) AS "line_note",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("place_of_service_id" AS UUID) AS "place_of_service_id",
        CAST("primary_diagnosis_code" AS VARCHAR) AS "primary_diagnosis_code",
        CAST("procedure_code" AS VARCHAR) AS "procedure_code",
        CAST("procedure_modifier_1" AS VARCHAR) AS "procedure_modifier_1",
        CAST("procedure_modifier_2" AS VARCHAR) AS "procedure_modifier_2",
        CAST("provider_id" AS UUID) AS "provider_id",
        CAST("quaternary_diagnosis_code" AS VARCHAR) AS "quaternary_diagnosis_code",
        CAST("secondary_diagnosis_code" AS VARCHAR) AS "secondary_diagnosis_code",
        CAST("service_end_datetime" AS TIMESTAMP) AS "service_end_datetime",
        CAST("service_start_datetime" AS TIMESTAMP) AS "service_start_datetime",
        CAST("supervising_provider_id" AS UUID) AS "supervising_provider_id",
        CAST("tertiary_diagnosis_code" AS VARCHAR) AS "tertiary_diagnosis_code",
        CASE
            WHEN regexp_full_match("transaction_id", '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}') THEN CAST("transaction_id" AS UUID)
            WHEN regexp_full_match("transaction_id", '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}') THEN CAST("transaction_id" AS UUID)
            ELSE "transaction_id"
        END AS "transaction_id",
        CAST("transfer_amount" AS VARCHAR) AS "transfer_amount",
        CAST("transfer_out_id" AS VARCHAR) AS "transfer_out_id"
    FROM "claims_transactions_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "claims_transactions_renamed_cleaned_null_casted"