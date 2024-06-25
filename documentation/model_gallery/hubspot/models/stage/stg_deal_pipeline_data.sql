-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"deal_pipeline_data_projected" AS (
    -- Projection: Selecting 7 out of 8 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "pipeline_id",
        "_fivetran_deleted",
        "active",
        "display_order",
        "label",
        "created_at",
        "updated_at"
    FROM "deal_pipeline_data"
),

"deal_pipeline_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- active -> is_active
    -- label -> encrypted_label
    SELECT 
        "pipeline_id",
        "_fivetran_deleted" AS "is_deleted",
        "active" AS "is_active",
        "display_order",
        "label" AS "encrypted_label",
        "created_at",
        "updated_at"
    FROM "deal_pipeline_data_projected"
),

"deal_pipeline_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "pipeline_id",
        "is_deleted",
        "is_active",
        "display_order",
        "encrypted_label",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "deal_pipeline_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "deal_pipeline_data_projected_renamed_casted"