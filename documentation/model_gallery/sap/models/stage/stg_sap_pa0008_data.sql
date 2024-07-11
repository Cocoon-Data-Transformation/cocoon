-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 14:44:00.378541+00:00
WITH 
"sap_pa0008_data_projected" AS (
    -- Projection: Selecting 286 out of 287 columns
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
        "trfar",
        "trfgb",
        "trfgr",
        "trfst",
        "stvor",
        "orzst",
        "partn",
        "waers",
        "vglta",
        "vglgb",
        "vglgr",
        "vglst",
        "vglsv",
        "bsgrd",
        "divgv",
        "ansal",
        "falgk",
        "falgr",
        "lga01",
        "bet01",
        "anz01",
        "ein01",
        "opk01",
        "lga02",
        "bet02",
        "anz02",
        "ein02",
        "opk02",
        "lga03",
        "bet03",
        "anz03",
        "ein03",
        "opk03",
        "lga04",
        "bet04",
        "anz04",
        "ein04",
        "opk04",
        "lga05",
        "bet05",
        "anz05",
        "ein05",
        "opk05",
        "lga06",
        "bet06",
        "anz06",
        "ein06",
        "opk06",
        "lga07",
        "bet07",
        "anz07",
        "ein07",
        "opk07",
        "lga08",
        "bet08",
        "anz08",
        "ein08",
        "opk08",
        "lga09",
        "bet09",
        "anz09",
        "ein09",
        "opk09",
        "lga10",
        "bet10",
        "anz10",
        "ein10",
        "opk10",
        "lga11",
        "bet11",
        "anz11",
        "ein11",
        "opk11",
        "lga12",
        "bet12",
        "anz12",
        "ein12",
        "opk12",
        "lga13",
        "bet13",
        "anz13",
        "ein13",
        "opk13",
        "lga14",
        "bet14",
        "anz14",
        "ein14",
        "opk14",
        "lga15",
        "bet15",
        "anz15",
        "ein15",
        "opk15",
        "lga16",
        "bet16",
        "anz16",
        "ein16",
        "opk16",
        "lga17",
        "bet17",
        "anz17",
        "ein17",
        "opk17",
        "lga18",
        "bet18",
        "anz18",
        "ein18",
        "opk18",
        "lga19",
        "bet19",
        "anz19",
        "ein19",
        "opk19",
        "lga20",
        "bet20",
        "anz20",
        "ein20",
        "opk20",
        "lga21",
        "bet21",
        "anz21",
        "ein21",
        "opk21",
        "lga22",
        "bet22",
        "anz22",
        "ein22",
        "opk22",
        "lga23",
        "bet23",
        "anz23",
        "ein23",
        "opk23",
        "lga24",
        "bet24",
        "anz24",
        "ein24",
        "opk24",
        "lga25",
        "bet25",
        "anz25",
        "ein25",
        "opk25",
        "lga26",
        "bet26",
        "anz26",
        "ein26",
        "opk26",
        "lga27",
        "bet27",
        "anz27",
        "ein27",
        "opk27",
        "lga28",
        "bet28",
        "anz28",
        "ein28",
        "opk28",
        "lga29",
        "bet29",
        "anz29",
        "ein29",
        "opk29",
        "lga30",
        "bet30",
        "anz30",
        "ein30",
        "opk30",
        "lga31",
        "bet31",
        "anz31",
        "ein31",
        "opk31",
        "lga32",
        "bet32",
        "anz32",
        "ein32",
        "opk32",
        "lga33",
        "bet33",
        "anz33",
        "ein33",
        "opk33",
        "lga34",
        "bet34",
        "anz34",
        "ein34",
        "opk34",
        "lga35",
        "bet35",
        "anz35",
        "ein35",
        "opk35",
        "lga36",
        "bet36",
        "anz36",
        "ein36",
        "opk36",
        "lga37",
        "bet37",
        "anz37",
        "ein37",
        "opk37",
        "lga38",
        "bet38",
        "anz38",
        "ein38",
        "opk38",
        "lga39",
        "bet39",
        "anz39",
        "ein39",
        "opk39",
        "lga40",
        "bet40",
        "anz40",
        "ein40",
        "opk40",
        "ind01",
        "ind02",
        "ind03",
        "ind04",
        "ind05",
        "ind06",
        "ind07",
        "ind08",
        "ind09",
        "ind10",
        "ind11",
        "ind12",
        "ind13",
        "ind14",
        "ind15",
        "ind16",
        "ind17",
        "ind18",
        "ind19",
        "ind20",
        "ind21",
        "ind22",
        "ind23",
        "ind24",
        "ind25",
        "ind26",
        "ind27",
        "ind28",
        "ind29",
        "ind30",
        "ind31",
        "ind32",
        "ind33",
        "ind34",
        "ind35",
        "ind36",
        "ind37",
        "ind38",
        "ind39",
        "ind40",
        "ancur",
        "cpind",
        "flaga",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_pa0008_data"
),

