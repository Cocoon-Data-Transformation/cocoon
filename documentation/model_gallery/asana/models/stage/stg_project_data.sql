-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:59:07.456396+00:00
WITH 
"project_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "archived",
        "color",
        "created_at",
        "current_status",
        "due_date",
        "modified_at",
        "name",
        "notes",
        "owner_id",
        "public_",
        "team_id",
        "workspace_id"
    FROM "memory"."main"."project_data"
),

"project_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> project_id
    -- _fivetran_deleted -> is_deleted
    -- archived -> is_archived
    -- color -> project_color
    -- created_at -> creation_date
    -- current_status -> project_status
    -- due_date -> project_deadline
    -- modified_at -> last_modified_date
    -- name -> project_name
    -- notes -> project_notes
    -- public_ -> is_public
    SELECT 
        "id" AS "project_id",
        "_fivetran_deleted" AS "is_deleted",
        "archived" AS "is_archived",
        "color" AS "project_color",
        "created_at" AS "creation_date",
        "current_status" AS "project_status",
        "due_date" AS "project_deadline",
        "modified_at" AS "last_modified_date",
        "name" AS "project_name",
        "notes" AS "project_notes",
        "owner_id",
        "public_" AS "is_public",
        "team_id",
        "workspace_id"
    FROM "project_data_projected"
),

"project_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- project_status: The problem is that the project_status column contains a single value that appears to be a hashed or encoded string ('752e3db7344085cd1bdb19f63d241ca8') rather than a human-readable project status. This value is unusual because it doesn't provide any meaningful information about the status of the project. The correct values for a project status column would typically be descriptive terms like 'In Progress', 'Completed', 'On Hold', etc. Since we don't have any information about what this hash might represent, and there are no other values to compare it to, the safest approach is to map it to an empty string to indicate that the status is unknown or not provided. 
    SELECT
        "project_id",
        "is_deleted",
        "is_archived",
        "project_color",
        "creation_date",
        CASE
            WHEN "project_status" = '''752e3db7344085cd1bdb19f63d241ca8''' THEN ''''
            ELSE "project_status"
        END AS "project_status",
        "project_deadline",
        "last_modified_date",
        "project_name",
        "project_notes",
        "owner_id",
        "is_public",
        "team_id",
        "workspace_id"
    FROM "project_data_projected_renamed"
),

"project_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- project_notes: ['d41d8cd98f00b204e9800998ecf8427e']
    SELECT 
        CASE
            WHEN "project_notes" = 'd41d8cd98f00b204e9800998ecf8427e' THEN NULL
            ELSE "project_notes"
        END AS "project_notes",
        "team_id",
        "project_color",
        "project_id",
        "workspace_id",
        "creation_date",
        "owner_id",
        "last_modified_date",
        "is_archived",
        "is_deleted",
        "project_status",
        "project_name",
        "is_public",
        "project_deadline"
    FROM "project_data_projected_renamed_cleaned"
),

"project_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to TIMESTAMP
    -- is_public: from DECIMAL to VARCHAR
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- owner_id: from DECIMAL to VARCHAR
    -- project_id: from INT to VARCHAR
    -- team_id: from INT to VARCHAR
    -- workspace_id: from INT to VARCHAR
    SELECT
        "project_notes",
        "project_color",
        "is_archived",
        "is_deleted",
        "project_status",
        "project_name",
        "project_deadline",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("is_public" AS VARCHAR) AS "is_public",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("owner_id" AS VARCHAR) AS "owner_id",
        CAST("project_id" AS VARCHAR) AS "project_id",
        CAST("team_id" AS VARCHAR) AS "team_id",
        CAST("workspace_id" AS VARCHAR) AS "workspace_id"
    FROM "project_data_projected_renamed_cleaned_null"
),

"project_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 5 columns with unacceptable missing values
    -- owner_id has 18.75 percent missing. Strategy: 🔄 Unchanged
    -- project_color has 43.75 percent missing. Strategy: 🔄 Unchanged
    -- project_deadline has 93.75 percent missing. Strategy: 🗑️ Drop Column
    -- project_notes has 87.5 percent missing. Strategy: 🔄 Unchanged
    -- project_status has 93.75 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "project_notes",
        "project_color",
        "is_archived",
        "is_deleted",
        "project_name",
        "creation_date",
        "is_public",
        "last_modified_date",
        "owner_id",
        "project_id",
        "team_id",
        "workspace_id"
    FROM "project_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "project_data_projected_renamed_cleaned_null_casted_missing_handled"