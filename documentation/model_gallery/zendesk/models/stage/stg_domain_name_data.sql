-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"domain_name_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "index_",
        "organization_id",
        "domain_name"
    FROM "domain_name_data"
),

"domain_name_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> row_index
    -- domain_name -> encrypted_domain
    SELECT 
        "index_" AS "row_index",
        "organization_id",
        "domain_name" AS "encrypted_domain"
    FROM "domain_name_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "domain_name_data_projected_renamed"