-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_pipeline_stage_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "stage_id",
        "_fivetran_deleted",
        "active",
        "display_order",
        "is_closed",
        "label",
        "pipeline_id",
        "ticket_state",
        "created_at",
        "updated_at"
    FROM "ticket_pipeline_stage_data"
),

"ticket_pipeline_stage_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- active -> is_active
    -- label -> stage_label
    SELECT 
        "stage_id",
        "_fivetran_deleted" AS "is_deleted",
        "active" AS "is_active",
        "display_order",
        "is_closed",
        "label" AS "stage_label",
        "pipeline_id",
        "ticket_state",
        "created_at",
        "updated_at"
    FROM "ticket_pipeline_stage_data_projected"
),

"ticket_pipeline_stage_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- stage_id: from INT to VARCHAR
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "is_deleted",
        "is_active",
        "display_order",
        "is_closed",
        "stage_label",
        "pipeline_id",
        "ticket_state",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("stage_id" AS VARCHAR) AS "stage_id",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "ticket_pipeline_stage_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_pipeline_stage_data_projected_renamed_casted"