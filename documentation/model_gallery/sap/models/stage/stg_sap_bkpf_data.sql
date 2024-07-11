-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 04:24:14.810339+00:00
WITH 
"sap_bkpf_data_projected" AS (
    -- Projection: Selecting 115 out of 116 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "belnr",
        "bukrs",
        "gjahr",
        "mandt",
        "blart",
        "bldat",
        "budat",
        "monat",
        "cpudt",
        "cputm",
        "aedat",
        "upddt",
        "wwert",
        "usnam",
        "tcode",
        "bvorg",
        "xblnr",
        "dbblg",
        "stblg",
        "stjah",
        "bktxt",
        "waers",
        "kursf",
        "kzwrs",
        "kzkrs",
        "bstat",
        "xnetb",
        "frath",
        "xrueb",
        "glvor",
        "grpid",
        "dokid",
        "arcid",
        "iblar",
        "awtyp",
        "awkey",
        "fikrs",
        "hwaer",
        "hwae2",
        "hwae3",
        "kurs2",
        "kurs3",
        "basw2",
        "basw3",
        "umrd2",
        "umrd3",
        "xstov",
        "stodt",
        "xmwst",
        "curt2",
        "curt3",
        "kuty2",
        "kuty3",
        "xsnet",
        "ausbk",
        "xusvr",
        "duefl",
        "awsys",
        "txkrs",
        "ctxkrs",
        "lotkz",
        "xwvof",
        "stgrd",
        "ppnam",
        "brnch",
        "numpg",
        "adisc",
        "xref1_hd",
        "xref2_hd",
        "xreversal",
        "reindat",
        "rldnr",
        "ldgrp",
        "propmano",
        "xblnr_alt",
        "vatdate",
        "doccat",
        "xsplit",
        "cash_alloc",
        "follow_on",
        "xreorg",
        "subset",
        "kurst",
        "kursx",
        "kur2x",
        "kur3x",
        "xmca",
        "resubmission",
        "_sapf15_status",
        "psoty",
        "psoak",
        "psoks",
        "psosg",
        "psofn",
        "intform",
        "intdate",
        "psobt",
        "psozl",
        "psodt",
        "psotm",
        "fm_umart",
        "ccins",
        "ccnum",
        "ssblk",
        "batch",
        "sname",
        "sampled",
        "exclude_flag",
        "blind",
        "offset_status",
        "offset_refer_dat",
        "penrc",
        "knumv",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_bkpf_data"
),

