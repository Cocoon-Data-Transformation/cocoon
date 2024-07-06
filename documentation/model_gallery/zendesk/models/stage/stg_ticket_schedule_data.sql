-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_schedule_data_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "created_at",
        "ticket_id",
        "schedule_id"
    FROM "ticket_schedule_data"
),

"ticket_schedule_data_projected_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    SELECT
        "ticket_id",
        "schedule_id",
        CAST("created_at" AS TIMESTAMP) AS "created_at"
    FROM "ticket_schedule_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_schedule_data_projected_casted"