"sap_pa0008_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- mandt -> client_code
    -- objps -> position_id
    -- seqnr -> sequence_number
    -- sprps -> special_purpose
    -- subty -> subtype
    -- aedtm -> salary_record_date
    -- histo -> historical_indicator
    -- itxex -> record_id
    -- refex -> reference_id
    -- ordex -> order_index
    -- itbld -> it_build
    -- preas -> personnel_reason_code
    -- flag1 -> flag_1
    -- flag2 -> flag_2
    -- flag3 -> flag_3
    -- flag4 -> flag_4
    -- rese1 -> reserve_field_1
    -- rese2 -> reserved_field_2
    -- grpvl -> group_value
    -- trfar -> wage_type
    -- trfgb -> wage_area
    -- trfgr -> pay_scale_group
    -- trfst -> pay_scale_level
    -- stvor -> pay_scale_type
    -- orzst -> organizational_status
    -- partn -> partner_code
    -- vglta -> comparison_date
    -- vglgb -> comparison_wage_area
    -- vglgr -> comparison_pay_scale_group
    -- vglst -> comparison_pay_scale_level
    -- vglsv -> comparison_collective_agreement
    -- divgv -> dividend_percentage
    -- ansal -> annual_salary
    -- falgk -> compensation_flag
    -- falgr -> reason_flag
    -- bet01 -> wage_component_1
    -- anz01 -> wage_component_01
    -- opk01 -> org_key_01
    -- bet02 -> wage_component_2
    -- anz02 -> wage_component_02
    -- opk02 -> org_key_02
    -- bet03 -> wage_component_3
    -- anz03 -> wage_component_03
    -- opk03 -> org_key_03
    -- bet04 -> wage_component_4
    -- anz04 -> wage_component_04
    -- opk04 -> org_key_04
    -- bet05 -> wage_component_5
    -- anz05 -> wage_component_05
    -- opk05 -> org_key_05
    -- bet06 -> wage_component_6
    -- anz06 -> wage_component_06
    -- opk06 -> org_key_06
    -- bet07 -> wage_component_7
    -- anz07 -> wage_component_07
    -- opk07 -> org_key_07
    -- bet08 -> wage_component_8
    -- anz08 -> wage_component_08
    -- opk08 -> org_key_08
    -- lga09 -> location
    -- bet09 -> wage_component_9
    -- anz09 -> wage_component_09
    -- opk09 -> org_key_09
    -- opk10 -> org_key_10
    -- opk11 -> org_key_11
    -- ein12 -> allowance
    -- opk12 -> org_key_12
    -- lga13 -> overtime
    -- ein13 -> overtime_pay
    -- opk13 -> org_key_13
    -- lga14 -> allowances
    -- ein14 -> commission
    -- opk14 -> org_key_14
    -- lga15 -> benefits
    -- bet15 -> salary_component_15
    -- anz15 -> wage_component_15
    -- opk15 -> org_key_15
    -- bet16 -> salary_component_16
    -- anz16 -> wage_component_16
    -- opk16 -> org_key_16
    -- bet17 -> salary_component_17
    -- anz17 -> wage_component_17
    -- opk17 -> org_key_17
    -- bet18 -> salary_component_18
    -- bet19 -> salary_component_19
    -- lga20 -> manager_id
    -- bet20 -> salary_component_20
    -- ein20 -> salary_review_date
    -- bet21 -> salary_component_21
    -- ein21 -> benefits_eligible
    -- lga22 -> next_review_date
    -- bet22 -> salary_component_22
    -- lga23 -> adjustment_reason
    -- bet23 -> salary_component_23
    -- ein23 -> retirement_contribution
    -- lga24 -> union_status
    -- bet24 -> salary_component_24
    -- ein24 -> health_insurance_plan
    -- lga25 -> work_schedule
    -- bet25 -> salary_component_25
    -- ein25 -> vacation_days
    -- lga26 -> commission_rate
    -- bet26 -> salary_component_26
    -- anz26 -> unknown_value_26
    -- ein26 -> sick_leave
    -- opk26 -> wage_component_26
    -- bet27 -> salary_component_27
    -- anz27 -> unknown_value_27
    -- ein27 -> training_budget
    -- opk27 -> wage_component_27
    -- lga28 -> retirement_contributions
    -- bet28 -> salary_component_28
    -- anz28 -> unknown_value_28
    -- opk28 -> wage_component_28
    -- lga29 -> compensation_notes
    -- bet29 -> salary_component_29
    -- anz29 -> unknown_value_29
    -- ein29 -> next_pay_raise_date
    -- opk29 -> wage_component_29
    -- lga30 -> org_attribute_30
    -- bet30 -> salary_component_30
    -- anz30 -> unknown_value_30
    -- ein30 -> probation_end_date
    -- opk30 -> wage_component_30
    -- lga31 -> org_attribute_31
    -- bet31 -> salary_component_31
    -- anz31 -> unknown_value_31
    -- ein31 -> contract_end_date
    -- opk31 -> wage_component_31
    -- lga32 -> org_attribute_32
    -- bet32 -> salary_component_32
    -- anz32 -> unknown_value_32
    -- ein32 -> employee_id_32
    -- opk32 -> wage_component_32
    -- lga33 -> org_attribute_33
    -- bet33 -> salary_component_33
    -- anz33 -> unknown_value_33
    -- ein33 -> employee_id_33
    -- opk33 -> wage_component_33
    -- lga34 -> org_attribute_34
    -- bet34 -> salary_component_34
    -- anz34 -> unknown_value_34
    -- ein34 -> employee_id_34
    -- opk34 -> wage_component_34
    -- lga35 -> org_attribute_35
    -- bet35 -> salary_component_35
    -- anz35 -> unknown_value_35
    -- ein35 -> employee_id_35
    -- opk35 -> wage_component_35
    -- lga36 -> org_attribute_36
    -- bet36 -> salary_component_36
    -- anz36 -> unknown_value_36
    -- ein36 -> employee_id_36
    -- opk36 -> wage_component_36
    -- lga37 -> org_attribute_37
    -- bet37 -> salary_component_37
    -- anz37 -> unknown_value_37
    -- ein37 -> employee_id_37
    -- opk37 -> wage_component_37
    -- lga38 -> org_attribute_38
    -- bet38 -> salary_component_38
    -- anz38 -> unknown_value_38
    -- ein38 -> employee_id_38
    -- opk38 -> wage_component_38
    -- lga39 -> org_attribute_39
    -- bet39 -> salary_component_39
    -- anz39 -> unknown_value_39
    -- ein39 -> employee_id_39
    -- opk39 -> wage_component_39
    -- lga40 -> org_attribute_40
    -- bet40 -> salary_component_40
    -- anz40 -> unknown_value_40
    -- ein40 -> employee_id_40
    -- opk40 -> wage_component_40
    -- ind01 -> indicator_1
    -- ind02 -> indicator_2
    -- ind03 -> indicator_3
    -- ind04 -> indicator_4
    -- ind05 -> indicator_5
    -- ind06 -> indicator_6
    -- ind07 -> indicator_7
    -- ind08 -> indicator_8
    -- ind09 -> indicator_9
    -- ind10 -> indicator_10
    -- ind11 -> indicator_11
    -- ind12 -> indicator_12
    -- ind13 -> indicator_13
    -- ind14 -> indicator_14
    -- ind15 -> indicator_15
    -- ind16 -> indicator_16
    -- ind17 -> indicator_17
    -- ind18 -> indicator_18
    -- ind19 -> indicator_19
    -- ind20 -> indicator_20
    -- ind21 -> indicator_21
    -- ind22 -> indicator_22
    -- ind23 -> indicator_23
    -- ind24 -> indicator_24
    -- ind25 -> indicator_25
    -- ind26 -> indicator_26
    -- ind27 -> indicator_27
    -- ind28 -> indicator_28
    -- ind29 -> indicator_29
    -- ind30 -> indicator_30
    -- ind31 -> indicator_31
    -- ind32 -> indicator_32
    -- ind33 -> indicator_33
    -- ind34 -> indicator_34
    -- ind35 -> indicator_35
    -- ind36 -> indicator_36
    -- ind37 -> indicator_37
    -- ind38 -> indicator_38
    -- ind39 -> indicator_39
    -- ind40 -> indicator_40
    -- ancur -> salary_currency
    -- cpind -> currency_indicator
    -- flaga -> flag_additional
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "begda",
        "endda",
        "mandt" AS "client_code",
        "objps" AS "position_id",
        "pernr",
        "seqnr" AS "sequence_number",
        "sprps" AS "special_purpose",
        "subty" AS "subtype",
        "aedtm" AS "salary_record_date",
        "uname",
        "histo" AS "historical_indicator",
        "itxex" AS "record_id",
        "refex" AS "reference_id",
        "ordex" AS "order_index",
        "itbld" AS "it_build",
        "preas" AS "personnel_reason_code",
        "flag1" AS "flag_1",
        "flag2" AS "flag_2",
        "flag3" AS "flag_3",
        "flag4" AS "flag_4",
        "rese1" AS "reserve_field_1",
        "rese2" AS "reserved_field_2",
        "grpvl" AS "group_value",
        "trfar" AS "wage_type",
        "trfgb" AS "wage_area",
        "trfgr" AS "pay_scale_group",
        "trfst" AS "pay_scale_level",
        "stvor" AS "pay_scale_type",
        "orzst" AS "organizational_status",
        "partn" AS "partner_code",
        "waers",
        "vglta" AS "comparison_date",
        "vglgb" AS "comparison_wage_area",
        "vglgr" AS "comparison_pay_scale_group",
        "vglst" AS "comparison_pay_scale_level",
        "vglsv" AS "comparison_collective_agreement",
        "bsgrd",
        "divgv" AS "dividend_percentage",
        "ansal" AS "annual_salary",
        "falgk" AS "compensation_flag",
        "falgr" AS "reason_flag",
        "lga01",
        "bet01" AS "wage_component_1",
        "anz01" AS "wage_component_01",
        "ein01",
        "opk01" AS "org_key_01",
        "lga02",
        "bet02" AS "wage_component_2",
        "anz02" AS "wage_component_02",
        "ein02",
        "opk02" AS "org_key_02",
        "lga03",
        "bet03" AS "wage_component_3",
        "anz03" AS "wage_component_03",
        "ein03",
        "opk03" AS "org_key_03",
        "lga04",
        "bet04" AS "wage_component_4",
        "anz04" AS "wage_component_04",
        "ein04",
        "opk04" AS "org_key_04",
        "lga05",
        "bet05" AS "wage_component_5",
        "anz05" AS "wage_component_05",
        "ein05",
        "opk05" AS "org_key_05",
        "lga06",
        "bet06" AS "wage_component_6",
        "anz06" AS "wage_component_06",
        "ein06",
        "opk06" AS "org_key_06",
        "lga07",
        "bet07" AS "wage_component_7",
        "anz07" AS "wage_component_07",
        "ein07",
        "opk07" AS "org_key_07",
        "lga08",
        "bet08" AS "wage_component_8",
        "anz08" AS "wage_component_08",
        "ein08",
        "opk08" AS "org_key_08",
        "lga09" AS "location",
        "bet09" AS "wage_component_9",
        "anz09" AS "wage_component_09",
        "ein09",
        "opk09" AS "org_key_09",
        "lga10",
        "bet10",
        "anz10",
        "ein10",
        "opk10" AS "org_key_10",
        "lga11",
        "bet11",
        "anz11",
        "ein11",
        "opk11" AS "org_key_11",
        "lga12",
        "bet12",
        "anz12",
        "ein12" AS "allowance",
        "opk12" AS "org_key_12",
        "lga13" AS "overtime",
        "bet13",
        "anz13",
        "ein13" AS "overtime_pay",
        "opk13" AS "org_key_13",
        "lga14" AS "allowances",
        "bet14",
        "anz14",
        "ein14" AS "commission",
        "opk14" AS "org_key_14",
        "lga15" AS "benefits",
        "bet15" AS "salary_component_15",
        "anz15" AS "wage_component_15",
        "ein15",
        "opk15" AS "org_key_15",
        "lga16",
        "bet16" AS "salary_component_16",
        "anz16" AS "wage_component_16",
        "ein16",
        "opk16" AS "org_key_16",
        "lga17",
        "bet17" AS "salary_component_17",
        "anz17" AS "wage_component_17",
        "ein17",
        "opk17" AS "org_key_17",
        "lga18",
        "bet18" AS "salary_component_18",
        "anz18",
        "ein18",
        "opk18",
        "lga19",
        "bet19" AS "salary_component_19",
        "anz19",
        "ein19",
        "opk19",
        "lga20" AS "manager_id",
        "bet20" AS "salary_component_20",
        "anz20",
        "ein20" AS "salary_review_date",
        "opk20",
        "lga21",
        "bet21" AS "salary_component_21",
        "anz21",
        "ein21" AS "benefits_eligible",
        "opk21",
        "lga22" AS "next_review_date",
        "bet22" AS "salary_component_22",
        "anz22",
        "ein22",
        "opk22",
        "lga23" AS "adjustment_reason",
        "bet23" AS "salary_component_23",
        "anz23",
        "ein23" AS "retirement_contribution",
        "opk23",
        "lga24" AS "union_status",
        "bet24" AS "salary_component_24",
        "anz24",
        "ein24" AS "health_insurance_plan",
        "opk24",
        "lga25" AS "work_schedule",
        "bet25" AS "salary_component_25",
        "anz25",
        "ein25" AS "vacation_days",
        "opk25",
        "lga26" AS "commission_rate",
        "bet26" AS "salary_component_26",
        "anz26" AS "unknown_value_26",
        "ein26" AS "sick_leave",
        "opk26" AS "wage_component_26",
        "lga27",
        "bet27" AS "salary_component_27",
        "anz27" AS "unknown_value_27",
        "ein27" AS "training_budget",
        "opk27" AS "wage_component_27",
        "lga28" AS "retirement_contributions",
        "bet28" AS "salary_component_28",
        "anz28" AS "unknown_value_28",
        "ein28",
        "opk28" AS "wage_component_28",
        "lga29" AS "compensation_notes",
        "bet29" AS "salary_component_29",
        "anz29" AS "unknown_value_29",
        "ein29" AS "next_pay_raise_date",
        "opk29" AS "wage_component_29",
        "lga30" AS "org_attribute_30",
        "bet30" AS "salary_component_30",
        "anz30" AS "unknown_value_30",
        "ein30" AS "probation_end_date",
        "opk30" AS "wage_component_30",
        "lga31" AS "org_attribute_31",
        "bet31" AS "salary_component_31",
        "anz31" AS "unknown_value_31",
        "ein31" AS "contract_end_date",
        "opk31" AS "wage_component_31",
        "lga32" AS "org_attribute_32",
        "bet32" AS "salary_component_32",
        "anz32" AS "unknown_value_32",
        "ein32" AS "employee_id_32",
        "opk32" AS "wage_component_32",
        "lga33" AS "org_attribute_33",
        "bet33" AS "salary_component_33",
        "anz33" AS "unknown_value_33",
        "ein33" AS "employee_id_33",
        "opk33" AS "wage_component_33",
        "lga34" AS "org_attribute_34",
        "bet34" AS "salary_component_34",
        "anz34" AS "unknown_value_34",
        "ein34" AS "employee_id_34",
        "opk34" AS "wage_component_34",
        "lga35" AS "org_attribute_35",
        "bet35" AS "salary_component_35",
        "anz35" AS "unknown_value_35",
        "ein35" AS "employee_id_35",
        "opk35" AS "wage_component_35",
        "lga36" AS "org_attribute_36",
        "bet36" AS "salary_component_36",
        "anz36" AS "unknown_value_36",
        "ein36" AS "employee_id_36",
        "opk36" AS "wage_component_36",
        "lga37" AS "org_attribute_37",
        "bet37" AS "salary_component_37",
        "anz37" AS "unknown_value_37",
        "ein37" AS "employee_id_37",
        "opk37" AS "wage_component_37",
        "lga38" AS "org_attribute_38",
        "bet38" AS "salary_component_38",
        "anz38" AS "unknown_value_38",
        "ein38" AS "employee_id_38",
        "opk38" AS "wage_component_38",
        "lga39" AS "org_attribute_39",
        "bet39" AS "salary_component_39",
        "anz39" AS "unknown_value_39",
        "ein39" AS "employee_id_39",
        "opk39" AS "wage_component_39",
        "lga40" AS "org_attribute_40",
        "bet40" AS "salary_component_40",
        "anz40" AS "unknown_value_40",
        "ein40" AS "employee_id_40",
        "opk40" AS "wage_component_40",
        "ind01" AS "indicator_1",
        "ind02" AS "indicator_2",
        "ind03" AS "indicator_3",
        "ind04" AS "indicator_4",
        "ind05" AS "indicator_5",
        "ind06" AS "indicator_6",
        "ind07" AS "indicator_7",
        "ind08" AS "indicator_8",
        "ind09" AS "indicator_9",
        "ind10" AS "indicator_10",
        "ind11" AS "indicator_11",
        "ind12" AS "indicator_12",
        "ind13" AS "indicator_13",
        "ind14" AS "indicator_14",
        "ind15" AS "indicator_15",
        "ind16" AS "indicator_16",
        "ind17" AS "indicator_17",
        "ind18" AS "indicator_18",
        "ind19" AS "indicator_19",
        "ind20" AS "indicator_20",
        "ind21" AS "indicator_21",
        "ind22" AS "indicator_22",
        "ind23" AS "indicator_23",
        "ind24" AS "indicator_24",
        "ind25" AS "indicator_25",
        "ind26" AS "indicator_26",
        "ind27" AS "indicator_27",
        "ind28" AS "indicator_28",
        "ind29" AS "indicator_29",
        "ind30" AS "indicator_30",
        "ind31" AS "indicator_31",
        "ind32" AS "indicator_32",
        "ind33" AS "indicator_33",
        "ind34" AS "indicator_34",
        "ind35" AS "indicator_35",
        "ind36" AS "indicator_36",
        "ind37" AS "indicator_37",
        "ind38" AS "indicator_38",
        "ind39" AS "indicator_39",
        "ind40" AS "indicator_40",
        "ancur" AS "salary_currency",
        "cpind" AS "currency_indicator",
        "flaga" AS "flag_additional",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_pa0008_data_projected"
),

