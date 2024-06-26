-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"providers_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> provider_id
    -- ORGANIZATION -> organization_id
    -- NAME -> provider_name
    -- GENDER -> provider_gender
    -- SPECIALITY -> medical_specialty
    -- ADDRESS -> street_address
    -- CITY -> city
    -- STATE -> state
    -- ZIP -> zip_code
    -- LAT -> latitude
    -- LON -> longitude
    -- ENCOUNTERS -> patient_encounters
    -- PROCEDURES -> procedures_performed
    SELECT 
        "Id" AS "provider_id",
        "ORGANIZATION" AS "organization_id",
        "NAME" AS "provider_name",
        "GENDER" AS "provider_gender",
        "SPECIALITY" AS "medical_specialty",
        "ADDRESS" AS "street_address",
        "CITY" AS "city",
        "STATE" AS "state",
        "ZIP" AS "zip_code",
        "LAT" AS "latitude",
        "LON" AS "longitude",
        "ENCOUNTERS" AS "patient_encounters",
        "PROCEDURES" AS "procedures_performed"
    FROM "providers"
),

"providers_renamed_casted" AS (
    -- Column Type Casting: 
    -- organization_id: from VARCHAR to UUID
    -- provider_id: from VARCHAR to UUID
    -- zip_code: from INT to VARCHAR
    SELECT
        "provider_name",
        "provider_gender",
        "medical_specialty",
        "street_address",
        "city",
        "state",
        "latitude",
        "longitude",
        "patient_encounters",
        "procedures_performed",
        CAST("organization_id" AS UUID) AS "organization_id",
        CAST("provider_id" AS UUID) AS "provider_id",
        CAST("zip_code" AS VARCHAR) AS "zip_code"
    FROM "providers_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "providers_renamed_casted"