-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_pipeline_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "pipeline_id",
        "_fivetran_deleted",
        "active",
        "display_order",
        "label",
        "object_type_id",
        "created_at",
        "updated_at"
    FROM "ticket_pipeline_data"
),

"ticket_pipeline_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- active -> is_active
    -- label -> stage_identifier
    SELECT 
        "pipeline_id",
        "_fivetran_deleted" AS "is_deleted",
        "active" AS "is_active",
        "display_order",
        "label" AS "stage_identifier",
        "object_type_id",
        "created_at",
        "updated_at"
    FROM "ticket_pipeline_data_projected"
),

"ticket_pipeline_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "pipeline_id",
        "is_deleted",
        "is_active",
        "display_order",
        "stage_identifier",
        "object_type_id",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "ticket_pipeline_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_pipeline_data_projected_renamed_casted"