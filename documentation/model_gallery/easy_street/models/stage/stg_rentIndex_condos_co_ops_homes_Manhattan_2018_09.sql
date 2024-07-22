-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-22 18:21:07.573921+00:00
WITH 
"rentIndex_condos_co_ops_homes_Manhattan_2018_09_renamed" AS (
    -- Rename: Renaming columns
    -- Manhattan_All -> manhattan_price_index
    -- Manhattan_Q1 -> manhattan_q1_price_index
    -- Manhattan_Q2 -> manhattan_q2_price_index
    -- Manhattan_Q3 -> manhattan_q3_price_index
    -- Manhattan_Q4 -> manhattan_q4_price_index
    -- Manhattan_Q5 -> manhattan_q5_price_index
    -- Manhattan_All_MoM -> manhattan_price_index_mom
    -- Manhattan_Q1_MoM -> manhattan_q1_price_index_mom
    -- Manhattan_Q2_MoM -> manhattan_q2_price_index_mom
    -- Manhattan_Q3_MoM -> manhattan_q3_price_index_mom
    -- Manhattan_Q4_MoM -> manhattan_q4_price_index_mom
    -- Manhattan_Q5_MoM -> manhattan_q5_price_index_mom
    -- Manhattan_All_YoY -> manhattan_price_index_yoy
    -- Manhattan_Q1_YoY -> manhattan_q1_price_index_yoy
    -- Manhattan_Q2_YoY -> manhattan_q2_price_index_yoy
    -- Manhattan_Q3_YoY -> manhattan_q3_price_index_yoy
    -- Manhattan_Q4_YoY -> manhattan_q4_price_index_yoy
    -- Manhattan_Q5_YoY -> manhattan_q5_price_index_yoy
    SELECT 
        "date_",
        "Manhattan_All" AS "manhattan_price_index",
        "Manhattan_Q1" AS "manhattan_q1_price_index",
        "Manhattan_Q2" AS "manhattan_q2_price_index",
        "Manhattan_Q3" AS "manhattan_q3_price_index",
        "Manhattan_Q4" AS "manhattan_q4_price_index",
        "Manhattan_Q5" AS "manhattan_q5_price_index",
        "Manhattan_All_MoM" AS "manhattan_price_index_mom",
        "Manhattan_Q1_MoM" AS "manhattan_q1_price_index_mom",
        "Manhattan_Q2_MoM" AS "manhattan_q2_price_index_mom",
        "Manhattan_Q3_MoM" AS "manhattan_q3_price_index_mom",
        "Manhattan_Q4_MoM" AS "manhattan_q4_price_index_mom",
        "Manhattan_Q5_MoM" AS "manhattan_q5_price_index_mom",
        "Manhattan_All_YoY" AS "manhattan_price_index_yoy",
        "Manhattan_Q1_YoY" AS "manhattan_q1_price_index_yoy",
        "Manhattan_Q2_YoY" AS "manhattan_q2_price_index_yoy",
        "Manhattan_Q3_YoY" AS "manhattan_q3_price_index_yoy",
        "Manhattan_Q4_YoY" AS "manhattan_q4_price_index_yoy",
        "Manhattan_Q5_YoY" AS "manhattan_q5_price_index_yoy"
    FROM "memory"."main"."rentIndex_condos_co_ops_homes_Manhattan_2018_09"
),

"rentIndex_condos_co_ops_homes_Manhattan_2018_09_renamed_casted" AS (
    -- Column Type Casting: 
    -- date_: from VARCHAR to DATE
    SELECT
        "manhattan_price_index",
        "manhattan_q1_price_index",
        "manhattan_q2_price_index",
        "manhattan_q3_price_index",
        "manhattan_q4_price_index",
        "manhattan_q5_price_index",
        "manhattan_price_index_mom",
        "manhattan_q1_price_index_mom",
        "manhattan_q2_price_index_mom",
        "manhattan_q3_price_index_mom",
        "manhattan_q4_price_index_mom",
        "manhattan_q5_price_index_mom",
        "manhattan_price_index_yoy",
        "manhattan_q1_price_index_yoy",
        "manhattan_q2_price_index_yoy",
        "manhattan_q3_price_index_yoy",
        "manhattan_q4_price_index_yoy",
        "manhattan_q5_price_index_yoy",
        CAST("date_" AS DATE) 
        AS "date_"
    FROM "rentIndex_condos_co_ops_homes_Manhattan_2018_09_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "rentIndex_condos_co_ops_homes_Manhattan_2018_09_renamed_casted"