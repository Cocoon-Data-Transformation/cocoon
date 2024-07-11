-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 04:40:40.227636+00:00
WITH 
"sap_faglflexa_data_projected" AS (
    -- Projection: Selecting 50 out of 51 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "docln",
        "docnr",
        "rbukrs",
        "rclnt",
        "rldnr",
        "ryear",
        "activ",
        "rmvct",
        "rtcur",
        "runit",
        "awtyp",
        "rrcty",
        "rvers",
        "logsys",
        "racct",
        "cost_elem",
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
        "tsl",
        "hsl",
        "ksl",
        "osl",
        "msl",
        "wsl",
        "drcrk",
        "poper",
        "rwcur",
        "gjahr",
        "budat",
        "belnr",
        "buzei",
        "bschl",
        "bstat",
        "linetype",
        "xsplitmod",
        "usnam",
        "timestamp_",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_faglflexa_data"
),

"sap_faglflexa_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- docln -> document_line_number
    -- docnr -> reference_document_number
    -- rbukrs -> company_code
    -- rclnt -> client_code
    -- rldnr -> ledger_number
    -- activ -> activity_type
    -- rmvct -> movement_type
    -- rtcur -> transaction_currency
    -- runit -> unit_of_measure
    -- awtyp -> document_type
    -- rrcty -> record_type
    -- rvers -> version_number
    -- logsys -> logical_system
    -- racct -> gl_account_number
    -- cost_elem -> cost_element
    -- rcntr -> cost_center
    -- prctr -> profit_center
    -- rfarea -> functional_area
    -- kokrs -> controlling_area
    -- zzspreg -> special_region
    -- scntr -> sender_cost_center
    -- pprctr -> partner_profit_center
    -- sfarea -> sender_functional_area
    -- rassc -> asset_class
    -- psegment -> profit_segment
    -- tsl -> transaction_amount_local
    -- hsl -> local_currency_amount
    -- ksl -> group_currency_amount
    -- osl -> transaction_currency_amount
    -- msl -> material_ledger_amount
    -- wsl -> amount_document_currency
    -- drcrk -> debit_credit_indicator
    -- poper -> posting_period
    -- rwcur -> reporting_currency
    -- budat -> posting_date
    -- belnr -> document_number
    -- buzei -> line_item_number
    -- bschl -> posting_key
    -- bstat -> document_status
    -- linetype -> line_item_type
    -- xsplitmod -> split_modification
    -- usnam -> user_name
    -- timestamp_ -> transaction_timestamp
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "docln" AS "document_line_number",
        "docnr" AS "reference_document_number",
        "rbukrs" AS "company_code",
        "rclnt" AS "client_code",
        "rldnr" AS "ledger_number",
        "ryear",
        "activ" AS "activity_type",
        "rmvct" AS "movement_type",
        "rtcur" AS "transaction_currency",
        "runit" AS "unit_of_measure",
        "awtyp" AS "document_type",
        "rrcty" AS "record_type",
        "rvers" AS "version_number",
        "logsys" AS "logical_system",
        "racct" AS "gl_account_number",
        "cost_elem" AS "cost_element",
        "rcntr" AS "cost_center",
        "prctr" AS "profit_center",
        "rfarea" AS "functional_area",
        "rbusa",
        "kokrs" AS "controlling_area",
        "segment",
        "zzspreg" AS "special_region",
        "scntr" AS "sender_cost_center",
        "pprctr" AS "partner_profit_center",
        "sfarea" AS "sender_functional_area",
        "sbusa",
        "rassc" AS "asset_class",
        "psegment" AS "profit_segment",
        "tsl" AS "transaction_amount_local",
        "hsl" AS "local_currency_amount",
        "ksl" AS "group_currency_amount",
        "osl" AS "transaction_currency_amount",
        "msl" AS "material_ledger_amount",
        "wsl" AS "amount_document_currency",
        "drcrk" AS "debit_credit_indicator",
        "poper" AS "posting_period",
        "rwcur" AS "reporting_currency",
        "gjahr",
        "budat" AS "posting_date",
        "belnr" AS "document_number",
        "buzei" AS "line_item_number",
        "bschl" AS "posting_key",
        "bstat" AS "document_status",
        "linetype" AS "line_item_type",
        "xsplitmod" AS "split_modification",
        "usnam" AS "user_name",
        "timestamp_" AS "transaction_timestamp",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_faglflexa_data_projected"
),

