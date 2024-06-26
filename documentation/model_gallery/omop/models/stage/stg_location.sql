-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"location_renamed" AS (
    -- Rename: Renaming columns
    -- address_1 -> primary_address
    -- address_2 -> secondary_address
    -- zip -> zip_code
    -- location_source_value -> source_value
    SELECT 
        "location_id",
        "address_1" AS "primary_address",
        "address_2" AS "secondary_address",
        "city",
        "state",
        "zip" AS "zip_code",
        "county",
        "location_source_value" AS "source_value",
        "latitude",
        "longitude"
    FROM "location"
),

"location_renamed_casted" AS (
    -- Column Type Casting: 
    -- zip_code: from INT to VARCHAR
    SELECT
        "location_id",
        "primary_address",
        "secondary_address",
        "city",
        "state",
        "county",
        "source_value",
        "latitude",
        "longitude",
        CAST("zip_code" AS VARCHAR) AS "zip_code"
    FROM "location_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "location_renamed_casted"