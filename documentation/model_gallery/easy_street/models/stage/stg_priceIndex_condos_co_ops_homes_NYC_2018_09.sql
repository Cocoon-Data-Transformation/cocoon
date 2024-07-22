-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-22 18:20:52.383907+00:00
WITH 
"priceIndex_condos_co_ops_homes_NYC_2018_09_renamed" AS (
    -- Rename: Renaming columns
    -- NYC_All -> nyc_price_index
    -- NYC_All_MoM -> price_index_mom_change
    -- NYC_All_YoY -> price_index_yoy_change
    SELECT 
        "date_",
        "NYC_All" AS "nyc_price_index",
        "NYC_All_MoM" AS "price_index_mom_change",
        "NYC_All_YoY" AS "price_index_yoy_change"
    FROM "memory"."main"."priceIndex_condos_co_ops_homes_NYC_2018_09"
),

"priceIndex_condos_co_ops_homes_NYC_2018_09_renamed_casted" AS (
    -- Column Type Casting: 
    -- date_: from VARCHAR to DATE
    SELECT
        "nyc_price_index",
        "price_index_mom_change",
        "price_index_yoy_change",
        CAST("date_" AS DATE) 
        AS "date_"
    FROM "priceIndex_condos_co_ops_homes_NYC_2018_09_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "priceIndex_condos_co_ops_homes_NYC_2018_09_renamed_casted"