"sap_bkpf_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- mandt -> client_number
    -- monat -> posting_month
    -- cpudt -> entry_date
    -- cputm -> entry_time
    -- aedat -> last_change_date
    -- upddt -> update_date
    -- wwert -> value_date
    -- tcode -> transaction_code
    -- bvorg -> accounting_transaction
    -- xblnr -> reference_document_number
    -- stblg -> reverse_document_number
    -- bktxt -> document_header_text
    -- waers -> currency_code
    -- kursf -> fixed_exchange_rate
    -- kzwrs -> currency_indicator
    -- kzkrs -> reciprocal_exchange_rate_indicator
    -- bstat -> document_status
    -- xnetb -> net_amount
    -- frath -> freight_charges
    -- xrueb -> invoice_correction_indicator
    -- glvor -> business_transaction
    -- grpid -> group_id
    -- dokid -> document_id
    -- arcid -> archive_id
    -- iblar -> clearing_document_number
    -- awtyp -> reference_type
    -- awkey -> document_reference_key
    -- fikrs -> financial_management_area
    -- hwaer -> primary_currency
    -- hwae2 -> currency_2
    -- hwae3 -> currency_3
    -- kurs2 -> exchange_rate_currency_2
    -- kurs3 -> exchange_rate_currency_3
    -- basw2 -> withholding_tax_base_method
    -- basw3 -> extended_withholding_tax_base
    -- umrd2 -> unknown_field_2
    -- umrd3 -> unknown_field_3
    -- xstov -> other_period_reversal_indicator
    -- stodt -> reverse_posting_date
    -- xmwst -> tax_code
    -- curt2 -> currency_type
    -- curt3 -> currency_type_3
    -- kuty2 -> currency_type_2
    -- kuty3 -> currency_type_3_alt
    -- xsnet -> statistical_posting_indicator
    -- xusvr -> eu_sales_list_indicator
    -- duefl -> due_flag
    -- awsys -> origin_system
    -- txkrs -> exchange_rate
    -- ctxkrs -> local_currency_exchange_rate
    -- xwvof -> tax_determination_date_indicator
    -- stgrd -> reversal_reason
    -- ppnam -> parked_by
    -- brnch -> branch_number
    -- numpg -> page_count
    -- adisc -> additional_discount
    -- xref1_hd -> reference_key_1
    -- xref2_hd -> reference_key_2
    -- rldnr -> ledger
    -- ldgrp -> ledger_group
    -- propmano -> property_management_object
    -- xblnr_alt -> alternative_reference_number
    -- vatdate -> vat_date
    -- doccat -> document_category
    -- xsplit -> line_item_split_indicator
    -- cash_alloc -> is_cash_allocation
    -- follow_on -> follow_on_indicator
    -- xreorg -> reorganization_status
    -- kurst -> exchange_rate_type
    -- kursx -> primary_exchange_rate
    -- kur2x -> exchange_rate_2
    -- kur3x -> exchange_rate_3
    -- xmca -> special_gl_indicator
    -- resubmission -> resubmission_date
    -- _sapf15_status -> sap_f15_status
    -- psoty -> transaction_type
    -- psoak -> accounting_clerk
    -- psosg -> posting_key
    -- intform -> interest_calculation_form
    -- intdate -> interest_calculation_date
    -- psozl -> line_item_number
    -- psotm -> document_time
    -- fm_umart -> funds_management_type
    -- ccins -> credit_card_issuer
    -- ccnum -> credit_card_number
    -- ssblk -> blocking_reason
    -- batch -> batch_number
    -- sampled -> sampled_indicator
    -- blind -> is_blind_document
    -- offset_refer_dat -> offset_reference_date
    -- penrc -> penalty_calculation_rule
    -- knumv -> condition_record_number
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "belnr",
        "bukrs",
        "gjahr",
        "mandt" AS "client_number",
        "blart",
        "bldat",
        "budat",
        "monat" AS "posting_month",
        "cpudt" AS "entry_date",
        "cputm" AS "entry_time",
        "aedat" AS "last_change_date",
        "upddt" AS "update_date",
        "wwert" AS "value_date",
        "usnam",
        "tcode" AS "transaction_code",
        "bvorg" AS "accounting_transaction",
        "xblnr" AS "reference_document_number",
        "dbblg",
        "stblg" AS "reverse_document_number",
        "stjah",
        "bktxt" AS "document_header_text",
        "waers" AS "currency_code",
        "kursf" AS "fixed_exchange_rate",
        "kzwrs" AS "currency_indicator",
        "kzkrs" AS "reciprocal_exchange_rate_indicator",
        "bstat" AS "document_status",
        "xnetb" AS "net_amount",
        "frath" AS "freight_charges",
        "xrueb" AS "invoice_correction_indicator",
        "glvor" AS "business_transaction",
        "grpid" AS "group_id",
        "dokid" AS "document_id",
        "arcid" AS "archive_id",
        "iblar" AS "clearing_document_number",
        "awtyp" AS "reference_type",
        "awkey" AS "document_reference_key",
        "fikrs" AS "financial_management_area",
        "hwaer" AS "primary_currency",
        "hwae2" AS "currency_2",
        "hwae3" AS "currency_3",
        "kurs2" AS "exchange_rate_currency_2",
        "kurs3" AS "exchange_rate_currency_3",
        "basw2" AS "withholding_tax_base_method",
        "basw3" AS "extended_withholding_tax_base",
        "umrd2" AS "unknown_field_2",
        "umrd3" AS "unknown_field_3",
        "xstov" AS "other_period_reversal_indicator",
        "stodt" AS "reverse_posting_date",
        "xmwst" AS "tax_code",
        "curt2" AS "currency_type",
        "curt3" AS "currency_type_3",
        "kuty2" AS "currency_type_2",
        "kuty3" AS "currency_type_3_alt",
        "xsnet" AS "statistical_posting_indicator",
        "ausbk",
        "xusvr" AS "eu_sales_list_indicator",
        "duefl" AS "due_flag",
        "awsys" AS "origin_system",
        "txkrs" AS "exchange_rate",
        "ctxkrs" AS "local_currency_exchange_rate",
        "lotkz",
        "xwvof" AS "tax_determination_date_indicator",
        "stgrd" AS "reversal_reason",
        "ppnam" AS "parked_by",
        "brnch" AS "branch_number",
        "numpg" AS "page_count",
        "adisc" AS "additional_discount",
        "xref1_hd" AS "reference_key_1",
        "xref2_hd" AS "reference_key_2",
        "xreversal",
        "reindat",
        "rldnr" AS "ledger",
        "ldgrp" AS "ledger_group",
        "propmano" AS "property_management_object",
        "xblnr_alt" AS "alternative_reference_number",
        "vatdate" AS "vat_date",
        "doccat" AS "document_category",
        "xsplit" AS "line_item_split_indicator",
        "cash_alloc" AS "is_cash_allocation",
        "follow_on" AS "follow_on_indicator",
        "xreorg" AS "reorganization_status",
        "subset",
        "kurst" AS "exchange_rate_type",
        "kursx" AS "primary_exchange_rate",
        "kur2x" AS "exchange_rate_2",
        "kur3x" AS "exchange_rate_3",
        "xmca" AS "special_gl_indicator",
        "resubmission" AS "resubmission_date",
        "_sapf15_status" AS "sap_f15_status",
        "psoty" AS "transaction_type",
        "psoak" AS "accounting_clerk",
        "psoks",
        "psosg" AS "posting_key",
        "psofn",
        "intform" AS "interest_calculation_form",
        "intdate" AS "interest_calculation_date",
        "psobt",
        "psozl" AS "line_item_number",
        "psodt",
        "psotm" AS "document_time",
        "fm_umart" AS "funds_management_type",
        "ccins" AS "credit_card_issuer",
        "ccnum" AS "credit_card_number",
        "ssblk" AS "blocking_reason",
        "batch" AS "batch_number",
        "sname",
        "sampled" AS "sampled_indicator",
        "exclude_flag",
        "blind" AS "is_blind_document",
        "offset_status",
        "offset_refer_dat" AS "offset_reference_date",
        "penrc" AS "penalty_calculation_rule",
        "knumv" AS "condition_record_number",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_bkpf_data_projected"
),

