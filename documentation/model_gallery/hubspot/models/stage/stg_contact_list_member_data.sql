-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"contact_list_member_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "contact_id",
        "contact_list_id",
        "_fivetran_deleted",
        "added_at"
    FROM "contact_list_member_data"
),

"contact_list_member_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- contact_list_id -> list_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "contact_id",
        "contact_list_id" AS "list_id",
        "_fivetran_deleted" AS "is_deleted",
        "added_at"
    FROM "contact_list_member_data_projected"
),

"contact_list_member_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- added_at: from VARCHAR to TIMESTAMP
    -- contact_id: from INT to VARCHAR
    -- list_id: from INT to VARCHAR
    SELECT
        "is_deleted",
        CAST("added_at" AS TIMESTAMP) AS "added_at",
        CAST("contact_id" AS VARCHAR) AS "contact_id",
        CAST("list_id" AS VARCHAR) AS "list_id"
    FROM "contact_list_member_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "contact_list_member_data_projected_renamed_casted"