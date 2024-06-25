-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"field_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "is_array",
        "is_custom",
        "name"
    FROM "field"
),

"field_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> field_id
    -- is_array -> is_multi_value
    -- is_custom -> is_custom_field
    -- name -> field_name
    SELECT 
        "id" AS "field_id",
        "is_array" AS "is_multi_value",
        "is_custom" AS "is_custom_field",
        "name" AS "field_name"
    FROM "field_projected"
)

-- COCOON BLOCK END
SELECT * FROM "field_projected_renamed"