-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"payers_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> payer_id
    -- NAME -> payer_name
    -- ADDRESS -> payer_address
    -- CITY -> payer_city
    -- STATE_HEADQUARTERED -> headquarters_state
    -- ZIP -> payer_zip_code
    -- PHONE -> payer_phone
    -- AMOUNT_COVERED -> total_covered_amount
    -- AMOUNT_UNCOVERED -> total_uncovered_amount
    -- COVERED_ENCOUNTERS -> covered_encounters_count
    -- UNCOVERED_ENCOUNTERS -> uncovered_encounters_count
    -- COVERED_MEDICATIONS -> covered_medications_count
    -- UNCOVERED_MEDICATIONS -> uncovered_medications_count
    -- COVERED_PROCEDURES -> covered_procedures_count
    -- UNCOVERED_PROCEDURES -> uncovered_procedures_count
    -- COVERED_IMMUNIZATIONS -> covered_immunizations_count
    -- UNCOVERED_IMMUNIZATIONS -> uncovered_immunizations_count
    -- QOLS_AVG -> average_quality_of_life_score
    SELECT 
        "Id" AS "payer_id",
        "NAME" AS "payer_name",
        "OWNERSHIP",
        "ADDRESS" AS "payer_address",
        "CITY" AS "payer_city",
        "STATE_HEADQUARTERED" AS "headquarters_state",
        "ZIP" AS "payer_zip_code",
        "PHONE" AS "payer_phone",
        "AMOUNT_COVERED" AS "total_covered_amount",
        "AMOUNT_UNCOVERED" AS "total_uncovered_amount",
        "REVENUE",
        "COVERED_ENCOUNTERS" AS "covered_encounters_count",
        "UNCOVERED_ENCOUNTERS" AS "uncovered_encounters_count",
        "COVERED_MEDICATIONS" AS "covered_medications_count",
        "UNCOVERED_MEDICATIONS" AS "uncovered_medications_count",
        "COVERED_PROCEDURES" AS "covered_procedures_count",
        "UNCOVERED_PROCEDURES" AS "uncovered_procedures_count",
        "COVERED_IMMUNIZATIONS" AS "covered_immunizations_count",
        "UNCOVERED_IMMUNIZATIONS" AS "uncovered_immunizations_count",
        "UNIQUE_CUSTOMERS",
        "QOLS_AVG" AS "average_quality_of_life_score",
        "MEMBER_MONTHS"
    FROM "payers"
),

"payers_renamed_casted" AS (
    -- Column Type Casting: 
    -- headquarters_state: from DECIMAL to VARCHAR
    -- payer_address: from DECIMAL to VARCHAR
    -- payer_city: from DECIMAL to VARCHAR
    -- payer_id: from VARCHAR to UUID
    -- payer_phone: from DECIMAL to VARCHAR
    -- payer_zip_code: from DECIMAL to VARCHAR
    SELECT
        "payer_name",
        "OWNERSHIP",
        "total_covered_amount",
        "total_uncovered_amount",
        "REVENUE",
        "covered_encounters_count",
        "uncovered_encounters_count",
        "covered_medications_count",
        "uncovered_medications_count",
        "covered_procedures_count",
        "uncovered_procedures_count",
        "covered_immunizations_count",
        "uncovered_immunizations_count",
        "UNIQUE_CUSTOMERS",
        "average_quality_of_life_score",
        "MEMBER_MONTHS",
        CAST("headquarters_state" AS VARCHAR) AS "headquarters_state",
        CAST("payer_address" AS VARCHAR) AS "payer_address",
        CAST("payer_city" AS VARCHAR) AS "payer_city",
        CAST("payer_id" AS UUID) AS "payer_id",
        CAST("payer_phone" AS VARCHAR) AS "payer_phone",
        CAST("payer_zip_code" AS VARCHAR) AS "payer_zip_code"
    FROM "payers_renamed"
),

"payers_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 5 columns with unacceptable missing values
    -- headquarters_state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payer_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payer_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payer_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payer_zip_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "payer_name",
        "OWNERSHIP",
        "total_covered_amount",
        "total_uncovered_amount",
        "REVENUE",
        "covered_encounters_count",
        "uncovered_encounters_count",
        "covered_medications_count",
        "uncovered_medications_count",
        "covered_procedures_count",
        "uncovered_procedures_count",
        "covered_immunizations_count",
        "uncovered_immunizations_count",
        "UNIQUE_CUSTOMERS",
        "average_quality_of_life_score",
        "MEMBER_MONTHS",
        "payer_id"
    FROM "payers_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "payers_renamed_casted_missing_handled"