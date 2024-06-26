-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"careplans_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> care_plan_id
    -- START -> start_date
    -- STOP -> end_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> procedure_code
    -- DESCRIPTION -> procedure_description
    -- REASONCODE -> condition_code
    -- REASONDESCRIPTION -> condition_description
    SELECT 
        "Id" AS "care_plan_id",
        "START" AS "start_date",
        "STOP" AS "end_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CODE" AS "procedure_code",
        "DESCRIPTION" AS "procedure_description",
        "REASONCODE" AS "condition_code",
        "REASONDESCRIPTION" AS "condition_description"
    FROM "careplans"
),

"careplans_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- condition_description: The problem is inconsistent labeling of conditions. Some conditions include '(disorder)' at the end while others don't. The correct values should not include '(disorder)' for consistency. Additionally, some conditions use different terminology for similar conditions (e.g., 'Sleep apnea (disorder)' vs 'Obstructive sleep apnea syndrome (disorder)'). The correct values should use consistent terminology and remove the '(disorder)' suffix. 
    SELECT
        "care_plan_id",
        "start_date",
        "end_date",
        "patient_id",
        "encounter_id",
        "procedure_code",
        "procedure_description",
        "condition_code",
        CASE
            WHEN "condition_description" = 'Chronic congestive heart failure (disorder)' THEN 'Chronic congestive heart failure'
            WHEN "condition_description" = 'Obstructive sleep apnea syndrome (disorder)' THEN 'Obstructive sleep apnea syndrome'
            WHEN "condition_description" = 'Alzheimer''s disease (disorder)' THEN 'Alzheimer''s disease'
            WHEN "condition_description" = 'Pulmonary emphysema (disorder)' THEN 'Pulmonary emphysema'
            WHEN "condition_description" = 'Sleep apnea (disorder)' THEN 'Sleep apnea'
            ELSE "condition_description"
        END AS "condition_description"
    FROM "careplans_renamed"
),

"careplans_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- care_plan_id: from VARCHAR to UUID
    -- encounter_id: from VARCHAR to UUID
    -- end_date: from VARCHAR to DATE
    -- patient_id: from VARCHAR to UUID
    -- procedure_code: from INT to VARCHAR
    -- start_date: from VARCHAR to DATE
    SELECT
        "procedure_description",
        "condition_code",
        "condition_description",
        CAST("care_plan_id" AS UUID) AS "care_plan_id",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CAST("end_date" AS DATE) AS "end_date",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("procedure_code" AS VARCHAR) AS "procedure_code",
        CAST("start_date" AS DATE) AS "start_date"
    FROM "careplans_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "careplans_renamed_cleaned_casted"