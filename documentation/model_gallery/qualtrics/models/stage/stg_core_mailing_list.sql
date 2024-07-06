-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:41:57.026219+00:00
WITH 
"core_mailing_list_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "library_id",
        "name",
        "category",
        "folder",
        "_fivetran_deleted"
    FROM "memory"."main"."core_mailing_list"
)

-- COCOON BLOCK END
SELECT * FROM "core_mailing_list_projected"