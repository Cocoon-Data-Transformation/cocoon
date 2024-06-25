-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_engagement_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "ticket_id",
        "engagement_id"
    FROM "ticket_engagement_data"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_engagement_data_projected"