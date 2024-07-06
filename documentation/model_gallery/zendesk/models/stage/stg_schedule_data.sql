-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"schedule_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "end_time",
        "id",
        "start_time",
        "_fivetran_deleted",
        "end_time_utc",
        "name",
        "start_time_utc",
        "time_zone",
        "created_at"
    FROM "schedule_data"
),

"schedule_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- end_time -> shift_end_local
    -- start_time -> shift_start_local
    -- _fivetran_deleted -> is_deleted
    -- end_time_utc -> shift_end_utc
    -- name -> team_name
    -- start_time_utc -> shift_start_utc
    SELECT 
        "end_time" AS "shift_end_local",
        "id",
        "start_time" AS "shift_start_local",
        "_fivetran_deleted" AS "is_deleted",
        "end_time_utc" AS "shift_end_utc",
        "name" AS "team_name",
        "start_time_utc" AS "shift_start_utc",
        "time_zone",
        "created_at"
    FROM "schedule_data_projected"
),

"schedule_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- id: from INT to VARCHAR
    SELECT
        "shift_end_local",
        "shift_start_local",
        "is_deleted",
        "shift_end_utc",
        "team_name",
        "shift_start_utc",
        "time_zone",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("id" AS VARCHAR) AS "id"
    FROM "schedule_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "schedule_data_projected_renamed_casted"