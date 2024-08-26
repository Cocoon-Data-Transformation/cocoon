-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:27:04.921327+00:00
WITH 
"region_renamed" AS (
    -- Rename: Renaming columns
    -- R_REGIONKEY -> region_id
    -- R_NAME -> region_name
    -- R_COMMENT -> random_comment
    SELECT 
        "R_REGIONKEY" AS "region_id",
        "R_NAME" AS "region_name",
        "R_COMMENT" AS "random_comment"
    FROM "memory"."main"."region"
)

-- COCOON BLOCK END
SELECT *
FROM "region_renamed"