-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"_2012_sat_results_renamed" AS (
    -- Rename: Renaming columns
    -- DBN -> school_id
    -- Num_of_SAT_Test_Takers -> num_sat_takers
    -- SAT_Critical_Reading_Avg__Score -> sat_critical_reading_avg
    -- SAT_Math_Avg__Score -> sat_math_avg
    -- SAT_Writing_Avg__Score -> sat_writing_avg
    SELECT 
        "DBN" AS "school_id",
        "SCHOOL_NAME",
        "Num_of_SAT_Test_Takers" AS "num_sat_takers",
        "SAT_Critical_Reading_Avg__Score" AS "sat_critical_reading_avg",
        "SAT_Math_Avg__Score" AS "sat_math_avg",
        "SAT_Writing_Avg__Score" AS "sat_writing_avg"
    FROM "_2012_sat_results"
),

"_2012_sat_results_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- num_sat_takers: ['s']
    -- sat_critical_reading_avg: ['s']
    -- sat_math_avg: ['s']
    -- sat_writing_avg: ['s']
    SELECT 
        CASE
            WHEN "num_sat_takers" = 's' THEN NULL
            ELSE "num_sat_takers"
        END AS "num_sat_takers",
        CASE
            WHEN "sat_critical_reading_avg" = 's' THEN NULL
            ELSE "sat_critical_reading_avg"
        END AS "sat_critical_reading_avg",
        CASE
            WHEN "sat_math_avg" = 's' THEN NULL
            ELSE "sat_math_avg"
        END AS "sat_math_avg",
        CASE
            WHEN "sat_writing_avg" = 's' THEN NULL
            ELSE "sat_writing_avg"
        END AS "sat_writing_avg",
        "school_id",
        "SCHOOL_NAME"
    FROM "_2012_sat_results_renamed"
),

"_2012_sat_results_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- num_sat_takers: from VARCHAR to INT
    -- sat_critical_reading_avg: from VARCHAR to INT
    -- sat_math_avg: from VARCHAR to INT
    -- sat_writing_avg: from VARCHAR to INT
    SELECT
        "school_id",
        "SCHOOL_NAME",
        CAST("num_sat_takers" AS INT) AS "num_sat_takers",
        CAST("sat_critical_reading_avg" AS INT) AS "sat_critical_reading_avg",
        CAST("sat_math_avg" AS INT) AS "sat_math_avg",
        CAST("sat_writing_avg" AS INT) AS "sat_writing_avg"
    FROM "_2012_sat_results_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "_2012_sat_results_renamed_null_casted"