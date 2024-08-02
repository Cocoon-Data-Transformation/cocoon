-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:20:25.440671+00:00
WITH 
"imaging_studies_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> study_id
    -- DATE_ -> study_datetime
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- SERIES_UID -> series_uid
    -- BODYSITE_CODE -> bodysite_code
    -- BODYSITE_DESCRIPTION -> bodysite_description
    -- MODALITY_CODE -> modality_code
    -- MODALITY_DESCRIPTION -> modality_description
    -- INSTANCE_UID -> instance_uid
    -- SOP_CODE -> sop_code
    -- SOP_DESCRIPTION -> sop_description
    -- PROCEDURE_CODE -> procedure_code
    SELECT 
        "Id" AS "study_id",
        "DATE_" AS "study_datetime",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "SERIES_UID" AS "series_uid",
        "BODYSITE_CODE" AS "bodysite_code",
        "BODYSITE_DESCRIPTION" AS "bodysite_description",
        "MODALITY_CODE" AS "modality_code",
        "MODALITY_DESCRIPTION" AS "modality_description",
        "INSTANCE_UID" AS "instance_uid",
        "SOP_CODE" AS "sop_code",
        "SOP_DESCRIPTION" AS "sop_description",
        "PROCEDURE_CODE" AS "procedure_code"
    FROM "memory"."main"."imaging_studies"
),

"imaging_studies_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- bodysite_description: The problem is inconsistent use of the '(body structure)' suffix and varying levels of anatomical specificity. Some values have the suffix while others don't, and some are more specific (e.g., 'Ankle') while others are broader (e.g., 'Thoracic structure'). The correct values should maintain a consistent format and level of specificity. In this case, we'll standardize by adding '(body structure)' to all values and using more general anatomical terms where possible.
    SELECT
        "study_id",
        "study_datetime",
        "patient_id",
        "encounter_id",
        "series_uid",
        "bodysite_code",
        CASE
            WHEN "bodysite_description" = 'Clavicle' THEN 'Upper limb structure (body structure)'
            WHEN "bodysite_description" = 'Ankle' THEN 'Lower limb structure (body structure)'
            WHEN "bodysite_description" = 'Arm' THEN 'Upper limb structure (body structure)'
            WHEN "bodysite_description" = 'Entire chest and abdomen and pelvis (body structure)' THEN 'Trunk structure (body structure)'
            WHEN "bodysite_description" = 'Knee' THEN 'Lower limb structure (body structure)'
            WHEN "bodysite_description" = 'Wrist' THEN 'Upper limb structure (body structure)'
            ELSE "bodysite_description"
        END AS "bodysite_description",
        "modality_code",
        "modality_description",
        "instance_uid",
        "sop_code",
        "sop_description",
        "procedure_code"
    FROM "imaging_studies_renamed"
),

"imaging_studies_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- bodysite_code: from INT to VARCHAR
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- procedure_code: from INT to VARCHAR
    -- study_datetime: from VARCHAR to TIMESTAMP
    -- study_id: from VARCHAR to UUID
    SELECT
        "series_uid",
        "bodysite_description",
        "modality_code",
        "modality_description",
        "instance_uid",
        "sop_code",
        "sop_description",
        CAST("bodysite_code" AS VARCHAR) 
        AS "bodysite_code",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("procedure_code" AS VARCHAR) 
        AS "procedure_code",
        CAST("study_datetime" AS TIMESTAMP) 
        AS "study_datetime",
        CAST("study_id" AS UUID) 
        AS "study_id"
    FROM "imaging_studies_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "imaging_studies_renamed_cleaned_casted"