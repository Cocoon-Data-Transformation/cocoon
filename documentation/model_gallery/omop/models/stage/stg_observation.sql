-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"observation_renamed" AS (
    -- Rename: Renaming columns
    -- person_id -> patient_id
    -- value_as_number -> numeric_value
    -- value_as_string -> result_description
    -- visit_occurrence_id -> visit_id
    -- observation_source_value -> observation_type
    -- unit_source_value -> measurement_unit
    -- qualifier_source_value -> observation_context
    SELECT 
        "observation_id",
        "person_id" AS "patient_id",
        "observation_date",
        "observation_datetime",
        "value_as_number" AS "numeric_value",
        "value_as_string" AS "result_description",
        "provider_id",
        "visit_occurrence_id" AS "visit_id",
        "observation_source_value" AS "observation_type",
        "unit_source_value" AS "measurement_unit",
        "qualifier_source_value" AS "observation_context"
    FROM "observation"
),

"observation_renamed_casted" AS (
    -- Column Type Casting: 
    -- observation_date: from VARCHAR to DATE
    -- observation_datetime: from VARCHAR to TIMESTAMP
    -- observation_id: from INT to VARCHAR
    -- patient_id: from INT to VARCHAR
    -- provider_id: from INT to VARCHAR
    -- visit_id: from INT to VARCHAR
    SELECT
        "numeric_value",
        "result_description",
        "observation_type",
        "measurement_unit",
        "observation_context",
        CAST("observation_date" AS DATE) AS "observation_date",
        CAST("observation_datetime" AS TIMESTAMP) AS "observation_datetime",
        CAST("observation_id" AS VARCHAR) AS "observation_id",
        CAST("patient_id" AS VARCHAR) AS "patient_id",
        CAST("provider_id" AS VARCHAR) AS "provider_id",
        CAST("visit_id" AS VARCHAR) AS "visit_id"
    FROM "observation_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "observation_renamed_casted"