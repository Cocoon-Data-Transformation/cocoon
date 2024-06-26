-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"inventory_renamed" AS (
    -- Rename: Renaming columns
    -- INV_DATE_SK -> inventory_date
    -- INV_ITEM_SK -> item_id
    -- INV_WAREHOUSE_SK -> warehouse_id
    -- INV_QUANTITY_ON_HAND -> quantity_on_hand
    SELECT 
        "INV_DATE_SK" AS "inventory_date",
        "INV_ITEM_SK" AS "item_id",
        "INV_WAREHOUSE_SK" AS "warehouse_id",
        "INV_QUANTITY_ON_HAND" AS "quantity_on_hand"
    FROM "inventory"
),

"inventory_renamed_casted" AS (
    -- Column Type Casting: 
    -- inventory_date: from INT to DATE
    SELECT
        "item_id",
        "warehouse_id",
        "quantity_on_hand",
        julian(DATE '1858-11-17' + CAST("inventory_date" AS INTEGER)) AS "inventory_date"
    FROM "inventory_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "inventory_renamed_casted"