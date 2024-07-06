-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:04:09.011709+00:00
WITH 
"task_section_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "section_id",
        "task_id"
    FROM "memory"."main"."task_section_data"
),

"task_section_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- task_id -> parent_task_id
    SELECT 
        "section_id",
        "task_id" AS "parent_task_id"
    FROM "task_section_data_projected"
),

"task_section_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- parent_task_id: from INT to VARCHAR
    -- section_id: from INT to VARCHAR
    SELECT
        CAST("parent_task_id" AS VARCHAR) AS "parent_task_id",
        CAST("section_id" AS VARCHAR) AS "section_id"
    FROM "task_section_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "task_section_data_projected_renamed_casted"