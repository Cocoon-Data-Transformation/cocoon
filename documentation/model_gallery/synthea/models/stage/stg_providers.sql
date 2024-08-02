-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:36:42.298559+00:00
WITH 
"providers_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> provider_id
    -- ORGANIZATION -> organization_id
    -- NAME -> provider_name
    -- GENDER -> gender
    -- SPECIALITY -> specialty
    -- ADDRESS -> street_address
    -- CITY -> city
    -- STATE -> state
    -- ZIP -> zip_code
    -- LAT -> latitude
    -- LON -> longitude
    -- ENCOUNTERS -> encounter_count
    -- PROCEDURES -> procedure_count
    SELECT 
        "Id" AS "provider_id",
        "ORGANIZATION" AS "organization_id",
        "NAME" AS "provider_name",
        "GENDER" AS "gender",
        "SPECIALITY" AS "specialty",
        "ADDRESS" AS "street_address",
        "CITY" AS "city",
        "STATE" AS "state",
        "ZIP" AS "zip_code",
        "LAT" AS "latitude",
        "LON" AS "longitude",
        "ENCOUNTERS" AS "encounter_count",
        "PROCEDURES" AS "procedure_count"
    FROM "memory"."main"."providers"
),

"providers_renamed_casted" AS (
    -- Column Type Casting: 
    -- organization_id: from VARCHAR to UUID
    -- provider_id: from VARCHAR to UUID
    -- zip_code: from INT to VARCHAR
    SELECT
        "provider_name",
        "gender",
        "specialty",
        "street_address",
        "city",
        "state",
        "latitude",
        "longitude",
        "encounter_count",
        "procedure_count",
        CAST("organization_id" AS UUID) 
        AS "organization_id",
        CAST("provider_id" AS UUID) 
        AS "provider_id",
        CAST("zip_code" AS VARCHAR) 
        AS "zip_code"
    FROM "providers_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "providers_renamed_casted"