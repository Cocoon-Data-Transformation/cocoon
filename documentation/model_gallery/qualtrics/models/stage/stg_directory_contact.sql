-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:42:00.767074+00:00
WITH 
"directory_contact_projected" AS (
    -- Projection: Selecting 17 out of 18 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "directory_id",
        "id",
        "creation_date",
        "directory_unsubscribe_date",
        "directory_unsubscribed",
        "email",
        "email_domain",
        "embedded_data_last_active_time",
        "embedded_data_last_response_date",
        "embedded_data_login_date",
        "ext_ref",
        "first_name",
        "language_",
        "last_modified",
        "last_name",
        "phone",
        "write_blanks"
    FROM "memory"."main"."directory_contact"
),

"directory_contact_projected_missing_handled" AS (
    -- Handling missing values: There are 10 columns with unacceptable missing values
    -- directory_unsubscribe_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- embedded_data_last_active_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- embedded_data_last_response_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- embedded_data_login_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ext_ref has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- first_name has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- language_ has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_name has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- phone has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- write_blanks has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "directory_id",
        "id",
        "creation_date",
        "directory_unsubscribed",
        "email",
        "email_domain",
        "first_name",
        "last_modified",
        "last_name",
        "phone"
    FROM "directory_contact_projected"
)

-- COCOON BLOCK END
SELECT * FROM "directory_contact_projected_missing_handled"