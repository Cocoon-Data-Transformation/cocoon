-- Slowly Changing Dimension: Dimension keys are "survey_id"
-- Effective date columns are "version_number"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "survey_id",
    "is_deleted",
    "description",
    "is_published",
    "user_id",
    "was_ever_published",
    "creation_date",
    "version_id"
FROM (
     SELECT 
            "survey_id",
            "is_deleted",
            "description",
            "is_published",
            "user_id",
            "was_ever_published",
            "creation_date",
            "version_id",
            ROW_NUMBER() OVER (
                PARTITION BY "survey_id" 
                ORDER BY "version_number" 
            DESC) AS "cocoon_rn"
    FROM "stg_survey_version"
) ranked
WHERE "cocoon_rn" = 1