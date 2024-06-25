-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"owner_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "owner_id",
        "created_at",
        "portal_id",
        "type",
        "updated_at",
        "email",
        "first_name",
        "last_name"
    FROM "owner_data"
),

"owner_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- type -> owner_type
    -- email -> encrypted_email
    -- first_name -> encrypted_first_name
    -- last_name -> encrypted_last_name
    SELECT 
        "owner_id",
        "created_at",
        "portal_id",
        "type" AS "owner_type",
        "updated_at",
        "email" AS "encrypted_email",
        "first_name" AS "encrypted_first_name",
        "last_name" AS "encrypted_last_name"
    FROM "owner_data_projected"
),

"owner_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- owner_id: from INT to VARCHAR
    -- portal_id: from INT to VARCHAR
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "owner_type",
        "encrypted_email",
        "encrypted_first_name",
        "encrypted_last_name",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("owner_id" AS VARCHAR) AS "owner_id",
        CAST("portal_id" AS VARCHAR) AS "portal_id",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "owner_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "owner_data_projected_renamed_casted"