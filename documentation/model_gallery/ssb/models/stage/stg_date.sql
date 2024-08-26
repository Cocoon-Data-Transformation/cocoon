-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-26 00:48:59.029137+00:00
WITH 
"date_renamed" AS (
    -- Rename: Renaming columns
    -- D_DATEKEY -> date_key
    -- D_DATE -> full_date
    -- D_DAYOFWEEK -> day_of_week
    -- D_MONTH -> month_name
    -- D_YEAR -> year_
    -- D_YEARMONTHNUM -> year_month_numeric
    -- D_YEARMONTH -> year_month_abbr
    -- D_DAYNUMINWEEK -> day_number_in_week
    -- D_DAYNUMINMONTH -> day_number_in_month
    -- D_DAYNUMINYEAR -> day_number_in_year
    -- D_MONTHNUMINYEAR -> month_number
    -- D_WEEKNUMINYEAR -> week_number
    -- D_SELLINGSEASON -> selling_season
    -- D_LASTDAYINWEEKFL -> is_last_day_of_week
    -- D_LASTDAYINMONTHFL -> is_last_day_of_month
    -- D_HOLIDAYFL -> is_holiday
    -- D_WEEKDAYFL -> is_weekday
    SELECT 
        "D_DATEKEY" AS "date_key",
        "D_DATE" AS "full_date",
        "D_DAYOFWEEK" AS "day_of_week",
        "D_MONTH" AS "month_name",
        "D_YEAR" AS "year_",
        "D_YEARMONTHNUM" AS "year_month_numeric",
        "D_YEARMONTH" AS "year_month_abbr",
        "D_DAYNUMINWEEK" AS "day_number_in_week",
        "D_DAYNUMINMONTH" AS "day_number_in_month",
        "D_DAYNUMINYEAR" AS "day_number_in_year",
        "D_MONTHNUMINYEAR" AS "month_number",
        "D_WEEKNUMINYEAR" AS "week_number",
        "D_SELLINGSEASON" AS "selling_season",
        "D_LASTDAYINWEEKFL" AS "is_last_day_of_week",
        "D_LASTDAYINMONTHFL" AS "is_last_day_of_month",
        "D_HOLIDAYFL" AS "is_holiday",
        "D_WEEKDAYFL" AS "is_weekday"
    FROM "memory"."main"."date"
),

"date_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- month_name: The problem is that there are two misspelled month names in the dataset. 'Augest' is a misspelling of 'August', and 'Octorber' is a misspelling of 'October'. These are typos that need to be corrected to ensure accurate data representation and analysis. The correct values should be the proper spellings of these month names.
    SELECT
        "date_key",
        "full_date",
        "day_of_week",
        CASE
            WHEN "month_name" = 'Augest' THEN 'August'
            WHEN "month_name" = 'Octorber' THEN 'October'
            ELSE "month_name"
        END AS "month_name",
        "year_",
        "year_month_numeric",
        "year_month_abbr",
        "day_number_in_week",
        "day_number_in_month",
        "day_number_in_year",
        "month_number",
        "week_number",
        "selling_season",
        "is_last_day_of_week",
        "is_last_day_of_month",
        "is_holiday",
        "is_weekday"
    FROM "date_renamed"
),

"date_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- date_key: from INT to VARCHAR
    -- full_date: from VARCHAR to DATE
    -- is_holiday: from INT to BOOLEAN
    -- is_last_day_of_month: from INT to BOOLEAN
    -- is_last_day_of_week: from INT to BOOLEAN
    -- is_weekday: from INT to BOOLEAN
    -- year_month_numeric: from INT to VARCHAR
    SELECT
        "day_of_week",
        "month_name",
        "year_",
        "year_month_abbr",
        "day_number_in_week",
        "day_number_in_month",
        "day_number_in_year",
        "month_number",
        "week_number",
        "selling_season",
        CAST("date_key" AS VARCHAR) 
        AS "date_key",
        CASE
            WHEN regexp_full_match("full_date", 'April \d{1,2}, \d{4}') THEN CAST(strptime("full_date", '%B %-d, %Y') AS DATE)
            WHEN regexp_full_match("full_date", 'Augest \d{1,2}, \d{4}') THEN CAST(strptime(replace("full_date", 'Augest', 'August'), '%B %-d, %Y') AS DATE)
            WHEN regexp_full_match("full_date", 'December \d{1,2}, \d{4}') THEN CAST(strptime("full_date", '%B %-d, %Y') AS DATE)
            WHEN regexp_full_match("full_date", '(January|February|March|April|May|June|July|August|September|October|November|December) \d{1,2}, \d{4}') THEN CAST(strptime("full_date", '%B %d, %Y') AS DATE)
            WHEN regexp_full_match("full_date", 'Octorber \d{1,2}, \d{4}') THEN CAST(strptime(replace("full_date", 'Octorber', 'October'), '%B %d, %Y') AS DATE)
        END 
        AS "full_date",
        CAST("is_holiday" AS BOOLEAN) 
        AS "is_holiday",
        CAST("is_last_day_of_month" AS BOOLEAN) 
        AS "is_last_day_of_month",
        CAST("is_last_day_of_week" AS BOOLEAN) 
        AS "is_last_day_of_week",
        CAST("is_weekday" AS BOOLEAN) 
        AS "is_weekday",
        CAST("year_month_numeric" AS VARCHAR) 
        AS "year_month_numeric"
    FROM "date_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "date_renamed_cleaned_casted"