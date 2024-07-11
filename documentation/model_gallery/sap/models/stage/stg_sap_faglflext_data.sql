-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 04:44:35.524411+00:00
WITH 
"sap_faglflext_data_projected" AS (
    -- Projection: Selecting 126 out of 127 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "drcrk",
        "objnr00",
        "objnr01",
        "objnr02",
        "objnr03",
        "objnr04",
        "objnr05",
        "objnr06",
        "objnr07",
        "objnr08",
        "rclnt",
        "rpmax",
        "ryear",
        "activ",
        "rmvct",
        "rtcur",
        "runit",
        "awtyp",
        "rldnr",
        "rrcty",
        "rvers",
        "logsys",
        "racct",
        "cost_elem",
        "rbukrs",
        "rcntr",
        "prctr",
        "rfarea",
        "rbusa",
        "kokrs",
        "segment",
        "zzspreg",
        "scntr",
        "pprctr",
        "sfarea",
        "sbusa",
        "rassc",
        "psegment",
        "tslvt",
        "tsl01",
        "tsl02",
        "tsl03",
        "tsl04",
        "tsl05",
        "tsl06",
        "tsl07",
        "tsl08",
        "tsl09",
        "tsl10",
        "tsl11",
        "tsl12",
        "tsl13",
        "tsl14",
        "tsl15",
        "tsl16",
        "hslvt",
        "hsl01",
        "hsl02",
        "hsl03",
        "hsl04",
        "hsl05",
        "hsl06",
        "hsl07",
        "hsl08",
        "hsl09",
        "hsl10",
        "hsl11",
        "hsl12",
        "hsl13",
        "hsl14",
        "hsl15",
        "hsl16",
        "kslvt",
        "ksl01",
        "ksl02",
        "ksl03",
        "ksl04",
        "ksl05",
        "ksl06",
        "ksl07",
        "ksl08",
        "ksl09",
        "ksl10",
        "ksl11",
        "ksl12",
        "ksl13",
        "ksl14",
        "ksl15",
        "ksl16",
        "oslvt",
        "osl01",
        "osl02",
        "osl03",
        "osl04",
        "osl05",
        "osl06",
        "osl07",
        "osl08",
        "osl09",
        "osl10",
        "osl11",
        "osl12",
        "osl13",
        "osl14",
        "osl15",
        "osl16",
        "mslvt",
        "msl01",
        "msl02",
        "msl03",
        "msl04",
        "msl05",
        "msl06",
        "msl07",
        "msl08",
        "msl09",
        "msl10",
        "msl11",
        "msl12",
        "msl13",
        "msl14",
        "msl15",
        "msl16",
        "timestamp_",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_faglflext_data"
),

