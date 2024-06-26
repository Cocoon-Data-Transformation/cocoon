-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"visit_occurrence_renamed" AS (
    -- Rename: Renaming columns
    -- visit_occurrence_id -> visit_id
    -- person_id -> patient_id
    -- visit_source_value -> visit_source_id
    -- admitting_source_value -> admission_source
    -- discharge_to_source_value -> discharge_destination
    -- preceding_visit_occurrence_id -> previous_visit_id
    SELECT 
        "visit_occurrence_id" AS "visit_id",
        "person_id" AS "patient_id",
        "visit_start_date",
        "visit_start_datetime",
        "visit_end_date",
        "visit_end_datetime",
        "provider_id",
        "care_site_id",
        "visit_source_value" AS "visit_source_id",
        "admitting_source_value" AS "admission_source",
        "discharge_to_source_value" AS "discharge_destination",
        "preceding_visit_occurrence_id" AS "previous_visit_id"
    FROM "visit_occurrence"
),

"visit_occurrence_renamed_casted" AS (
    -- Column Type Casting: 
    -- visit_end_date: from VARCHAR to DATE
    -- visit_end_datetime: from VARCHAR to TIMESTAMP
    -- visit_start_date: from VARCHAR to DATE
    -- visit_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "visit_id",
        "patient_id",
        "provider_id",
        "care_site_id",
        "visit_source_id",
        "admission_source",
        "discharge_destination",
        "previous_visit_id",
        CAST("visit_end_date" AS DATE) AS "visit_end_date",
        CAST("visit_end_datetime" AS TIMESTAMP) AS "visit_end_datetime",
        CAST("visit_start_date" AS DATE) AS "visit_start_date",
        CAST("visit_start_datetime" AS TIMESTAMP) AS "visit_start_datetime"
    FROM "visit_occurrence_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "visit_occurrence_renamed_casted"