-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"daylight_time_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "time_zone",
        "year_",
        "daylight_end_utc",
        "daylight_offset",
        "daylight_start_utc"
    FROM "daylight_time_data"
),

"daylight_time_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- daylight_end_utc -> daylight_saving_end_utc
    -- daylight_offset -> daylight_saving_offset_hours
    -- daylight_start_utc -> daylight_saving_start_utc
    SELECT 
        "time_zone",
        "year_",
        "daylight_end_utc" AS "daylight_saving_end_utc",
        "daylight_offset" AS "daylight_saving_offset_hours",
        "daylight_start_utc" AS "daylight_saving_start_utc"
    FROM "daylight_time_data_projected"
),

"daylight_time_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- daylight_saving_end_utc: from VARCHAR to TIMESTAMP
    -- daylight_saving_start_utc: from VARCHAR to TIMESTAMP
    SELECT
        "time_zone",
        "year_",
        "daylight_saving_offset_hours",
        CAST("daylight_saving_end_utc" AS TIMESTAMP) AS "daylight_saving_end_utc",
        CAST("daylight_saving_start_utc" AS TIMESTAMP) AS "daylight_saving_start_utc"
    FROM "daylight_time_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "daylight_time_data_projected_renamed_casted"