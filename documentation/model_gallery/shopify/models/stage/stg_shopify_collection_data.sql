-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_collection_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "handle",
        "published_at",
        "published_scope",
        "title",
        "updated_at",
        "disjunctive",
        "rules",
        "sort_order",
        "template_suffix",
        "body_html"
    FROM "shopify_collection_data"
),

"shopify_collection_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> collection_id
    -- _fivetran_deleted -> is_deleted
    -- handle -> url_slug
    -- published_at -> publish_date
    -- published_scope -> visibility_scope
    -- title -> collection_name
    -- updated_at -> last_updated
    -- disjunctive -> is_disjunctive
    -- rules -> product_rules
    -- sort_order -> product_sort_order
    -- template_suffix -> page_template
    -- body_html -> description_html
    SELECT 
        "id" AS "collection_id",
        "_fivetran_deleted" AS "is_deleted",
        "handle" AS "url_slug",
        "published_at" AS "publish_date",
        "published_scope" AS "visibility_scope",
        "title" AS "collection_name",
        "updated_at" AS "last_updated",
        "disjunctive" AS "is_disjunctive",
        "rules" AS "product_rules",
        "sort_order" AS "product_sort_order",
        "template_suffix" AS "page_template",
        "body_html" AS "description_html"
    FROM "shopify_collection_data_projected"
),

"shopify_collection_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- collection_name: from DECIMAL to VARCHAR
    -- description_html: from DECIMAL to VARCHAR
    -- is_disjunctive: from DECIMAL to VARCHAR
    -- last_updated: from VARCHAR to TIMESTAMP
    -- page_template: from DECIMAL to VARCHAR
    -- product_rules: from DECIMAL to VARCHAR
    -- product_sort_order: from DECIMAL to VARCHAR
    -- publish_date: from DECIMAL to VARCHAR
    -- url_slug: from DECIMAL to VARCHAR
    -- visibility_scope: from DECIMAL to VARCHAR
    SELECT
        "collection_id",
        "is_deleted",
        CAST("collection_name" AS VARCHAR) AS "collection_name",
        CAST("description_html" AS VARCHAR) AS "description_html",
        CAST("is_disjunctive" AS VARCHAR) AS "is_disjunctive",
        CAST("last_updated" AS TIMESTAMP) AS "last_updated",
        CAST("page_template" AS VARCHAR) AS "page_template",
        CAST("product_rules" AS VARCHAR) AS "product_rules",
        CAST("product_sort_order" AS VARCHAR) AS "product_sort_order",
        CAST("publish_date" AS VARCHAR) AS "publish_date",
        CAST("url_slug" AS VARCHAR) AS "url_slug",
        CAST("visibility_scope" AS VARCHAR) AS "visibility_scope"
    FROM "shopify_collection_data_projected_renamed"
),

"shopify_collection_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 8 columns with unacceptable missing values
    -- collection_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- description_html has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- page_template has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_rules has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_sort_order has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- publish_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- url_slug has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- visibility_scope has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "collection_id",
        "is_deleted",
        "is_disjunctive",
        "last_updated"
    FROM "shopify_collection_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_collection_data_projected_renamed_casted_missing_handled"