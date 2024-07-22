-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-22 18:20:57.653990+00:00
WITH 
"priceIndex_condos_co_ops_homes_The_Rockaways_2018_09_renamed" AS (
    -- Rename: Renaming columns
    -- sales -> average_sales_price
    -- MoM -> month_over_month_change
    -- YoY -> year_over_year_change
    SELECT 
        "date_",
        "sales" AS "average_sales_price",
        "MoM" AS "month_over_month_change",
        "YoY" AS "year_over_year_change"
    FROM "memory"."main"."priceIndex_condos_co_ops_homes_The_Rockaways_2018_09"
),

"priceIndex_condos_co_ops_homes_The_Rockaways_2018_09_renamed_casted" AS (
    -- Column Type Casting: 
    -- date_: from VARCHAR to DATE
    SELECT
        "average_sales_price",
        "month_over_month_change",
        "year_over_year_change",
        CAST("date_" AS DATE) 
        AS "date_"
    FROM "priceIndex_condos_co_ops_homes_The_Rockaways_2018_09_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "priceIndex_condos_co_ops_homes_The_Rockaways_2018_09_renamed_casted"