-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 14:46:10.017022+00:00
WITH 
"sap_pa0031_data_projected" AS (
    -- Projection: Selecting 45 out of 46 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "aedtm",
        "begda",
        "endda",
        "flag1",
        "flag2",
        "flag3",
        "flag4",
        "grpvl",
        "histo",
        "itbld",
        "itxex",
        "mandt",
        "objps",
        "ordex",
        "pernr",
        "preas",
        "refex",
        "rese1",
        "rese2",
        "rfp01",
        "rfp02",
        "rfp03",
        "rfp04",
        "rfp05",
        "rfp06",
        "rfp07",
        "rfp08",
        "rfp09",
        "rfp10",
        "rfp11",
        "rfp12",
        "rfp13",
        "rfp14",
        "rfp15",
        "rfp16",
        "rfp17",
        "rfp18",
        "rfp19",
        "rfp20",
        "seqnr",
        "sprps",
        "subty",
        "uname",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_pa0031_data"
),

"sap_pa0031_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- aedtm -> last_change_date
    -- begda -> start_date
    -- endda -> end_date
    -- flag1 -> flag_1
    -- flag2 -> flag_2
    -- flag3 -> flag_3
    -- flag4 -> flag_4
    -- grpvl -> group_value
    -- histo -> is_historical
    -- itbld -> info_type_build
    -- itxex -> info_type_exit
    -- mandt -> company_code
    -- objps -> object_spec
    -- ordex -> record_order
    -- pernr -> employee_number
    -- preas -> processing_reason
    -- refex -> external_reference
    -- rese1 -> reserved_1
    -- rese2 -> reserved_2
    -- rfp01 -> reference_field_1
    -- rfp02 -> reference_field_2
    -- rfp03 -> reference_field_3
    -- rfp04 -> reference_field_4
    -- rfp05 -> reference_field_5
    -- rfp06 -> reference_field_6
    -- rfp07 -> reference_field_7
    -- rfp08 -> reference_field_8
    -- rfp09 -> reference_field_9
    -- rfp10 -> reference_field_10
    -- rfp11 -> reference_field_11
    -- rfp12 -> reference_field_12
    -- rfp13 -> reference_field_13
    -- rfp14 -> reference_field_14
    -- rfp15 -> reference_field_15
    -- rfp16 -> reference_field_16
    -- rfp17 -> reference_field_17
    -- rfp18 -> reference_field_18
    -- rfp19 -> reference_field_19
    -- rfp20 -> reference_field_20
    -- sprps -> specific_purpose
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "aedtm" AS "last_change_date",
        "begda" AS "start_date",
        "endda" AS "end_date",
        "flag1" AS "flag_1",
        "flag2" AS "flag_2",
        "flag3" AS "flag_3",
        "flag4" AS "flag_4",
        "grpvl" AS "group_value",
        "histo" AS "is_historical",
        "itbld" AS "info_type_build",
        "itxex" AS "info_type_exit",
        "mandt" AS "company_code",
        "objps" AS "object_spec",
        "ordex" AS "record_order",
        "pernr" AS "employee_number",
        "preas" AS "processing_reason",
        "refex" AS "external_reference",
        "rese1" AS "reserved_1",
        "rese2" AS "reserved_2",
        "rfp01" AS "reference_field_1",
        "rfp02" AS "reference_field_2",
        "rfp03" AS "reference_field_3",
        "rfp04" AS "reference_field_4",
        "rfp05" AS "reference_field_5",
        "rfp06" AS "reference_field_6",
        "rfp07" AS "reference_field_7",
        "rfp08" AS "reference_field_8",
        "rfp09" AS "reference_field_9",
        "rfp10" AS "reference_field_10",
        "rfp11" AS "reference_field_11",
        "rfp12" AS "reference_field_12",
        "rfp13" AS "reference_field_13",
        "rfp14" AS "reference_field_14",
        "rfp15" AS "reference_field_15",
        "rfp16" AS "reference_field_16",
        "rfp17" AS "reference_field_17",
        "rfp18" AS "reference_field_18",
        "rfp19" AS "reference_field_19",
        "rfp20" AS "reference_field_20",
        "seqnr",
        "sprps" AS "specific_purpose",
        "subty",
        "uname",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_pa0031_data_projected"
),

