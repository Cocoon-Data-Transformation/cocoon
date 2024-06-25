-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_product_tag_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "index_",
        "product_id",
        "value_"
    FROM "shopify_product_tag_data"
),

"shopify_product_tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> tag_id
    -- value_ -> tag_value
    SELECT 
        "index_" AS "tag_id",
        "product_id",
        "value_" AS "tag_value"
    FROM "shopify_product_tag_data_projected"
),

"shopify_product_tag_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- tag_value: The problem is inconsistent formatting and an outlier value. Most values use a colon followed by a space to separate categories, except for "StyleID:nice" which lacks a space after the colon. "Final Sale" and "Sale" don't follow the category:value pattern at all. The correct values should follow the "Category: Value" format consistently, or be a single descriptive term for sales items. 
    SELECT
        "tag_id",
        "product_id",
        CASE
            WHEN "tag_value" = 'StyleID:nice' THEN 'StyleID: Nice'
            ELSE "tag_value"
        END AS "tag_value"
    FROM "shopify_product_tag_data_projected_renamed"
),

"shopify_product_tag_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- product_id: from INT to VARCHAR
    SELECT
        "tag_id",
        "tag_value",
        CAST("product_id" AS VARCHAR) AS "product_id"
    FROM "shopify_product_tag_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_product_tag_data_projected_renamed_cleaned_casted"