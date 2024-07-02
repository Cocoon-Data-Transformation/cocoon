-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completedclient_renamed" AS (
    -- Rename: Renaming columns
    -- sex -> gender
    -- fulldate -> full_birth_date
    -- day_ -> birth_day
    -- month_ -> birth_month
    -- year_ -> birth_year
    -- date_ -> birth_date
    -- social -> ssn
    -- first_ -> first_name
    -- middle -> middle_name
    -- last_ -> last_name
    -- phone -> phone_number
    -- address_1 -> street_address
    -- address_2 -> address_line_2
    -- zipcode -> zip_code
    SELECT 
        "client_id",
        "sex" AS "gender",
        "fulldate" AS "full_birth_date",
        "day_" AS "birth_day",
        "month_" AS "birth_month",
        "year_" AS "birth_year",
        "date_" AS "birth_date",
        "age",
        "social" AS "ssn",
        "first_" AS "first_name",
        "middle" AS "middle_name",
        "last_" AS "last_name",
        "phone" AS "phone_number",
        "email",
        "address_1" AS "street_address",
        "address_2" AS "address_line_2",
        "city",
        "state",
        "zipcode" AS "zip_code",
        "district_id"
    FROM "completedclient"
),

"completedclient_renamed_casted" AS (
    -- Column Type Casting: 
    -- birth_date: from VARCHAR to DATE
    -- full_birth_date: from VARCHAR to DATE
    -- zip_code: from INT to VARCHAR
    SELECT
        "client_id",
        "gender",
        "birth_day",
        "birth_month",
        "birth_year",
        "age",
        "ssn",
        "first_name",
        "middle_name",
        "last_name",
        "phone_number",
        "email",
        "street_address",
        "address_line_2",
        "city",
        "state",
        "district_id",
        CAST("birth_date" AS DATE) AS "birth_date",
        CAST("full_birth_date" AS DATE) AS "full_birth_date",
        CAST("zip_code" AS VARCHAR) AS "zip_code"
    FROM "completedclient_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "completedclient_renamed_casted"