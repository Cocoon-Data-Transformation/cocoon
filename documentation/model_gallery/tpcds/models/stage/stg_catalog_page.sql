-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"catalog_page_renamed" AS (
    -- Rename: Renaming columns
    -- CP_CATALOG_PAGE_SK -> page_surrogate_key
    -- CP_CATALOG_PAGE_ID -> page_id
    -- CP_START_DATE_SK -> start_date_key
    -- CP_END_DATE_SK -> end_date_key
    -- CP_DEPARTMENT -> department
    -- CP_CATALOG_NUMBER -> catalog_id
    -- CP_CATALOG_PAGE_NUMBER -> page_number
    -- CP_DESCRIPTION -> page_description
    -- CP_TYPE -> catalog_type
    SELECT 
        "CP_CATALOG_PAGE_SK" AS "page_surrogate_key",
        "CP_CATALOG_PAGE_ID" AS "page_id",
        "CP_START_DATE_SK" AS "start_date_key",
        "CP_END_DATE_SK" AS "end_date_key",
        "CP_DEPARTMENT" AS "department",
        "CP_CATALOG_NUMBER" AS "catalog_id",
        "CP_CATALOG_PAGE_NUMBER" AS "page_number",
        "CP_DESCRIPTION" AS "page_description",
        "CP_TYPE" AS "catalog_type"
    FROM "catalog_page"
),

"catalog_page_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "page_surrogate_key",
        "page_id",
        "start_date_key",
        "end_date_key",
        "department",
        "catalog_id",
        "page_number",
        "catalog_type",
        TRIM("page_description") AS "page_description"
    FROM "catalog_page_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "catalog_page_renamed_trimmed"