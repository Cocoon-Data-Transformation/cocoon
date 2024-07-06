-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"CRM_Call_Center_Logs_renamed" AS (
    -- Rename: Renaming columns
    -- date_received -> call_date
    -- rand_client -> client_id
    -- phonefinal -> caller_phone_number
    -- priority -> call_priority
    -- type -> call_type
    -- outcome -> call_outcome
    -- server -> agent_name
    -- ser_start -> service_start_time
    -- ser_exit -> service_end_time
    -- ser_time -> service_duration
    SELECT 
        "date_received" AS "call_date",
        "complaint_id",
        "rand_client" AS "client_id",
        "phonefinal" AS "caller_phone_number",
        "vru_line",
        "call_id",
        "priority" AS "call_priority",
        "type" AS "call_type",
        "outcome" AS "call_outcome",
        "server" AS "agent_name",
        "ser_start" AS "service_start_time",
        "ser_exit" AS "service_end_time",
        "ser_time" AS "service_duration"
    FROM "CRM_Call_Center_Logs"
),

"CRM_Call_Center_Logs_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- call_outcome: The problem is that 'AGENT' being the only value in the call_outcome column is unusual and likely incorrect. Call outcomes typically have multiple possibilities such as 'Answered', 'Voicemail', 'Busy', 'No Answer', etc. The 'AGENT' value seems to be a placeholder or default value that was incorrectly used for all entries. Without more context or data about the actual outcomes of the calls, it's not possible to map this to correct values. The most appropriate action would be to mark this data as unknown or missing. 
    -- agent_name: The problem is that 'NO_SERVER' is an unusual value in a column of personal names. It appears to be a system-related value rather than a person's name. All other values follow the pattern of being personal names, either first names or surnames. The correct values should all be personal names, and 'NO_SERVER' should be handled differently as it likely indicates a missing or unavailable agent. 
    SELECT
        "call_date",
        "complaint_id",
        "client_id",
        "caller_phone_number",
        "vru_line",
        "call_id",
        "call_priority",
        "call_type",
        CASE
            WHEN "call_outcome" = 'AGENT' THEN NULL
            ELSE "call_outcome"
        END AS "call_outcome",
        CASE
            WHEN "agent_name" = 'NO_SERVER' THEN NULL
            ELSE "agent_name"
        END AS "agent_name",
        "service_start_time",
        "service_end_time",
        "service_duration"
    FROM "CRM_Call_Center_Logs_renamed"
),

"CRM_Call_Center_Logs_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- call_date: from VARCHAR to DATE
    -- service_duration: from VARCHAR to TIME
    -- service_end_time: from VARCHAR to TIME
    -- service_start_time: from VARCHAR to TIME
    SELECT
        "complaint_id",
        "client_id",
        "caller_phone_number",
        "vru_line",
        "call_id",
        "call_priority",
        "call_type",
        "call_outcome",
        "agent_name",
        CAST("call_date" AS DATE) AS "call_date",
        CAST("service_duration" AS TIME) AS "service_duration",
        CAST("service_end_time" AS TIME) AS "service_end_time",
        CAST("service_start_time" AS TIME) AS "service_start_time"
    FROM "CRM_Call_Center_Logs_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "CRM_Call_Center_Logs_renamed_cleaned_casted"