"sap_pa0008_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- adjustment_reason: from DECIMAL to VARCHAR
    -- allowance: from DECIMAL to VARCHAR
    -- allowances: from DECIMAL to VARCHAR
    -- begda: from INT to DATE
    -- benefits: from DECIMAL to VARCHAR
    -- benefits_eligible: from DECIMAL to VARCHAR
    -- client_code: from INT to VARCHAR
    -- commission: from DECIMAL to VARCHAR
    -- commission_rate: from DECIMAL to VARCHAR
    -- comparison_date: from DECIMAL to DATE
    -- comparison_wage_area: from DECIMAL to VARCHAR
    -- compensation_flag: from DECIMAL to VARCHAR
    -- compensation_notes: from DECIMAL to VARCHAR
    -- contract_end_date: from DECIMAL to DATE
    -- ein01: from DECIMAL to VARCHAR
    -- ein02: from DECIMAL to VARCHAR
    -- ein03: from DECIMAL to VARCHAR
    -- ein04: from DECIMAL to VARCHAR
    -- ein05: from DECIMAL to VARCHAR
    -- ein06: from DECIMAL to VARCHAR
    -- ein07: from DECIMAL to VARCHAR
    -- ein08: from DECIMAL to VARCHAR
    -- ein09: from DECIMAL to VARCHAR
    -- ein10: from DECIMAL to VARCHAR
    -- ein11: from DECIMAL to VARCHAR
    -- ein15: from DECIMAL to VARCHAR
    -- ein16: from DECIMAL to VARCHAR
    -- ein17: from DECIMAL to VARCHAR
    -- ein18: from DECIMAL to VARCHAR
    -- ein19: from DECIMAL to VARCHAR
    -- ein22: from DECIMAL to VARCHAR
    -- ein28: from DECIMAL to VARCHAR
    -- employee_id_32: from DECIMAL to VARCHAR
    -- employee_id_33: from DECIMAL to VARCHAR
    -- employee_id_34: from DECIMAL to VARCHAR
    -- employee_id_35: from DECIMAL to VARCHAR
    -- employee_id_36: from DECIMAL to VARCHAR
    -- employee_id_37: from DECIMAL to VARCHAR
    -- employee_id_38: from DECIMAL to VARCHAR
    -- employee_id_39: from DECIMAL to VARCHAR
    -- employee_id_40: from DECIMAL to VARCHAR
    -- endda: from INT to DATE
    -- flag_1: from DECIMAL to VARCHAR
    -- flag_2: from DECIMAL to VARCHAR
    -- flag_3: from DECIMAL to VARCHAR
    -- flag_4: from DECIMAL to VARCHAR
    -- flag_additional: from DECIMAL to VARCHAR
    -- group_value: from DECIMAL to VARCHAR
    -- health_insurance_plan: from DECIMAL to VARCHAR
    -- historical_indicator: from DECIMAL to VARCHAR
    -- indicator_10: from DECIMAL to VARCHAR
    -- indicator_11: from DECIMAL to VARCHAR
    -- indicator_12: from DECIMAL to VARCHAR
    -- indicator_13: from DECIMAL to VARCHAR
    -- indicator_14: from DECIMAL to VARCHAR
    -- indicator_15: from DECIMAL to VARCHAR
    -- indicator_16: from DECIMAL to VARCHAR
    -- indicator_17: from DECIMAL to VARCHAR
    -- indicator_18: from DECIMAL to VARCHAR
    -- indicator_19: from DECIMAL to VARCHAR
    -- indicator_20: from DECIMAL to VARCHAR
    -- indicator_21: from DECIMAL to VARCHAR
    -- indicator_22: from DECIMAL to VARCHAR
    -- indicator_23: from DECIMAL to VARCHAR
    -- indicator_24: from DECIMAL to VARCHAR
    -- indicator_25: from DECIMAL to VARCHAR
    -- indicator_26: from DECIMAL to VARCHAR
    -- indicator_27: from DECIMAL to VARCHAR
    -- indicator_28: from DECIMAL to VARCHAR
    -- indicator_29: from DECIMAL to VARCHAR
    -- indicator_3: from DECIMAL to VARCHAR
    -- indicator_30: from DECIMAL to VARCHAR
    -- indicator_31: from DECIMAL to VARCHAR
    -- indicator_32: from DECIMAL to VARCHAR
    -- indicator_33: from DECIMAL to VARCHAR
    -- indicator_34: from DECIMAL to VARCHAR
    -- indicator_35: from DECIMAL to VARCHAR
    -- indicator_36: from DECIMAL to VARCHAR
    -- indicator_37: from DECIMAL to VARCHAR
    -- indicator_38: from DECIMAL to VARCHAR
    -- indicator_39: from DECIMAL to VARCHAR
    -- indicator_4: from DECIMAL to VARCHAR
    -- indicator_40: from DECIMAL to VARCHAR
    -- indicator_5: from DECIMAL to VARCHAR
    -- indicator_6: from DECIMAL to VARCHAR
    -- indicator_7: from DECIMAL to VARCHAR
    -- indicator_8: from DECIMAL to VARCHAR
    -- indicator_9: from DECIMAL to VARCHAR
    -- it_build: from DECIMAL to VARCHAR
    -- lga03: from DECIMAL to VARCHAR
    -- lga04: from DECIMAL to VARCHAR
    -- lga05: from DECIMAL to VARCHAR
    -- lga06: from DECIMAL to VARCHAR
    -- lga07: from DECIMAL to VARCHAR
    -- lga08: from DECIMAL to VARCHAR
    -- lga10: from DECIMAL to VARCHAR
    -- lga11: from DECIMAL to VARCHAR
    -- lga12: from DECIMAL to VARCHAR
    -- lga16: from DECIMAL to VARCHAR
    -- lga17: from DECIMAL to VARCHAR
    -- lga18: from DECIMAL to VARCHAR
    -- lga19: from DECIMAL to VARCHAR
    -- lga21: from DECIMAL to VARCHAR
    -- lga27: from DECIMAL to VARCHAR
    -- location: from DECIMAL to VARCHAR
    -- manager_id: from DECIMAL to INT
    -- next_pay_raise_date: from DECIMAL to DATE
    -- next_review_date: from DECIMAL to DATE
    -- opk18: from DECIMAL to VARCHAR
    -- opk19: from DECIMAL to VARCHAR
    -- opk20: from DECIMAL to VARCHAR
    -- opk21: from DECIMAL to VARCHAR
    -- opk22: from DECIMAL to VARCHAR
    -- opk23: from DECIMAL to VARCHAR
    -- opk24: from DECIMAL to VARCHAR
    -- opk25: from DECIMAL to VARCHAR
    -- order_index: from DECIMAL to INT
    -- org_attribute_30: from DECIMAL to VARCHAR
    -- org_attribute_31: from DECIMAL to VARCHAR
    -- org_attribute_32: from DECIMAL to VARCHAR
    -- org_attribute_33: from DECIMAL to VARCHAR
    -- org_attribute_34: from DECIMAL to VARCHAR
    -- org_attribute_35: from DECIMAL to VARCHAR
    -- org_attribute_36: from DECIMAL to VARCHAR
    -- org_attribute_37: from DECIMAL to VARCHAR
    -- org_attribute_38: from DECIMAL to VARCHAR
    -- org_attribute_39: from DECIMAL to VARCHAR
    -- org_attribute_40: from DECIMAL to VARCHAR
    -- org_key_01: from DECIMAL to VARCHAR
    -- org_key_02: from DECIMAL to VARCHAR
    -- org_key_03: from DECIMAL to VARCHAR
    -- org_key_04: from DECIMAL to VARCHAR
    -- org_key_05: from DECIMAL to VARCHAR
    -- org_key_06: from DECIMAL to VARCHAR
    -- org_key_07: from DECIMAL to VARCHAR
    -- org_key_08: from DECIMAL to VARCHAR
    -- org_key_09: from DECIMAL to VARCHAR
    -- org_key_10: from DECIMAL to VARCHAR
    -- org_key_11: from DECIMAL to VARCHAR
    -- org_key_12: from DECIMAL to VARCHAR
    -- org_key_13: from DECIMAL to VARCHAR
    -- org_key_14: from DECIMAL to VARCHAR
    -- org_key_15: from DECIMAL to VARCHAR
    -- org_key_16: from DECIMAL to VARCHAR
    -- org_key_17: from DECIMAL to VARCHAR
    -- organizational_status: from DECIMAL to VARCHAR
    -- overtime: from DECIMAL to VARCHAR
    -- overtime_pay: from DECIMAL to VARCHAR
    -- partner_code: from DECIMAL to VARCHAR
    -- pernr: from INT to VARCHAR
    -- personnel_reason_code: from DECIMAL to VARCHAR
    -- position_id: from DECIMAL to VARCHAR
    -- probation_end_date: from DECIMAL to DATE
    -- reason_flag: from DECIMAL to VARCHAR
    -- record_id: from DECIMAL to VARCHAR
    -- reference_id: from DECIMAL to VARCHAR
    -- reserve_field_1: from DECIMAL to VARCHAR
    -- reserved_field_2: from DECIMAL to VARCHAR
    -- retirement_contribution: from DECIMAL to VARCHAR
    -- retirement_contributions: from DECIMAL to VARCHAR
    -- salary_record_date: from INT to DATE
    -- salary_review_date: from DECIMAL to DATE
    -- sick_leave: from DECIMAL to VARCHAR
    -- special_purpose: from DECIMAL to VARCHAR
    -- training_budget: from DECIMAL to VARCHAR
    -- union_status: from DECIMAL to VARCHAR
    -- vacation_days: from DECIMAL to VARCHAR
    -- wage_component_26: from DECIMAL to VARCHAR
    -- wage_component_27: from DECIMAL to VARCHAR
    -- wage_component_28: from DECIMAL to VARCHAR
    -- wage_component_29: from DECIMAL to VARCHAR
    -- wage_component_30: from DECIMAL to VARCHAR
    -- wage_component_31: from DECIMAL to VARCHAR
    -- wage_component_32: from DECIMAL to VARCHAR
    -- wage_component_33: from DECIMAL to VARCHAR
    -- wage_component_34: from DECIMAL to VARCHAR
    -- wage_component_35: from DECIMAL to VARCHAR
    -- wage_component_36: from DECIMAL to VARCHAR
    -- wage_component_37: from DECIMAL to VARCHAR
    -- wage_component_38: from DECIMAL to VARCHAR
    -- wage_component_39: from DECIMAL to VARCHAR
    -- wage_component_40: from DECIMAL to VARCHAR
    -- work_schedule: from DECIMAL to VARCHAR
    SELECT
        "sequence_number",
        "subtype",
        "uname",
        "wage_type",
        "wage_area",
        "pay_scale_group",
        "pay_scale_level",
        "pay_scale_type",
        "waers",
        "comparison_pay_scale_group",
        "comparison_pay_scale_level",
        "comparison_collective_agreement",
        "bsgrd",
        "dividend_percentage",
        "annual_salary",
        "lga01",
        "wage_component_1",
        "wage_component_01",
        "lga02",
        "wage_component_2",
        "wage_component_02",
        "wage_component_3",
        "wage_component_03",
        "wage_component_4",
        "wage_component_04",
        "wage_component_5",
        "wage_component_05",
        "wage_component_6",
        "wage_component_06",
        "wage_component_7",
        "wage_component_07",
        "wage_component_8",
        "wage_component_08",
        "wage_component_9",
        "wage_component_09",
        "bet10",
        "anz10",
        "bet11",
        "anz11",
        "bet12",
        "anz12",
        "bet13",
        "anz13",
        "bet14",
        "anz14",
        "salary_component_15",
        "wage_component_15",
        "salary_component_16",
        "wage_component_16",
        "salary_component_17",
        "wage_component_17",
        "salary_component_18",
        "anz18",
        "salary_component_19",
        "anz19",
        "salary_component_20",
        "anz20",
        "salary_component_21",
        "anz21",
        "salary_component_22",
        "anz22",
        "salary_component_23",
        "anz23",
        "salary_component_24",
        "anz24",
        "salary_component_25",
        "anz25",
        "salary_component_26",
        "unknown_value_26",
        "salary_component_27",
        "unknown_value_27",
        "salary_component_28",
        "unknown_value_28",
        "salary_component_29",
        "unknown_value_29",
        "salary_component_30",
        "unknown_value_30",
        "salary_component_31",
        "unknown_value_31",
        "salary_component_32",
        "unknown_value_32",
        "salary_component_33",
        "unknown_value_33",
        "salary_component_34",
        "unknown_value_34",
        "salary_component_35",
        "unknown_value_35",
        "salary_component_36",
        "unknown_value_36",
        "salary_component_37",
        "unknown_value_37",
        "salary_component_38",
        "unknown_value_38",
        "salary_component_39",
        "unknown_value_39",
        "salary_component_40",
        "unknown_value_40",
        "indicator_1",
        "indicator_2",
        "salary_currency",
        "currency_indicator",
        "row_id",
        "is_deleted",
        CAST("adjustment_reason" AS VARCHAR) AS "adjustment_reason",
        CAST("allowance" AS VARCHAR) AS "allowance",
        CAST("allowances" AS VARCHAR) AS "allowances",
        strptime(CAST("begda" AS VARCHAR), '%Y%m%d') AS "begda",
        CAST("benefits" AS VARCHAR) AS "benefits",
        CAST("benefits_eligible" AS VARCHAR) AS "benefits_eligible",
        CAST("client_code" AS VARCHAR) AS "client_code",
        CAST("commission" AS VARCHAR) AS "commission",
        CAST("commission_rate" AS VARCHAR) AS "commission_rate",
        CAST("comparison_date" AS DATE) AS "comparison_date",
        CAST("comparison_wage_area" AS VARCHAR) AS "comparison_wage_area",
        CAST("compensation_flag" AS VARCHAR) AS "compensation_flag",
        CAST("compensation_notes" AS VARCHAR) AS "compensation_notes",
        CAST("contract_end_date" AS DATE) AS "contract_end_date",
        CAST("ein01" AS VARCHAR) AS "ein01",
        CAST("ein02" AS VARCHAR) AS "ein02",
        CAST("ein03" AS VARCHAR) AS "ein03",
        CAST("ein04" AS VARCHAR) AS "ein04",
        CAST("ein05" AS VARCHAR) AS "ein05",
        CAST("ein06" AS VARCHAR) AS "ein06",
        CAST("ein07" AS VARCHAR) AS "ein07",
        CAST("ein08" AS VARCHAR) AS "ein08",
        CAST("ein09" AS VARCHAR) AS "ein09",
        CAST("ein10" AS VARCHAR) AS "ein10",
        CAST("ein11" AS VARCHAR) AS "ein11",
        CAST("ein15" AS VARCHAR) AS "ein15",
        CAST("ein16" AS VARCHAR) AS "ein16",
        CAST("ein17" AS VARCHAR) AS "ein17",
        CAST("ein18" AS VARCHAR) AS "ein18",
        CAST("ein19" AS VARCHAR) AS "ein19",
        CAST("ein22" AS VARCHAR) AS "ein22",
        CAST("ein28" AS VARCHAR) AS "ein28",
        CAST("employee_id_32" AS VARCHAR) AS "employee_id_32",
        CAST("employee_id_33" AS VARCHAR) AS "employee_id_33",
        CAST("employee_id_34" AS VARCHAR) AS "employee_id_34",
        CAST("employee_id_35" AS VARCHAR) AS "employee_id_35",
        CAST("employee_id_36" AS VARCHAR) AS "employee_id_36",
        CAST("employee_id_37" AS VARCHAR) AS "employee_id_37",
        CAST("employee_id_38" AS VARCHAR) AS "employee_id_38",
        CAST("employee_id_39" AS VARCHAR) AS "employee_id_39",
        CAST("employee_id_40" AS VARCHAR) AS "employee_id_40",
        strptime(CAST("endda" AS VARCHAR), '%Y%m%d') AS "endda",
        CAST("flag_1" AS VARCHAR) AS "flag_1",
        CAST("flag_2" AS VARCHAR) AS "flag_2",
        CAST("flag_3" AS VARCHAR) AS "flag_3",
        CAST("flag_4" AS VARCHAR) AS "flag_4",
        CAST("flag_additional" AS VARCHAR) AS "flag_additional",
        CAST("group_value" AS VARCHAR) AS "group_value",
        CAST("health_insurance_plan" AS VARCHAR) AS "health_insurance_plan",
        CAST("historical_indicator" AS VARCHAR) AS "historical_indicator",
        CAST("indicator_10" AS VARCHAR) AS "indicator_10",
        CAST("indicator_11" AS VARCHAR) AS "indicator_11",
        CAST("indicator_12" AS VARCHAR) AS "indicator_12",
        CAST("indicator_13" AS VARCHAR) AS "indicator_13",
        CAST("indicator_14" AS VARCHAR) AS "indicator_14",
        CAST("indicator_15" AS VARCHAR) AS "indicator_15",
        CAST("indicator_16" AS VARCHAR) AS "indicator_16",
        CAST("indicator_17" AS VARCHAR) AS "indicator_17",
        CAST("indicator_18" AS VARCHAR) AS "indicator_18",
        CAST("indicator_19" AS VARCHAR) AS "indicator_19",
        CAST("indicator_20" AS VARCHAR) AS "indicator_20",
        CAST("indicator_21" AS VARCHAR) AS "indicator_21",
        CAST("indicator_22" AS VARCHAR) AS "indicator_22",
        CAST("indicator_23" AS VARCHAR) AS "indicator_23",
        CAST("indicator_24" AS VARCHAR) AS "indicator_24",
        CAST("indicator_25" AS VARCHAR) AS "indicator_25",
        CAST("indicator_26" AS VARCHAR) AS "indicator_26",
        CAST("indicator_27" AS VARCHAR) AS "indicator_27",
        CAST("indicator_28" AS VARCHAR) AS "indicator_28",
        CAST("indicator_29" AS VARCHAR) AS "indicator_29",
        CAST("indicator_3" AS VARCHAR) AS "indicator_3",
        CAST("indicator_30" AS VARCHAR) AS "indicator_30",
        CAST("indicator_31" AS VARCHAR) AS "indicator_31",
        CAST("indicator_32" AS VARCHAR) AS "indicator_32",
        CAST("indicator_33" AS VARCHAR) AS "indicator_33",
        CAST("indicator_34" AS VARCHAR) AS "indicator_34",
        CAST("indicator_35" AS VARCHAR) AS "indicator_35",
        CAST("indicator_36" AS VARCHAR) AS "indicator_36",
        CAST("indicator_37" AS VARCHAR) AS "indicator_37",
        CAST("indicator_38" AS VARCHAR) AS "indicator_38",
        CAST("indicator_39" AS VARCHAR) AS "indicator_39",
        CAST("indicator_4" AS VARCHAR) AS "indicator_4",
        CAST("indicator_40" AS VARCHAR) AS "indicator_40",
        CAST("indicator_5" AS VARCHAR) AS "indicator_5",
        CAST("indicator_6" AS VARCHAR) AS "indicator_6",
        CAST("indicator_7" AS VARCHAR) AS "indicator_7",
        CAST("indicator_8" AS VARCHAR) AS "indicator_8",
        CAST("indicator_9" AS VARCHAR) AS "indicator_9",
        CAST("it_build" AS VARCHAR) AS "it_build",
        CAST("lga03" AS VARCHAR) AS "lga03",
        CAST("lga04" AS VARCHAR) AS "lga04",
        CAST("lga05" AS VARCHAR) AS "lga05",
        CAST("lga06" AS VARCHAR) AS "lga06",
        CAST("lga07" AS VARCHAR) AS "lga07",
        CAST("lga08" AS VARCHAR) AS "lga08",
        CAST("lga10" AS VARCHAR) AS "lga10",
        CAST("lga11" AS VARCHAR) AS "lga11",
        CAST("lga12" AS VARCHAR) AS "lga12",
        CAST("lga16" AS VARCHAR) AS "lga16",
        CAST("lga17" AS VARCHAR) AS "lga17",
        CAST("lga18" AS VARCHAR) AS "lga18",
        CAST("lga19" AS VARCHAR) AS "lga19",
        CAST("lga21" AS VARCHAR) AS "lga21",
        CAST("lga27" AS VARCHAR) AS "lga27",
        CAST("location" AS VARCHAR) AS "location",
        CAST("manager_id" AS INT) AS "manager_id",
        CAST("next_pay_raise_date" AS DATE) AS "next_pay_raise_date",
        CAST("next_review_date" AS DATE) AS "next_review_date",
        CAST("opk18" AS VARCHAR) AS "opk18",
        CAST("opk19" AS VARCHAR) AS "opk19",
        CAST("opk20" AS VARCHAR) AS "opk20",
        CAST("opk21" AS VARCHAR) AS "opk21",
        CAST("opk22" AS VARCHAR) AS "opk22",
        CAST("opk23" AS VARCHAR) AS "opk23",
        CAST("opk24" AS VARCHAR) AS "opk24",
        CAST("opk25" AS VARCHAR) AS "opk25",
        CAST("order_index" AS INT) AS "order_index",
        CAST("org_attribute_30" AS VARCHAR) AS "org_attribute_30",
        CAST("org_attribute_31" AS VARCHAR) AS "org_attribute_31",
        CAST("org_attribute_32" AS VARCHAR) AS "org_attribute_32",
        CAST("org_attribute_33" AS VARCHAR) AS "org_attribute_33",
        CAST("org_attribute_34" AS VARCHAR) AS "org_attribute_34",
        CAST("org_attribute_35" AS VARCHAR) AS "org_attribute_35",
        CAST("org_attribute_36" AS VARCHAR) AS "org_attribute_36",
        CAST("org_attribute_37" AS VARCHAR) AS "org_attribute_37",
        CAST("org_attribute_38" AS VARCHAR) AS "org_attribute_38",
        CAST("org_attribute_39" AS VARCHAR) AS "org_attribute_39",
        CAST("org_attribute_40" AS VARCHAR) AS "org_attribute_40",
        CAST("org_key_01" AS VARCHAR) AS "org_key_01",
        CAST("org_key_02" AS VARCHAR) AS "org_key_02",
        CAST("org_key_03" AS VARCHAR) AS "org_key_03",
        CAST("org_key_04" AS VARCHAR) AS "org_key_04",
        CAST("org_key_05" AS VARCHAR) AS "org_key_05",
        CAST("org_key_06" AS VARCHAR) AS "org_key_06",
        CAST("org_key_07" AS VARCHAR) AS "org_key_07",
        CAST("org_key_08" AS VARCHAR) AS "org_key_08",
        CAST("org_key_09" AS VARCHAR) AS "org_key_09",
        CAST("org_key_10" AS VARCHAR) AS "org_key_10",
        CAST("org_key_11" AS VARCHAR) AS "org_key_11",
        CAST("org_key_12" AS VARCHAR) AS "org_key_12",
        CAST("org_key_13" AS VARCHAR) AS "org_key_13",
        CAST("org_key_14" AS VARCHAR) AS "org_key_14",
        CAST("org_key_15" AS VARCHAR) AS "org_key_15",
        CAST("org_key_16" AS VARCHAR) AS "org_key_16",
        CAST("org_key_17" AS VARCHAR) AS "org_key_17",
        CAST("organizational_status" AS VARCHAR) AS "organizational_status",
        CAST("overtime" AS VARCHAR) AS "overtime",
        CAST("overtime_pay" AS VARCHAR) AS "overtime_pay",
        CAST("partner_code" AS VARCHAR) AS "partner_code",
        CAST("pernr" AS VARCHAR) AS "pernr",
        CAST("personnel_reason_code" AS VARCHAR) AS "personnel_reason_code",
        CAST("position_id" AS VARCHAR) AS "position_id",
        CAST("probation_end_date" AS DATE) AS "probation_end_date",
        CAST("reason_flag" AS VARCHAR) AS "reason_flag",
        CAST("record_id" AS VARCHAR) AS "record_id",
        CAST("reference_id" AS VARCHAR) AS "reference_id",
        CAST("reserve_field_1" AS VARCHAR) AS "reserve_field_1",
        CAST("reserved_field_2" AS VARCHAR) AS "reserved_field_2",
        CAST("retirement_contribution" AS VARCHAR) AS "retirement_contribution",
        CAST("retirement_contributions" AS VARCHAR) AS "retirement_contributions",
        strptime(CAST("salary_record_date" AS VARCHAR), '%Y%m%d') AS "salary_record_date",
        CAST("salary_review_date" AS DATE) AS "salary_review_date",
        CAST("sick_leave" AS VARCHAR) AS "sick_leave",
        CAST("special_purpose" AS VARCHAR) AS "special_purpose",
        CAST("training_budget" AS VARCHAR) AS "training_budget",
        CAST("union_status" AS VARCHAR) AS "union_status",
        CAST("vacation_days" AS VARCHAR) AS "vacation_days",
        CAST("wage_component_26" AS VARCHAR) AS "wage_component_26",
        CAST("wage_component_27" AS VARCHAR) AS "wage_component_27",
        CAST("wage_component_28" AS VARCHAR) AS "wage_component_28",
        CAST("wage_component_29" AS VARCHAR) AS "wage_component_29",
        CAST("wage_component_30" AS VARCHAR) AS "wage_component_30",
        CAST("wage_component_31" AS VARCHAR) AS "wage_component_31",
        CAST("wage_component_32" AS VARCHAR) AS "wage_component_32",
        CAST("wage_component_33" AS VARCHAR) AS "wage_component_33",
        CAST("wage_component_34" AS VARCHAR) AS "wage_component_34",
        CAST("wage_component_35" AS VARCHAR) AS "wage_component_35",
        CAST("wage_component_36" AS VARCHAR) AS "wage_component_36",
        CAST("wage_component_37" AS VARCHAR) AS "wage_component_37",
        CAST("wage_component_38" AS VARCHAR) AS "wage_component_38",
        CAST("wage_component_39" AS VARCHAR) AS "wage_component_39",
        CAST("wage_component_40" AS VARCHAR) AS "wage_component_40",
        CAST("work_schedule" AS VARCHAR) AS "work_schedule"
    FROM "sap_pa0008_data_projected_renamed"
),

