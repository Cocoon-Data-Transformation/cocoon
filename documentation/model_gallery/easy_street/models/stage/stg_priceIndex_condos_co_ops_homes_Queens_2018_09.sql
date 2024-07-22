-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-22 18:20:54.919573+00:00
WITH 
"priceIndex_condos_co_ops_homes_Queens_2018_09_renamed" AS (
    -- Rename: Renaming columns
    -- Queens_All -> queens_all_index
    -- Queens_Q1 -> queens_q1_index
    -- Queens_Q2 -> queens_q2_index
    -- Queens_Q3 -> queens_q3_index
    -- Queens_Q4 -> queens_q4_index
    -- Queens_Q5 -> queens_q5_index
    -- Queens_All_MoM -> queens_all_mom_change
    -- Queens_Q1_MoM -> queens_q1_mom_change
    -- Queens_Q2_MoM -> queens_q2_mom_change
    -- Queens_Q3_MoM -> queens_q3_mom_change
    -- Queens_Q4_MoM -> queens_q4_mom_change
    -- Queens_Q5_MoM -> queens_q5_mom_change
    -- Queens_All_YoY -> queens_all_yoy_change
    -- Queens_Q1_YoY -> queens_q1_yoy_change
    -- Queens_Q2_YoY -> queens_q2_yoy_change
    -- Queens_Q3_YoY -> queens_q3_yoy_change
    -- Queens_Q4_YoY -> queens_q4_yoy_change
    -- Queens_Q5_YoY -> queens_q5_yoy_change
    SELECT 
        "date_",
        "Queens_All" AS "queens_all_index",
        "Queens_Q1" AS "queens_q1_index",
        "Queens_Q2" AS "queens_q2_index",
        "Queens_Q3" AS "queens_q3_index",
        "Queens_Q4" AS "queens_q4_index",
        "Queens_Q5" AS "queens_q5_index",
        "Queens_All_MoM" AS "queens_all_mom_change",
        "Queens_Q1_MoM" AS "queens_q1_mom_change",
        "Queens_Q2_MoM" AS "queens_q2_mom_change",
        "Queens_Q3_MoM" AS "queens_q3_mom_change",
        "Queens_Q4_MoM" AS "queens_q4_mom_change",
        "Queens_Q5_MoM" AS "queens_q5_mom_change",
        "Queens_All_YoY" AS "queens_all_yoy_change",
        "Queens_Q1_YoY" AS "queens_q1_yoy_change",
        "Queens_Q2_YoY" AS "queens_q2_yoy_change",
        "Queens_Q3_YoY" AS "queens_q3_yoy_change",
        "Queens_Q4_YoY" AS "queens_q4_yoy_change",
        "Queens_Q5_YoY" AS "queens_q5_yoy_change"
    FROM "memory"."main"."priceIndex_condos_co_ops_homes_Queens_2018_09"
),

"priceIndex_condos_co_ops_homes_Queens_2018_09_renamed_casted" AS (
    -- Column Type Casting: 
    -- date_: from VARCHAR to DATE
    SELECT
        "queens_all_index",
        "queens_q1_index",
        "queens_q2_index",
        "queens_q3_index",
        "queens_q4_index",
        "queens_q5_index",
        "queens_all_mom_change",
        "queens_q1_mom_change",
        "queens_q2_mom_change",
        "queens_q3_mom_change",
        "queens_q4_mom_change",
        "queens_q5_mom_change",
        "queens_all_yoy_change",
        "queens_q1_yoy_change",
        "queens_q2_yoy_change",
        "queens_q3_yoy_change",
        "queens_q4_yoy_change",
        "queens_q5_yoy_change",
        CAST("date_" AS DATE) 
        AS "date_"
    FROM "priceIndex_condos_co_ops_homes_Queens_2018_09_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "priceIndex_condos_co_ops_homes_Queens_2018_09_renamed_casted"