-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sprint_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "board_id",
        "complete_date",
        "end_date",
        "name",
        "start_date"
    FROM "sprint"
),

"sprint_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> sprint_id
    -- complete_date -> completion_date
    -- name -> sprint_name
    SELECT 
        "id" AS "sprint_id",
        "board_id",
        "complete_date" AS "completion_date",
        "end_date",
        "name" AS "sprint_name",
        "start_date"
    FROM "sprint_projected"
),

"sprint_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- end_date: The problem is that one of the date-time values ('2020-11-17 10:29:44.653') includes milliseconds, while the others don't. The correct values should all follow the same format without milliseconds, which is the most common format in the dataset. 
    SELECT
        "sprint_id",
        "board_id",
        "completion_date",
        CASE
            WHEN "end_date" = '2020-11-17 10:29:44.653' THEN '2020-11-17 10:29:44'
            ELSE "end_date"
        END AS "end_date",
        "sprint_name",
        "start_date"
    FROM "sprint_projected_renamed"
),

"sprint_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- completion_date: from VARCHAR to TIMESTAMP
    -- end_date: from VARCHAR to TIMESTAMP
    -- start_date: from VARCHAR to TIMESTAMP
    SELECT
        "sprint_id",
        "board_id",
        "sprint_name",
        CAST("completion_date" AS TIMESTAMP) AS "completion_date",
        CAST("end_date" AS TIMESTAMP) AS "end_date",
        CAST("start_date" AS TIMESTAMP) AS "start_date"
    FROM "sprint_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "sprint_projected_renamed_cleaned_casted"