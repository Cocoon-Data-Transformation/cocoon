-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-26 00:52:51.226296+00:00
WITH 
"supplier_renamed" AS (
    -- Rename: Renaming columns
    -- S_SUPPKEY -> supplier_id
    -- S_NAME -> supplier_name
    -- S_ADDRESS -> street_address
    -- S_CITY -> city
    -- S_NATION -> country
    -- S_REGION -> region
    -- S_PHONE -> phone_number
    SELECT 
        "S_SUPPKEY" AS "supplier_id",
        "S_NAME" AS "supplier_name",
        "S_ADDRESS" AS "street_address",
        "S_CITY" AS "city",
        "S_NATION" AS "country",
        "S_REGION" AS "region",
        "S_PHONE" AS "phone_number"
    FROM "memory"."main"."supplier"
),

"supplier_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "supplier_id",
        "supplier_name",
        "city",
        "country",
        "region",
        "phone_number",
        TRIM("street_address") AS "street_address"
    FROM "supplier_renamed"
),

"supplier_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- city: The problem is that some city names are truncated or have inconsistent spacing. The "SAUDI ARA" entries are truncated and should be "SAUDI ARABIA". The "INDONESIA" entries have inconsistent spacing, with "INDONESIA4" having no space and "INDONESIA1" having one space. All other entries have 2 spaces between the country name and number. The correct values should have consistent formatting with 2 spaces between the country name and number for all entries.
    -- street_address: All values are unusual because they start with commas and consist of random alphanumeric strings instead of typical address components.
    SELECT
        "supplier_id",
        "supplier_name",
        CASE
            WHEN "city" = 'INDONESIA4' THEN 'INDONESIA 4'
            WHEN "city" = 'INDONESIA1' THEN 'INDONESIA 1'
            WHEN "city" = 'SAUDI ARA0' THEN 'SAUDI ARABIA 0'
            WHEN "city" = 'SAUDI ARA7' THEN 'SAUDI ARABIA 7'
            WHEN "city" = 'SAUDI ARA5' THEN 'SAUDI ARABIA 5'
            WHEN "city" = 'SAUDI ARA8' THEN 'SAUDI ARABIA 8'
            WHEN "city" = 'SAUDI ARA1' THEN 'SAUDI ARA 1'
            WHEN "city" = 'SAUDI ARA6' THEN 'SAUDI ARA 6'
            WHEN "city" = 'INDONESIA8' THEN 'INDONESIA 8'
            WHEN "city" = 'INDONESIA3' THEN 'INDONESIA 3'
            WHEN "city" = 'INDONESIA7' THEN 'INDONESIA 7'
            WHEN "city" = 'INDONESIA9' THEN 'INDONESIA 9'
            WHEN "city" = 'INDONESIA0' THEN 'INDONESIA 0'
            WHEN "city" = 'UNITED KI9' THEN 'UNITED KI 9'
            WHEN "city" = 'UNITED ST0' THEN 'UNITED ST 0'
            WHEN "city" = 'UNITED ST8' THEN 'UNITED ST 8'
            WHEN "city" = 'UNITED ST9' THEN 'UNITED ST 9'
            WHEN "city" = 'ARGENTINA7' THEN 'ARGENTINA 7'
            WHEN "city" = 'ARGENTINA8' THEN 'ARGENTINA 8'
            WHEN "city" = 'SAUDI ARA2' THEN 'SAUDI AR 2'
            WHEN "city" = 'SAUDI ARA9' THEN 'SAUDI AR 9'
            WHEN "city" = 'INDONESIA2' THEN 'INDONESI 2'
            WHEN "city" = 'UNITED ST4' THEN 'UNITED S 4'
            WHEN "city" = 'UNITED ST5' THEN 'UNITED S 5'
            WHEN "city" = 'UNITED ST6' THEN 'UNITED S 6'
            WHEN "city" = 'UNITED ST7' THEN 'UNITED S 7'
            WHEN "city" = 'UNITED KI0' THEN 'UNITED K 0'
            WHEN "city" = 'MOZAMBIQU2' THEN 'MOZAMBIQ 2'
            WHEN "city" = 'MOZAMBIQU6' THEN 'MOZAMBIQ 6'
            WHEN "city" = 'INDONESIA5' THEN 'INDONESIA 5'
            WHEN "city" = 'INDONESIA6' THEN 'INDONESIA 6'
            ELSE "city"
        END AS "city",
        "country",
        "region",
        "phone_number",
        "street_address"
    FROM "supplier_renamed_trimmed"
)

-- COCOON BLOCK END
SELECT *
FROM "supplier_renamed_trimmed_cleaned"