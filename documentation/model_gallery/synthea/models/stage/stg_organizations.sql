-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:27:14.155774+00:00
WITH 
"organizations_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> organization_id
    -- LAT -> latitude
    -- LON -> longitude
    -- REVENUE -> revenue
    -- UTILIZATION -> utilization_score
    SELECT 
        "Id" AS "organization_id",
        "NAME",
        "ADDRESS",
        "CITY",
        "STATE",
        "ZIP",
        "LAT" AS "latitude",
        "LON" AS "longitude",
        "PHONE",
        "REVENUE" AS "revenue",
        "UTILIZATION" AS "utilization_score"
    FROM "memory"."main"."organizations"
),

"organizations_renamed_casted" AS (
    -- Column Type Casting: 
    -- ZIP: from INT to VARCHAR
    -- organization_id: from VARCHAR to UUID
    SELECT
        "NAME",
        "ADDRESS",
        "CITY",
        "STATE",
        "latitude",
        "longitude",
        "PHONE",
        "revenue",
        "utilization_score",
        CAST("ZIP" AS VARCHAR) 
        AS "ZIP",
        CAST("organization_id" AS UUID) 
        AS "organization_id"
    FROM "organizations_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "organizations_renamed_casted"