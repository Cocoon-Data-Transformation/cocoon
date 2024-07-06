-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"schedule_holiday_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "schedule_id",
        "_fivetran_deleted",
        "end_date",
        "name",
        "start_date"
    FROM "schedule_holiday_data"
),

"schedule_holiday_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> holiday_id
    -- _fivetran_deleted -> is_deleted
    -- name -> holiday_name
    SELECT 
        "id" AS "holiday_id",
        "schedule_id",
        "_fivetran_deleted" AS "is_deleted",
        "end_date",
        "name" AS "holiday_name",
        "start_date"
    FROM "schedule_holiday_data_projected"
),

"schedule_holiday_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- end_date: from VARCHAR to DATE
    -- start_date: from VARCHAR to DATE
    SELECT
        "holiday_id",
        "schedule_id",
        "is_deleted",
        "holiday_name",
        CAST("end_date" AS DATE) AS "end_date",
        CAST("start_date" AS DATE) AS "start_date"
    FROM "schedule_holiday_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "schedule_holiday_data_projected_renamed_casted"