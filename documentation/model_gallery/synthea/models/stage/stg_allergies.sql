-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 00:46:26.795976+00:00
WITH 
"allergies_renamed" AS (
    -- Rename: Renaming columns
    -- START -> allergy_start_date
    -- STOP -> allergy_end_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> allergen_code
    -- SYSTEM -> coding_system
    -- DESCRIPTION -> allergen_description
    -- TYPE -> sensitivity_type
    -- CATEGORY -> allergen_category
    -- REACTION1 -> primary_reaction_code
    -- DESCRIPTION1 -> primary_reaction_description
    -- SEVERITY1 -> primary_reaction_severity
    -- REACTION2 -> secondary_reaction_code
    -- DESCRIPTION2 -> secondary_reaction_description
    -- SEVERITY2 -> secondary_reaction_severity
    SELECT 
        "START" AS "allergy_start_date",
        "STOP" AS "allergy_end_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "allergen_code",
        "SYSTEM" AS "coding_system",
        "DESCRIPTION" AS "allergen_description",
        "TYPE" AS "sensitivity_type",
        "CATEGORY" AS "allergen_category",
        "REACTION1" AS "primary_reaction_code",
        "DESCRIPTION1" AS "primary_reaction_description",
        "SEVERITY1" AS "primary_reaction_severity",
        "REACTION2" AS "secondary_reaction_code",
        "DESCRIPTION2" AS "secondary_reaction_description",
        "SEVERITY2" AS "secondary_reaction_severity"
    FROM "memory"."main"."allergies"
),

"allergies_renamed_casted" AS (
    -- Column Type Casting: 
    -- allergen_code: from INT to VARCHAR
    -- allergy_end_date: from DECIMAL to DATE
    -- allergy_start_date: from VARCHAR to DATE
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- primary_reaction_code: from DECIMAL to VARCHAR
    -- secondary_reaction_code: from DECIMAL to VARCHAR
    SELECT
        "coding_system",
        "allergen_description",
        "sensitivity_type",
        "allergen_category",
        "primary_reaction_description",
        "primary_reaction_severity",
        "secondary_reaction_description",
        "secondary_reaction_severity",
        CAST("allergen_code" AS VARCHAR) 
        AS "allergen_code",
        CAST("allergy_end_date" AS DATE) 
        AS "allergy_end_date",
        CAST("allergy_start_date" AS DATE) 
        AS "allergy_start_date",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("primary_reaction_code" AS VARCHAR) 
        AS "primary_reaction_code",
        CAST("secondary_reaction_code" AS VARCHAR) 
        AS "secondary_reaction_code"
    FROM "allergies_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "allergies_renamed_casted"