"sap_pa0008_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 170 columns with unacceptable missing values
    -- comparison_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- comparison_pay_scale_group has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- comparison_pay_scale_level has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- comparison_wage_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- compensation_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- compensation_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein01 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein02 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein03 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein04 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein05 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein06 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein07 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein08 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein09 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein10 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein11 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein15 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein16 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein17 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein18 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein19 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein22 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ein28 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_32 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_33 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_34 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_35 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_36 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_37 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_38 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_39 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_id_40 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- flag_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- flag_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- flag_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- flag_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- flag_additional has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_value has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- health_insurance_plan has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_10 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_11 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_12 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_13 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_14 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_15 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_16 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_17 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_18 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_19 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_20 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_21 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_22 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_23 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_24 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_25 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_26 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_27 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_28 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_29 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_30 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_31 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_32 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_33 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_34 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_35 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_36 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_37 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_38 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_39 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_40 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_6 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_7 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_8 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- indicator_9 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- it_build has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga03 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga04 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga05 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga06 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga07 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga08 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga10 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga11 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga12 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga16 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga17 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga18 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga19 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga21 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lga27 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- location has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- manager_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- next_pay_raise_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- next_review_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk18 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk19 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk20 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk21 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk22 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk23 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk24 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- opk25 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- order_index has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_30 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_31 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_32 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_33 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_34 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_35 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_36 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_37 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_38 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_39 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_attribute_40 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_01 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_02 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_03 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_04 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_05 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_06 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_07 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_08 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_09 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_10 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_11 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_12 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_13 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_14 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_15 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_16 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- org_key_17 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- organizational_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- overtime has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- overtime_pay has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- personnel_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- position_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- probation_end_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reason_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserve_field_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reserved_field_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- retirement_contribution has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- retirement_contributions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sick_leave has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- special_purpose has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- training_budget has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- union_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vacation_days has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_26 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_27 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_28 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_29 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_30 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_31 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_32 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_33 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_34 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_35 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_36 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_37 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_38 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_39 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wage_component_40 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- work_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "sequence_number",
        "subtype",
        "uname",
        "wage_type",
        "wage_area",
        "pay_scale_group",
        "pay_scale_level",
        "pay_scale_type",
        "waers",
        "comparison_pay_scale_group",
        "comparison_pay_scale_level",
        "comparison_collective_agreement",
        "bsgrd",
        "dividend_percentage",
        "annual_salary",
        "lga01",
        "wage_component_1",
        "wage_component_01",
        "lga02",
        "wage_component_2",
        "wage_component_02",
        "wage_component_3",
        "wage_component_03",
        "wage_component_4",
        "wage_component_04",
        "wage_component_5",
        "wage_component_05",
        "wage_component_6",
        "wage_component_06",
        "wage_component_7",
        "wage_component_07",
        "wage_component_8",
        "wage_component_08",
        "wage_component_9",
        "wage_component_09",
        "bet10",
        "anz10",
        "bet11",
        "anz11",
        "bet12",
        "anz12",
        "bet13",
        "anz13",
        "bet14",
        "anz14",
        "salary_component_15",
        "wage_component_15",
        "salary_component_16",
        "wage_component_16",
        "salary_component_17",
        "wage_component_17",
        "salary_component_18",
        "anz18",
        "salary_component_19",
        "anz19",
        "salary_component_20",
        "anz20",
        "salary_component_21",
        "anz21",
        "salary_component_22",
        "anz22",
        "salary_component_23",
        "anz23",
        "salary_component_24",
        "anz24",
        "salary_component_25",
        "anz25",
        "salary_component_26",
        "unknown_value_26",
        "salary_component_27",
        "unknown_value_27",
        "salary_component_28",
        "unknown_value_28",
        "salary_component_29",
        "unknown_value_29",
        "salary_component_30",
        "unknown_value_30",
        "salary_component_31",
        "unknown_value_31",
        "salary_component_32",
        "unknown_value_32",
        "salary_component_33",
        "unknown_value_33",
        "salary_component_34",
        "unknown_value_34",
        "salary_component_35",
        "unknown_value_35",
        "salary_component_36",
        "unknown_value_36",
        "salary_component_37",
        "unknown_value_37",
        "salary_component_38",
        "unknown_value_38",
        "salary_component_39",
        "unknown_value_39",
        "salary_component_40",
        "unknown_value_40",
        "indicator_1",
        "indicator_2",
        "salary_currency",
        "currency_indicator",
        "row_id",
        "is_deleted",
        "adjustment_reason",
        "allowance",
        "allowances",
        "begda",
        "benefits",
        "benefits_eligible",
        "client_code",
        "commission",
        "commission_rate",
        "contract_end_date",
        "endda",
        "historical_indicator",
        "pernr",
        "salary_record_date",
        "salary_review_date"
    FROM "sap_pa0008_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_pa0008_data_projected_renamed_casted_missing_handled"