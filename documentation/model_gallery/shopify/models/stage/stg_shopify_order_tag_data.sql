-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_tag_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "index_",
        "order_id",
        "value_"
    FROM "shopify_order_tag_data"
),

"shopify_order_tag_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> tag_group_id
    -- value_ -> color_tag
    SELECT 
        "index_" AS "tag_group_id",
        "order_id",
        "value_" AS "color_tag"
    FROM "shopify_order_tag_data_projected"
),

"shopify_order_tag_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- color_tag: The problem is that '#22222' and '#33333' are invalid hex color codes because they have only 5 digits instead of the standard 6 digits. Hex color codes should always have 6 digits (or 3 digits in shorthand notation). The correct values should have 6 digits. To fix this, we can assume that the last digit was accidentally omitted and duplicate it to create valid 6-digit hex codes. 
    SELECT
        "tag_group_id",
        "order_id",
        CASE
            WHEN "color_tag" = '#22222' THEN '#222222'
            WHEN "color_tag" = '#33333' THEN '#333333'
            ELSE "color_tag"
        END AS "color_tag"
    FROM "shopify_order_tag_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_tag_data_projected_renamed_cleaned"