"sap_faglflext_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- drcrk -> debit_credit_indicator
    -- objnr00 -> object_number
    -- objnr02 -> account_group
    -- objnr03 -> account_number
    -- objnr04 -> unused_object_4
    -- objnr05 -> unused_object_5
    -- objnr06 -> unused_object_6
    -- objnr07 -> unused_object_7
    -- objnr08 -> unused_object_8
    -- rclnt -> client
    -- rpmax -> max_periods
    -- ryear -> fiscal_year
    -- activ -> activity_type
    -- rmvct -> movement_type
    -- rtcur -> currency
    -- runit -> unit_of_measure
    -- awtyp -> document_type
    -- rldnr -> ledger
    -- rrcty -> record_type
    -- rvers -> version
    -- logsys -> logical_system
    -- racct -> gl_account
    -- cost_elem -> cost_element
    -- rcntr -> cost_center
    -- prctr -> profit_center
    -- rfarea -> functional_area
    -- rbusa -> business_area
    -- kokrs -> controlling_area
    -- zzspreg -> special_region_code
    -- scntr -> sender_cost_center
    -- pprctr -> partner_profit_center
    -- sfarea -> sender_functional_area
    -- sbusa -> sender_business_area
    -- rassc -> asset_class
    -- psegment -> profit_segment
    -- tsl01 -> january_amount
    -- tsl02 -> february_amount
    -- tsl03 -> march_amount
    -- tsl04 -> april_amount
    -- tsl05 -> may_amount
    -- tsl06 -> june_amount
    -- tsl07 -> july_amount
    -- tsl08 -> august_amount
    -- tsl09 -> september_amount
    -- tsl10 -> october_amount
    -- tsl11 -> november_amount
    -- tsl12 -> december_amount
    -- hslvt -> amount_previous_year
    -- hsl01 -> amount_period_01
    -- hsl02 -> amount_period_02
    -- hsl03 -> amount_period_03
    -- hsl04 -> amount_period_04
    -- hsl05 -> amount_period_05
    -- hsl06 -> amount_period_06
    -- hsl07 -> amount_period_07
    -- hsl08 -> amount_period_08
    -- hsl09 -> amount_period_09
    -- hsl10 -> amount_period_10
    -- hsl11 -> amount_period_11
    -- hsl12 -> amount_period_12
    -- hsl13 -> amount_period_13
    -- hsl14 -> amount_period_14
    -- hsl15 -> amount_period_15
    -- hsl16 -> amount_period_16
    -- kslvt -> cost_element_total
    -- ksl01 -> group_amount_period_01
    -- ksl02 -> group_amount_period_02
    -- ksl03 -> group_amount_period_03
    -- ksl04 -> group_amount_period_04
    -- ksl05 -> group_amount_period_05
    -- ksl06 -> group_amount_period_06
    -- ksl07 -> cost_element_july
    -- ksl08 -> cost_element_august
    -- ksl09 -> cost_element_september
    -- ksl10 -> cost_element_october
    -- ksl11 -> cost_element_november
    -- ksl12 -> cost_element_december
    -- ksl13 -> cost_element_january_next
    -- ksl14 -> cost_element_february_next
    -- ksl15 -> cost_element_march_next
    -- ksl16 -> cost_element_april_next
    -- osl01 -> period_01_value
    -- osl02 -> period_02_value
    -- osl03 -> period_03_value
    -- osl04 -> period_04_value
    -- osl05 -> period_05_value
    -- osl06 -> period_06_value
    -- osl07 -> period_07_value
    -- osl08 -> period_08_value
    -- osl09 -> period_09_value
    -- osl10 -> period_10_value
    -- osl11 -> period_11_value
    -- osl12 -> period_12_value
    -- mslvt -> stat_key_figure_total
    -- msl01 -> stat_key_figure_january
    -- msl02 -> stat_key_figure_february
    -- msl03 -> stat_key_figure_march
    -- msl04 -> stat_key_figure_april
    -- msl05 -> stat_key_figure_may
    -- msl06 -> stat_key_figure_june
    -- msl07 -> stat_key_figure_july
    -- msl08 -> stat_key_figure_august
    -- msl09 -> stat_key_figure_september
    -- msl10 -> stat_key_figure_october
    -- msl11 -> stat_key_figure_november
    -- msl12 -> stat_key_figure_december
    -- msl13 -> stat_key_figure_january_next
    -- msl14 -> stat_key_figure_february_next
    -- msl15 -> stat_key_figure_march_next
    -- msl16 -> stat_key_figure_april_next
    -- timestamp_ -> record_timestamp
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "drcrk" AS "debit_credit_indicator",
        "objnr00" AS "object_number",
        "objnr01",
        "objnr02" AS "account_group",
        "objnr03" AS "account_number",
        "objnr04" AS "unused_object_4",
        "objnr05" AS "unused_object_5",
        "objnr06" AS "unused_object_6",
        "objnr07" AS "unused_object_7",
        "objnr08" AS "unused_object_8",
        "rclnt" AS "client",
        "rpmax" AS "max_periods",
        "ryear" AS "fiscal_year",
        "activ" AS "activity_type",
        "rmvct" AS "movement_type",
        "rtcur" AS "currency",
        "runit" AS "unit_of_measure",
        "awtyp" AS "document_type",
        "rldnr" AS "ledger",
        "rrcty" AS "record_type",
        "rvers" AS "version",
        "logsys" AS "logical_system",
        "racct" AS "gl_account",
        "cost_elem" AS "cost_element",
        "rbukrs",
        "rcntr" AS "cost_center",
        "prctr" AS "profit_center",
        "rfarea" AS "functional_area",
        "rbusa" AS "business_area",
        "kokrs" AS "controlling_area",
        "segment",
        "zzspreg" AS "special_region_code",
        "scntr" AS "sender_cost_center",
        "pprctr" AS "partner_profit_center",
        "sfarea" AS "sender_functional_area",
        "sbusa" AS "sender_business_area",
        "rassc" AS "asset_class",
        "psegment" AS "profit_segment",
        "tslvt",
        "tsl01" AS "january_amount",
        "tsl02" AS "february_amount",
        "tsl03" AS "march_amount",
        "tsl04" AS "april_amount",
        "tsl05" AS "may_amount",
        "tsl06" AS "june_amount",
        "tsl07" AS "july_amount",
        "tsl08" AS "august_amount",
        "tsl09" AS "september_amount",
        "tsl10" AS "october_amount",
        "tsl11" AS "november_amount",
        "tsl12" AS "december_amount",
        "tsl13",
        "tsl14",
        "tsl15",
        "tsl16",
        "hslvt" AS "amount_previous_year",
        "hsl01" AS "amount_period_01",
        "hsl02" AS "amount_period_02",
        "hsl03" AS "amount_period_03",
        "hsl04" AS "amount_period_04",
        "hsl05" AS "amount_period_05",
        "hsl06" AS "amount_period_06",
        "hsl07" AS "amount_period_07",
        "hsl08" AS "amount_period_08",
        "hsl09" AS "amount_period_09",
        "hsl10" AS "amount_period_10",
        "hsl11" AS "amount_period_11",
        "hsl12" AS "amount_period_12",
        "hsl13" AS "amount_period_13",
        "hsl14" AS "amount_period_14",
        "hsl15" AS "amount_period_15",
        "hsl16" AS "amount_period_16",
        "kslvt" AS "cost_element_total",
        "ksl01" AS "group_amount_period_01",
        "ksl02" AS "group_amount_period_02",
        "ksl03" AS "group_amount_period_03",
        "ksl04" AS "group_amount_period_04",
        "ksl05" AS "group_amount_period_05",
        "ksl06" AS "group_amount_period_06",
        "ksl07" AS "cost_element_july",
        "ksl08" AS "cost_element_august",
        "ksl09" AS "cost_element_september",
        "ksl10" AS "cost_element_october",
        "ksl11" AS "cost_element_november",
        "ksl12" AS "cost_element_december",
        "ksl13" AS "cost_element_january_next",
        "ksl14" AS "cost_element_february_next",
        "ksl15" AS "cost_element_march_next",
        "ksl16" AS "cost_element_april_next",
        "oslvt",
        "osl01" AS "period_01_value",
        "osl02" AS "period_02_value",
        "osl03" AS "period_03_value",
        "osl04" AS "period_04_value",
        "osl05" AS "period_05_value",
        "osl06" AS "period_06_value",
        "osl07" AS "period_07_value",
        "osl08" AS "period_08_value",
        "osl09" AS "period_09_value",
        "osl10" AS "period_10_value",
        "osl11" AS "period_11_value",
        "osl12" AS "period_12_value",
        "osl13",
        "osl14",
        "osl15",
        "osl16",
        "mslvt" AS "stat_key_figure_total",
        "msl01" AS "stat_key_figure_january",
        "msl02" AS "stat_key_figure_february",
        "msl03" AS "stat_key_figure_march",
        "msl04" AS "stat_key_figure_april",
        "msl05" AS "stat_key_figure_may",
        "msl06" AS "stat_key_figure_june",
        "msl07" AS "stat_key_figure_july",
        "msl08" AS "stat_key_figure_august",
        "msl09" AS "stat_key_figure_september",
        "msl10" AS "stat_key_figure_october",
        "msl11" AS "stat_key_figure_november",
        "msl12" AS "stat_key_figure_december",
        "msl13" AS "stat_key_figure_january_next",
        "msl14" AS "stat_key_figure_february_next",
        "msl15" AS "stat_key_figure_march_next",
        "msl16" AS "stat_key_figure_april_next",
        "timestamp_" AS "record_timestamp",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_faglflext_data_projected"
),

