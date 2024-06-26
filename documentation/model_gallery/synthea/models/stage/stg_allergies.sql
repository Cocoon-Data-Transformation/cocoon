-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"allergies_renamed" AS (
    -- Rename: Renaming columns
    -- START -> ALLERGY_START_DATE
    -- STOP -> ALLERGY_END_DATE
    -- PATIENT -> PATIENT_ID
    -- ENCOUNTER -> ENCOUNTER_ID
    -- CODE -> ALLERGEN_CODE
    -- SYSTEM -> CODING_SYSTEM
    -- DESCRIPTION -> ALLERGEN_DESCRIPTION
    -- TYPE -> ALLERGY_TYPE
    -- REACTION1 -> PRIMARY_REACTION_CODE
    -- DESCRIPTION1 -> ADDITIONAL_DESCRIPTION_1
    -- SEVERITY1 -> PRIMARY_REACTION_SEVERITY
    -- REACTION2 -> SECONDARY_REACTION_CODE
    -- DESCRIPTION2 -> ADDITIONAL_DESCRIPTION_2
    -- SEVERITY2 -> SECONDARY_REACTION_SEVERITY
    SELECT 
        "START" AS "ALLERGY_START_DATE",
        "STOP" AS "ALLERGY_END_DATE",
        "PATIENT" AS "PATIENT_ID",
        "ENCOUNTER" AS "ENCOUNTER_ID",
        "CODE" AS "ALLERGEN_CODE",
        "SYSTEM" AS "CODING_SYSTEM",
        "DESCRIPTION" AS "ALLERGEN_DESCRIPTION",
        "TYPE" AS "ALLERGY_TYPE",
        "CATEGORY",
        "REACTION1" AS "PRIMARY_REACTION_CODE",
        "DESCRIPTION1" AS "ADDITIONAL_DESCRIPTION_1",
        "SEVERITY1" AS "PRIMARY_REACTION_SEVERITY",
        "REACTION2" AS "SECONDARY_REACTION_CODE",
        "DESCRIPTION2" AS "ADDITIONAL_DESCRIPTION_2",
        "SEVERITY2" AS "SECONDARY_REACTION_SEVERITY"
    FROM "allergies"
),

"allergies_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- ADDITIONAL_DESCRIPTION_1: The problem is inconsistent use of classifications '(disorder)' and '(finding)', as well as some terms lacking any classification. The correct values should all follow the same pattern, with the most frequent being '(disorder)'. Terms without classification should be updated to include '(disorder)', and '(finding)' should be changed to '(disorder)' for consistency. 
    SELECT
        "ALLERGY_START_DATE",
        "ALLERGY_END_DATE",
        "PATIENT_ID",
        "ENCOUNTER_ID",
        "ALLERGEN_CODE",
        "CODING_SYSTEM",
        "ALLERGEN_DESCRIPTION",
        "ALLERGY_TYPE",
        "CATEGORY",
        "PRIMARY_REACTION_CODE",
        CASE
            WHEN "ADDITIONAL_DESCRIPTION_1" = 'Allergic skin rash' THEN 'Allergic skin rash (disorder)'
            WHEN "ADDITIONAL_DESCRIPTION_1" = 'Dyspnea (finding)' THEN 'Dyspnea (disorder)'
            WHEN "ADDITIONAL_DESCRIPTION_1" = 'Wheal (finding)' THEN 'Wheal (disorder)'
            WHEN "ADDITIONAL_DESCRIPTION_1" = 'Cough (finding)' THEN 'Cough (disorder)'
            WHEN "ADDITIONAL_DESCRIPTION_1" = 'Nose running' THEN 'Nose running (disorder)'
            WHEN "ADDITIONAL_DESCRIPTION_1" = 'Sneezing' THEN 'Sneezing (disorder)'
            ELSE "ADDITIONAL_DESCRIPTION_1"
        END AS "ADDITIONAL_DESCRIPTION_1",
        "PRIMARY_REACTION_SEVERITY",
        "SECONDARY_REACTION_CODE",
        "ADDITIONAL_DESCRIPTION_2",
        "SECONDARY_REACTION_SEVERITY"
    FROM "allergies_renamed"
),

"allergies_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- ALLERGEN_CODE: from INT to VARCHAR
    -- ALLERGY_END_DATE: from DECIMAL to DATE
    -- ALLERGY_START_DATE: from VARCHAR to DATE
    -- ENCOUNTER_ID: from VARCHAR to UUID
    -- PATIENT_ID: from VARCHAR to UUID
    -- PRIMARY_REACTION_CODE: from DECIMAL to VARCHAR
    -- SECONDARY_REACTION_CODE: from DECIMAL to VARCHAR
    SELECT
        "CODING_SYSTEM",
        "ALLERGEN_DESCRIPTION",
        "ALLERGY_TYPE",
        "CATEGORY",
        "ADDITIONAL_DESCRIPTION_1",
        "PRIMARY_REACTION_SEVERITY",
        "ADDITIONAL_DESCRIPTION_2",
        "SECONDARY_REACTION_SEVERITY",
        CAST("ALLERGEN_CODE" AS VARCHAR) AS "ALLERGEN_CODE",
        CAST("ALLERGY_END_DATE" AS DATE) AS "ALLERGY_END_DATE",
        CAST("ALLERGY_START_DATE" AS DATE) AS "ALLERGY_START_DATE",
        CAST("ENCOUNTER_ID" AS UUID) AS "ENCOUNTER_ID",
        CAST("PATIENT_ID" AS UUID) AS "PATIENT_ID",
        CAST("PRIMARY_REACTION_CODE" AS VARCHAR) AS "PRIMARY_REACTION_CODE",
        CAST("SECONDARY_REACTION_CODE" AS VARCHAR) AS "SECONDARY_REACTION_CODE"
    FROM "allergies_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "allergies_renamed_cleaned_casted"