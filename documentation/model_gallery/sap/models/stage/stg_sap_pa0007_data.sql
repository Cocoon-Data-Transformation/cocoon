-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 05:14:43.756140+00:00
WITH 
"sap_pa0007_data_projected" AS (
    -- Projection: Selecting 46 out of 47 columns
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
        "schkz",
        "zterf",
        "empct",
        "mostd",
        "wostd",
        "arbst",
        "wkwdy",
        "jrstd",
        "teilk",
        "minta",
        "maxta",
        "minwo",
        "maxwo",
        "minmo",
        "maxmo",
        "minja",
        "maxja",
        "dysch",
        "kztim",
        "wweek",
        "awtyp",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_pa0007_data"
),

"sap_pa0007_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- begda -> valid_from_date
    -- endda -> valid_to_date
    -- mandt -> client_id
    -- objps -> personnel_calculation_object
    -- pernr -> employee_id
    -- seqnr -> sequence_number
    -- sprps -> lock_indicator
    -- subty -> subtype
    -- aedtm -> last_modified_date
    -- uname -> last_modified_by
    -- histo -> is_historical
    -- itxex -> integration_time_execution
    -- refex -> external_reference
    -- ordex -> execution_order
    -- itbld -> integration_time_building
    -- preas -> reason_code
    -- flag1 -> custom_flag_1
    -- flag2 -> custom_flag_2
    -- flag3 -> custom_flag_3
    -- flag4 -> custom_flag_4
    -- rese1 -> reserve_field_1
    -- rese2 -> reserve_field_2
    -- grpvl -> group_value
    -- schkz -> schedule_type
    -- zterf -> time_recording_indicator
    -- empct -> employment_percentage
    -- mostd -> monthly_hours
    -- wostd -> weekly_hours
    -- arbst -> daily_hours
    -- wkwdy -> workdays_per_week
    -- jrstd -> yearly_hours
    -- teilk -> part_time_indicator
    -- minta -> min_daily_hours
    -- maxta -> max_daily_hours
    -- minwo -> min_weekly_hours
    -- maxwo -> max_weekly_hours
    -- minmo -> min_monthly_hours
    -- maxmo -> max_monthly_hours
    -- minja -> min_yearly_hours
    -- maxja -> max_yearly_hours
    -- dysch -> dynamic_scheduling
    -- kztim -> time_management_indicator
    -- wweek -> work_week_definition
    -- awtyp -> work_time_type
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "begda" AS "valid_from_date",
        "endda" AS "valid_to_date",
        "mandt" AS "client_id",
        "objps" AS "personnel_calculation_object",
        "pernr" AS "employee_id",
        "seqnr" AS "sequence_number",
        "sprps" AS "lock_indicator",
        "subty" AS "subtype",
        "aedtm" AS "last_modified_date",
        "uname" AS "last_modified_by",
        "histo" AS "is_historical",
        "itxex" AS "integration_time_execution",
        "refex" AS "external_reference",
        "ordex" AS "execution_order",
        "itbld" AS "integration_time_building",
        "preas" AS "reason_code",
        "flag1" AS "custom_flag_1",
        "flag2" AS "custom_flag_2",
        "flag3" AS "custom_flag_3",
        "flag4" AS "custom_flag_4",
        "rese1" AS "reserve_field_1",
        "rese2" AS "reserve_field_2",
        "grpvl" AS "group_value",
        "schkz" AS "schedule_type",
        "zterf" AS "time_recording_indicator",
        "empct" AS "employment_percentage",
        "mostd" AS "monthly_hours",
        "wostd" AS "weekly_hours",
        "arbst" AS "daily_hours",
        "wkwdy" AS "workdays_per_week",
        "jrstd" AS "yearly_hours",
        "teilk" AS "part_time_indicator",
        "minta" AS "min_daily_hours",
        "maxta" AS "max_daily_hours",
        "minwo" AS "min_weekly_hours",
        "maxwo" AS "max_weekly_hours",
        "minmo" AS "min_monthly_hours",
        "maxmo" AS "max_monthly_hours",
        "minja" AS "min_yearly_hours",
        "maxja" AS "max_yearly_hours",
        "dysch" AS "dynamic_scheduling",
        "kztim" AS "time_management_indicator",
        "wweek" AS "work_week_definition",
        "awtyp" AS "work_time_type",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_pa0007_data_projected"
),

