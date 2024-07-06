-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:42:59.416057+00:00
WITH 
"twilio_usage_record_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "account_id",
        "category",
        "end_date",
        "start_date",
        "as_of",
        "count_",
        "count_unit",
        "description",
        "price",
        "price_unit",
        "usage_",
        "usage_unit"
    FROM "memory"."main"."twilio_usage_record_data"
),

"twilio_usage_record_data_projected_casted" AS (
    -- Column Type Casting: 
    -- as_of: from VARCHAR to TIMESTAMP
    -- end_date: from VARCHAR to DATE
    -- start_date: from VARCHAR to DATE
    SELECT
        "account_id",
        "category",
        "count_",
        "count_unit",
        "description",
        "price",
        "price_unit",
        "usage_",
        "usage_unit",
        CAST("as_of" AS TIMESTAMP) AS "as_of",
        CAST("end_date" AS DATE) AS "end_date",
        CAST("start_date" AS DATE) AS "start_date"
    FROM "twilio_usage_record_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_usage_record_data_projected_casted"