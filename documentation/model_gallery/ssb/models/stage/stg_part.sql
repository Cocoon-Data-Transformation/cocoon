-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-26 00:51:15.538935+00:00
WITH 
"part_renamed" AS (
    -- Rename: Renaming columns
    -- P_PARTKEY -> part_id
    -- P_NAME -> part_name
    -- P_MFGR -> manufacturer_code
    -- P_CATEGORY -> category_code
    -- P_BRAND1 -> brand_code
    -- P_COLOR -> color
    -- P_TYPE -> type_and_material
    -- P_SIZE -> size_
    -- P_CONTAINER -> container_type
    SELECT 
        "P_PARTKEY" AS "part_id",
        "P_NAME" AS "part_name",
        "P_MFGR" AS "manufacturer_code",
        "P_CATEGORY" AS "category_code",
        "P_BRAND1" AS "brand_code",
        "P_COLOR" AS "color",
        "P_TYPE" AS "type_and_material",
        "P_SIZE" AS "size_",
        "P_CONTAINER" AS "container_type"
    FROM "memory"."main"."part"
)

-- COCOON BLOCK END
SELECT *
FROM "part_renamed"