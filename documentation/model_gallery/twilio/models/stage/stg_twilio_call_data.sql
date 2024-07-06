-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:33:05.120257+00:00
WITH 
"twilio_call_data_projected" AS (
    -- Projection: Selecting 24 out of 25 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "account_id",
        "annotation",
        "answered_by",
        "caller_name",
        "created_at",
        "direction",
        "duration",
        "end_time",
        "forwarded_from",
        "from_",
        "from_formatted",
        "group_id",
        "outgoing_caller_id",
        "parent_call_id",
        "price",
        "price_unit",
        "queue_time",
        "start_time",
        "status",
        "to_",
        "to_formatted",
        "trunk_id",
        "updated_at"
    FROM "memory"."main"."twilio_call_data"
),

"twilio_call_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> call_id
    -- annotation -> call_notes
    -- created_at -> record_created_at
    -- direction -> call_direction
    -- duration -> call_duration
    -- end_time -> call_end_time
    -- from_ -> caller_number
    -- from_formatted -> caller_number_formatted
    -- price -> call_price
    -- price_unit -> price_currency
    -- start_time -> call_start_time
    -- status -> call_status
    -- to_ -> recipient_number
    -- to_formatted -> recipient_number_formatted
    -- updated_at -> record_updated_at
    SELECT 
        "id" AS "call_id",
        "account_id",
        "annotation" AS "call_notes",
        "answered_by",
        "caller_name",
        "created_at" AS "record_created_at",
        "direction" AS "call_direction",
        "duration" AS "call_duration",
        "end_time" AS "call_end_time",
        "forwarded_from",
        "from_" AS "caller_number",
        "from_formatted" AS "caller_number_formatted",
        "group_id",
        "outgoing_caller_id",
        "parent_call_id",
        "price" AS "call_price",
        "price_unit" AS "price_currency",
        "queue_time",
        "start_time" AS "call_start_time",
        "status" AS "call_status",
        "to_" AS "recipient_number",
        "to_formatted" AS "recipient_number_formatted",
        "trunk_id",
        "updated_at" AS "record_updated_at"
    FROM "twilio_call_data_projected"
),

"twilio_call_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- record_created_at: The problem is that the date '2022-02-30' is invalid because February never has 30 days. The correct value should be the last day of February in 2022, which is February 28th. All other dates in the list appear to be valid and do not need correction. 
    -- call_end_time: The problem is that '2022-02-30 17:23:13.000000 UTC' contains an invalid date. February 30th does not exist in any year. The most likely explanation is that this is a data entry error, and the intended date was February 28th (the last day of February in non-leap years) or March 2nd (if it was meant to be the last day of February plus 2 days). Since 2022 was not a leap year, the most probable correct date is February 28th. 
    -- call_start_time: The problem is that '2022-02-30 17:23:13.000000 UTC' is an invalid date because February never has 30 days. All other dates in the list appear to be valid. The correct value for this date should be the last day of February in 2022, which is February 28th. 
    -- record_updated_at: The problem is that '2022-02-30 17:23:13.000000 UTC' is an invalid date because February 30th doesn't exist in any calendar year. February can have at most 29 days in a leap year. The correct value should be the last valid day of February 2022, which is February 28th, 2022. All other dates in the list appear to be valid and don't need correction. 
    SELECT
        "call_id",
        "account_id",
        "call_notes",
        "answered_by",
        "caller_name",
        CASE
            WHEN "record_created_at" = '''2022-02-30 17:23:13.000000 UTC''' THEN '''2022-02-28 17:23:13.000000 UTC'''
            ELSE "record_created_at"
        END AS "record_created_at",
        "call_direction",
        "call_duration",
        CASE
            WHEN "call_end_time" = '''2022-02-30 17:23:13.000000 UTC''' THEN '''2022-02-28 17:23:13.000000 UTC'''
            ELSE "call_end_time"
        END AS "call_end_time",
        "forwarded_from",
        "caller_number",
        "caller_number_formatted",
        "group_id",
        "outgoing_caller_id",
        "parent_call_id",
        "call_price",
        "price_currency",
        "queue_time",
        CASE
            WHEN "call_start_time" = '''2022-02-30 17:23:13.000000 UTC''' THEN '''2022-02-28 17:23:13.000000 UTC'''
            ELSE "call_start_time"
        END AS "call_start_time",
        "call_status",
        "recipient_number",
        "recipient_number_formatted",
        "trunk_id",
        CASE
            WHEN "record_updated_at" = '''2022-02-30 17:23:13.000000 UTC''' THEN '''2022-02-28 17:23:13.000000 UTC'''
            ELSE "record_updated_at"
        END AS "record_updated_at"
    FROM "twilio_call_data_projected_renamed"
),

