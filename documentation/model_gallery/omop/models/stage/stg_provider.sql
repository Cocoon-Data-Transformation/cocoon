-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 01:16:09.626074+00:00
WITH 
"provider_casted" AS (
    -- Column Type Casting: 
    -- npi: from INT to VARCHAR
    SELECT
        "provider_id",
        "provider_name",
        "dea",
        "care_site_id",
        "provider_source_value",
        "specialty_source_value",
        "gender_source_value",
        CAST("npi" AS VARCHAR) 
        AS "npi"
    FROM "memory"."main"."provider"
)

-- COCOON BLOCK END
SELECT *
FROM "provider_casted"