"sap_faglflexa_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- ledger_number: The problem is that the ledger_number column contains the value '0l' (zero followed by lowercase L), which is likely a typo. The correct value should be '01' (zero followed by the number one). This type of error often occurs when the font used makes it difficult to distinguish between the lowercase letter 'l' and the number '1'. 
    -- activity_type: The problem is that 'rfbu' is the only value present in the activity_type column, and it's an unclear acronym that doesn't provide meaningful information about the activity type. Without additional context or a data dictionary, it's impossible to determine what 'rfbu' stands for or what kind of activity it represents. In this case, since we don't have enough information to map it to a correct value, the best approach is to map it to an empty string to indicate that the activity type is unknown or undefined. 
    -- debit_credit_indicator: The problem is that 'h' is an unusual and non-standard value for a debit_credit_indicator column. Typically, this column should contain 'D' for debit and 'C' for credit. The value 'h' is not meaningful in this context and doesn't provide clear information about whether the transaction is a debit or credit. Since we don't have additional information about what 'h' might represent, it's safest to map it to an empty string to indicate missing or invalid data. 
    SELECT
        "document_line_number",
        "reference_document_number",
        "company_code",
        "client_code",
        CASE
            WHEN "ledger_number" = '''0l''' THEN '''01'''
            ELSE "ledger_number"
        END AS "ledger_number",
        "ryear",
        CASE
            WHEN "activity_type" = '''rfbu''' THEN ''''
            ELSE "activity_type"
        END AS "activity_type",
        "movement_type",
        "transaction_currency",
        "unit_of_measure",
        "document_type",
        "record_type",
        "version_number",
        "logical_system",
        "gl_account_number",
        "cost_element",
        "cost_center",
        "profit_center",
        "functional_area",
        "rbusa",
        "controlling_area",
        "segment",
        "special_region",
        "sender_cost_center",
        "partner_profit_center",
        "sender_functional_area",
        "sbusa",
        "asset_class",
        "profit_segment",
        "transaction_amount_local",
        "local_currency_amount",
        "group_currency_amount",
        "transaction_currency_amount",
        "material_ledger_amount",
        "amount_document_currency",
        CASE
            WHEN "debit_credit_indicator" = '''h''' THEN ''''
            ELSE "debit_credit_indicator"
        END AS "debit_credit_indicator",
        "posting_period",
        "reporting_currency",
        "gjahr",
        "posting_date",
        "document_number",
        "line_item_number",
        "posting_key",
        "document_status",
        "line_item_type",
        "split_modification",
        "user_name",
        "transaction_timestamp",
        "row_id",
        "is_deleted"
    FROM "sap_faglflexa_data_projected_renamed"
),

