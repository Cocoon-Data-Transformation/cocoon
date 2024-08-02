-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 00:50:41.286315+00:00
WITH 
"drug_exposure_casted" AS (
    -- Column Type Casting: 
    -- drug_exposure_end_date: from VARCHAR to DATE
    -- drug_exposure_start_date: from VARCHAR to DATE
    -- quantity: from INT to DECIMAL
    -- verbatim_end_date: from VARCHAR to DATE
    SELECT
        "drug_exposure_id",
        "person_id",
        "stop_reason",
        "refills",
        "days_supply",
        "sig",
        "lot_number",
        "provider_id",
        "visit_occurrence_id",
        "drug_source_value",
        "route_source_value",
        "dose_unit_source_value",
        CAST("drug_exposure_end_date" AS DATE) 
        AS "drug_exposure_end_date",
        CAST("drug_exposure_start_date" AS DATE) 
        AS "drug_exposure_start_date",
        CAST("quantity" AS DECIMAL) 
        AS "quantity",
        CAST("verbatim_end_date" AS DATE) 
        AS "verbatim_end_date"
    FROM "memory"."main"."drug_exposure"
)

-- COCOON BLOCK END
SELECT *
FROM "drug_exposure_casted"