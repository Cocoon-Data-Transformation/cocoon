-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_product_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "title",
        "handle",
        "product_type",
        "vendor",
        "created_at",
        "updated_at",
        "published_at",
        "published_scope",
        "_fivetran_deleted"
    FROM "shopify_product_data"
),

"shopify_product_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> product_id
    -- title -> product_title
    -- handle -> product_handle
    -- vendor -> vendor_id
    -- published_scope -> visibility_scope
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "id" AS "product_id",
        "title" AS "product_title",
        "handle" AS "product_handle",
        "product_type",
        "vendor" AS "vendor_id",
        "created_at",
        "updated_at",
        "published_at",
        "published_scope" AS "visibility_scope",
        "_fivetran_deleted" AS "is_deleted"
    FROM "shopify_product_data_projected"
),

"shopify_product_data_projected_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "product_id",
        "product_title",
        "product_handle",
        "product_type",
        "vendor_id",
        "visibility_scope",
        "is_deleted",
        TRIM("created_at") AS "created_at",
        TRIM("updated_at") AS "updated_at",
        TRIM("published_at") AS "published_at"
    FROM "shopify_product_data_projected_renamed"
),

"shopify_product_data_projected_renamed_trimmed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- product_id: from INT to VARCHAR
    -- published_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "product_title",
        "product_handle",
        "product_type",
        "vendor_id",
        "visibility_scope",
        "is_deleted",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("product_id" AS VARCHAR) AS "product_id",
        CAST("published_at" AS TIMESTAMP) AS "published_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "shopify_product_data_projected_renamed_trimmed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_product_data_projected_renamed_trimmed_casted"