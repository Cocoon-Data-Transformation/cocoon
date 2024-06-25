-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"deal_contact_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "contact_id",
        "deal_id",
        "type_id"
    FROM "deal_contact_data"
),

"deal_contact_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- type_id -> relationship_type_id
    SELECT 
        "contact_id",
        "deal_id",
        "type_id" AS "relationship_type_id"
    FROM "deal_contact_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "deal_contact_data_projected_renamed"