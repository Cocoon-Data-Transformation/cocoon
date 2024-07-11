-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 05:13:22.987849+00:00
WITH 
"sap_pa0001_data_projected" AS (
    -- Projection: Selecting 54 out of 55 columns
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
        "bukrs",
        "werks",
        "persg",
        "persk",
        "vdsk1",
        "gsber",
        "btrtl",
        "juper",
        "abkrs",
        "ansvh",
        "kostl",
        "orgeh",
        "plans",
        "stell",
        "mstbr",
        "sacha",
        "sachp",
        "sachz",
        "sname",
        "ename",
        "otype",
        "sbmod",
        "kokrs",
        "fistl",
        "geber",
        "fkber",
        "grant_nbr",
        "sgmnt",
        "budget_pd",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_pa0001_data"
),

"sap_pa0001_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- begda -> valid_from
    -- endda -> valid_to
    -- mandt -> client
    -- objps -> object_specification
    -- pernr -> employee_id
    -- seqnr -> sequence_number
    -- sprps -> lock_indicator
    -- subty -> subtype
    -- aedtm -> last_changed_date
    -- uname -> user_name
    -- histo -> is_historical
    -- itxex -> tax_exemption
    -- refex -> reference_id
    -- ordex -> order_id
    -- itbld -> it_planning_layout
    -- preas -> processing_reason
    -- flag1 -> custom_flag_1
    -- flag2 -> custom_flag_2
    -- flag3 -> custom_flag_3
    -- flag4 -> custom_flag_4
    -- rese1 -> reserved_field_1
    -- rese2 -> reserved_field_2
    -- bukrs -> company_code
    -- werks -> personnel_area
    -- persk -> employee_subgroup
    -- vdsk1 -> distribution_key
    -- gsber -> business_area
    -- btrtl -> personnel_subarea
    -- juper -> payroll_period
    -- abkrs -> work_schedule_rule
    -- ansvh -> action_reason
    -- kostl -> cost_center
    -- orgeh -> org_unit_id
    -- plans -> position_id
    -- stell -> job_id
    -- sacha -> wage_type
    -- sachz -> time_constraint
    -- otype -> object_type
    -- sbmod -> payroll_modifier
    -- kokrs -> controlling_area
    -- fistl -> funds_center
    -- geber -> fund
    -- fkber -> functional_area
    -- grant_nbr -> grant_number
    -- sgmnt -> segment_id
    -- budget_pd -> budget_period
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "begda" AS "valid_from",
        "endda" AS "valid_to",
        "mandt" AS "client",
        "objps" AS "object_specification",
        "pernr" AS "employee_id",
        "seqnr" AS "sequence_number",
        "sprps" AS "lock_indicator",
        "subty" AS "subtype",
        "aedtm" AS "last_changed_date",
        "uname" AS "user_name",
        "histo" AS "is_historical",
        "itxex" AS "tax_exemption",
        "refex" AS "reference_id",
        "ordex" AS "order_id",
        "itbld" AS "it_planning_layout",
        "preas" AS "processing_reason",
        "flag1" AS "custom_flag_1",
        "flag2" AS "custom_flag_2",
        "flag3" AS "custom_flag_3",
        "flag4" AS "custom_flag_4",
        "rese1" AS "reserved_field_1",
        "rese2" AS "reserved_field_2",
        "grpvl",
        "bukrs" AS "company_code",
        "werks" AS "personnel_area",
        "persg",
        "persk" AS "employee_subgroup",
        "vdsk1" AS "distribution_key",
        "gsber" AS "business_area",
        "btrtl" AS "personnel_subarea",
        "juper" AS "payroll_period",
        "abkrs" AS "work_schedule_rule",
        "ansvh" AS "action_reason",
        "kostl" AS "cost_center",
        "orgeh" AS "org_unit_id",
        "plans" AS "position_id",
        "stell" AS "job_id",
        "mstbr",
        "sacha" AS "wage_type",
        "sachp",
        "sachz" AS "time_constraint",
        "sname",
        "ename",
        "otype" AS "object_type",
        "sbmod" AS "payroll_modifier",
        "kokrs" AS "controlling_area",
        "fistl" AS "funds_center",
        "geber" AS "fund",
        "fkber" AS "functional_area",
        "grant_nbr" AS "grant_number",
        "sgmnt" AS "segment_id",
        "budget_pd" AS "budget_period",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_pa0001_data_projected"
),

