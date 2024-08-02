-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 00:52:59.900703+00:00
WITH 
"location_cleaned" AS (
    -- Clean unusual string values: 
    -- county: The problem is that 'Archie' is not a valid county name in any U.S. state. The correct value appears to be 'Hampden', which is a real county name in Massachusetts. 'Archie' is likely a data entry error or misclassification.
    SELECT
        "location_id",
        "address_1",
        "address_2",
        "city",
        "state",
        "zip",
        CASE
            WHEN "county" = 'Archie' THEN 'Hampden'
            ELSE "county"
        END AS "county",
        "location_source_value",
        "latitude",
        "longitude"
    FROM "memory"."main"."location"
),

"location_cleaned_casted" AS (
    -- Column Type Casting: 
    -- zip: from INT to VARCHAR
    SELECT
        "location_id",
        "address_1",
        "address_2",
        "city",
        "state",
        "county",
        "location_source_value",
        "latitude",
        "longitude",
        CAST("zip" AS VARCHAR) 
        AS "zip"
    FROM "location_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "location_cleaned_casted"