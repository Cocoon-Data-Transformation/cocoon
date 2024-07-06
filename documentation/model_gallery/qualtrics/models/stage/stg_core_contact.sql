-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:41:55.483602+00:00
WITH 
"core_contact_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "mailing_list_id",
        "first_name",
        "last_name",
        "email",
        "external_data_reference",
        "language_",
        "unsubscribed",
        "_fivetran_deleted"
    FROM "memory"."main"."core_contact"
)

-- COCOON BLOCK END
SELECT * FROM "core_contact_projected"