"sap_pa0001_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- employee_subgroup: The problem is that 'gc' is the only value present in the employee_subgroup column, and it's an ambiguous code that doesn't clearly indicate its meaning for employee subgroups. Without additional context or a data dictionary, it's impossible to determine what 'gc' stands for or if it's a valid employee subgroup designation. The correct values should be more descriptive and meaningful employee subgroup categories. 
    -- ename: The problem is inconsistent capitalization and title formatting across the ename values. 'austin powers' lacks capitalization and a title, while 'mr bruce wayne' and 'mr sponge bob' have inconsistent title formatting (lowercase 'mr'). The correct values should have consistent capitalization (title case for names) and title formatting (capitalized 'Mr.'). 
    -- object_type: The problem is that 's' is the only value in the object_type column, and it's a single letter that doesn't clearly indicate what object type it represents. In this case, 's' likely stands for 'star', as it's common in astronomical datasets to use 's' as an abbreviation for star objects. However, without more context or other values to compare it to, it's difficult to be certain. The correct value should be more descriptive to avoid ambiguity. 
    SELECT
        "valid_from",
        "valid_to",
        "client",
        "object_specification",
        "employee_id",
        "sequence_number",
        "lock_indicator",
        "subtype",
        "last_changed_date",
        "user_name",
        "is_historical",
        "tax_exemption",
        "reference_id",
        "order_id",
        "it_planning_layout",
        "processing_reason",
        "custom_flag_1",
        "custom_flag_2",
        "custom_flag_3",
        "custom_flag_4",
        "reserved_field_1",
        "reserved_field_2",
        "grpvl",
        "company_code",
        "personnel_area",
        "persg",
        CASE
            WHEN "employee_subgroup" = '''gc''' THEN ''''
            ELSE "employee_subgroup"
        END AS "employee_subgroup",
        "distribution_key",
        "business_area",
        "personnel_subarea",
        "payroll_period",
        "work_schedule_rule",
        "action_reason",
        "cost_center",
        "org_unit_id",
        "position_id",
        "job_id",
        "mstbr",
        "wage_type",
        "sachp",
        "time_constraint",
        "sname",
        CASE
            WHEN "ename" = 'austin powers' THEN 'Mr. Austin Powers'
            WHEN "ename" = 'mr bruce wayne' THEN 'Mr. Bruce Wayne'
            WHEN "ename" = 'mr sponge bob' THEN 'Mr. Sponge Bob'
            ELSE "ename"
        END AS "ename",
        CASE
            WHEN "object_type" = '''s''' THEN '''star'''
            ELSE "object_type"
        END AS "object_type",
        "payroll_modifier",
        "controlling_area",
        "funds_center",
        "fund",
        "functional_area",
        "grant_number",
        "segment_id",
        "budget_period",
        "row_id",
        "is_deleted"
    FROM "sap_pa0001_data_projected_renamed"
),

"sap_pa0001_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- action_reason: from DECIMAL to VARCHAR
    -- budget_period: from DECIMAL to VARCHAR
    -- business_area: from DECIMAL to VARCHAR
    -- client: from INT to VARCHAR
    -- company_code: from INT to VARCHAR
    -- controlling_area: from INT to VARCHAR
    -- cost_center: from DECIMAL to VARCHAR
    -- custom_flag_1: from DECIMAL to VARCHAR
    -- custom_flag_2: from DECIMAL to VARCHAR
    -- custom_flag_3: from DECIMAL to VARCHAR
    -- custom_flag_4: from DECIMAL to VARCHAR
    -- distribution_key: from INT to VARCHAR
    -- functional_area: from DECIMAL to VARCHAR
    -- fund: from DECIMAL to VARCHAR
    -- funds_center: from DECIMAL to VARCHAR
    -- grant_number: from DECIMAL to VARCHAR
    -- grpvl: from DECIMAL to VARCHAR
    -- is_historical: from DECIMAL to VARCHAR
    -- it_planning_layout: from DECIMAL to VARCHAR
    -- job_id: from INT to VARCHAR
    -- last_changed_date: from INT to DATE
    -- lock_indicator: from DECIMAL to VARCHAR
    -- mstbr: from DECIMAL to VARCHAR
    -- object_specification: from DECIMAL to VARCHAR
    -- order_id: from DECIMAL to VARCHAR
    -- org_unit_id: from INT to VARCHAR
    -- payroll_period: from DECIMAL to VARCHAR
    -- position_id: from INT to VARCHAR
    -- processing_reason: from DECIMAL to VARCHAR
    -- reference_id: from DECIMAL to VARCHAR
    -- reserved_field_1: from DECIMAL to VARCHAR
    -- reserved_field_2: from DECIMAL to VARCHAR
    -- segment_id: from DECIMAL to VARCHAR
    -- subtype: from DECIMAL to VARCHAR
    -- tax_exemption: from DECIMAL to VARCHAR
    -- time_constraint: from DECIMAL to VARCHAR
    -- valid_from: from INT to DATE
    -- valid_to: from INT to DATE
    -- wage_type: from DECIMAL to VARCHAR
    SELECT
        "employee_id",
        "sequence_number",
        "user_name",
        "personnel_area",
        "persg",
        "employee_subgroup",
        "personnel_subarea",
        "work_schedule_rule",
        "sachp",
        "sname",
        "ename",
        "object_type",
        "payroll_modifier",
        "row_id",
        "is_deleted",
        CAST("action_reason" AS VARCHAR) AS "action_reason",
        CAST("budget_period" AS VARCHAR) AS "budget_period",
        CAST("business_area" AS VARCHAR) AS "business_area",
        CAST("client" AS VARCHAR) AS "client",
        CAST("company_code" AS VARCHAR) AS "company_code",
        CAST("controlling_area" AS VARCHAR) AS "controlling_area",
        CAST("cost_center" AS VARCHAR) AS "cost_center",
        CAST("custom_flag_1" AS VARCHAR) AS "custom_flag_1",
        CAST("custom_flag_2" AS VARCHAR) AS "custom_flag_2",
        CAST("custom_flag_3" AS VARCHAR) AS "custom_flag_3",
        CAST("custom_flag_4" AS VARCHAR) AS "custom_flag_4",
        CAST("distribution_key" AS VARCHAR) AS "distribution_key",
        CAST("functional_area" AS VARCHAR) AS "functional_area",
        CAST("fund" AS VARCHAR) AS "fund",
        CAST("funds_center" AS VARCHAR) AS "funds_center",
        CAST("grant_number" AS VARCHAR) AS "grant_number",
        CAST("grpvl" AS VARCHAR) AS "grpvl",
        CAST("is_historical" AS VARCHAR) AS "is_historical",
        CAST("it_planning_layout" AS VARCHAR) AS "it_planning_layout",
        CAST("job_id" AS VARCHAR) AS "job_id",
        strptime(CAST("last_changed_date" AS VARCHAR), '%Y%m%d') AS "last_changed_date",
        CAST("lock_indicator" AS VARCHAR) AS "lock_indicator",
        CAST("mstbr" AS VARCHAR) AS "mstbr",
        CAST("object_specification" AS VARCHAR) AS "object_specification",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("org_unit_id" AS VARCHAR) AS "org_unit_id",
        CAST("payroll_period" AS VARCHAR) AS "payroll_period",
        CAST("position_id" AS VARCHAR) AS "position_id",
        CAST("processing_reason" AS VARCHAR) AS "processing_reason",
        CAST("reference_id" AS VARCHAR) AS "reference_id",
        CAST("reserved_field_1" AS VARCHAR) AS "reserved_field_1",
        CAST("reserved_field_2" AS VARCHAR) AS "reserved_field_2",
        CAST("segment_id" AS VARCHAR) AS "segment_id",
        CAST("subtype" AS VARCHAR) AS "subtype",
        CAST("tax_exemption" AS VARCHAR) AS "tax_exemption",
        CAST("time_constraint" AS VARCHAR) AS "time_constraint",
        strptime(CAST("valid_from" AS VARCHAR), '%Y%m%d') AS "valid_from",
        strptime(CAST("valid_to" AS VARCHAR), '%Y%m%d') AS "valid_to",
        CAST("wage_type" AS VARCHAR) AS "wage_type"
    FROM "sap_pa0001_data_projected_renamed_cleaned"
),

"sap_pa0001_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 26 columns with unacceptable missing values
    -- action_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- budget_period has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_flag_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- functional_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fund has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- funds_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- grant_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- grpvl has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- it_planning_layout has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mstbr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- object_specification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- order_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payroll_period has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserved_field_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserved_field_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- segment_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subtype has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_exemption has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- time_constraint has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "employee_id",
        "sequence_number",
        "user_name",
        "personnel_area",
        "persg",
        "employee_subgroup",
        "personnel_subarea",
        "work_schedule_rule",
        "sachp",
        "sname",
        "ename",
        "object_type",
        "payroll_modifier",
        "row_id",
        "is_deleted",
        "client",
        "company_code",
        "controlling_area",
        "distribution_key",
        "is_historical",
        "job_id",
        "last_changed_date",
        "lock_indicator",
        "org_unit_id",
        "position_id",
        "processing_reason",
        "valid_from",
        "valid_to"
    FROM "sap_pa0001_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_pa0001_data_projected_renamed_cleaned_casted_missing_handled"