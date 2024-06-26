-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"provider_renamed" AS (
    -- Rename: Renaming columns
    -- npi -> npi_number
    -- dea -> dea_number
    -- care_site_id -> facility_id
    -- provider_source_value -> internal_provider_id
    -- specialty_source_value -> provider_specialty
    -- gender_source_value -> provider_gender
    SELECT 
        "provider_id",
        "provider_name",
        "npi" AS "npi_number",
        "dea" AS "dea_number",
        "care_site_id" AS "facility_id",
        "provider_source_value" AS "internal_provider_id",
        "specialty_source_value" AS "provider_specialty",
        "gender_source_value" AS "provider_gender"
    FROM "provider"
),

"provider_renamed_casted" AS (
    -- Column Type Casting: 
    -- npi_number: from INT to VARCHAR
    -- provider_id: from INT to VARCHAR
    SELECT
        "provider_name",
        "dea_number",
        "facility_id",
        "internal_provider_id",
        "provider_specialty",
        "provider_gender",
        CAST("npi_number" AS VARCHAR) AS "npi_number",
        CAST("provider_id" AS VARCHAR) AS "provider_id"
    FROM "provider_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "provider_renamed_casted"