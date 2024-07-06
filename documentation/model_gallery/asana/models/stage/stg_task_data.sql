-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 00:03:32.255648+00:00
WITH 
"task_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> task_id
    -- completed -> is_completed
    -- completed_at -> completion_timestamp
    -- created_at -> creation_timestamp
    -- due_on -> due_date
    -- due_at -> due_timestamp
    -- modified_at -> last_modified_timestamp
    -- name -> task_name
    -- parent_id -> parent_task_id
    -- start_on -> start_date
    -- notes -> task_description
    SELECT 
        "id" AS "task_id",
        "assignee_id",
        "completed" AS "is_completed",
        "completed_at" AS "completion_timestamp",
        "completed_by_id",
        "created_at" AS "creation_timestamp",
        "due_on" AS "due_date",
        "due_at" AS "due_timestamp",
        "modified_at" AS "last_modified_timestamp",
        "name" AS "task_name",
        "parent_id" AS "parent_task_id",
        "start_on" AS "start_date",
        "notes" AS "task_description",
        "workspace_id"
    FROM "memory"."main"."task_data"
),

"task_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- assignee_id: from INT to VARCHAR
    -- completed_by_id: from DECIMAL to VARCHAR
    -- completion_timestamp: from VARCHAR to TIMESTAMP
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- due_date: from VARCHAR to TIMESTAMP
    -- due_timestamp: from DECIMAL to TIMESTAMP
    -- last_modified_timestamp: from VARCHAR to TIMESTAMP
    -- parent_task_id: from DECIMAL to VARCHAR
    -- start_date: from DECIMAL to TIMESTAMP
    -- task_id: from INT to VARCHAR
    -- workspace_id: from INT to VARCHAR
    SELECT
        "is_completed",
        "task_name",
        "task_description",
        CAST("assignee_id" AS VARCHAR) AS "assignee_id",
        CAST("completed_by_id" AS VARCHAR) AS "completed_by_id",
        CAST("completion_timestamp" AS TIMESTAMP) AS "completion_timestamp",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("due_date" AS TIMESTAMP) AS "due_date",
        CAST("due_timestamp" AS TIMESTAMP) AS "due_timestamp",
        CAST("last_modified_timestamp" AS TIMESTAMP) AS "last_modified_timestamp",
        CAST("parent_task_id" AS VARCHAR) AS "parent_task_id",
        CAST("start_date" AS TIMESTAMP) AS "start_date",
        CAST("task_id" AS VARCHAR) AS "task_id",
        CAST("workspace_id" AS VARCHAR) AS "workspace_id"
    FROM "task_data_renamed"
),

"task_data_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- due_timestamp has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- parent_task_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- start_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_completed",
        "task_name",
        "task_description",
        "assignee_id",
        "completed_by_id",
        "completion_timestamp",
        "creation_timestamp",
        "due_date",
        "last_modified_timestamp",
        "task_id",
        "workspace_id"
    FROM "task_data_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "task_data_renamed_casted_missing_handled"