"sap_bkpf_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- blart: The problem is that 'sa' is the only value in the column, and it's a very short, ambiguous code without clear meaning in most contexts. Without more information about the dataset or the intended meaning of this column, it's difficult to determine if this is an error or if it has a specific significance in the context of the data. The correct values cannot be determined without additional context. 
    -- currency_type_2: The problem is that 'm' is not a standard currency code or recognizable currency name. Given that this is the only value in the column and without more context, it's difficult to determine what it might represent. It could be a typo, an abbreviation, or a placeholder. Without additional information about the dataset or what this column is supposed to represent, we can't confidently map it to a correct value. The safest approach would be to mark it as an unknown or invalid currency. 
    -- currency_type_3_alt: The problem is that 'm' is not a standard currency code and lacks context. In currency-related data, 'm' is sometimes used as an abbreviation for 'million', but it's not clear if that's the intended meaning here. Without more context about the data set and what this column represents, it's difficult to determine the correct mapping. If 'm' is indeed meant to represent 'million', it should be replaced with a more clear representation. If it's meant to be a currency code, it should be replaced with the appropriate ISO 4217 currency code. Given the lack of context, the safest approach is to keep the value as is for now, pending further clarification. 
    SELECT
        "belnr",
        "bukrs",
        "gjahr",
        "client_number",
        "blart",
        "bldat",
        "budat",
        "posting_month",
        "entry_date",
        "entry_time",
        "last_change_date",
        "update_date",
        "value_date",
        "usnam",
        "transaction_code",
        "accounting_transaction",
        "reference_document_number",
        "dbblg",
        "reverse_document_number",
        "stjah",
        "document_header_text",
        "currency_code",
        "fixed_exchange_rate",
        "currency_indicator",
        "reciprocal_exchange_rate_indicator",
        "document_status",
        "net_amount",
        "freight_charges",
        "invoice_correction_indicator",
        "business_transaction",
        "group_id",
        "document_id",
        "archive_id",
        "clearing_document_number",
        "reference_type",
        "document_reference_key",
        "financial_management_area",
        "primary_currency",
        "currency_2",
        "currency_3",
        "exchange_rate_currency_2",
        "exchange_rate_currency_3",
        "withholding_tax_base_method",
        "extended_withholding_tax_base",
        "unknown_field_2",
        "unknown_field_3",
        "other_period_reversal_indicator",
        "reverse_posting_date",
        "tax_code",
        "currency_type",
        "currency_type_3",
        CASE
            WHEN "currency_type_2" = '''m''' THEN '''UNKNOWN'''
            ELSE "currency_type_2"
        END AS "currency_type_2",
        "currency_type_3_alt",
        "statistical_posting_indicator",
        "ausbk",
        "eu_sales_list_indicator",
        "due_flag",
        "origin_system",
        "exchange_rate",
        "local_currency_exchange_rate",
        "lotkz",
        "tax_determination_date_indicator",
        "reversal_reason",
        "parked_by",
        "branch_number",
        "page_count",
        "additional_discount",
        "reference_key_1",
        "reference_key_2",
        "xreversal",
        "reindat",
        "ledger",
        "ledger_group",
        "property_management_object",
        "alternative_reference_number",
        "vat_date",
        "document_category",
        "line_item_split_indicator",
        "is_cash_allocation",
        "follow_on_indicator",
        "reorganization_status",
        "subset",
        "exchange_rate_type",
        "primary_exchange_rate",
        "exchange_rate_2",
        "exchange_rate_3",
        "special_gl_indicator",
        "resubmission_date",
        "sap_f15_status",
        "transaction_type",
        "accounting_clerk",
        "psoks",
        "posting_key",
        "psofn",
        "interest_calculation_form",
        "interest_calculation_date",
        "psobt",
        "line_item_number",
        "psodt",
        "document_time",
        "funds_management_type",
        "credit_card_issuer",
        "credit_card_number",
        "blocking_reason",
        "batch_number",
        "sname",
        "sampled_indicator",
        "exclude_flag",
        "is_blind_document",
        "offset_status",
        "offset_reference_date",
        "penalty_calculation_rule",
        "condition_record_number",
        "row_id",
        "is_deleted"
    FROM "sap_bkpf_data_projected_renamed"
),

