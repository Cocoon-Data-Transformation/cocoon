-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completedacct_renamed" AS (
    -- Rename: Renaming columns
    -- frequency -> transaction_frequency
    -- parseddate -> parsed_date
    -- month_ -> month_number
    -- day_ -> day_of_month
    -- date_ -> transaction_date
    SELECT 
        "account_id",
        "district_id",
        "frequency" AS "transaction_frequency",
        "parseddate" AS "parsed_date",
        "year_",
        "month_" AS "month_number",
        "day_" AS "day_of_month",
        "date_" AS "transaction_date"
    FROM "completedacct"
),

"completedacct_renamed_casted" AS (
    -- Column Type Casting: 
    -- parsed_date: from VARCHAR to DATE
    -- transaction_date: from VARCHAR to DATE
    SELECT
        "account_id",
        "district_id",
        "transaction_frequency",
        "year_",
        "month_number",
        "day_of_month",
        CAST("parsed_date" AS DATE) AS "parsed_date",
        CAST("transaction_date" AS DATE) AS "transaction_date"
    FROM "completedacct_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "completedacct_renamed_casted"