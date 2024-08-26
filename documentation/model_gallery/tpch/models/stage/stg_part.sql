-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:26:17.331735+00:00
WITH 
"part_renamed" AS (
    -- Rename: Renaming columns
    -- P_PARTKEY -> part_id
    -- P_NAME -> part_name
    -- P_MFGR -> manufacturer
    -- P_BRAND -> brand
    -- P_TYPE -> part_type
    -- P_SIZE -> size_
    -- P_CONTAINER -> packaging
    -- P_RETAILPRICE -> retail_price
    -- P_COMMENT -> comments
    SELECT 
        "P_PARTKEY" AS "part_id",
        "P_NAME" AS "part_name",
        "P_MFGR" AS "manufacturer",
        "P_BRAND" AS "brand",
        "P_TYPE" AS "part_type",
        "P_SIZE" AS "size_",
        "P_CONTAINER" AS "packaging",
        "P_RETAILPRICE" AS "retail_price",
        "P_COMMENT" AS "comments"
    FROM "memory"."main"."part"
),

"part_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- comments: The problem is that all values in the comments column are incomplete fragments of sentences, making their meaning unclear. These fragments appear to be cut-off portions of longer comments. Without the full context, it's impossible to determine the intended complete sentences. The correct approach is to treat these as corrupted data and map them to empty strings, as we cannot accurately reconstruct the original comments.
    SELECT
        "part_id",
        "part_name",
        "manufacturer",
        "brand",
        "part_type",
        "size_",
        "packaging",
        "retail_price",
        CASE
            WHEN "comments" = 'egular deposits hag' THEN NULL
            WHEN "comments" = 'lar accounts amo' THEN NULL
            WHEN "comments" = 'ly. slyly ironi' THEN NULL
            WHEN "comments" = 'p furiously r' THEN NULL
            WHEN "comments" = 'wake carefully' THEN NULL
            ELSE "comments"
        END AS "comments"
    FROM "part_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "part_renamed_cleaned"