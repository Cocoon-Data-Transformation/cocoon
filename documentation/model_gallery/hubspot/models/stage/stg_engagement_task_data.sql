-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_task_data_projected" AS (
    -- Projection: Selecting 11 out of 12 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "engagement_id",
        "_fivetran_deleted",
        "property_hs_createdate",
        "property_hs_object_id",
        "property_hs_task_type",
        "property_hs_timestamp",
        "property_hubspot_owner_id",
        "property_hubspot_team_id",
        "type",
        "task_type",
        "property_hs_engagement_source"
    FROM "engagement_task_data"
),

"engagement_task_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- engagement_id -> task_id
    -- _fivetran_deleted -> is_deleted
    -- property_hs_createdate -> creation_datetime
    -- property_hs_object_id -> associated_object_id
    -- property_hs_task_type -> task_type
    -- property_hs_timestamp -> due_datetime
    -- property_hubspot_owner_id -> owner_id
    -- property_hubspot_team_id -> team_id
    -- type -> engagement_type
    -- task_type -> alternative_task_type
    -- property_hs_engagement_source -> task_source
    SELECT 
        "engagement_id" AS "task_id",
        "_fivetran_deleted" AS "is_deleted",
        "property_hs_createdate" AS "creation_datetime",
        "property_hs_object_id" AS "associated_object_id",
        "property_hs_task_type" AS "task_type",
        "property_hs_timestamp" AS "due_datetime",
        "property_hubspot_owner_id" AS "owner_id",
        "property_hubspot_team_id" AS "team_id",
        "type" AS "engagement_type",
        "task_type" AS "alternative_task_type",
        "property_hs_engagement_source" AS "task_source"
    FROM "engagement_task_data_projected"
),

"engagement_task_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- associated_object_id: from INT to VARCHAR
    -- creation_datetime: from VARCHAR to TIMESTAMP
    -- due_datetime: from VARCHAR to TIMESTAMP
    -- owner_id: from INT to VARCHAR
    -- task_id: from INT to VARCHAR
    SELECT
        "is_deleted",
        "task_type",
        "team_id",
        "engagement_type",
        "alternative_task_type",
        "task_source",
        CAST("associated_object_id" AS VARCHAR) AS "associated_object_id",
        CAST("creation_datetime" AS TIMESTAMP) AS "creation_datetime",
        CAST("due_datetime" AS TIMESTAMP) AS "due_datetime",
        CAST("owner_id" AS VARCHAR) AS "owner_id",
        CAST("task_id" AS VARCHAR) AS "task_id"
    FROM "engagement_task_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_task_data_projected_renamed_casted"