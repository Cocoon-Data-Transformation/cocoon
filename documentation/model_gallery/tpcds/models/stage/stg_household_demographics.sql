-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"household_demographics_renamed" AS (
    -- Rename: Renaming columns
    -- HD_DEMO_SK -> household_demographic_id
    -- HD_INCOME_BAND_SK -> income_band_id
    -- HD_BUY_POTENTIAL -> household_buying_potential
    -- HD_DEP_COUNT -> dependent_count
    -- HD_VEHICLE_COUNT -> vehicle_count
    SELECT 
        "HD_DEMO_SK" AS "household_demographic_id",
        "HD_INCOME_BAND_SK" AS "income_band_id",
        "HD_BUY_POTENTIAL" AS "household_buying_potential",
        "HD_DEP_COUNT" AS "dependent_count",
        "HD_VEHICLE_COUNT" AS "vehicle_count"
    FROM "household_demographics"
)

-- COCOON BLOCK END
SELECT * FROM "household_demographics_renamed"