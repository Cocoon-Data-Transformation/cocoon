-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:26:38.079237+00:00
WITH 
"partsupp_renamed" AS (
    -- Rename: Renaming columns
    -- PS_PARTKEY -> part_key
    -- PS_SUPPKEY -> supplier_key
    -- PS_AVAILQTY -> available_quantity
    -- PS_SUPPLYCOST -> supply_cost
    -- PS_COMMENT -> comment
    SELECT 
        "PS_PARTKEY" AS "part_key",
        "PS_SUPPKEY" AS "supplier_key",
        "PS_AVAILQTY" AS "available_quantity",
        "PS_SUPPLYCOST" AS "supply_cost",
        "PS_COMMENT" AS "comment"
    FROM "memory"."main"."partsupp"
)

-- COCOON BLOCK END
SELECT *
FROM "partsupp_renamed"