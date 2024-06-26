-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"drug_exposure_renamed" AS (
    -- Rename: Renaming columns
    -- drug_exposure_id -> exposure_id
    -- person_id -> patient_id
    -- drug_exposure_start_date -> exposure_start_date
    -- drug_exposure_end_date -> exposure_end_date
    -- sig -> dosing_instructions
    -- visit_occurrence_id -> visit_id
    -- drug_source_value -> drug_name
    -- route_source_value -> administration_route
    -- dose_unit_source_value -> dose_unit
    SELECT 
        "drug_exposure_id" AS "exposure_id",
        "person_id" AS "patient_id",
        "drug_exposure_start_date" AS "exposure_start_date",
        "drug_exposure_end_date" AS "exposure_end_date",
        "verbatim_end_date",
        "stop_reason",
        "refills",
        "quantity",
        "days_supply",
        "sig" AS "dosing_instructions",
        "lot_number",
        "provider_id",
        "visit_occurrence_id" AS "visit_id",
        "drug_source_value" AS "drug_name",
        "route_source_value" AS "administration_route",
        "dose_unit_source_value" AS "dose_unit"
    FROM "drug_exposure"
),

"drug_exposure_renamed_casted" AS (
    -- Column Type Casting: 
    -- exposure_end_date: from VARCHAR to DATE
    -- exposure_start_date: from VARCHAR to DATE
    -- verbatim_end_date: from VARCHAR to DATE
    SELECT
        "exposure_id",
        "patient_id",
        "stop_reason",
        "refills",
        "quantity",
        "days_supply",
        "dosing_instructions",
        "lot_number",
        "provider_id",
        "visit_id",
        "drug_name",
        "administration_route",
        "dose_unit",
        CAST("exposure_end_date" AS DATE) AS "exposure_end_date",
        CAST("exposure_start_date" AS DATE) AS "exposure_start_date",
        CAST("verbatim_end_date" AS DATE) AS "verbatim_end_date"
    FROM "drug_exposure_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "drug_exposure_renamed_casted"