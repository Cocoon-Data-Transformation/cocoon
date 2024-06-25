-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"issue_projected" AS (
    -- Projection: Selecting 28 out of 29 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "_original_estimate",
        "_remaining_estimate",
        "_time_spent",
        "assignee",
        "created",
        "creator",
        "description",
        "due_date",
        "environment",
        "issue_type",
        "key_",
        "last_viewed",
        "original_estimate",
        "parent_id",
        "priority",
        "project",
        "remaining_estimate",
        "reporter",
        "resolution",
        "resolved",
        "status",
        "status_category_changed",
        "summary",
        "time_spent",
        "updated",
        "work_ratio"
    FROM "issue"
),

"issue_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> issue_id
    -- _fivetran_deleted -> is_deleted
    -- _original_estimate -> original_estimate_seconds
    -- _remaining_estimate -> remaining_estimate_seconds
    -- _time_spent -> time_spent_seconds
    -- created -> created_at
    -- creator -> creator_id
    -- issue_type -> issue_type_id
    -- key_ -> issue_key
    -- last_viewed -> last_viewed_at
    -- parent_id -> parent_issue_id
    -- priority -> priority_id
    -- project -> project_id
    -- reporter -> reporter_id
    -- resolution -> resolution_id
    -- resolved -> resolved_at
    -- status -> status_id
    -- status_category_changed -> status_category_changed_at
    -- updated -> updated_at
    SELECT 
        "id" AS "issue_id",
        "_fivetran_deleted" AS "is_deleted",
        "_original_estimate" AS "original_estimate_seconds",
        "_remaining_estimate" AS "remaining_estimate_seconds",
        "_time_spent" AS "time_spent_seconds",
        "assignee",
        "created" AS "created_at",
        "creator" AS "creator_id",
        "description",
        "due_date",
        "environment",
        "issue_type" AS "issue_type_id",
        "key_" AS "issue_key",
        "last_viewed" AS "last_viewed_at",
        "original_estimate",
        "parent_id" AS "parent_issue_id",
        "priority" AS "priority_id",
        "project" AS "project_id",
        "remaining_estimate",
        "reporter" AS "reporter_id",
        "resolution" AS "resolution_id",
        "resolved" AS "resolved_at",
        "status" AS "status_id",
        "status_category_changed" AS "status_category_changed_at",
        "summary",
        "time_spent",
        "updated" AS "updated_at",
        "work_ratio"
    FROM "issue_projected"
),

"issue_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- issue_key: The problem is inconsistent prefixes in the issue_key column. The prefixes 'TCP' and 'TP' are likely meant to represent the same concept but are inconsistently applied. Given that 'TCP' appears in the most frequent value ('TCP-1'), it's likely the intended prefix. The correct values should all use the 'TCP' prefix for consistency. 
    SELECT
        "issue_id",
        "is_deleted",
        "original_estimate_seconds",
        "remaining_estimate_seconds",
        "time_spent_seconds",
        "assignee",
        "created_at",
        "creator_id",
        "description",
        "due_date",
        "environment",
        "issue_type_id",
        CASE
            WHEN "issue_key" = 'TP-12' THEN 'TCP-12'
            WHEN "issue_key" = 'TP-8' THEN 'TCP-8'
            ELSE "issue_key"
        END AS "issue_key",
        "last_viewed_at",
        "original_estimate",
        "parent_issue_id",
        "priority_id",
        "project_id",
        "remaining_estimate",
        "reporter_id",
        "resolution_id",
        "resolved_at",
        "status_id",
        "status_category_changed_at",
        "summary",
        "time_spent",
        "updated_at",
        "work_ratio"
    FROM "issue_projected_renamed"
),

"issue_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- assignee: from DECIMAL to VARCHAR
    -- created_at: from VARCHAR to TIMESTAMP
    -- due_date: from DECIMAL to DATE
    -- environment: from DECIMAL to VARCHAR
    -- last_viewed_at: from VARCHAR to TIMESTAMP
    -- original_estimate: from DECIMAL to VARCHAR
    -- original_estimate_seconds: from DECIMAL to INT
    -- parent_issue_id: from DECIMAL to INT
    -- remaining_estimate: from DECIMAL to VARCHAR
    -- remaining_estimate_seconds: from DECIMAL to INT
    -- resolution_id: from DECIMAL to INT
    -- resolved_at: from VARCHAR to TIMESTAMP
    -- status_category_changed_at: from VARCHAR to TIMESTAMP
    -- time_spent: from DECIMAL to VARCHAR
    -- time_spent_seconds: from DECIMAL to INT
    -- updated_at: from VARCHAR to TIMESTAMP
    -- work_ratio: from INT to DECIMAL
    SELECT
        "issue_id",
        "is_deleted",
        "creator_id",
        "description",
        "issue_type_id",
        "issue_key",
        "priority_id",
        "project_id",
        "reporter_id",
        "status_id",
        "summary",
        CAST("assignee" AS VARCHAR) AS "assignee",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("due_date" AS DATE) AS "due_date",
        CAST("environment" AS VARCHAR) AS "environment",
        CAST("last_viewed_at" AS TIMESTAMP) AS "last_viewed_at",
        CAST("original_estimate" AS VARCHAR) AS "original_estimate",
        CAST("original_estimate_seconds" AS INT) AS "original_estimate_seconds",
        CAST("parent_issue_id" AS INT) AS "parent_issue_id",
        CAST("remaining_estimate" AS VARCHAR) AS "remaining_estimate",
        CAST("remaining_estimate_seconds" AS INT) AS "remaining_estimate_seconds",
        CAST("resolution_id" AS INT) AS "resolution_id",
        CAST("resolved_at" AS TIMESTAMP) AS "resolved_at",
        CAST("status_category_changed_at" AS TIMESTAMP) AS "status_category_changed_at",
        CAST("time_spent" AS VARCHAR) AS "time_spent",
        CAST("time_spent_seconds" AS INT) AS "time_spent_seconds",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at",
        CAST("work_ratio" AS DECIMAL) AS "work_ratio"
    FROM "issue_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "issue_projected_renamed_cleaned_casted"