-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_deal_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "ticket_id",
        "deal_id"
    FROM "ticket_deal_data"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_deal_data_projected"