"sap_bkpf_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- accounting_clerk: from DECIMAL to VARCHAR
    -- accounting_transaction: from DECIMAL to VARCHAR
    -- additional_discount: from DECIMAL to VARCHAR
    -- alternative_reference_number: from DECIMAL to VARCHAR
    -- archive_id: from DECIMAL to VARCHAR
    -- ausbk: from DECIMAL to VARCHAR
    -- batch_number: from DECIMAL to VARCHAR
    -- belnr: from INT to VARCHAR
    -- bldat: from INT to DATE
    -- blocking_reason: from DECIMAL to VARCHAR
    -- branch_number: from DECIMAL to VARCHAR
    -- budat: from INT to DATE
    -- bukrs: from INT to VARCHAR
    -- clearing_document_number: from DECIMAL to VARCHAR
    -- client_number: from INT to VARCHAR
    -- condition_record_number: from DECIMAL to VARCHAR
    -- credit_card_issuer: from DECIMAL to VARCHAR
    -- credit_card_number: from DECIMAL to VARCHAR
    -- currency_indicator: from DECIMAL to VARCHAR
    -- currency_type: from INT to VARCHAR
    -- currency_type_3: from INT to VARCHAR
    -- dbblg: from DECIMAL to VARCHAR
    -- document_category: from DECIMAL to VARCHAR
    -- document_header_text: from DECIMAL to VARCHAR
    -- document_id: from DECIMAL to VARCHAR
    -- document_reference_key: from INT to VARCHAR
    -- document_status: from DECIMAL to VARCHAR
    -- due_flag: from DECIMAL to VARCHAR
    -- entry_date: from INT to DATE
    -- entry_time: from INT to TIME
    -- eu_sales_list_indicator: from DECIMAL to VARCHAR
    -- exchange_rate_type: from DECIMAL to VARCHAR
    -- exclude_flag: from DECIMAL to VARCHAR
    -- financial_management_area: from INT to VARCHAR
    -- follow_on_indicator: from DECIMAL to VARCHAR
    -- funds_management_type: from DECIMAL to VARCHAR
    -- group_id: from DECIMAL to VARCHAR
    -- interest_calculation_form: from DECIMAL to VARCHAR
    -- invoice_correction_indicator: from DECIMAL to VARCHAR
    -- is_blind_document: from DECIMAL to VARCHAR
    -- is_cash_allocation: from DECIMAL to VARCHAR
    -- ledger: from DECIMAL to VARCHAR
    -- ledger_group: from DECIMAL to VARCHAR
    -- line_item_number: from DECIMAL to VARCHAR
    -- line_item_split_indicator: from DECIMAL to VARCHAR
    -- lotkz: from DECIMAL to VARCHAR
    -- net_amount: from DECIMAL to VARCHAR
    -- offset_status: from DECIMAL to VARCHAR
    -- origin_system: from DECIMAL to VARCHAR
    -- other_period_reversal_indicator: from DECIMAL to VARCHAR
    -- parked_by: from DECIMAL to VARCHAR
    -- penalty_calculation_rule: from DECIMAL to VARCHAR
    -- posting_key: from DECIMAL to VARCHAR
    -- property_management_object: from DECIMAL to VARCHAR
    -- psofn: from DECIMAL to VARCHAR
    -- psoks: from DECIMAL to VARCHAR
    -- reference_document_number: from DECIMAL to VARCHAR
    -- reference_key_1: from DECIMAL to VARCHAR
    -- reference_key_2: from DECIMAL to VARCHAR
    -- reorganization_status: from DECIMAL to VARCHAR
    -- reversal_reason: from DECIMAL to VARCHAR
    -- reverse_document_number: from DECIMAL to VARCHAR
    -- sampled_indicator: from DECIMAL to VARCHAR
    -- sap_f15_status: from DECIMAL to VARCHAR
    -- sname: from DECIMAL to VARCHAR
    -- special_gl_indicator: from DECIMAL to VARCHAR
    -- statistical_posting_indicator: from DECIMAL to VARCHAR
    -- subset: from DECIMAL to VARCHAR
    -- tax_code: from DECIMAL to VARCHAR
    -- tax_determination_date_indicator: from DECIMAL to VARCHAR
    -- transaction_type: from DECIMAL to VARCHAR
    -- value_date: from INT to DATE
    -- xreversal: from DECIMAL to VARCHAR
    SELECT
        "gjahr",
        "blart",
        "posting_month",
        "last_change_date",
        "update_date",
        "usnam",
        "transaction_code",
        "stjah",
        "currency_code",
        "fixed_exchange_rate",
        "reciprocal_exchange_rate_indicator",
        "freight_charges",
        "business_transaction",
        "reference_type",
        "primary_currency",
        "currency_2",
        "currency_3",
        "exchange_rate_currency_2",
        "exchange_rate_currency_3",
        "withholding_tax_base_method",
        "extended_withholding_tax_base",
        "unknown_field_2",
        "unknown_field_3",
        "reverse_posting_date",
        "currency_type_2",
        "currency_type_3_alt",
        "exchange_rate",
        "local_currency_exchange_rate",
        "page_count",
        "reindat",
        "vat_date",
        "primary_exchange_rate",
        "exchange_rate_2",
        "exchange_rate_3",
        "resubmission_date",
        "interest_calculation_date",
        "psobt",
        "psodt",
        "document_time",
        "offset_reference_date",
        "row_id",
        "is_deleted",
        CAST("accounting_clerk" AS VARCHAR) AS "accounting_clerk",
        CAST("accounting_transaction" AS VARCHAR) AS "accounting_transaction",
        CAST("additional_discount" AS VARCHAR) AS "additional_discount",
        CAST("alternative_reference_number" AS VARCHAR) AS "alternative_reference_number",
        CAST("archive_id" AS VARCHAR) AS "archive_id",
        CAST("ausbk" AS VARCHAR) AS "ausbk",
        CAST("batch_number" AS VARCHAR) AS "batch_number",
        CAST("belnr" AS VARCHAR) AS "belnr",
        strptime(CAST("bldat" AS VARCHAR), '%Y%m%d') AS "bldat",
        CAST("blocking_reason" AS VARCHAR) AS "blocking_reason",
        CAST("branch_number" AS VARCHAR) AS "branch_number",
        strptime(CAST("budat" AS VARCHAR), '%Y%m%d') AS "budat",
        CAST("bukrs" AS VARCHAR) AS "bukrs",
        CAST("clearing_document_number" AS VARCHAR) AS "clearing_document_number",
        CAST("client_number" AS VARCHAR) AS "client_number",
        CAST("condition_record_number" AS VARCHAR) AS "condition_record_number",
        CAST("credit_card_issuer" AS VARCHAR) AS "credit_card_issuer",
        CAST("credit_card_number" AS VARCHAR) AS "credit_card_number",
        CAST("currency_indicator" AS VARCHAR) AS "currency_indicator",
        CAST("currency_type" AS VARCHAR) AS "currency_type",
        CAST("currency_type_3" AS VARCHAR) AS "currency_type_3",
        CAST("dbblg" AS VARCHAR) AS "dbblg",
        CAST("document_category" AS VARCHAR) AS "document_category",
        CAST("document_header_text" AS VARCHAR) AS "document_header_text",
        CAST("document_id" AS VARCHAR) AS "document_id",
        CAST("document_reference_key" AS VARCHAR) AS "document_reference_key",
        CAST("document_status" AS VARCHAR) AS "document_status",
        CAST("due_flag" AS VARCHAR) AS "due_flag",
        strptime(CAST("entry_date" AS VARCHAR), '%Y%m%d') AS "entry_date",
        CAST(
            strptime(
                LPAD(CAST("entry_time" AS VARCHAR), 6, '0'),
                '%H%M%S'
            ) AS TIME
        ) AS "entry_time",
        CAST("eu_sales_list_indicator" AS VARCHAR) AS "eu_sales_list_indicator",
        CAST("exchange_rate_type" AS VARCHAR) AS "exchange_rate_type",
        CAST("exclude_flag" AS VARCHAR) AS "exclude_flag",
        CAST("financial_management_area" AS VARCHAR) AS "financial_management_area",
        CAST("follow_on_indicator" AS VARCHAR) AS "follow_on_indicator",
        CAST("funds_management_type" AS VARCHAR) AS "funds_management_type",
        CAST("group_id" AS VARCHAR) AS "group_id",
        CAST("interest_calculation_form" AS VARCHAR) AS "interest_calculation_form",
        CAST("invoice_correction_indicator" AS VARCHAR) AS "invoice_correction_indicator",
        CAST("is_blind_document" AS VARCHAR) AS "is_blind_document",
        CAST("is_cash_allocation" AS VARCHAR) AS "is_cash_allocation",
        CAST("ledger" AS VARCHAR) AS "ledger",
        CAST("ledger_group" AS VARCHAR) AS "ledger_group",
        CAST("line_item_number" AS VARCHAR) AS "line_item_number",
        CAST("line_item_split_indicator" AS VARCHAR) AS "line_item_split_indicator",
        CAST("lotkz" AS VARCHAR) AS "lotkz",
        CAST("net_amount" AS VARCHAR) AS "net_amount",
        CAST("offset_status" AS VARCHAR) AS "offset_status",
        CAST("origin_system" AS VARCHAR) AS "origin_system",
        CAST("other_period_reversal_indicator" AS VARCHAR) AS "other_period_reversal_indicator",
        CAST("parked_by" AS VARCHAR) AS "parked_by",
        CAST("penalty_calculation_rule" AS VARCHAR) AS "penalty_calculation_rule",
        CAST("posting_key" AS VARCHAR) AS "posting_key",
        CAST("property_management_object" AS VARCHAR) AS "property_management_object",
        CAST("psofn" AS VARCHAR) AS "psofn",
        CAST("psoks" AS VARCHAR) AS "psoks",
        CAST("reference_document_number" AS VARCHAR) AS "reference_document_number",
        CAST("reference_key_1" AS VARCHAR) AS "reference_key_1",
        CAST("reference_key_2" AS VARCHAR) AS "reference_key_2",
        CAST("reorganization_status" AS VARCHAR) AS "reorganization_status",
        CAST("reversal_reason" AS VARCHAR) AS "reversal_reason",
        CAST("reverse_document_number" AS VARCHAR) AS "reverse_document_number",
        CAST("sampled_indicator" AS VARCHAR) AS "sampled_indicator",
        CAST("sap_f15_status" AS VARCHAR) AS "sap_f15_status",
        CAST("sname" AS VARCHAR) AS "sname",
        CAST("special_gl_indicator" AS VARCHAR) AS "special_gl_indicator",
        CAST("statistical_posting_indicator" AS VARCHAR) AS "statistical_posting_indicator",
        CAST("subset" AS VARCHAR) AS "subset",
        CAST("tax_code" AS VARCHAR) AS "tax_code",
        CAST("tax_determination_date_indicator" AS VARCHAR) AS "tax_determination_date_indicator",
        CAST("transaction_type" AS VARCHAR) AS "transaction_type",
        strptime(CAST("value_date" AS VARCHAR), '%Y%m%d') AS "value_date",
        CAST("xreversal" AS VARCHAR) AS "xreversal"
    FROM "sap_bkpf_data_projected_renamed_cleaned"
),

