-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-02 01:12:28.154591+00:00
WITH 
"procedure_occurrence_casted" AS (
    -- Column Type Casting: 
    -- procedure_date: from VARCHAR to DATE
    -- procedure_datetime: from VARCHAR to TIMESTAMP
    -- qualifier_source_value: from DECIMAL to VARCHAR
    SELECT
        "procedure_occurrence_id",
        "person_id",
        "quantity",
        "provider_id",
        "visit_occurrence_id",
        "visit_detail_id",
        "procedure_source_value",
        "procedure_cost",
        CAST("procedure_date" AS DATE) 
        AS "procedure_date",
        CAST("procedure_datetime" AS TIMESTAMP) 
        AS "procedure_datetime",
        CAST("qualifier_source_value" AS VARCHAR) 
        AS "qualifier_source_value"
    FROM "memory"."main"."procedure_occurrence"
)

-- COCOON BLOCK END
SELECT *
FROM "procedure_occurrence_casted"