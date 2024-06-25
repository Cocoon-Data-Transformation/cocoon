-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_inventory_level_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "inventory_item_id",
        "location_id",
        "available",
        "updated_at"
    FROM "shopify_inventory_level_data"
),

"shopify_inventory_level_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- available -> quantity_available
    -- updated_at -> last_updated
    SELECT 
        "inventory_item_id",
        "location_id",
        "available" AS "quantity_available",
        "updated_at" AS "last_updated"
    FROM "shopify_inventory_level_data_projected"
),

"shopify_inventory_level_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- last_updated: from DECIMAL to TIMESTAMP
    -- quantity_available: from DECIMAL to INT
    SELECT
        "inventory_item_id",
        "location_id",
        CAST("last_updated" AS TIMESTAMP) AS "last_updated",
        CAST("quantity_available" AS INT) AS "quantity_available"
    FROM "shopify_inventory_level_data_projected_renamed"
),

"shopify_inventory_level_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- last_updated has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_available has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "inventory_item_id",
        "location_id"
    FROM "shopify_inventory_level_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_inventory_level_data_projected_renamed_casted_missing_handled"