"sap_bkpf_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 52 columns with unacceptable missing values
    -- accounting_clerk has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- accounting_transaction has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- additional_discount has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- alternative_reference_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- archive_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ausbk has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- batch_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- blocking_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- branch_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- clearing_document_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- condition_record_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- currency_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dbblg has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- document_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- document_header_text has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- document_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- document_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- due_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- eu_sales_list_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- exchange_rate_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- exclude_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- follow_on_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- funds_management_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- interest_calculation_form has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ledger has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ledger_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- line_item_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lotkz has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- net_amount has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- offset_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- origin_system has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- other_period_reversal_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- parked_by has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- penalty_calculation_rule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- posting_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- property_management_object has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psofn has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psoks has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_document_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_key_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_key_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reorganization_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sampled_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sap_f15_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sname has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statistical_posting_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subset has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_determination_date_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transaction_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xreversal has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "gjahr",
        "blart",
        "posting_month",
        "last_change_date",
        "update_date",
        "usnam",
        "transaction_code",
        "stjah",
        "currency_code",
        "fixed_exchange_rate",
        "reciprocal_exchange_rate_indicator",
        "freight_charges",
        "business_transaction",
        "reference_type",
        "primary_currency",
        "currency_2",
        "currency_3",
        "exchange_rate_currency_2",
        "exchange_rate_currency_3",
        "withholding_tax_base_method",
        "extended_withholding_tax_base",
        "unknown_field_2",
        "unknown_field_3",
        "reverse_posting_date",
        "currency_type_2",
        "currency_type_3_alt",
        "exchange_rate",
        "local_currency_exchange_rate",
        "page_count",
        "reindat",
        "vat_date",
        "primary_exchange_rate",
        "exchange_rate_2",
        "exchange_rate_3",
        "resubmission_date",
        "interest_calculation_date",
        "psobt",
        "psodt",
        "document_time",
        "offset_reference_date",
        "row_id",
        "is_deleted",
        "belnr",
        "bldat",
        "budat",
        "bukrs",
        "client_number",
        "credit_card_issuer",
        "credit_card_number",
        "currency_type",
        "currency_type_3",
        "document_reference_key",
        "entry_date",
        "entry_time",
        "financial_management_area",
        "invoice_correction_indicator",
        "is_blind_document",
        "is_cash_allocation",
        "line_item_split_indicator",
        "reversal_reason",
        "reverse_document_number",
        "special_gl_indicator",
        "value_date"
    FROM "sap_bkpf_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_bkpf_data_projected_renamed_cleaned_casted_missing_handled"