"twilio_call_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- answered_by: from DECIMAL to VARCHAR
    -- call_end_time: from VARCHAR to TIMESTAMP
    -- call_notes: from DECIMAL to VARCHAR
    -- call_start_time: from VARCHAR to TIMESTAMP
    -- caller_name: from DECIMAL to VARCHAR
    -- caller_number: from INT to VARCHAR
    -- forwarded_from: from INT to VARCHAR
    -- group_id: from DECIMAL to VARCHAR
    -- parent_call_id: from DECIMAL to VARCHAR
    -- recipient_number: from INT to VARCHAR
    -- record_created_at: from VARCHAR to TIMESTAMP
    -- record_updated_at: from VARCHAR to TIMESTAMP
    -- trunk_id: from DECIMAL to VARCHAR
    SELECT
        "call_id",
        "account_id",
        "call_direction",
        "call_duration",
        "caller_number_formatted",
        "outgoing_caller_id",
        "call_price",
        "price_currency",
        "queue_time",
        "call_status",
        "recipient_number_formatted",
        CAST("answered_by" AS VARCHAR) AS "answered_by",
        CASE
            WHEN "call_end_time" = '2022-02-30 17:23:13.000000 UTC' THEN 
                strptime('2022-02-28 17:23:13.000000 UTC', '%Y-%m-%d %H:%M:%S.%f UTC')
            ELSE 
                strptime("call_end_time", '%Y-%m-%d %H:%M:%S.%f UTC')
        END AS "call_end_time",
        CAST("call_notes" AS VARCHAR) AS "call_notes",
        CASE
            WHEN "call_start_time" = '2022-02-30 17:23:13.000000 UTC' THEN CAST('2022-02-28 17:23:13.000000 UTC' AS TIMESTAMP)
            ELSE CAST("call_start_time" AS TIMESTAMP)
        END AS "call_start_time",
        CAST("caller_name" AS VARCHAR) AS "caller_name",
        CAST("caller_number" AS VARCHAR) AS "caller_number",
        CAST("forwarded_from" AS VARCHAR) AS "forwarded_from",
        CAST("group_id" AS VARCHAR) AS "group_id",
        CAST("parent_call_id" AS VARCHAR) AS "parent_call_id",
        CAST("recipient_number" AS VARCHAR) AS "recipient_number",
        CASE
            WHEN TRY_CAST("record_created_at" AS TIMESTAMP) IS NOT NULL
            THEN CAST("record_created_at" AS TIMESTAMP)
            ELSE strptime(replace("record_created_at", '2022-02-30', '2022-02-28'), '%Y-%m-%d %H:%M:%S.%f UTC')
        END AS "record_created_at",
        CASE
            WHEN SUBSTRING("record_updated_at", 1, 10) = '2022-02-30'
            THEN CAST(REPLACE("record_updated_at", '2022-02-30', '2022-02-28') AS TIMESTAMP)
            ELSE CAST("record_updated_at" AS TIMESTAMP)
        END AS "record_updated_at",
        CAST("trunk_id" AS VARCHAR) AS "trunk_id"
    FROM "twilio_call_data_projected_renamed_cleaned"
),

"twilio_call_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 6 columns with unacceptable missing values
    -- call_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- call_price has 22.22 percent missing. Strategy: 🔄 Unchanged
    -- caller_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- parent_call_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- trunk_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "call_id",
        "account_id",
        "call_direction",
        "call_duration",
        "caller_number_formatted",
        "outgoing_caller_id",
        "call_price",
        "price_currency",
        "queue_time",
        "call_status",
        "recipient_number_formatted",
        "answered_by",
        "call_end_time",
        "call_start_time",
        "caller_number",
        "forwarded_from",
        "recipient_number",
        "record_created_at",
        "record_updated_at"
    FROM "twilio_call_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_call_data_projected_renamed_cleaned_casted_missing_handled"