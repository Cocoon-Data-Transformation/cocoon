-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"warehouse_renamed" AS (
    -- Rename: Renaming columns
    -- W_WAREHOUSE_SK -> warehouse_surrogate_key
    -- W_WAREHOUSE_SQ_FT -> warehouse_size_sqft
    -- W_STREET_NUMBER -> warehouse_street_number
    -- W_STREET_NAME -> warehouse_street_name
    -- W_STREET_TYPE -> warehouse_street_type
    -- W_SUITE_NUMBER -> warehouse_suite_number
    -- W_CITY -> warehouse_city
    -- W_COUNTY -> warehouse_county
    -- W_STATE -> warehouse_state
    -- W_ZIP -> warehouse_zip_code
    -- W_COUNTRY -> warehouse_country
    -- W_GMT_OFFSET -> warehouse_timezone_offset
    SELECT 
        "W_WAREHOUSE_SK" AS "warehouse_surrogate_key",
        "W_WAREHOUSE_ID",
        "W_WAREHOUSE_NAME",
        "W_WAREHOUSE_SQ_FT" AS "warehouse_size_sqft",
        "W_STREET_NUMBER" AS "warehouse_street_number",
        "W_STREET_NAME" AS "warehouse_street_name",
        "W_STREET_TYPE" AS "warehouse_street_type",
        "W_SUITE_NUMBER" AS "warehouse_suite_number",
        "W_CITY" AS "warehouse_city",
        "W_COUNTY" AS "warehouse_county",
        "W_STATE" AS "warehouse_state",
        "W_ZIP" AS "warehouse_zip_code",
        "W_COUNTRY" AS "warehouse_country",
        "W_GMT_OFFSET" AS "warehouse_timezone_offset"
    FROM "warehouse"
),

"warehouse_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "warehouse_surrogate_key",
        "W_WAREHOUSE_ID",
        "W_WAREHOUSE_NAME",
        "warehouse_size_sqft",
        "warehouse_street_number",
        "warehouse_street_type",
        "warehouse_suite_number",
        "warehouse_city",
        "warehouse_county",
        "warehouse_state",
        "warehouse_zip_code",
        "warehouse_country",
        "warehouse_timezone_offset",
        TRIM("warehouse_street_name") AS "warehouse_street_name"
    FROM "warehouse_renamed"
),

"warehouse_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- W_WAREHOUSE_NAME: The problem is that the value 'Conventional childr' appears to be truncated. It's likely that this is meant to be 'Conventional children' or possibly 'Conventional child'. Given that this is a warehouse name, it's more likely to be 'Conventional children' as it probably refers to a warehouse for conventional children's products. 
    SELECT
        "warehouse_surrogate_key",
        "W_WAREHOUSE_ID",
        CASE
            WHEN "W_WAREHOUSE_NAME" = 'Conventional childr' THEN 'Conventional children'
            ELSE "W_WAREHOUSE_NAME"
        END AS "W_WAREHOUSE_NAME",
        "warehouse_size_sqft",
        "warehouse_street_number",
        "warehouse_street_type",
        "warehouse_suite_number",
        "warehouse_city",
        "warehouse_county",
        "warehouse_state",
        "warehouse_zip_code",
        "warehouse_country",
        "warehouse_timezone_offset",
        "warehouse_street_name"
    FROM "warehouse_renamed_trimmed"
),

"warehouse_renamed_trimmed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- warehouse_street_number: from INT to VARCHAR
    -- warehouse_zip_code: from INT to VARCHAR
    SELECT
        "warehouse_surrogate_key",
        "W_WAREHOUSE_ID",
        "W_WAREHOUSE_NAME",
        "warehouse_size_sqft",
        "warehouse_street_type",
        "warehouse_suite_number",
        "warehouse_city",
        "warehouse_county",
        "warehouse_state",
        "warehouse_country",
        "warehouse_timezone_offset",
        "warehouse_street_name",
        CAST("warehouse_street_number" AS VARCHAR) AS "warehouse_street_number",
        CAST("warehouse_zip_code" AS VARCHAR) AS "warehouse_zip_code"
    FROM "warehouse_renamed_trimmed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "warehouse_renamed_trimmed_cleaned_casted"