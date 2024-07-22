-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-22 18:21:13.196971+00:00
WITH 
"rentIndex_condos_co_ops_homes_Prospect_Park_2018_09_renamed" AS (
    -- Rename: Renaming columns
    -- rentals -> rental_price_index
    -- MoM -> month_over_month_change
    -- YoY -> year_over_year_change
    SELECT 
        "date_",
        "rentals" AS "rental_price_index",
        "MoM" AS "month_over_month_change",
        "YoY" AS "year_over_year_change"
    FROM "memory"."main"."rentIndex_condos_co_ops_homes_Prospect_Park_2018_09"
),

"rentIndex_condos_co_ops_homes_Prospect_Park_2018_09_renamed_casted" AS (
    -- Column Type Casting: 
    -- date_: from VARCHAR to DATE
    SELECT
        "rental_price_index",
        "month_over_month_change",
        "year_over_year_change",
        CAST("date_" AS DATE) 
        AS "date_"
    FROM "rentIndex_condos_co_ops_homes_Prospect_Park_2018_09_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "rentIndex_condos_co_ops_homes_Prospect_Park_2018_09_renamed_casted"