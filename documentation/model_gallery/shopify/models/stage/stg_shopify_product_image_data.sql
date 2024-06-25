-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_product_image_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "product_id",
        "_fivetran_deleted",
        "alt",
        "created_at",
        "height",
        "position_",
        "src",
        "updated_at",
        "width",
        "is_default",
        "variant_ids"
    FROM "shopify_product_image_data"
),

"shopify_product_image_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> image_id
    -- _fivetran_deleted -> is_deleted
    -- alt -> alt_text
    -- position_ -> display_order
    -- src -> image_url
    SELECT 
        "id" AS "image_id",
        "product_id",
        "_fivetran_deleted" AS "is_deleted",
        "alt" AS "alt_text",
        "created_at",
        "height",
        "position_" AS "display_order",
        "src" AS "image_url",
        "updated_at",
        "width",
        "is_default",
        "variant_ids"
    FROM "shopify_product_image_data_projected"
),

"shopify_product_image_data_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- variant_ids: ['[]']
    SELECT 
        CASE
            WHEN "variant_ids" = '[]' THEN NULL
            ELSE "variant_ids"
        END AS "variant_ids",
        "updated_at",
        "is_deleted",
        "is_default",
        "image_url",
        "product_id",
        "image_id",
        "alt_text",
        "display_order",
        "height",
        "created_at",
        "width"
    FROM "shopify_product_image_data_projected_renamed"
),

"shopify_product_image_data_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- alt_text: from DECIMAL to VARCHAR
    -- created_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    -- variant_ids: from VARCHAR to ARRAY
    SELECT
        "is_deleted",
        "is_default",
        "image_url",
        "product_id",
        "image_id",
        "display_order",
        "height",
        "width",
        CAST("alt_text" AS VARCHAR) AS "alt_text",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at",
        from_json("variant_ids", '["INTEGER"]') AS "variant_ids"
    FROM "shopify_product_image_data_projected_renamed_null"
),

"shopify_product_image_data_projected_renamed_null_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- alt_text has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_deleted",
        "is_default",
        "image_url",
        "product_id",
        "image_id",
        "display_order",
        "height",
        "width",
        "created_at",
        "updated_at",
        "variant_ids"
    FROM "shopify_product_image_data_projected_renamed_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_product_image_data_projected_renamed_null_casted_missing_handled"