-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:41:53.401328+00:00
WITH 
"contact_mailing_list_membership_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "contact_lookup_id",
        "contact_id",
        "directory_id",
        "mailing_list_id",
        "name",
        "owner_id",
        "unsubscribe_date",
        "unsubscribed"
    FROM "memory"."main"."contact_mailing_list_membership"
),

"contact_mailing_list_membership_projected_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- unsubscribe_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "contact_lookup_id",
        "contact_id",
        "directory_id",
        "mailing_list_id",
        "name",
        "owner_id",
        "unsubscribed"
    FROM "contact_mailing_list_membership_projected"
)

-- COCOON BLOCK END
SELECT * FROM "contact_mailing_list_membership_projected_missing_handled"