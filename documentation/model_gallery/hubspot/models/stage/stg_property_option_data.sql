-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"property_option_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "label",
        "property_id",
        "display_order",
        "hidden",
        "value_"
    FROM "property_option_data"
),

"property_option_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- label -> encrypted_option_label
    -- property_id -> encrypted_property_id
    -- hidden -> is_hidden
    -- value_ -> encrypted_option_value
    SELECT 
        "label" AS "encrypted_option_label",
        "property_id" AS "encrypted_property_id",
        "display_order",
        "hidden" AS "is_hidden",
        "value_" AS "encrypted_option_value"
    FROM "property_option_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "property_option_data_projected_renamed"