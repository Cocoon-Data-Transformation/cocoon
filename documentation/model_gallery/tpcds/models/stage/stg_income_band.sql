-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"income_band_renamed" AS (
    -- Rename: Renaming columns
    -- IB_INCOME_BAND_SK -> income_band_id
    -- IB_LOWER_BOUND -> lower_income_limit
    -- IB_UPPER_BOUND -> upper_income_limit
    SELECT 
        "IB_INCOME_BAND_SK" AS "income_band_id",
        "IB_LOWER_BOUND" AS "lower_income_limit",
        "IB_UPPER_BOUND" AS "upper_income_limit"
    FROM "income_band"
)

-- COCOON BLOCK END
SELECT * FROM "income_band_renamed"