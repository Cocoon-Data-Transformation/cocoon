-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:04:25.812042+00:00
WITH 
"task_tag_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "tag_id",
        "task_id"
    FROM "memory"."main"."task_tag_data"
),

"task_tag_data_projected_casted" AS (
    -- Column Type Casting: 
    -- tag_id: from INT to VARCHAR
    -- task_id: from INT to VARCHAR
    SELECT
        CAST("tag_id" AS VARCHAR) AS "tag_id",
        CAST("task_id" AS VARCHAR) AS "task_id"
    FROM "task_tag_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "task_tag_data_projected_casted"