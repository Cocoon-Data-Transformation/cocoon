-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"deal_pipeline_stage_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_deleted",
        "active",
        "closed_won",
        "display_order",
        "probability",
        "stage_id",
        "label",
        "pipeline_id",
        "created_at",
        "updated_at"
    FROM "deal_pipeline_stage_data"
),

"deal_pipeline_stage_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- active -> is_active
    -- closed_won -> is_closed_won
    -- probability -> win_probability
    -- label -> stage_label
    SELECT 
        "_fivetran_deleted" AS "is_deleted",
        "active" AS "is_active",
        "closed_won" AS "is_closed_won",
        "display_order",
        "probability" AS "win_probability",
        "stage_id",
        "label" AS "stage_label",
        "pipeline_id",
        "created_at",
        "updated_at"
    FROM "deal_pipeline_stage_data_projected"
),

"deal_pipeline_stage_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "is_deleted",
        "is_active",
        "is_closed_won",
        "display_order",
        "win_probability",
        "stage_id",
        "stage_label",
        "pipeline_id",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "deal_pipeline_stage_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "deal_pipeline_stage_data_projected_renamed_casted"