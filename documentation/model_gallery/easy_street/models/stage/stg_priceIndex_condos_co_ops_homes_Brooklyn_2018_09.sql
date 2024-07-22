-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-22 18:20:37.638014+00:00
WITH 
"priceIndex_condos_co_ops_homes_Brooklyn_2018_09_renamed" AS (
    -- Rename: Renaming columns
    -- Brooklyn_All -> brooklyn_price_index
    -- Brooklyn_Q1 -> brooklyn_q1_price_index
    -- Brooklyn_Q2 -> brooklyn_q2_price_index
    -- Brooklyn_Q3 -> brooklyn_q3_price_index
    -- Brooklyn_Q4 -> brooklyn_q4_price_index
    -- Brooklyn_Q5 -> brooklyn_q5_price_index
    -- Brooklyn_All_MoM -> brooklyn_price_index_mom
    -- Brooklyn_Q1_MoM -> brooklyn_q1_price_index_mom
    -- Brooklyn_Q2_MoM -> brooklyn_q2_price_index_mom
    -- Brooklyn_Q3_MoM -> brooklyn_q3_price_index_mom
    -- Brooklyn_Q4_MoM -> brooklyn_q4_price_index_mom
    -- Brooklyn_Q5_MoM -> brooklyn_q5_price_index_mom
    -- Brooklyn_All_YoY -> brooklyn_price_index_yoy
    -- Brooklyn_Q1_YoY -> brooklyn_q1_price_index_yoy
    -- Brooklyn_Q2_YoY -> brooklyn_q2_price_index_yoy
    -- Brooklyn_Q3_YoY -> brooklyn_q3_price_index_yoy
    -- Brooklyn_Q4_YoY -> brooklyn_q4_price_index_yoy
    -- Brooklyn_Q5_YoY -> brooklyn_q5_price_index_yoy
    SELECT 
        "date_",
        "Brooklyn_All" AS "brooklyn_price_index",
        "Brooklyn_Q1" AS "brooklyn_q1_price_index",
        "Brooklyn_Q2" AS "brooklyn_q2_price_index",
        "Brooklyn_Q3" AS "brooklyn_q3_price_index",
        "Brooklyn_Q4" AS "brooklyn_q4_price_index",
        "Brooklyn_Q5" AS "brooklyn_q5_price_index",
        "Brooklyn_All_MoM" AS "brooklyn_price_index_mom",
        "Brooklyn_Q1_MoM" AS "brooklyn_q1_price_index_mom",
        "Brooklyn_Q2_MoM" AS "brooklyn_q2_price_index_mom",
        "Brooklyn_Q3_MoM" AS "brooklyn_q3_price_index_mom",
        "Brooklyn_Q4_MoM" AS "brooklyn_q4_price_index_mom",
        "Brooklyn_Q5_MoM" AS "brooklyn_q5_price_index_mom",
        "Brooklyn_All_YoY" AS "brooklyn_price_index_yoy",
        "Brooklyn_Q1_YoY" AS "brooklyn_q1_price_index_yoy",
        "Brooklyn_Q2_YoY" AS "brooklyn_q2_price_index_yoy",
        "Brooklyn_Q3_YoY" AS "brooklyn_q3_price_index_yoy",
        "Brooklyn_Q4_YoY" AS "brooklyn_q4_price_index_yoy",
        "Brooklyn_Q5_YoY" AS "brooklyn_q5_price_index_yoy"
    FROM "memory"."main"."priceIndex_condos_co_ops_homes_Brooklyn_2018_09"
),

"priceIndex_condos_co_ops_homes_Brooklyn_2018_09_renamed_casted" AS (
    -- Column Type Casting: 
    -- date_: from VARCHAR to DATE
    SELECT
        "brooklyn_price_index",
        "brooklyn_q1_price_index",
        "brooklyn_q2_price_index",
        "brooklyn_q3_price_index",
        "brooklyn_q4_price_index",
        "brooklyn_q5_price_index",
        "brooklyn_price_index_mom",
        "brooklyn_q1_price_index_mom",
        "brooklyn_q2_price_index_mom",
        "brooklyn_q3_price_index_mom",
        "brooklyn_q4_price_index_mom",
        "brooklyn_q5_price_index_mom",
        "brooklyn_price_index_yoy",
        "brooklyn_q1_price_index_yoy",
        "brooklyn_q2_price_index_yoy",
        "brooklyn_q3_price_index_yoy",
        "brooklyn_q4_price_index_yoy",
        "brooklyn_q5_price_index_yoy",
        CAST("date_" AS DATE) 
        AS "date_"
    FROM "priceIndex_condos_co_ops_homes_Brooklyn_2018_09_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "priceIndex_condos_co_ops_homes_Brooklyn_2018_09_renamed_casted"