"sap_faglflexa_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- asset_class: from DECIMAL to VARCHAR
    -- client_code: from INT to VARCHAR
    -- company_code: from INT to VARCHAR
    -- controlling_area: from INT to VARCHAR
    -- cost_center: from DECIMAL to VARCHAR
    -- cost_element: from DECIMAL to VARCHAR
    -- document_number: from INT to VARCHAR
    -- document_status: from DECIMAL to VARCHAR
    -- functional_area: from DECIMAL to VARCHAR
    -- gl_account_number: from INT to VARCHAR
    -- line_item_type: from DECIMAL to VARCHAR
    -- logical_system: from DECIMAL to VARCHAR
    -- movement_type: from DECIMAL to VARCHAR
    -- partner_profit_center: from DECIMAL to VARCHAR
    -- posting_date: from INT to DATE
    -- posting_key: from INT to VARCHAR
    -- profit_center: from DECIMAL to VARCHAR
    -- profit_segment: from DECIMAL to VARCHAR
    -- rbusa: from DECIMAL to VARCHAR
    -- reference_document_number: from INT to VARCHAR
    -- sbusa: from DECIMAL to VARCHAR
    -- segment: from DECIMAL to VARCHAR
    -- sender_cost_center: from DECIMAL to VARCHAR
    -- sender_functional_area: from DECIMAL to VARCHAR
    -- special_region: from DECIMAL to VARCHAR
    -- split_modification: from DECIMAL to VARCHAR
    -- transaction_timestamp: from INT to TIMESTAMP
    -- unit_of_measure: from DECIMAL to VARCHAR
    SELECT
        "document_line_number",
        "ledger_number",
        "ryear",
        "activity_type",
        "transaction_currency",
        "document_type",
        "record_type",
        "version_number",
        "transaction_amount_local",
        "local_currency_amount",
        "group_currency_amount",
        "transaction_currency_amount",
        "material_ledger_amount",
        "amount_document_currency",
        "debit_credit_indicator",
        "posting_period",
        "reporting_currency",
        "gjahr",
        "line_item_number",
        "user_name",
        "row_id",
        "is_deleted",
        CAST("asset_class" AS VARCHAR) AS "asset_class",
        CAST("client_code" AS VARCHAR) AS "client_code",
        CAST("company_code" AS VARCHAR) AS "company_code",
        CAST("controlling_area" AS VARCHAR) AS "controlling_area",
        CAST("cost_center" AS VARCHAR) AS "cost_center",
        CAST("cost_element" AS VARCHAR) AS "cost_element",
        CAST("document_number" AS VARCHAR) AS "document_number",
        CAST("document_status" AS VARCHAR) AS "document_status",
        CAST("functional_area" AS VARCHAR) AS "functional_area",
        CAST("gl_account_number" AS VARCHAR) AS "gl_account_number",
        CAST("line_item_type" AS VARCHAR) AS "line_item_type",
        CAST("logical_system" AS VARCHAR) AS "logical_system",
        CAST("movement_type" AS VARCHAR) AS "movement_type",
        CAST("partner_profit_center" AS VARCHAR) AS "partner_profit_center",
        strptime(CAST("posting_date" AS VARCHAR), '%Y%m%d') AS "posting_date",
        CAST("posting_key" AS VARCHAR) AS "posting_key",
        CAST("profit_center" AS VARCHAR) AS "profit_center",
        CAST("profit_segment" AS VARCHAR) AS "profit_segment",
        CAST("rbusa" AS VARCHAR) AS "rbusa",
        CAST("reference_document_number" AS VARCHAR) AS "reference_document_number",
        CAST("sbusa" AS VARCHAR) AS "sbusa",
        CAST("segment" AS VARCHAR) AS "segment",
        CAST("sender_cost_center" AS VARCHAR) AS "sender_cost_center",
        CAST("sender_functional_area" AS VARCHAR) AS "sender_functional_area",
        CAST("special_region" AS VARCHAR) AS "special_region",
        CAST("split_modification" AS VARCHAR) AS "split_modification",
        strptime(CAST("transaction_timestamp" AS VARCHAR), '%Y%m%d%H%M%S') AS "transaction_timestamp",
        CAST("unit_of_measure" AS VARCHAR) AS "unit_of_measure"
    FROM "sap_faglflexa_data_projected_renamed_cleaned"
),

"sap_faglflexa_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 17 columns with unacceptable missing values
    -- asset_class has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_element has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- document_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- line_item_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- logical_system has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- movement_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_profit_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- profit_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- profit_segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- rbusa has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sbusa has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sender_cost_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sender_functional_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- special_region has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- split_modification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- unit_of_measure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "document_line_number",
        "ledger_number",
        "ryear",
        "activity_type",
        "transaction_currency",
        "document_type",
        "record_type",
        "version_number",
        "transaction_amount_local",
        "local_currency_amount",
        "group_currency_amount",
        "transaction_currency_amount",
        "material_ledger_amount",
        "amount_document_currency",
        "debit_credit_indicator",
        "posting_period",
        "reporting_currency",
        "gjahr",
        "line_item_number",
        "user_name",
        "row_id",
        "is_deleted",
        "client_code",
        "company_code",
        "controlling_area",
        "cost_center",
        "document_number",
        "functional_area",
        "gl_account_number",
        "posting_date",
        "posting_key",
        "reference_document_number",
        "transaction_timestamp"
    FROM "sap_faglflexa_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_faglflexa_data_projected_renamed_cleaned_casted_missing_handled"