-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"supplies_renamed" AS (
    -- Rename: Renaming columns
    -- DATE_ -> supply_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> supply_code
    -- DESCRIPTION -> supply_description
    -- QUANTITY -> supply_quantity
    SELECT 
        "DATE_" AS "supply_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "supply_code",
        "DESCRIPTION" AS "supply_description",
        "QUANTITY" AS "supply_quantity"
    FROM "supplies"
),

"supplies_renamed_dedup" AS (
    -- Deduplication: Removed 7 duplicated rows
    SELECT DISTINCT * FROM "supplies_renamed"
),

"supplies_renamed_dedup_cleaned" AS (
    -- Clean unusual string values: 
    -- supply_description: The problem is inconsistent spacing and inconsistent use of abbreviations. The value 'Air filter  device' has an extra space between 'filter' and 'device'. There's also inconsistent use of CPAP/BPAP abbreviations, with some entries using the full words and others using the abbreviations. The correct values should have consistent spacing and use the full words instead of abbreviations for clarity. 
    SELECT
        "supply_date",
        "patient_id",
        "encounter_id",
        "supply_code",
        CASE
            WHEN "supply_description" = 'Air filter  device (physical object)' THEN 'Air filter device (physical object)'
            WHEN "supply_description" = 'CPAP/BPAP oral mask (physical object)' THEN 'Continuous positive airway pressure/Bilevel positive airway pressure oral mask (physical object)'
            ELSE "supply_description"
        END AS "supply_description",
        "supply_quantity"
    FROM "supplies_renamed_dedup"
),

"supplies_renamed_dedup_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- supply_code: from INT to VARCHAR
    -- supply_date: from VARCHAR to DATE
    SELECT
        "supply_description",
        "supply_quantity",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("supply_code" AS VARCHAR) AS "supply_code",
        CAST("supply_date" AS DATE) AS "supply_date"
    FROM "supplies_renamed_dedup_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "supplies_renamed_dedup_cleaned_casted"