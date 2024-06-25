-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_company_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "ticket_id",
        "company_id"
    FROM "ticket_company_data"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_company_data_projected"