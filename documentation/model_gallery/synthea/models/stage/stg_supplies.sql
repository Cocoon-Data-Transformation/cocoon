-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:37:43.074313+00:00
WITH 
"supplies_renamed" AS (
    -- Rename: Renaming columns
    -- DATE_ -> supply_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> supply_code
    SELECT 
        "DATE_" AS "supply_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "supply_code",
        "DESCRIPTION",
        "QUANTITY"
    FROM "memory"."main"."supplies"
),

"supplies_renamed_dedup" AS (
    -- Deduplication: Removed 7 duplicated rows
    SELECT DISTINCT *
    FROM "supplies_renamed"
),

"supplies_renamed_dedup_cleaned" AS (
    -- Clean unusual string values: 
    -- DESCRIPTION: The problem is inconsistent spacing and inconsistent use of abbreviations. Specifically, 'Air filter  device' has an extra space, and some items use 'CPAP/BPAP' while others spell out 'Continuous positive airway pressure/Bilevel positive airway pressure'. The correct values should have consistent spacing and use the full spelling of CPAP/BPAP for clarity and consistency.
    SELECT
        "supply_date",
        "patient_id",
        "encounter_id",
        "supply_code",
        CASE
            WHEN "DESCRIPTION" = 'Air filter  device (physical object)' THEN 'Air filter device (physical object)'
            WHEN "DESCRIPTION" = 'CPAP/BPAP oral mask (physical object)' THEN 'Continuous positive airway pressure/Bilevel positive airway pressure oral mask (physical object)'
            ELSE "DESCRIPTION"
        END AS "DESCRIPTION",
        "QUANTITY"
    FROM "supplies_renamed_dedup"
),

"supplies_renamed_dedup_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- supply_code: from INT to VARCHAR
    -- supply_date: from VARCHAR to DATE
    SELECT
        "DESCRIPTION",
        "QUANTITY",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("supply_code" AS VARCHAR) 
        AS "supply_code",
        CAST("supply_date" AS DATE) 
        AS "supply_date"
    FROM "supplies_renamed_dedup_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "supplies_renamed_dedup_cleaned_casted"