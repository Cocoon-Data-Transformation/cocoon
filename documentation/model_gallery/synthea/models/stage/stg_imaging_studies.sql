-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"imaging_studies_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> study_id
    -- DATE_ -> study_datetime
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- SERIES_UID -> series_uid
    -- BODYSITE_CODE -> body_site_code
    -- BODYSITE_DESCRIPTION -> body_site_name
    -- MODALITY_CODE -> modality_code
    -- MODALITY_DESCRIPTION -> modality_name
    -- INSTANCE_UID -> image_instance_uid
    -- SOP_CODE -> sop_code
    -- SOP_DESCRIPTION -> sop_description
    -- PROCEDURE_CODE -> procedure_code
    SELECT 
        "Id" AS "study_id",
        "DATE_" AS "study_datetime",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "SERIES_UID" AS "series_uid",
        "BODYSITE_CODE" AS "body_site_code",
        "BODYSITE_DESCRIPTION" AS "body_site_name",
        "MODALITY_CODE" AS "modality_code",
        "MODALITY_DESCRIPTION" AS "modality_name",
        "INSTANCE_UID" AS "image_instance_uid",
        "SOP_CODE" AS "sop_code",
        "SOP_DESCRIPTION" AS "sop_description",
        "PROCEDURE_CODE" AS "procedure_code"
    FROM "imaging_studies"
),

"imaging_studies_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- body_site_name: The problem is inconsistent use of the '(body structure)' suffix and varying levels of anatomical specificity. Some terms include the suffix while others don't, and some terms are more specific (e.g., "Clavicle") while others are more general (e.g., "Arm"). The correct values should maintain a consistent level of specificity and include the '(body structure)' suffix for all terms. 
    -- sop_description: The problem is that 'Digital X-Ray Image Storage' appears twice, once with '– for Presentation' added. This is likely redundant or inconsistent. The correct values should be standardized to the most specific form, which is 'Digital X-Ray Image Storage – for Presentation'. The other values ('Ultrasound Multiframe Image Storage' and 'CT Image Storage') appear to be correct and consistent, so they don't need to be changed. 
    SELECT
        "study_id",
        "study_datetime",
        "patient_id",
        "encounter_id",
        "series_uid",
        "body_site_code",
        CASE
            WHEN "body_site_name" = 'Clavicle' THEN 'Clavicle structure (body structure)'
            WHEN "body_site_name" = 'Ankle' THEN 'Ankle structure (body structure)'
            WHEN "body_site_name" = 'Arm' THEN 'Arm structure (body structure)'
            WHEN "body_site_name" = 'Entire chest and abdomen and pelvis (body structure)' THEN 'Chest, abdomen, and pelvis structure (body structure)'
            WHEN "body_site_name" = 'Knee' THEN 'Knee structure (body structure)'
            WHEN "body_site_name" = 'Wrist' THEN 'Wrist structure (body structure)'
            ELSE "body_site_name"
        END AS "body_site_name",
        "modality_code",
        "modality_name",
        "image_instance_uid",
        "sop_code",
        CASE
            WHEN "sop_description" = 'Digital X-Ray Image Storage' THEN 'Digital X-Ray Image Storage – for Presentation'
            ELSE "sop_description"
        END AS "sop_description",
        "procedure_code"
    FROM "imaging_studies_renamed"
),

"imaging_studies_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- body_site_code: from INT to VARCHAR
    -- encounter_id: from VARCHAR to UUID
    -- patient_id: from VARCHAR to UUID
    -- procedure_code: from INT to VARCHAR
    -- study_datetime: from VARCHAR to TIMESTAMP
    -- study_id: from VARCHAR to UUID
    SELECT
        "series_uid",
        "body_site_name",
        "modality_code",
        "modality_name",
        "image_instance_uid",
        "sop_code",
        "sop_description",
        CAST("body_site_code" AS VARCHAR) AS "body_site_code",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("procedure_code" AS VARCHAR) AS "procedure_code",
        CAST("study_datetime" AS TIMESTAMP) AS "study_datetime",
        CAST("study_id" AS UUID) AS "study_id"
    FROM "imaging_studies_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "imaging_studies_renamed_cleaned_casted"