"sap_pa0007_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- custom_flag_1: from DECIMAL to VARCHAR
    -- custom_flag_2: from DECIMAL to VARCHAR
    -- custom_flag_3: from DECIMAL to VARCHAR
    -- custom_flag_4: from DECIMAL to VARCHAR
    -- dynamic_scheduling: from DECIMAL to VARCHAR
    -- execution_order: from DECIMAL to VARCHAR
    -- external_reference: from DECIMAL to VARCHAR
    -- group_value: from DECIMAL to VARCHAR
    -- integration_time_building: from DECIMAL to VARCHAR
    -- integration_time_execution: from DECIMAL to VARCHAR
    -- is_historical: from DECIMAL to VARCHAR
    -- last_modified_date: from INT to DATE
    -- lock_indicator: from DECIMAL to VARCHAR
    -- part_time_indicator: from DECIMAL to VARCHAR
    -- personnel_calculation_object: from DECIMAL to VARCHAR
    -- reason_code: from DECIMAL to VARCHAR
    -- reserve_field_1: from DECIMAL to VARCHAR
    -- reserve_field_2: from DECIMAL to VARCHAR
    -- subtype: from DECIMAL to VARCHAR
    -- time_management_indicator: from DECIMAL to VARCHAR
    -- valid_from_date: from INT to DATE
    -- valid_to_date: from INT to DATE
    -- work_time_type: from DECIMAL to VARCHAR
    -- work_week_definition: from DECIMAL to VARCHAR
    SELECT
        "client_id",
        "employee_id",
        "sequence_number",
        "last_modified_by",
        "schedule_type",
        "time_recording_indicator",
        "employment_percentage",
        "monthly_hours",
        "weekly_hours",
        "daily_hours",
        "workdays_per_week",
        "yearly_hours",
        "min_daily_hours",
        "max_daily_hours",
        "min_weekly_hours",
        "max_weekly_hours",
        "min_monthly_hours",
        "max_monthly_hours",
        "min_yearly_hours",
        "max_yearly_hours",
        "row_id",
        "is_deleted",
        CAST("custom_flag_1" AS VARCHAR) AS "custom_flag_1",
        CAST("custom_flag_2" AS VARCHAR) AS "custom_flag_2",
        CAST("custom_flag_3" AS VARCHAR) AS "custom_flag_3",
        CAST("custom_flag_4" AS VARCHAR) AS "custom_flag_4",
        CAST("dynamic_scheduling" AS VARCHAR) AS "dynamic_scheduling",
        CAST("execution_order" AS VARCHAR) AS "execution_order",
        CAST("external_reference" AS VARCHAR) AS "external_reference",
        CAST("group_value" AS VARCHAR) AS "group_value",
        CAST("integration_time_building" AS VARCHAR) AS "integration_time_building",
        CAST("integration_time_execution" AS VARCHAR) AS "integration_time_execution",
        CAST("is_historical" AS VARCHAR) AS "is_historical",
        strptime(CAST("last_modified_date" AS VARCHAR), '%Y%m%d') AS "last_modified_date",
        CAST("lock_indicator" AS VARCHAR) AS "lock_indicator",
        CAST("part_time_indicator" AS VARCHAR) AS "part_time_indicator",
        CAST("personnel_calculation_object" AS VARCHAR) AS "personnel_calculation_object",
        CAST("reason_code" AS VARCHAR) AS "reason_code",
        CAST("reserve_field_1" AS VARCHAR) AS "reserve_field_1",
        CAST("reserve_field_2" AS VARCHAR) AS "reserve_field_2",
        CAST("subtype" AS VARCHAR) AS "subtype",
        CAST("time_management_indicator" AS VARCHAR) AS "time_management_indicator",
        strptime(CAST("valid_from_date" AS VARCHAR), '%Y%m%d') AS "valid_from_date",
        strptime(CAST("valid_to_date" AS VARCHAR), '%Y%m%d') AS "valid_to_date",
        CAST("work_time_type" AS VARCHAR) AS "work_time_type",
        CAST("work_week_definition" AS VARCHAR) AS "work_week_definition"
    FROM "sap_pa0007_data_projected_renamed"
),

"sap_pa0007_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 20 columns with unacceptable missing values
    -- custom_flag_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- execution_order has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_reference has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_value has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- integration_time_building has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- integration_time_execution has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_historical has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lock_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- part_time_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- personnel_calculation_object has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserve_field_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserve_field_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subtype has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- time_management_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- work_time_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- work_week_definition has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "client_id",
        "employee_id",
        "sequence_number",
        "last_modified_by",
        "schedule_type",
        "time_recording_indicator",
        "employment_percentage",
        "monthly_hours",
        "weekly_hours",
        "daily_hours",
        "workdays_per_week",
        "yearly_hours",
        "min_daily_hours",
        "max_daily_hours",
        "min_weekly_hours",
        "max_weekly_hours",
        "min_monthly_hours",
        "max_monthly_hours",
        "min_yearly_hours",
        "max_yearly_hours",
        "row_id",
        "is_deleted",
        "dynamic_scheduling",
        "last_modified_date",
        "valid_from_date",
        "valid_to_date"
    FROM "sap_pa0007_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_pa0007_data_projected_renamed_casted_missing_handled"