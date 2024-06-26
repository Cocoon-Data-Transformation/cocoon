-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"web_page_renamed" AS (
    -- Rename: Renaming columns
    -- WP_WEB_PAGE_SK -> page_surrogate_key
    -- WP_WEB_PAGE_ID -> page_id
    -- WP_REC_START_DATE -> record_start_date
    -- WP_REC_END_DATE -> record_end_date
    -- WP_CREATION_DATE_SK -> creation_date
    -- WP_ACCESS_DATE_SK -> last_access_date
    -- WP_AUTOGEN_FLAG -> is_auto_generated
    -- WP_CUSTOMER_SK -> customer_id
    -- WP_URL -> url
    -- WP_TYPE -> page_type
    -- WP_CHAR_COUNT -> character_count
    -- WP_LINK_COUNT -> link_count
    -- WP_IMAGE_COUNT -> image_count
    -- WP_MAX_AD_COUNT -> max_ad_count
    SELECT 
        "WP_WEB_PAGE_SK" AS "page_surrogate_key",
        "WP_WEB_PAGE_ID" AS "page_id",
        "WP_REC_START_DATE" AS "record_start_date",
        "WP_REC_END_DATE" AS "record_end_date",
        "WP_CREATION_DATE_SK" AS "creation_date",
        "WP_ACCESS_DATE_SK" AS "last_access_date",
        "WP_AUTOGEN_FLAG" AS "is_auto_generated",
        "WP_CUSTOMER_SK" AS "customer_id",
        "WP_URL" AS "url",
        "WP_TYPE" AS "page_type",
        "WP_CHAR_COUNT" AS "character_count",
        "WP_LINK_COUNT" AS "link_count",
        "WP_IMAGE_COUNT" AS "image_count",
        "WP_MAX_AD_COUNT" AS "max_ad_count"
    FROM "web_page"
),

"web_page_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from INT to DATE
    -- is_auto_generated: from VARCHAR to BOOLEAN
    -- last_access_date: from INT to DATE
    -- record_end_date: from VARCHAR to DATE
    -- record_start_date: from VARCHAR to DATE
    SELECT
        "page_surrogate_key",
        "page_id",
        "customer_id",
        "url",
        "page_type",
        "character_count",
        "link_count",
        "image_count",
        "max_ad_count",
        julian(DATE '1858-11-17' + CAST("creation_date" AS INTEGER)) AS "creation_date",
        CAST("is_auto_generated" = 'Y' AS BOOLEAN) AS "is_auto_generated",
        julian(DATE '1970-01-01' + CAST("last_access_date" AS INTEGER)) AS "last_access_date",
        CAST("record_end_date" AS DATE) AS "record_end_date",
        CAST("record_start_date" AS DATE) AS "record_start_date"
    FROM "web_page_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "web_page_renamed_casted"