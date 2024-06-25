-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_inventory_item_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "cost",
        "created_at",
        "requires_shipping",
        "sku",
        "tracked",
        "updated_at",
        "country_code_of_origin",
        "province_code_of_origin",
        "_fivetran_deleted"
    FROM "shopify_inventory_item_data"
),

"shopify_inventory_item_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> item_id
    -- created_at -> creation_date
    -- tracked -> is_tracked
    -- updated_at -> last_updated_date
    -- country_code_of_origin -> origin_country_code
    -- province_code_of_origin -> origin_province_code
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "id" AS "item_id",
        "cost",
        "created_at" AS "creation_date",
        "requires_shipping",
        "sku",
        "tracked" AS "is_tracked",
        "updated_at" AS "last_updated_date",
        "country_code_of_origin" AS "origin_country_code",
        "province_code_of_origin" AS "origin_province_code",
        "_fivetran_deleted" AS "is_deleted"
    FROM "shopify_inventory_item_data_projected"
),

"shopify_inventory_item_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from DECIMAL to TIMESTAMP
    -- is_tracked: from DECIMAL to BOOLEAN
    -- last_updated_date: from DECIMAL to TIMESTAMP
    -- origin_country_code: from DECIMAL to VARCHAR
    -- origin_province_code: from DECIMAL to VARCHAR
    -- requires_shipping: from DECIMAL to BOOLEAN
    -- sku: from DECIMAL to VARCHAR
    SELECT
        "item_id",
        "cost",
        "is_deleted",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("is_tracked" AS BOOLEAN) AS "is_tracked",
        CAST("last_updated_date" AS TIMESTAMP) AS "last_updated_date",
        CAST("origin_country_code" AS VARCHAR) AS "origin_country_code",
        CAST("origin_province_code" AS VARCHAR) AS "origin_province_code",
        CAST("requires_shipping" AS BOOLEAN) AS "requires_shipping",
        CAST("sku" AS VARCHAR) AS "sku"
    FROM "shopify_inventory_item_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_inventory_item_data_projected_renamed_casted"