-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:42:02.933253+00:00
WITH 
"directory_mailing_list_projected" AS (
    -- Projection: Selecting 7 out of 8 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "directory_id",
        "id",
        "_fivetran_deleted",
        "creation_date",
        "last_modified_date",
        "name",
        "owner_id"
    FROM "memory"."main"."directory_mailing_list"
)

-- COCOON BLOCK END
SELECT * FROM "directory_mailing_list_projected"