-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"condition_occurrence_renamed" AS (
    -- Rename: Renaming columns
    -- condition_source_value -> condition_name
    -- condition_status_source_value -> condition_status
    SELECT 
        "condition_occurrence_id",
        "person_id",
        "condition_start_date",
        "condition_start_datetime",
        "condition_end_date",
        "condition_end_datetime",
        "stop_reason",
        "provider_id",
        "visit_occurrence_id",
        "visit_detail_id",
        "condition_source_value" AS "condition_name",
        "condition_status_source_value" AS "condition_status"
    FROM "condition_occurrence"
),

"condition_occurrence_renamed_casted" AS (
    -- Column Type Casting: 
    -- condition_end_date: from VARCHAR to DATE
    -- condition_end_datetime: from VARCHAR to TIMESTAMP
    -- condition_start_date: from VARCHAR to DATE
    -- condition_start_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "condition_occurrence_id",
        "person_id",
        "stop_reason",
        "provider_id",
        "visit_occurrence_id",
        "visit_detail_id",
        "condition_name",
        "condition_status",
        CAST("condition_end_date" AS DATE) AS "condition_end_date",
        CAST("condition_end_datetime" AS TIMESTAMP) AS "condition_end_datetime",
        CAST("condition_start_date" AS DATE) AS "condition_start_date",
        CAST("condition_start_datetime" AS TIMESTAMP) AS "condition_start_datetime"
    FROM "condition_occurrence_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "condition_occurrence_renamed_casted"