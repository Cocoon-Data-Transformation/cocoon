-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"customer_renamed" AS (
    -- Rename: Renaming columns
    -- C_CUSTOMER_SK -> customer_key
    -- C_CUSTOMER_ID -> customer_id
    -- C_CURRENT_CDEMO_SK -> current_demographics_key
    -- C_CURRENT_HDEMO_SK -> current_household_key
    -- C_CURRENT_ADDR_SK -> current_address_key
    -- C_FIRST_SHIPTO_DATE_SK -> first_shipment_date_key
    -- C_FIRST_SALES_DATE_SK -> first_sale_date_key
    -- C_SALUTATION -> salutation
    -- C_FIRST_NAME -> first_name
    -- C_LAST_NAME -> last_name
    -- C_PREFERRED_CUST_FLAG -> is_preferred_customer
    -- C_BIRTH_DAY -> birth_day
    -- C_BIRTH_MONTH -> birth_month
    -- C_BIRTH_YEAR -> birth_year
    -- C_BIRTH_COUNTRY -> birth_country
    -- C_LOGIN -> login
    -- C_EMAIL_ADDRESS -> email_address
    -- C_LAST_REVIEW_DATE_SK -> last_review_date_key
    SELECT 
        "C_CUSTOMER_SK" AS "customer_key",
        "C_CUSTOMER_ID" AS "customer_id",
        "C_CURRENT_CDEMO_SK" AS "current_demographics_key",
        "C_CURRENT_HDEMO_SK" AS "current_household_key",
        "C_CURRENT_ADDR_SK" AS "current_address_key",
        "C_FIRST_SHIPTO_DATE_SK" AS "first_shipment_date_key",
        "C_FIRST_SALES_DATE_SK" AS "first_sale_date_key",
        "C_SALUTATION" AS "salutation",
        "C_FIRST_NAME" AS "first_name",
        "C_LAST_NAME" AS "last_name",
        "C_PREFERRED_CUST_FLAG" AS "is_preferred_customer",
        "C_BIRTH_DAY" AS "birth_day",
        "C_BIRTH_MONTH" AS "birth_month",
        "C_BIRTH_YEAR" AS "birth_year",
        "C_BIRTH_COUNTRY" AS "birth_country",
        "C_LOGIN" AS "login",
        "C_EMAIL_ADDRESS" AS "email_address",
        "C_LAST_REVIEW_DATE_SK" AS "last_review_date_key"
    FROM "customer"
),

"customer_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- birth_country: The main problems are inconsistent country naming conventions and unusual apostrophes. The correct values should use standard English country names without special characters. "CÔTE D'IVOIRE" should be "IVORY COAST", and "KOREA, REPUBLIC OF" should be "SOUTH KOREA" to align with common naming conventions. Other country names are generally acceptable but could be standardized for consistency (e.g., removing "REPUBLIC OF" from names). 
    SELECT
        "customer_key",
        "customer_id",
        "current_demographics_key",
        "current_household_key",
        "current_address_key",
        "first_shipment_date_key",
        "first_sale_date_key",
        "salutation",
        "first_name",
        "last_name",
        "is_preferred_customer",
        "birth_day",
        "birth_month",
        "birth_year",
        CASE
            WHEN "birth_country" = 'CÔTE D''IVOIRE' THEN 'IVORY COAST'
            WHEN "birth_country" = 'KOREA, REPUBLIC OF' THEN 'SOUTH KOREA'
            WHEN "birth_country" = 'BRUNEI DARUSSALAM' THEN 'BRUNEI'
            WHEN "birth_country" = 'MOLDOVA, REPUBLIC OF' THEN 'MOLDOVA'
            WHEN "birth_country" = 'VIRGIN ISLANDS, U.S.' THEN 'US VIRGIN ISLANDS'
            WHEN "birth_country" = 'RUSSIAN FEDERATION' THEN 'RUSSIA'
            ELSE "birth_country"
        END AS "birth_country",
        "login",
        "email_address",
        "last_review_date_key"
    FROM "customer_renamed"
),

"customer_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- birth_day: from DECIMAL to INT
    -- birth_month: from DECIMAL to INT
    -- birth_year: from DECIMAL to INT
    -- current_demographics_key: from DECIMAL to INT
    -- current_household_key: from DECIMAL to INT
    -- first_sale_date_key: from DECIMAL to INT
    -- first_shipment_date_key: from DECIMAL to INT
    -- is_preferred_customer: from VARCHAR to BOOLEAN
    -- last_review_date_key: from DECIMAL to INT
    -- login: from DECIMAL to VARCHAR
    SELECT
        "customer_key",
        "customer_id",
        "current_address_key",
        "salutation",
        "first_name",
        "last_name",
        "birth_country",
        "email_address",
        CAST("birth_day" AS INT) AS "birth_day",
        CAST("birth_month" AS INT) AS "birth_month",
        CAST("birth_year" AS INT) AS "birth_year",
        CAST("current_demographics_key" AS INT) AS "current_demographics_key",
        CAST("current_household_key" AS INT) AS "current_household_key",
        CAST("first_sale_date_key" AS INT) AS "first_sale_date_key",
        CAST("first_shipment_date_key" AS INT) AS "first_shipment_date_key",
        CAST(CASE WHEN "is_preferred_customer" = 'Y' THEN TRUE WHEN "is_preferred_customer" = 'N' THEN FALSE ELSE NULL END AS BOOLEAN) AS "is_preferred_customer",
        CAST("last_review_date_key" AS INT) AS "last_review_date_key",
        CAST("login" AS VARCHAR) AS "login"
    FROM "customer_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "customer_renamed_cleaned_casted"