"sap_pa0031_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- company_code: from INT to VARCHAR
    -- end_date: from INT to DATE
    -- external_reference: from DECIMAL to VARCHAR
    -- flag_1: from DECIMAL to VARCHAR
    -- flag_2: from DECIMAL to VARCHAR
    -- flag_3: from DECIMAL to VARCHAR
    -- flag_4: from DECIMAL to VARCHAR
    -- group_value: from DECIMAL to VARCHAR
    -- info_type_build: from DECIMAL to VARCHAR
    -- info_type_exit: from DECIMAL to VARCHAR
    -- is_historical: from DECIMAL to VARCHAR
    -- last_change_date: from INT to DATE
    -- object_spec: from DECIMAL to VARCHAR
    -- processing_reason: from DECIMAL to VARCHAR
    -- record_order: from DECIMAL to VARCHAR
    -- reference_field_1: from INT to VARCHAR
    -- reference_field_10: from DECIMAL to VARCHAR
    -- reference_field_11: from DECIMAL to VARCHAR
    -- reference_field_12: from DECIMAL to VARCHAR
    -- reference_field_13: from DECIMAL to VARCHAR
    -- reference_field_14: from DECIMAL to VARCHAR
    -- reference_field_15: from DECIMAL to VARCHAR
    -- reference_field_16: from DECIMAL to VARCHAR
    -- reference_field_17: from DECIMAL to VARCHAR
    -- reference_field_18: from DECIMAL to VARCHAR
    -- reference_field_19: from DECIMAL to VARCHAR
    -- reference_field_2: from DECIMAL to VARCHAR
    -- reference_field_20: from DECIMAL to VARCHAR
    -- reference_field_3: from DECIMAL to VARCHAR
    -- reference_field_4: from DECIMAL to VARCHAR
    -- reference_field_5: from DECIMAL to VARCHAR
    -- reference_field_6: from DECIMAL to VARCHAR
    -- reference_field_7: from DECIMAL to VARCHAR
    -- reference_field_8: from DECIMAL to VARCHAR
    -- reference_field_9: from DECIMAL to VARCHAR
    -- reserved_1: from DECIMAL to VARCHAR
    -- reserved_2: from DECIMAL to VARCHAR
    -- specific_purpose: from DECIMAL to VARCHAR
    -- start_date: from INT to DATE
    SELECT
        "employee_number",
        "seqnr",
        "subty",
        "uname",
        "row_id",
        "is_deleted",
        CAST("company_code" AS VARCHAR) AS "company_code",
        strptime(CAST("end_date" AS VARCHAR), '%Y%m%d') AS "end_date",
        CAST("external_reference" AS VARCHAR) AS "external_reference",
        CAST("flag_1" AS VARCHAR) AS "flag_1",
        CAST("flag_2" AS VARCHAR) AS "flag_2",
        CAST("flag_3" AS VARCHAR) AS "flag_3",
        CAST("flag_4" AS VARCHAR) AS "flag_4",
        CAST("group_value" AS VARCHAR) AS "group_value",
        CAST("info_type_build" AS VARCHAR) AS "info_type_build",
        CAST("info_type_exit" AS VARCHAR) AS "info_type_exit",
        CAST("is_historical" AS VARCHAR) AS "is_historical",
        strptime(CAST("last_change_date" AS VARCHAR), '%Y%m%d') AS "last_change_date",
        CAST("object_spec" AS VARCHAR) AS "object_spec",
        CAST("processing_reason" AS VARCHAR) AS "processing_reason",
        CAST("record_order" AS VARCHAR) AS "record_order",
        CAST("reference_field_1" AS VARCHAR) AS "reference_field_1",
        CAST("reference_field_10" AS VARCHAR) AS "reference_field_10",
        CAST("reference_field_11" AS VARCHAR) AS "reference_field_11",
        CAST("reference_field_12" AS VARCHAR) AS "reference_field_12",
        CAST("reference_field_13" AS VARCHAR) AS "reference_field_13",
        CAST("reference_field_14" AS VARCHAR) AS "reference_field_14",
        CAST("reference_field_15" AS VARCHAR) AS "reference_field_15",
        CAST("reference_field_16" AS VARCHAR) AS "reference_field_16",
        CAST("reference_field_17" AS VARCHAR) AS "reference_field_17",
        CAST("reference_field_18" AS VARCHAR) AS "reference_field_18",
        CAST("reference_field_19" AS VARCHAR) AS "reference_field_19",
        CAST("reference_field_2" AS VARCHAR) AS "reference_field_2",
        CAST("reference_field_20" AS VARCHAR) AS "reference_field_20",
        CAST("reference_field_3" AS VARCHAR) AS "reference_field_3",
        CAST("reference_field_4" AS VARCHAR) AS "reference_field_4",
        CAST("reference_field_5" AS VARCHAR) AS "reference_field_5",
        CAST("reference_field_6" AS VARCHAR) AS "reference_field_6",
        CAST("reference_field_7" AS VARCHAR) AS "reference_field_7",
        CAST("reference_field_8" AS VARCHAR) AS "reference_field_8",
        CAST("reference_field_9" AS VARCHAR) AS "reference_field_9",
        CAST("reserved_1" AS VARCHAR) AS "reserved_1",
        CAST("reserved_2" AS VARCHAR) AS "reserved_2",
        CAST("specific_purpose" AS VARCHAR) AS "specific_purpose",
        strptime(CAST("start_date" AS VARCHAR), '%Y%m%d') AS "start_date"
    FROM "sap_pa0031_data_projected_renamed"
),

"sap_pa0031_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 30 columns with unacceptable missing values
    -- external_reference has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_value has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- info_type_build has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- info_type_exit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_historical has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- object_spec has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- processing_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_order has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_10 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_11 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_12 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_13 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_14 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_15 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_16 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_17 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_18 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_19 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_20 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_6 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_7 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_8 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_field_9 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserved_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserved_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- specific_purpose has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "employee_number",
        "seqnr",
        "subty",
        "uname",
        "row_id",
        "is_deleted",
        "company_code",
        "end_date",
        "flag_1",
        "flag_2",
        "flag_3",
        "flag_4",
        "last_change_date",
        "reference_field_1",
        "start_date"
    FROM "sap_pa0031_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_pa0031_data_projected_renamed_casted_missing_handled"