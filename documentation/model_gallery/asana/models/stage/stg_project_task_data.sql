-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:59:29.269778+00:00
WITH 
"project_task_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "project_id",
        "task_id"
    FROM "memory"."main"."project_task_data"
),

"project_task_data_projected_casted" AS (
    -- Column Type Casting: 
    -- project_id: from INT to VARCHAR
    -- task_id: from INT to VARCHAR
    SELECT
        CAST("project_id" AS VARCHAR) AS "project_id",
        CAST("task_id" AS VARCHAR) AS "task_id"
    FROM "project_task_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "project_task_data_projected_casted"