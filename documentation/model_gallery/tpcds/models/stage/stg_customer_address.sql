-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"customer_address_renamed" AS (
    -- Rename: Renaming columns
    -- CA_ADDRESS_SK -> address_surrogate_key
    -- CA_ADDRESS_ID -> address_id
    -- CA_STREET_NUMBER -> street_number
    -- CA_STREET_NAME -> street_name
    -- CA_STREET_TYPE -> street_type
    -- CA_SUITE_NUMBER -> suite_number
    -- CA_CITY -> city
    -- CA_COUNTY -> county
    -- CA_STATE -> state
    -- CA_ZIP -> zip_code
    -- CA_COUNTRY -> country
    -- CA_GMT_OFFSET -> gmt_offset
    -- CA_LOCATION_TYPE -> residence_type
    SELECT 
        "CA_ADDRESS_SK" AS "address_surrogate_key",
        "CA_ADDRESS_ID" AS "address_id",
        "CA_STREET_NUMBER" AS "street_number",
        "CA_STREET_NAME" AS "street_name",
        "CA_STREET_TYPE" AS "street_type",
        "CA_SUITE_NUMBER" AS "suite_number",
        "CA_CITY" AS "city",
        "CA_COUNTY" AS "county",
        "CA_STATE" AS "state",
        "CA_ZIP" AS "zip_code",
        "CA_COUNTRY" AS "country",
        "CA_GMT_OFFSET" AS "gmt_offset",
        "CA_LOCATION_TYPE" AS "residence_type"
    FROM "customer_address"
),

"customer_address_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "address_surrogate_key",
        "address_id",
        "street_number",
        "street_type",
        "suite_number",
        "city",
        "county",
        "state",
        "zip_code",
        "country",
        "gmt_offset",
        "residence_type",
        TRIM("street_name") AS "street_name"
    FROM "customer_address_renamed"
),

"customer_address_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- street_type: The problem is inconsistency in abbreviations and punctuation for street types. Some types are spelled out fully while others are abbreviated, and some abbreviations include periods while others don't. The correct values should be the most common or standard representation for each street type. 
    -- street_name: The problem is inconsistent representation of street names, particularly for numbered streets. Some entries combine the street number with additional descriptors or other street names. The correct values should use a consistent format, using just the numbered street name where applicable, and separating multiple street names if needed. 
    SELECT
        "address_surrogate_key",
        "address_id",
        "street_number",
        CASE
            WHEN "street_type" = 'Dr.' THEN 'Drive'
            WHEN "street_type" = 'ST' THEN 'Street'
            WHEN "street_type" = 'Ave' THEN 'Avenue'
            WHEN "street_type" = 'RD' THEN 'Road'
            WHEN "street_type" = 'Ct.' THEN 'Court'
            WHEN "street_type" = 'Wy' THEN 'Way'
            WHEN "street_type" = 'Pkwy' THEN 'Parkway'
            WHEN "street_type" = 'Blvd' THEN 'Boulevard'
            WHEN "street_type" = 'Ln' THEN 'Lane'
            WHEN "street_type" = 'Cir.' THEN 'Circle'
            ELSE "street_type"
        END AS "street_type",
        "suite_number",
        "city",
        "county",
        "state",
        "zip_code",
        "country",
        "gmt_offset",
        "residence_type",
        CASE
            WHEN "street_name" = '10th 10th' THEN '10th'
            WHEN "street_name" = '10th Oak' THEN '10th'
            WHEN "street_name" = '11th 14th' THEN '11th'
            WHEN "street_name" = '13th 2nd' THEN '13th'
            WHEN "street_name" = '14th Sycamore' THEN '14th'
            WHEN "street_name" = '1st Cedar' THEN '1st'
            WHEN "street_name" = '1st Laurel' THEN '1st'
            WHEN "street_name" = '2nd Maple' THEN '2nd'
            WHEN "street_name" = '3rd 4th' THEN '3rd'
            WHEN "street_name" = '6th Spring' THEN '6th'
            WHEN "street_name" = '8th Lake' THEN '8th'
            WHEN "street_name" = 'Ash 8th' THEN '8th'
            WHEN "street_name" = 'Ash Wilson' THEN 'Wilson'
            WHEN "street_name" = 'Cedar Franklin' THEN 'Cedar'
            WHEN "street_name" = 'Church 7th' THEN '7th'
            WHEN "street_name" = 'College Franklin' THEN 'College'
            WHEN "street_name" = 'Dogwood Washington' THEN 'Washington'
            WHEN "street_name" = 'Elevnth Green' THEN '11th'
            WHEN "street_name" = 'Elm Wilson' THEN 'Wilson'
            WHEN "street_name" = 'First Elevnth' THEN '11th'
            WHEN "street_name" = 'Fourth Lake' THEN '4th'
            WHEN "street_name" = 'Green Broadway' THEN 'Green'
            WHEN "street_name" = 'Hickory River' THEN 'River'
            WHEN "street_name" = 'Highland 2nd' THEN '2nd'
            WHEN "street_name" = 'Hill 7th' THEN '7th'
            WHEN "street_name" = 'Jefferson Smith' THEN 'Jefferson'
            WHEN "street_name" = 'Laurel Forest' THEN 'Laurel'
            WHEN "street_name" = 'Main Second' THEN 'Main and Second'
            WHEN "street_name" = 'Maple Spruce' THEN 'Maple and Spruce'
            WHEN "street_name" = 'Miller 15th' THEN 'Miller and 15th'
            WHEN "street_name" = 'Park 7th' THEN 'Park and 7th'
            WHEN "street_name" = 'Park Second' THEN 'Park and Second'
            WHEN "street_name" = 'Pine Oak' THEN 'Pine and Oak'
            WHEN "street_name" = 'River Main' THEN 'River and Main'
            WHEN "street_name" = 'River Spruce' THEN 'River and Spruce'
            WHEN "street_name" = 'Second Hickory' THEN 'Second and Hickory'
            WHEN "street_name" = 'Spring Poplar' THEN 'Spring and Poplar'
            WHEN "street_name" = 'Sunset Main' THEN 'Sunset and Main'
            WHEN "street_name" = 'Valley 14th' THEN 'Valley and 14th'
            WHEN "street_name" = 'Washington 6th' THEN 'Washington and 6th'
            WHEN "street_name" = 'Washington Main' THEN 'Washington and Main'
            WHEN "street_name" = 'Washington Sunset' THEN 'Washington and Sunset'
            WHEN "street_name" = 'Williams Sixth' THEN 'Williams and Sixth'
            WHEN "street_name" = 'Woodland Poplar' THEN 'Woodland and Poplar'
            ELSE "street_name"
        END AS "street_name"
    FROM "customer_address_renamed_trimmed"
)

-- COCOON BLOCK END
SELECT * FROM "customer_address_renamed_trimmed_cleaned"