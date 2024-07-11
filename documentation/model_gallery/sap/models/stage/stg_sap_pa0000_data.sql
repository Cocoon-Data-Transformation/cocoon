-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 05:10:27.159864+00:00
WITH 
"sap_pa0000_data_projected" AS (
    -- Projection: Selecting 30 out of 31 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "begda",
        "endda",
        "mandt",
        "objps",
        "pernr",
        "seqnr",
        "sprps",
        "subty",
        "aedtm",
        "uname",
        "histo",
        "itxex",
        "refex",
        "ordex",
        "itbld",
        "preas",
        "flag1",
        "flag2",
        "flag3",
        "flag4",
        "rese1",
        "rese2",
        "grpvl",
        "massn",
        "massg",
        "stat1",
        "stat2",
        "stat3",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_pa0000_data"
),

"sap_pa0000_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- begda -> start_date
    -- endda -> end_date
    -- mandt -> client_code
    -- objps -> object_spec
    -- pernr -> employee_id
    -- seqnr -> sequence_number
    -- sprps -> lock_indicator
    -- subty -> record_subtype
    -- aedtm -> last_change_date
    -- uname -> username
    -- histo -> is_historical
    -- itxex -> external_system_id
    -- refex -> external_reference
    -- ordex -> execution_order
    -- itbld -> it_location
    -- preas -> process_reason
    -- flag1 -> custom_flag_1
    -- flag2 -> custom_flag_2
    -- flag3 -> custom_flag_3
    -- flag4 -> custom_flag_4
    -- rese1 -> reserved_1
    -- rese2 -> reserved_2
    -- grpvl -> group_value
    -- massn -> action_type
    -- massg -> measure_group
    -- stat1 -> status_1
    -- stat2 -> status_2
    -- stat3 -> status_3
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "begda" AS "start_date",
        "endda" AS "end_date",
        "mandt" AS "client_code",
        "objps" AS "object_spec",
        "pernr" AS "employee_id",
        "seqnr" AS "sequence_number",
        "sprps" AS "lock_indicator",
        "subty" AS "record_subtype",
        "aedtm" AS "last_change_date",
        "uname" AS "username",
        "histo" AS "is_historical",
        "itxex" AS "external_system_id",
        "refex" AS "external_reference",
        "ordex" AS "execution_order",
        "itbld" AS "it_location",
        "preas" AS "process_reason",
        "flag1" AS "custom_flag_1",
        "flag2" AS "custom_flag_2",
        "flag3" AS "custom_flag_3",
        "flag4" AS "custom_flag_4",
        "rese1" AS "reserved_1",
        "rese2" AS "reserved_2",
        "grpvl" AS "group_value",
        "massn" AS "action_type",
        "massg" AS "measure_group",
        "stat1" AS "status_1",
        "stat2" AS "status_2",
        "stat3" AS "status_3",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_pa0000_data_projected"
),

"sap_pa0000_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- action_type: from INT to VARCHAR
    -- client_code: from INT to VARCHAR
    -- custom_flag_1: from DECIMAL to VARCHAR
    -- custom_flag_2: from DECIMAL to VARCHAR
    -- custom_flag_3: from DECIMAL to VARCHAR
    -- custom_flag_4: from DECIMAL to VARCHAR
    -- end_date: from INT to DATE
    -- execution_order: from DECIMAL to VARCHAR
    -- external_reference: from DECIMAL to VARCHAR
    -- external_system_id: from DECIMAL to VARCHAR
    -- group_value: from DECIMAL to VARCHAR
    -- is_historical: from DECIMAL to VARCHAR
    -- it_location: from DECIMAL to VARCHAR
    -- last_change_date: from INT to DATE
    -- lock_indicator: from DECIMAL to VARCHAR
    -- measure_group: from DECIMAL to VARCHAR
    -- object_spec: from DECIMAL to VARCHAR
    -- process_reason: from DECIMAL to VARCHAR
    -- record_subtype: from DECIMAL to VARCHAR
    -- reserved_1: from DECIMAL to VARCHAR
    -- reserved_2: from DECIMAL to VARCHAR
    -- start_date: from INT to DATE
    -- status_1: from DECIMAL to VARCHAR
    -- status_2: from INT to VARCHAR
    -- status_3: from INT to VARCHAR
    SELECT
        "employee_id",
        "sequence_number",
        "username",
        "row_id",
        "is_deleted",
        CAST("action_type" AS VARCHAR) AS "action_type",
        CAST("client_code" AS VARCHAR) AS "client_code",
        CAST("custom_flag_1" AS VARCHAR) AS "custom_flag_1",
        CAST("custom_flag_2" AS VARCHAR) AS "custom_flag_2",
        CAST("custom_flag_3" AS VARCHAR) AS "custom_flag_3",
        CAST("custom_flag_4" AS VARCHAR) AS "custom_flag_4",
        strptime(CAST("end_date" AS VARCHAR), '%Y%m%d') AS "end_date",
        CAST("execution_order" AS VARCHAR) AS "execution_order",
        CAST("external_reference" AS VARCHAR) AS "external_reference",
        CAST("external_system_id" AS VARCHAR) AS "external_system_id",
        CAST("group_value" AS VARCHAR) AS "group_value",
        CAST("is_historical" AS VARCHAR) AS "is_historical",
        CAST("it_location" AS VARCHAR) AS "it_location",
        strptime(CAST("last_change_date" AS VARCHAR), '%Y%m%d') AS "last_change_date",
        CAST("lock_indicator" AS VARCHAR) AS "lock_indicator",
        CAST("measure_group" AS VARCHAR) AS "measure_group",
        CAST("object_spec" AS VARCHAR) AS "object_spec",
        CAST("process_reason" AS VARCHAR) AS "process_reason",
        CAST("record_subtype" AS VARCHAR) AS "record_subtype",
        CAST("reserved_1" AS VARCHAR) AS "reserved_1",
        CAST("reserved_2" AS VARCHAR) AS "reserved_2",
        strptime(CAST("start_date" AS VARCHAR), '%Y%m%d') AS "start_date",
        CAST("status_1" AS VARCHAR) AS "status_1",
        CAST("status_2" AS VARCHAR) AS "status_2",
        CAST("status_3" AS VARCHAR) AS "status_3"
    FROM "sap_pa0000_data_projected_renamed"
),

"sap_pa0000_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 17 columns with unacceptable missing values
    -- custom_flag_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- execution_order has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_reference has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_system_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_value has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_historical has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- it_location has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- measure_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- object_spec has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- process_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_subtype has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserved_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserved_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- status_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "employee_id",
        "sequence_number",
        "username",
        "row_id",
        "is_deleted",
        "action_type",
        "client_code",
        "end_date",
        "last_change_date",
        "lock_indicator",
        "start_date",
        "status_2",
        "status_3"
    FROM "sap_pa0000_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_pa0000_data_projected_renamed_casted_missing_handled"