"sap_faglflext_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- debit_credit_indicator: The problem is that 's' and 'h' are not standard debit/credit indicators. Typically, debit/credit indicators use 'D' for debit and 'C' for credit, or sometimes 'Debit' and 'Credit'. The values 's' and 'h' are unusual and unclear in their meaning. Without more context about the specific system or data source, it's difficult to determine what these letters stand for. They could potentially be abbreviations for specific transaction types or have some other meaning within the system. 
    -- activity_type: The problem is that 'rfbu' is the only value present in the activity_type column, and it's an unclear acronym that doesn't provide meaningful information about the activity type. Without additional context or a data dictionary, it's impossible to determine what 'rfbu' stands for or what kind of activity it represents. In this case, since we don't have enough information to map it to a correct value, the best approach is to map it to an empty string to indicate that the activity type is unknown or undefined. 
    -- ledger: The problem is that '0l' appears to be a typo. It's likely that this was meant to be '01' (zero-one), representing the first ledger or account number. The letter 'l' (lowercase L) can easily be mistaken for the number '1' in many fonts. Since this is the only value present and it's clearly a data entry error, we should correct it to the intended value. 
    SELECT
        CASE
            WHEN "debit_credit_indicator" = '''s''' THEN '''D'''
            WHEN "debit_credit_indicator" = '''h''' THEN '''C'''
            ELSE "debit_credit_indicator"
        END AS "debit_credit_indicator",
        "object_number",
        "objnr01",
        "account_group",
        "account_number",
        "unused_object_4",
        "unused_object_5",
        "unused_object_6",
        "unused_object_7",
        "unused_object_8",
        "client",
        "max_periods",
        "fiscal_year",
        CASE
            WHEN "activity_type" = '''rfbu''' THEN ''''
            ELSE "activity_type"
        END AS "activity_type",
        "movement_type",
        "currency",
        "unit_of_measure",
        "document_type",
        CASE
            WHEN "ledger" = '''0l''' THEN '''01'''
            ELSE "ledger"
        END AS "ledger",
        "record_type",
        "version",
        "logical_system",
        "gl_account",
        "cost_element",
        "rbukrs",
        "cost_center",
        "profit_center",
        "functional_area",
        "business_area",
        "controlling_area",
        "segment",
        "special_region_code",
        "sender_cost_center",
        "partner_profit_center",
        "sender_functional_area",
        "sender_business_area",
        "asset_class",
        "profit_segment",
        "tslvt",
        "january_amount",
        "february_amount",
        "march_amount",
        "april_amount",
        "may_amount",
        "june_amount",
        "july_amount",
        "august_amount",
        "september_amount",
        "october_amount",
        "november_amount",
        "december_amount",
        "tsl13",
        "tsl14",
        "tsl15",
        "tsl16",
        "amount_previous_year",
        "amount_period_01",
        "amount_period_02",
        "amount_period_03",
        "amount_period_04",
        "amount_period_05",
        "amount_period_06",
        "amount_period_07",
        "amount_period_08",
        "amount_period_09",
        "amount_period_10",
        "amount_period_11",
        "amount_period_12",
        "amount_period_13",
        "amount_period_14",
        "amount_period_15",
        "amount_period_16",
        "cost_element_total",
        "group_amount_period_01",
        "group_amount_period_02",
        "group_amount_period_03",
        "group_amount_period_04",
        "group_amount_period_05",
        "group_amount_period_06",
        "cost_element_july",
        "cost_element_august",
        "cost_element_september",
        "cost_element_october",
        "cost_element_november",
        "cost_element_december",
        "cost_element_january_next",
        "cost_element_february_next",
        "cost_element_march_next",
        "cost_element_april_next",
        "oslvt",
        "period_01_value",
        "period_02_value",
        "period_03_value",
        "period_04_value",
        "period_05_value",
        "period_06_value",
        "period_07_value",
        "period_08_value",
        "period_09_value",
        "period_10_value",
        "period_11_value",
        "period_12_value",
        "osl13",
        "osl14",
        "osl15",
        "osl16",
        "stat_key_figure_total",
        "stat_key_figure_january",
        "stat_key_figure_february",
        "stat_key_figure_march",
        "stat_key_figure_april",
        "stat_key_figure_may",
        "stat_key_figure_june",
        "stat_key_figure_july",
        "stat_key_figure_august",
        "stat_key_figure_september",
        "stat_key_figure_october",
        "stat_key_figure_november",
        "stat_key_figure_december",
        "stat_key_figure_january_next",
        "stat_key_figure_february_next",
        "stat_key_figure_march_next",
        "stat_key_figure_april_next",
        "record_timestamp",
        "row_id",
        "is_deleted"
    FROM "sap_faglflext_data_projected_renamed"
),

"sap_faglflext_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_group: from INT to VARCHAR
    -- account_number: from INT to VARCHAR
    -- asset_class: from DECIMAL to VARCHAR
    -- business_area: from INT to VARCHAR
    -- client: from INT to VARCHAR
    -- controlling_area: from INT to VARCHAR
    -- cost_center: from DECIMAL to VARCHAR
    -- cost_element: from DECIMAL to VARCHAR
    -- functional_area: from DECIMAL to VARCHAR
    -- gl_account: from INT to VARCHAR
    -- logical_system: from DECIMAL to VARCHAR
    -- movement_type: from DECIMAL to VARCHAR
    -- partner_profit_center: from DECIMAL to VARCHAR
    -- profit_segment: from DECIMAL to VARCHAR
    -- record_timestamp: from INT to TIMESTAMP
    -- segment: from DECIMAL to VARCHAR
    -- sender_business_area: from DECIMAL to VARCHAR
    -- sender_cost_center: from DECIMAL to VARCHAR
    -- sender_functional_area: from DECIMAL to VARCHAR
    -- special_region_code: from DECIMAL to VARCHAR
    -- unit_of_measure: from DECIMAL to VARCHAR
    -- unused_object_4: from INT to BIT
    -- unused_object_5: from INT to BIT
    -- unused_object_6: from INT to BIT
    -- unused_object_7: from INT to BIT
    -- unused_object_8: from INT to BIT
    SELECT
        "debit_credit_indicator",
        "object_number",
        "objnr01",
        "max_periods",
        "fiscal_year",
        "activity_type",
        "currency",
        "document_type",
        "ledger",
        "record_type",
        "version",
        "rbukrs",
        "profit_center",
        "tslvt",
        "january_amount",
        "february_amount",
        "march_amount",
        "april_amount",
        "may_amount",
        "june_amount",
        "july_amount",
        "august_amount",
        "september_amount",
        "october_amount",
        "november_amount",
        "december_amount",
        "tsl13",
        "tsl14",
        "tsl15",
        "tsl16",
        "amount_previous_year",
        "amount_period_01",
        "amount_period_02",
        "amount_period_03",
        "amount_period_04",
        "amount_period_05",
        "amount_period_06",
        "amount_period_07",
        "amount_period_08",
        "amount_period_09",
        "amount_period_10",
        "amount_period_11",
        "amount_period_12",
        "amount_period_13",
        "amount_period_14",
        "amount_period_15",
        "amount_period_16",
        "cost_element_total",
        "group_amount_period_01",
        "group_amount_period_02",
        "group_amount_period_03",
        "group_amount_period_04",
        "group_amount_period_05",
        "group_amount_period_06",
        "cost_element_july",
        "cost_element_august",
        "cost_element_september",
        "cost_element_october",
        "cost_element_november",
        "cost_element_december",
        "cost_element_january_next",
        "cost_element_february_next",
        "cost_element_march_next",
        "cost_element_april_next",
        "oslvt",
        "period_01_value",
        "period_02_value",
        "period_03_value",
        "period_04_value",
        "period_05_value",
        "period_06_value",
        "period_07_value",
        "period_08_value",
        "period_09_value",
        "period_10_value",
        "period_11_value",
        "period_12_value",
        "osl13",
        "osl14",
        "osl15",
        "osl16",
        "stat_key_figure_total",
        "stat_key_figure_january",
        "stat_key_figure_february",
        "stat_key_figure_march",
        "stat_key_figure_april",
        "stat_key_figure_may",
        "stat_key_figure_june",
        "stat_key_figure_july",
        "stat_key_figure_august",
        "stat_key_figure_september",
        "stat_key_figure_october",
        "stat_key_figure_november",
        "stat_key_figure_december",
        "stat_key_figure_january_next",
        "stat_key_figure_february_next",
        "stat_key_figure_march_next",
        "stat_key_figure_april_next",
        "row_id",
        "is_deleted",
        CAST("account_group" AS VARCHAR) AS "account_group",
        CAST("account_number" AS VARCHAR) AS "account_number",
        CAST("asset_class" AS VARCHAR) AS "asset_class",
        CAST("business_area" AS VARCHAR) AS "business_area",
        CAST("client" AS VARCHAR) AS "client",
        CAST("controlling_area" AS VARCHAR) AS "controlling_area",
        CAST("cost_center" AS VARCHAR) AS "cost_center",
        CAST("cost_element" AS VARCHAR) AS "cost_element",
        CAST("functional_area" AS VARCHAR) AS "functional_area",
        CAST("gl_account" AS VARCHAR) AS "gl_account",
        CAST("logical_system" AS VARCHAR) AS "logical_system",
        CAST("movement_type" AS VARCHAR) AS "movement_type",
        CAST("partner_profit_center" AS VARCHAR) AS "partner_profit_center",
        CAST("profit_segment" AS VARCHAR) AS "profit_segment",
        strptime(CAST("record_timestamp" AS VARCHAR), '%Y%m%d%H%M%S') AS "record_timestamp",
        CAST("segment" AS VARCHAR) AS "segment",
        CAST("sender_business_area" AS VARCHAR) AS "sender_business_area",
        CAST("sender_cost_center" AS VARCHAR) AS "sender_cost_center",
        CAST("sender_functional_area" AS VARCHAR) AS "sender_functional_area",
        CAST("special_region_code" AS VARCHAR) AS "special_region_code",
        CAST("unit_of_measure" AS VARCHAR) AS "unit_of_measure",
        CAST("unused_object_4" AS BIT) AS "unused_object_4",
        CAST("unused_object_5" AS BIT) AS "unused_object_5",
        CAST("unused_object_6" AS BIT) AS "unused_object_6",
        CAST("unused_object_7" AS BIT) AS "unused_object_7",
        CAST("unused_object_8" AS BIT) AS "unused_object_8"
    FROM "sap_faglflext_data_projected_renamed_cleaned"
),

"sap_faglflext_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 13 columns with unacceptable missing values
    -- asset_class has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_element has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- functional_area has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- logical_system has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- movement_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_profit_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- profit_center has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- profit_segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sender_business_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sender_cost_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sender_functional_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- special_region_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "debit_credit_indicator",
        "object_number",
        "objnr01",
        "max_periods",
        "fiscal_year",
        "activity_type",
        "currency",
        "document_type",
        "ledger",
        "record_type",
        "version",
        "rbukrs",
        "profit_center",
        "tslvt",
        "january_amount",
        "february_amount",
        "march_amount",
        "april_amount",
        "may_amount",
        "june_amount",
        "july_amount",
        "august_amount",
        "september_amount",
        "october_amount",
        "november_amount",
        "december_amount",
        "tsl13",
        "tsl14",
        "tsl15",
        "tsl16",
        "amount_previous_year",
        "amount_period_01",
        "amount_period_02",
        "amount_period_03",
        "amount_period_04",
        "amount_period_05",
        "amount_period_06",
        "amount_period_07",
        "amount_period_08",
        "amount_period_09",
        "amount_period_10",
        "amount_period_11",
        "amount_period_12",
        "amount_period_13",
        "amount_period_14",
        "amount_period_15",
        "amount_period_16",
        "cost_element_total",
        "group_amount_period_01",
        "group_amount_period_02",
        "group_amount_period_03",
        "group_amount_period_04",
        "group_amount_period_05",
        "group_amount_period_06",
        "cost_element_july",
        "cost_element_august",
        "cost_element_september",
        "cost_element_october",
        "cost_element_november",
        "cost_element_december",
        "cost_element_january_next",
        "cost_element_february_next",
        "cost_element_march_next",
        "cost_element_april_next",
        "oslvt",
        "period_01_value",
        "period_02_value",
        "period_03_value",
        "period_04_value",
        "period_05_value",
        "period_06_value",
        "period_07_value",
        "period_08_value",
        "period_09_value",
        "period_10_value",
        "period_11_value",
        "period_12_value",
        "osl13",
        "osl14",
        "osl15",
        "osl16",
        "stat_key_figure_total",
        "stat_key_figure_january",
        "stat_key_figure_february",
        "stat_key_figure_march",
        "stat_key_figure_april",
        "stat_key_figure_may",
        "stat_key_figure_june",
        "stat_key_figure_july",
        "stat_key_figure_august",
        "stat_key_figure_september",
        "stat_key_figure_october",
        "stat_key_figure_november",
        "stat_key_figure_december",
        "stat_key_figure_january_next",
        "stat_key_figure_february_next",
        "stat_key_figure_march_next",
        "stat_key_figure_april_next",
        "row_id",
        "is_deleted",
        "account_group",
        "account_number",
        "business_area",
        "client",
        "controlling_area",
        "cost_center",
        "functional_area",
        "gl_account",
        "record_timestamp",
        "unit_of_measure",
        "unused_object_4",
        "unused_object_5",
        "unused_object_6",
        "unused_object_7",
        "unused_object_8"
    FROM "sap_faglflext_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_faglflext_data_projected_renamed_cleaned_casted_missing_handled"