-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"organizations_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> ORGANIZATION_ID
    -- NAME -> ORGANIZATION_NAME
    -- ZIP -> ZIP_CODE
    -- LAT -> LATITUDE
    -- LON -> LONGITUDE
    -- PHONE -> PHONE_NUMBER
    -- UTILIZATION -> UTILIZATION_RATE
    SELECT 
        "Id" AS "ORGANIZATION_ID",
        "NAME" AS "ORGANIZATION_NAME",
        "ADDRESS",
        "CITY",
        "STATE",
        "ZIP" AS "ZIP_CODE",
        "LAT" AS "LATITUDE",
        "LON" AS "LONGITUDE",
        "PHONE" AS "PHONE_NUMBER",
        "REVENUE",
        "UTILIZATION" AS "UTILIZATION_RATE"
    FROM "organizations"
),

"organizations_renamed_casted" AS (
    -- Column Type Casting: 
    -- ORGANIZATION_ID: from VARCHAR to UUID
    -- ZIP_CODE: from INT to VARCHAR
    SELECT
        "ORGANIZATION_NAME",
        "ADDRESS",
        "CITY",
        "STATE",
        "LATITUDE",
        "LONGITUDE",
        "PHONE_NUMBER",
        "REVENUE",
        "UTILIZATION_RATE",
        CAST("ORGANIZATION_ID" AS UUID) AS "ORGANIZATION_ID",
        CAST("ZIP_CODE" AS VARCHAR) AS "ZIP_CODE"
    FROM "organizations_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "organizations_renamed_casted"