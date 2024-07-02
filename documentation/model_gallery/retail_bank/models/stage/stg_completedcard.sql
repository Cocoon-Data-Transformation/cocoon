-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completedcard_renamed" AS (
    -- Rename: Renaming columns
    -- disp_id -> display_id
    -- type -> card_type
    -- year_ -> transaction_year
    -- month_ -> transaction_month
    -- day_ -> transaction_day
    -- date_ -> transaction_date
    -- fulldate -> remove_column
    SELECT 
        "card_id",
        "disp_id" AS "display_id",
        "type" AS "card_type",
        "year_" AS "transaction_year",
        "month_" AS "transaction_month",
        "day_" AS "transaction_day",
        "date_" AS "transaction_date",
        "fulldate" AS "remove_column"
    FROM "completedcard"
),

"completedcard_renamed_casted" AS (
    -- Column Type Casting: 
    -- remove_column: from VARCHAR to DATE
    -- transaction_date: from VARCHAR to DATE
    SELECT
        "card_id",
        "display_id",
        "card_type",
        "transaction_year",
        "transaction_month",
        "transaction_day",
        CAST("remove_column" AS DATE) AS "remove_column",
        CAST("transaction_date" AS DATE) AS "transaction_date"
    FROM "completedcard_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "completedcard_renamed_casted"