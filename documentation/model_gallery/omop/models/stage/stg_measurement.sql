-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"measurement_renamed" AS (
    -- Rename: Renaming columns
    -- value_as_number -> measurement_value
    -- visit_occurrence_id -> visit_id
    -- measurement_source_value -> measurement_type
    -- unit_source_value -> measurement_unit
    -- value_source_value -> original_measurement_value
    SELECT 
        "measurement_id",
        "person_id",
        "measurement_date",
        "measurement_datetime",
        "value_as_number" AS "measurement_value",
        "provider_id",
        "visit_occurrence_id" AS "visit_id",
        "measurement_source_value" AS "measurement_type",
        "unit_source_value" AS "measurement_unit",
        "value_source_value" AS "original_measurement_value"
    FROM "measurement"
),

"measurement_renamed_casted" AS (
    -- Column Type Casting: 
    -- measurement_date: from VARCHAR to DATE
    -- measurement_datetime: from VARCHAR to TIMESTAMP
    -- measurement_id: from INT to VARCHAR
    -- original_measurement_value: from INT to VARCHAR
    -- person_id: from INT to VARCHAR
    -- provider_id: from INT to VARCHAR
    -- visit_id: from INT to VARCHAR
    SELECT
        "measurement_value",
        "measurement_type",
        "measurement_unit",
        CAST("measurement_date" AS DATE) AS "measurement_date",
        CAST("measurement_datetime" AS TIMESTAMP) AS "measurement_datetime",
        CAST("measurement_id" AS VARCHAR) AS "measurement_id",
        CAST("original_measurement_value" AS VARCHAR) AS "original_measurement_value",
        CAST("person_id" AS VARCHAR) AS "person_id",
        CAST("provider_id" AS VARCHAR) AS "provider_id",
        CAST("visit_id" AS VARCHAR) AS "visit_id"
    FROM "measurement_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "measurement_renamed_casted"