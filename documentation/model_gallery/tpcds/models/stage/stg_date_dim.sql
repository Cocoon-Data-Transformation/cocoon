-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"date_dim_renamed" AS (
    -- Rename: Renaming columns
    -- D_DATE_SK -> date_sk
    -- D_DATE_ID -> date_id
    -- D_MONTH_SEQ -> month_seq
    -- D_WEEK_SEQ -> week_seq
    -- D_QUARTER_SEQ -> quarter_seq
    -- D_DOW -> day_of_week
    -- D_MOY -> month_of_year
    -- D_DOM -> day_of_month
    -- D_QOY -> quarter_of_year
    -- D_FY_YEAR -> fiscal_year
    -- D_FY_QUARTER_SEQ -> fiscal_quarter_seq
    -- D_FY_WEEK_SEQ -> fiscal_week_seq
    -- D_DAY_NAME -> day_name
    -- D_QUARTER_NAME -> quarter_name
    -- D_HOLIDAY -> is_holiday
    -- D_WEEKEND -> is_weekend
    -- D_FOLLOWING_HOLIDAY -> is_following_holiday
    -- D_FIRST_DOM -> first_day_of_month
    -- D_LAST_DOM -> last_day_of_month
    -- D_SAME_DAY_LY -> same_day_last_year
    -- D_SAME_DAY_LQ -> same_day_last_quarter
    -- D_CURRENT_DAY -> is_current_day
    -- D_CURRENT_WEEK -> is_current_week
    -- D_CURRENT_MONTH -> is_current_month
    -- D_CURRENT_QUARTER -> is_current_quarter
    -- D_CURRENT_YEAR -> is_current_year
    SELECT 
        "D_DATE_SK" AS "date_sk",
        "D_DATE_ID" AS "date_id",
        "D_DATE",
        "D_MONTH_SEQ" AS "month_seq",
        "D_WEEK_SEQ" AS "week_seq",
        "D_QUARTER_SEQ" AS "quarter_seq",
        "D_YEAR",
        "D_DOW" AS "day_of_week",
        "D_MOY" AS "month_of_year",
        "D_DOM" AS "day_of_month",
        "D_QOY" AS "quarter_of_year",
        "D_FY_YEAR" AS "fiscal_year",
        "D_FY_QUARTER_SEQ" AS "fiscal_quarter_seq",
        "D_FY_WEEK_SEQ" AS "fiscal_week_seq",
        "D_DAY_NAME" AS "day_name",
        "D_QUARTER_NAME" AS "quarter_name",
        "D_HOLIDAY" AS "is_holiday",
        "D_WEEKEND" AS "is_weekend",
        "D_FOLLOWING_HOLIDAY" AS "is_following_holiday",
        "D_FIRST_DOM" AS "first_day_of_month",
        "D_LAST_DOM" AS "last_day_of_month",
        "D_SAME_DAY_LY" AS "same_day_last_year",
        "D_SAME_DAY_LQ" AS "same_day_last_quarter",
        "D_CURRENT_DAY" AS "is_current_day",
        "D_CURRENT_WEEK" AS "is_current_week",
        "D_CURRENT_MONTH" AS "is_current_month",
        "D_CURRENT_QUARTER" AS "is_current_quarter",
        "D_CURRENT_YEAR" AS "is_current_year"
    FROM "date_dim"
),

"date_dim_renamed_casted" AS (
    -- Column Type Casting: 
    -- D_DATE: from VARCHAR to DATE
    -- is_current_day: from VARCHAR to BOOLEAN
    -- is_current_month: from VARCHAR to BOOLEAN
    -- is_current_quarter: from VARCHAR to BOOLEAN
    -- is_current_week: from VARCHAR to BOOLEAN
    -- is_current_year: from VARCHAR to BOOLEAN
    -- is_following_holiday: from VARCHAR to BOOLEAN
    -- is_holiday: from VARCHAR to BOOLEAN
    -- is_weekend: from VARCHAR to BOOLEAN
    SELECT
        "date_sk",
        "date_id",
        "month_seq",
        "week_seq",
        "quarter_seq",
        "D_YEAR",
        "day_of_week",
        "month_of_year",
        "day_of_month",
        "quarter_of_year",
        "fiscal_year",
        "fiscal_quarter_seq",
        "fiscal_week_seq",
        "day_name",
        "quarter_name",
        "first_day_of_month",
        "last_day_of_month",
        "same_day_last_year",
        "same_day_last_quarter",
        CAST("D_DATE" AS DATE) AS "D_DATE",
        CASE WHEN "is_current_day" = 'N' THEN FALSE ELSE TRUE END AS "is_current_day",
        CAST(CASE WHEN "is_current_month" = 'N' THEN FALSE ELSE TRUE END AS BOOLEAN) AS "is_current_month",
        CASE WHEN "is_current_quarter" = 'N' THEN FALSE ELSE TRUE END AS "is_current_quarter",
        CASE WHEN "is_current_week" = 'N' THEN FALSE ELSE TRUE END AS "is_current_week",
        CASE WHEN "is_current_year" = 'N' THEN FALSE ELSE TRUE END AS "is_current_year",
        CAST(CASE WHEN "is_following_holiday" = 'Y' THEN true WHEN "is_following_holiday" = 'N' THEN false END AS BOOLEAN) AS "is_following_holiday",
        CASE WHEN "is_holiday" = 'N' THEN FALSE ELSE TRUE END AS "is_holiday",
        CASE 
            WHEN "is_weekend" = 'Y' THEN TRUE
            WHEN "is_weekend" = 'N' THEN FALSE
            ELSE NULL
        END AS "is_weekend"
    FROM "date_dim_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "date_dim_renamed_casted"