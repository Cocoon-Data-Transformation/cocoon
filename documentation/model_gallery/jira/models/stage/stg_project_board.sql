-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"project_board_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "board_id",
        "project_id"
    FROM "project_board"
)

-- COCOON BLOCK END
SELECT * FROM "project_board_projected"