-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"deal_data_renamed" AS (
    -- Rename: Renaming columns
    -- deal_pipeline_id -> pipeline_id
    -- deal_pipeline_stage_id -> stage_id
    SELECT 
        "deal_id",
        "owner_id",
        "deal_pipeline_id" AS "pipeline_id",
        "deal_pipeline_stage_id" AS "stage_id",
        "is_deleted"
    FROM "deal_data"
),

"deal_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- deal_id: from INT to VARCHAR
    -- owner_id: from DECIMAL to VARCHAR
    SELECT
        "pipeline_id",
        "stage_id",
        "is_deleted",
        CAST("deal_id" AS VARCHAR) AS "deal_id",
        CAST("owner_id" AS VARCHAR) AS "owner_id"
    FROM "deal_data_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "deal_data_renamed_casted"