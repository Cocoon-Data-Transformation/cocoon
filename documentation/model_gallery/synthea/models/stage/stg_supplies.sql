-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:17:12.506926+00:00
WITH 
"supplies_renamed" AS (
    -- Rename: Renaming columns
    -- DATE_ -> order_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> supply_code
    -- DESCRIPTION -> supply_description
    -- QUANTITY -> quantity_ordered
    SELECT 
        "DATE_" AS "order_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "supply_code",
        "DESCRIPTION" AS "supply_description",
        "QUANTITY" AS "quantity_ordered"
    FROM "memory"."main"."supplies"
),

"supplies_renamed_dedup" AS (
    -- Deduplication: Removed 7 duplicated rows
    SELECT DISTINCT *
    FROM "supplies_renamed"
),

"supplies_renamed_dedup_cleaned" AS (
    -- Clean unusual string values: 
    -- supply_description: The supply_description column has several inconsistencies: 1. Inconsistent spacing: 'Air filter  device' has an extra space. 2. Inconsistent representations of CPAP/BPAP: Some use full words, others use abbreviations. 3. Inconsistent use of parentheses: Most entries have '(physical object)' at the end, but one has '(substance)' and another has '(product)'. 4. Inconsistent capitalization: Some entries start with capital letters, others don't. The correct values should have consistent spacing, use full words instead of abbreviations, use '(physical object)' consistently for devices, and have consistent capitalization.
    SELECT
        "order_date",
        "patient_id",
        "encounter_id",
        "supply_code",
        CASE
            WHEN "supply_description" = 'Air filter  device (physical object)' THEN 'Air filter device (physical object)'
            WHEN "supply_description" = 'CPAP/BPAP oral mask (physical object)' THEN 'Continuous positive airway pressure/Bilevel positive airway pressure oral mask (physical object)'
            WHEN "supply_description" = 'Solution (substance)' THEN 'Solution (physical object)'
            WHEN "supply_description" = 'Packed red blood cells (product)' THEN 'Packed red blood cells (physical object)'
            ELSE "supply_description"
        END AS "supply_description",
        "quantity_ordered"
    FROM "supplies_renamed_dedup"
),

"supplies_renamed_dedup_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- order_date: from VARCHAR to DATE
    -- patient_id: from VARCHAR to UUID
    -- supply_code: from INT to VARCHAR
    SELECT
        "supply_description",
        "quantity_ordered",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("order_date" AS DATE) 
        AS "order_date",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("supply_code" AS VARCHAR) 
        AS "supply_code"
    FROM "supplies_renamed_dedup_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "supplies_renamed_dedup_cleaned_casted"