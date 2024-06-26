-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"time_dim_renamed" AS (
    -- Rename: Renaming columns
    -- T_TIME_SK -> time_surrogate_key
    -- T_TIME_ID -> time_id
    -- T_TIME -> seconds_since_midnight
    -- T_HOUR -> hour_
    -- T_MINUTE -> minute_
    -- T_SECOND -> second_
    -- T_AM_PM -> time_period
    -- T_SHIFT -> shift
    -- T_SUB_SHIFT -> sub_shift
    -- T_MEAL_TIME -> meal_time
    SELECT 
        "T_TIME_SK" AS "time_surrogate_key",
        "T_TIME_ID" AS "time_id",
        "T_TIME" AS "seconds_since_midnight",
        "T_HOUR" AS "hour_",
        "T_MINUTE" AS "minute_",
        "T_SECOND" AS "second_",
        "T_AM_PM" AS "time_period",
        "T_SHIFT" AS "shift",
        "T_SUB_SHIFT" AS "sub_shift",
        "T_MEAL_TIME" AS "meal_time"
    FROM "time_dim"
),

"time_dim_renamed_casted" AS (
    -- Column Type Casting: 
    -- meal_time: from DECIMAL to VARCHAR
    SELECT
        "time_surrogate_key",
        "time_id",
        "seconds_since_midnight",
        "hour_",
        "minute_",
        "second_",
        "time_period",
        "shift",
        "sub_shift",
        CAST("meal_time" AS VARCHAR) AS "meal_time"
    FROM "time_dim_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "time_dim_renamed_casted"