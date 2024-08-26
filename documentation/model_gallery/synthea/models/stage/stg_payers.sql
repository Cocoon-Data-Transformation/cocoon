-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:12:14.679962+00:00
WITH 
"payers_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> payer_id
    -- NAME -> payer_name
    -- OWNERSHIP -> ownership_type
    -- ADDRESS -> street_address
    -- CITY -> city
    -- STATE_HEADQUARTERED -> state
    -- ZIP -> zip_code
    -- PHONE -> phone_number
    -- AMOUNT_COVERED -> covered_amount
    -- AMOUNT_UNCOVERED -> uncovered_amount
    -- REVENUE -> revenue
    -- COVERED_ENCOUNTERS -> covered_encounters
    -- UNCOVERED_ENCOUNTERS -> uncovered_encounters
    -- COVERED_MEDICATIONS -> covered_medications
    -- UNCOVERED_MEDICATIONS -> uncovered_medications
    -- COVERED_PROCEDURES -> covered_procedures
    -- UNCOVERED_PROCEDURES -> uncovered_procedures
    -- COVERED_IMMUNIZATIONS -> covered_immunizations
    -- UNCOVERED_IMMUNIZATIONS -> uncovered_immunizations
    -- UNIQUE_CUSTOMERS -> unique_customers
    -- QOLS_AVG -> average_qol_score
    -- MEMBER_MONTHS -> member_months
    SELECT 
        "Id" AS "payer_id",
        "NAME" AS "payer_name",
        "OWNERSHIP" AS "ownership_type",
        "ADDRESS" AS "street_address",
        "CITY" AS "city",
        "STATE_HEADQUARTERED" AS "state",
        "ZIP" AS "zip_code",
        "PHONE" AS "phone_number",
        "AMOUNT_COVERED" AS "covered_amount",
        "AMOUNT_UNCOVERED" AS "uncovered_amount",
        "REVENUE" AS "revenue",
        "COVERED_ENCOUNTERS" AS "covered_encounters",
        "UNCOVERED_ENCOUNTERS" AS "uncovered_encounters",
        "COVERED_MEDICATIONS" AS "covered_medications",
        "UNCOVERED_MEDICATIONS" AS "uncovered_medications",
        "COVERED_PROCEDURES" AS "covered_procedures",
        "UNCOVERED_PROCEDURES" AS "uncovered_procedures",
        "COVERED_IMMUNIZATIONS" AS "covered_immunizations",
        "UNCOVERED_IMMUNIZATIONS" AS "uncovered_immunizations",
        "UNIQUE_CUSTOMERS" AS "unique_customers",
        "QOLS_AVG" AS "average_qol_score",
        "MEMBER_MONTHS" AS "member_months"
    FROM "memory"."main"."payers"
),

"payers_renamed_casted" AS (
    -- Column Type Casting: 
    -- city: from DECIMAL to VARCHAR
    -- payer_id: from VARCHAR to UUID
    -- phone_number: from DECIMAL to VARCHAR
    -- state: from DECIMAL to VARCHAR
    -- street_address: from DECIMAL to VARCHAR
    -- zip_code: from DECIMAL to VARCHAR
    SELECT
        "payer_name",
        "ownership_type",
        "covered_amount",
        "uncovered_amount",
        "revenue",
        "covered_encounters",
        "uncovered_encounters",
        "covered_medications",
        "uncovered_medications",
        "covered_procedures",
        "uncovered_procedures",
        "covered_immunizations",
        "uncovered_immunizations",
        "unique_customers",
        "average_qol_score",
        "member_months",
        CAST("city" AS VARCHAR) 
        AS "city",
        CAST("payer_id" AS UUID) 
        AS "payer_id",
        CAST("phone_number" AS VARCHAR) 
        AS "phone_number",
        CAST("state" AS VARCHAR) 
        AS "state",
        CAST("street_address" AS VARCHAR) 
        AS "street_address",
        CAST("zip_code" AS VARCHAR) 
        AS "zip_code"
    FROM "payers_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "payers_renamed_casted"