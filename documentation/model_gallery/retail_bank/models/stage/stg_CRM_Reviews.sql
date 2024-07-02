-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"CRM_Reviews_renamed" AS (
    -- Rename: Renaming columns
    -- date_ -> review_date
    -- stars -> star_rating
    -- reviews -> review_text
    -- product -> product_name
    SELECT 
        "date_" AS "review_date",
        "stars" AS "star_rating",
        "reviews" AS "review_text",
        "product" AS "product_name",
        "district_id"
    FROM "CRM_Reviews"
),

"CRM_Reviews_renamed_dedup" AS (
    -- Deduplication: Removed 1 duplicated rows
    SELECT DISTINCT * FROM "CRM_Reviews_renamed"
),

"CRM_Reviews_renamed_dedup_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "review_date",
        "star_rating",
        "product_name",
        "district_id",
        TRIM("review_text") AS "review_text"
    FROM "CRM_Reviews_renamed_dedup"
),

"CRM_Reviews_renamed_dedup_trimmed_casted" AS (
    -- Column Type Casting: 
    -- review_date: from VARCHAR to DATE
    SELECT
        "star_rating",
        "product_name",
        "district_id",
        "review_text",
        CAST("review_date" AS DATE) AS "review_date"
    FROM "CRM_Reviews_renamed_dedup_trimmed"
)

-- COCOON BLOCK END
SELECT * FROM "CRM_Reviews_renamed_dedup_trimmed_casted"