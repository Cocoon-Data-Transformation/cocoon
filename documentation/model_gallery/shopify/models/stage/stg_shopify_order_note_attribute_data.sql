-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_note_attribute_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "name",
        "order_id",
        "value_"
    FROM "shopify_order_note_attribute_data"
),

"shopify_order_note_attribute_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- name -> attribute_name
    -- value_ -> attribute_value
    SELECT 
        "name" AS "attribute_name",
        "order_id",
        "value_" AS "attribute_value"
    FROM "shopify_order_note_attribute_data_projected"
),

"shopify_order_note_attribute_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- order_id: from INT to VARCHAR
    SELECT
        "attribute_name",
        "attribute_value",
        CAST("order_id" AS VARCHAR) AS "order_id"
    FROM "shopify_order_note_attribute_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_note_attribute_data_projected_renamed_casted"