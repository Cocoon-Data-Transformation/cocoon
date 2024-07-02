-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completedtrans_renamed" AS (
    -- Rename: Renaming columns
    -- column_a -> row_number
    -- trans_id -> transaction_id
    -- type -> transaction_type
    -- operation -> transaction_description
    -- amount -> transaction_amount
    -- k_symbol -> transaction_category
    -- bank -> bank_name
    -- account -> account_holder
    -- day_ -> day_of_month
    -- date_ -> transaction_date
    -- fulldate -> full_date
    -- fulltime -> transaction_time
    -- fulldatewithtime -> transaction_datetime
    SELECT 
        "column_a" AS "row_number",
        "trans_id" AS "transaction_id",
        "account_id",
        "type" AS "transaction_type",
        "operation" AS "transaction_description",
        "amount" AS "transaction_amount",
        "balance",
        "k_symbol" AS "transaction_category",
        "bank" AS "bank_name",
        "account" AS "account_holder",
        "year_",
        "month_",
        "day_" AS "day_of_month",
        "date_" AS "transaction_date",
        "fulldate" AS "full_date",
        "fulltime" AS "transaction_time",
        "fulldatewithtime" AS "transaction_datetime"
    FROM "completedtrans"
),

"completedtrans_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "row_number",
        "transaction_id",
        "account_id",
        "transaction_type",
        "transaction_description",
        "transaction_amount",
        "balance",
        "bank_name",
        "account_holder",
        "year_",
        "month_",
        "day_of_month",
        "transaction_date",
        "full_date",
        "transaction_time",
        "transaction_datetime",
        TRIM("transaction_category") AS "transaction_category"
    FROM "completedtrans_renamed"
),

"completedtrans_renamed_trimmed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- transaction_category: ['']
    SELECT 
        CASE
            WHEN "transaction_category" = '' THEN NULL
            ELSE "transaction_category"
        END AS "transaction_category",
        "account_holder",
        "balance",
        "transaction_time",
        "year_",
        "transaction_amount",
        "transaction_date",
        "transaction_description",
        "account_id",
        "transaction_id",
        "bank_name",
        "day_of_month",
        "month_",
        "row_number",
        "full_date",
        "transaction_type",
        "transaction_datetime"
    FROM "completedtrans_renamed_trimmed"
),

"completedtrans_renamed_trimmed_null_casted" AS (
    -- Column Type Casting: 
    -- account_holder: from FLOAT to VARCHAR
    -- full_date: from VARCHAR to DATE
    -- transaction_date: from VARCHAR to DATE
    -- transaction_datetime: from VARCHAR to TIMESTAMP
    -- transaction_time: from VARCHAR to TIME
    SELECT
        "transaction_category",
        "balance",
        "year_",
        "transaction_amount",
        "transaction_description",
        "account_id",
        "transaction_id",
        "bank_name",
        "day_of_month",
        "month_",
        "row_number",
        "transaction_type",
        CAST("account_holder" AS VARCHAR) AS "account_holder",
        CAST("full_date" AS DATE) AS "full_date",
        CAST("transaction_date" AS DATE) AS "transaction_date",
        TRY_TO_TIMESTAMP("transaction_datetime", 'YYYY-MM-DDTHH24:MI:SS') AS "transaction_datetime",
        CASE
            WHEN REGEXP_LIKE("transaction_time", '([01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d') THEN CAST("transaction_time" AS TIME)
            WHEN REGEXP_LIKE("transaction_time", '\\d{2}:\\d{2}:\\d{2}') THEN TO_TIME(
            CASE
                WHEN SPLIT_PART("transaction_time", ':', 1)::INT > 23 THEN '23'
                ELSE LPAD(SPLIT_PART("transaction_time", ':', 1), 2, '0')
            END || ':' ||
            CASE
                WHEN SPLIT_PART("transaction_time", ':', 2)::INT > 59 THEN '59'
                ELSE LPAD(SPLIT_PART("transaction_time", ':', 2), 2, '0')
            END || ':' ||
            CASE
                WHEN SPLIT_PART("transaction_time", ':', 3)::INT > 59 THEN '59'
                ELSE LPAD(SPLIT_PART("transaction_time", ':', 3), 2, '0')
            END
        )
            ELSE "transaction_time"
        END AS "transaction_time"
    FROM "completedtrans_renamed_trimmed_null"
)

-- COCOON BLOCK END
SELECT * FROM "completedtrans_renamed_trimmed_null_casted"