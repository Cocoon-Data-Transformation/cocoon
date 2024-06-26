-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"procedure_occurrence_renamed" AS (
    -- Rename: Renaming columns
    -- quantity -> procedure_quantity
    -- procedure_source_value -> procedure_code
    -- qualifier_source_value -> procedure_qualifier
    SELECT 
        "procedure_occurrence_id",
        "person_id",
        "procedure_date",
        "procedure_datetime",
        "quantity" AS "procedure_quantity",
        "provider_id",
        "visit_occurrence_id",
        "visit_detail_id",
        "procedure_source_value" AS "procedure_code",
        "qualifier_source_value" AS "procedure_qualifier",
        "procedure_cost"
    FROM "procedure_occurrence"
),

"procedure_occurrence_renamed_casted" AS (
    -- Column Type Casting: 
    -- procedure_date: from VARCHAR to DATE
    -- procedure_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "procedure_occurrence_id",
        "person_id",
        "procedure_quantity",
        "provider_id",
        "visit_occurrence_id",
        "visit_detail_id",
        "procedure_code",
        "procedure_qualifier",
        "procedure_cost",
        CAST("procedure_date" AS DATE) AS "procedure_date",
        CAST("procedure_datetime" AS TIMESTAMP) AS "procedure_datetime"
    FROM "procedure_occurrence_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "procedure_occurrence_renamed_casted"