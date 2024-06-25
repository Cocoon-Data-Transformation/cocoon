-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"deal_stage_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_start",
        "deal_id",
        "_fivetran_active",
        "_fivetran_end",
        "date_entered",
        "source",
        "source_id",
        "value_"
    FROM "deal_stage_data"
),

"deal_stage_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_start -> validity_start_date
    -- _fivetran_active -> is_active
    -- _fivetran_end -> validity_end_date
    -- date_entered -> stage_entry_datetime
    -- source -> source_system_id
    -- source_id -> source_stage_id
    -- value_ -> stage_value
    SELECT 
        "_fivetran_start" AS "validity_start_date",
        "deal_id",
        "_fivetran_active" AS "is_active",
        "_fivetran_end" AS "validity_end_date",
        "date_entered" AS "stage_entry_datetime",
        "source" AS "source_system_id",
        "source_id" AS "source_stage_id",
        "value_" AS "stage_value"
    FROM "deal_stage_data_projected"
),

"deal_stage_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- deal_id: from INT to VARCHAR
    -- stage_entry_datetime: from VARCHAR to TIMESTAMP
    -- validity_end_date: from VARCHAR to TIMESTAMP
    -- validity_start_date: from VARCHAR to TIMESTAMP
    SELECT
        "is_active",
        "source_system_id",
        "source_stage_id",
        "stage_value",
        CAST("deal_id" AS VARCHAR) AS "deal_id",
        CAST("stage_entry_datetime" AS TIMESTAMP) AS "stage_entry_datetime",
        CAST("validity_end_date" AS TIMESTAMP) AS "validity_end_date",
        CAST("validity_start_date" AS TIMESTAMP) AS "validity_start_date"
    FROM "deal_stage_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "deal_stage_data_projected_renamed_casted"