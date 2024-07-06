-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:03:47.783533+00:00
WITH 
"task_follower_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "task_id",
        "user_id"
    FROM "memory"."main"."task_follower_data"
),

"task_follower_data_projected_casted" AS (
    -- Column Type Casting: 
    -- task_id: from INT to VARCHAR
    -- user_id: from INT to VARCHAR
    SELECT
        CAST("task_id" AS VARCHAR) AS "task_id",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "task_follower_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "task_follower_data_projected_casted"