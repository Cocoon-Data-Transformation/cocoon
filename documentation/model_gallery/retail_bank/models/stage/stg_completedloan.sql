-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completedloan_renamed" AS (
    -- Rename: Renaming columns
    -- amount -> loan_amount
    -- duration -> loan_term_months
    -- payments -> monthly_payment
    -- status -> loan_status
    -- year_ -> start_year
    -- month_ -> start_month
    -- day_ -> start_day
    -- date_ -> loan_start_date
    -- fulldate -> loan_start_fulldate
    -- location -> location_code
    -- purpose -> loan_purpose
    SELECT 
        "loan_id",
        "account_id",
        "amount" AS "loan_amount",
        "duration" AS "loan_term_months",
        "payments" AS "monthly_payment",
        "status" AS "loan_status",
        "year_" AS "start_year",
        "month_" AS "start_month",
        "day_" AS "start_day",
        "date_" AS "loan_start_date",
        "fulldate" AS "loan_start_fulldate",
        "location" AS "location_code",
        "purpose" AS "loan_purpose"
    FROM "completedloan"
),

"completedloan_renamed_casted" AS (
    -- Column Type Casting: 
    -- loan_start_date: from VARCHAR to DATE
    -- loan_start_fulldate: from VARCHAR to DATE
    SELECT
        "loan_id",
        "account_id",
        "loan_amount",
        "loan_term_months",
        "monthly_payment",
        "loan_status",
        "start_year",
        "start_month",
        "start_day",
        "location_code",
        "loan_purpose",
        CAST("loan_start_date" AS DATE) AS "loan_start_date",
        CAST("loan_start_fulldate" AS DATE) AS "loan_start_fulldate"
    FROM "completedloan_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "completedloan_renamed_casted"