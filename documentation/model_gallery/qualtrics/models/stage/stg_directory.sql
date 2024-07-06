-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:41:58.109139+00:00
WITH 
"directory_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "deduplication_criteria_email",
        "deduplication_criteria_external_data_reference",
        "deduplication_criteria_first_name",
        "deduplication_criteria_last_name",
        "deduplication_criteria_phone",
        "is_default",
        "name"
    FROM "memory"."main"."directory"
)

-- COCOON BLOCK END
SELECT * FROM "directory_projected"