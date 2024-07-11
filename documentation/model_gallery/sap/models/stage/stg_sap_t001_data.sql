-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 14:54:30.885040+00:00
WITH 
"sap_t001_data_projected" AS (
    -- Projection: Selecting 81 out of 82 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "bukrs",
        "mandt",
        "butxt",
        "ort01",
        "land1",
        "waers",
        "spras",
        "ktopl",
        "waabw",
        "periv",
        "kokfi",
        "rcomp",
        "adrnr",
        "stceg",
        "fikrs",
        "xfmco",
        "xfmcb",
        "xfmca",
        "txjcd",
        "fmhrdate",
        "buvar",
        "fdbuk",
        "xfdis",
        "xvalv",
        "xskfn",
        "kkber",
        "xmwsn",
        "mregl",
        "xgsbe",
        "xgjrv",
        "xkdft",
        "xprod",
        "xeink",
        "xjvaa",
        "xvvwa",
        "xslta",
        "xfdmm",
        "xfdsd",
        "xextb",
        "ebukr",
        "ktop2",
        "umkrs",
        "bukrs_glob",
        "fstva",
        "opvar",
        "xcovr",
        "txkrs",
        "wfvar",
        "xbbbf",
        "xbbbe",
        "xbbba",
        "xbbko",
        "xstdt",
        "mwskv",
        "mwska",
        "impda",
        "xnegp",
        "xkkbi",
        "wt_newwt",
        "pp_pdate",
        "infmt",
        "fstvare",
        "kopim",
        "dkweg",
        "offsacct",
        "bapovar",
        "xcos",
        "xcession",
        "xsplt",
        "surccm",
        "dtprov",
        "dtamtc",
        "dttaxc",
        "dttdsp",
        "dtaxr",
        "xvatdate",
        "pst_per_var",
        "xbbsc",
        "fm_derive_acc",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_t001_data"
),

"sap_t001_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- bukrs -> company_code
    -- mandt -> client
    -- butxt -> company_name
    -- ort01 -> city
    -- land1 -> country_key
    -- waers -> currency_key
    -- spras -> language_key
    -- ktopl -> chart_of_accounts
    -- waabw -> exchange_rate_tolerance
    -- periv -> fiscal_year_variant
    -- kokfi -> controlling_to_fi_interface
    -- adrnr -> address_number
    -- stceg -> vat_registration_number
    -- fikrs -> financial_management_area
    -- xfmco -> pl_consolidation_flag
    -- xfmcb -> balance_sheet_consolidation_flag
    -- xfmca -> mgmt_consolidation_flag
    -- txjcd -> tax_jurisdiction_code
    -- fmhrdate -> fiscal_year_variant_change_date
    -- buvar -> business_transaction_variant
    -- fdbuk -> fm_company_code
    -- xfdis -> distribution_flag
    -- xvalv -> valuation_flag
    -- xskfn -> special_gl_transactions_flag
    -- kkber -> credit_control_area
    -- xmwsn -> vat_flag
    -- mregl -> material_ledger_regulation
    -- xgsbe -> business_area_flag
    -- xgjrv -> fiscal_year_variant_flag
    -- xkdft -> customer_down_payment_flag
    -- xprod -> production_orders_flag
    -- xeink -> purchasing_company_code
    -- xjvaa -> joint_venture_accounting_flag
    -- xvvwa -> foreign_currency_valuation_flag
    -- xslta -> contract_management_flag
    -- xfdmm -> mm_flag
    -- xfdsd -> sd_flag
    -- xextb -> extended_bookkeeping
    -- ktop2 -> interest_calculation_profit_center
    -- umkrs -> sales_organization
    -- bukrs_glob -> global_company_code
    -- fstva -> funds_management_variant
    -- opvar -> open_period_variant
    -- xcovr -> coverage_indicator
    -- txkrs -> tax_calculation_procedure
    -- wfvar -> cash_flow_variant
    -- xbbbf -> cash_flow_account
    -- xbbbe -> pl_statement_account
    -- xbbba -> balance_sheet_account
    -- xbbko -> cost_accounting_account
    -- xstdt -> statistical_postings_flag
    -- mwskv -> output_tax_category
    -- mwska -> input_tax_category
    -- impda -> implementation_date
    -- xnegp -> negative_postings_flag
    -- xkkbi -> vendor_down_payment_flag
    -- wt_newwt -> new_withholding_tax
    -- pp_pdate -> posting_period_end_date
    -- infmt -> information_system_format
    -- fstvare -> extended_funds_management_variant
    -- dkweg -> dunning_procedure
    -- offsacct -> offsetting_account
    -- bapovar -> business_area_posting_variant
    -- xcession -> factoring_indicator
    -- xsplt -> splitting_flag
    -- surccm -> surcharge_calculation_method
    -- dtprov -> provisions_doc_type
    -- dtamtc -> auto_clearing_doc_type
    -- dttaxc -> tax_clearing_doc_type
    -- dttdsp -> down_payment_doc_type
    -- dtaxr -> auto_tax_reporting_doc_type
    -- xvatdate -> vat_reporting_date_flag
    -- pst_per_var -> posting_period_variant
    -- xbbsc -> equity_changes_account
    -- fm_derive_acc -> fm_derive_accounts
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "bukrs" AS "company_code",
        "mandt" AS "client",
        "butxt" AS "company_name",
        "ort01" AS "city",
        "land1" AS "country_key",
        "waers" AS "currency_key",
        "spras" AS "language_key",
        "ktopl" AS "chart_of_accounts",
        "waabw" AS "exchange_rate_tolerance",
        "periv" AS "fiscal_year_variant",
        "kokfi" AS "controlling_to_fi_interface",
        "rcomp",
        "adrnr" AS "address_number",
        "stceg" AS "vat_registration_number",
        "fikrs" AS "financial_management_area",
        "xfmco" AS "pl_consolidation_flag",
        "xfmcb" AS "balance_sheet_consolidation_flag",
        "xfmca" AS "mgmt_consolidation_flag",
        "txjcd" AS "tax_jurisdiction_code",
        "fmhrdate" AS "fiscal_year_variant_change_date",
        "buvar" AS "business_transaction_variant",
        "fdbuk" AS "fm_company_code",
        "xfdis" AS "distribution_flag",
        "xvalv" AS "valuation_flag",
        "xskfn" AS "special_gl_transactions_flag",
        "kkber" AS "credit_control_area",
        "xmwsn" AS "vat_flag",
        "mregl" AS "material_ledger_regulation",
        "xgsbe" AS "business_area_flag",
        "xgjrv" AS "fiscal_year_variant_flag",
        "xkdft" AS "customer_down_payment_flag",
        "xprod" AS "production_orders_flag",
        "xeink" AS "purchasing_company_code",
        "xjvaa" AS "joint_venture_accounting_flag",
        "xvvwa" AS "foreign_currency_valuation_flag",
        "xslta" AS "contract_management_flag",
        "xfdmm" AS "mm_flag",
        "xfdsd" AS "sd_flag",
        "xextb" AS "extended_bookkeeping",
        "ebukr",
        "ktop2" AS "interest_calculation_profit_center",
        "umkrs" AS "sales_organization",
        "bukrs_glob" AS "global_company_code",
        "fstva" AS "funds_management_variant",
        "opvar" AS "open_period_variant",
        "xcovr" AS "coverage_indicator",
        "txkrs" AS "tax_calculation_procedure",
        "wfvar" AS "cash_flow_variant",
        "xbbbf" AS "cash_flow_account",
        "xbbbe" AS "pl_statement_account",
        "xbbba" AS "balance_sheet_account",
        "xbbko" AS "cost_accounting_account",
        "xstdt" AS "statistical_postings_flag",
        "mwskv" AS "output_tax_category",
        "mwska" AS "input_tax_category",
        "impda" AS "implementation_date",
        "xnegp" AS "negative_postings_flag",
        "xkkbi" AS "vendor_down_payment_flag",
        "wt_newwt" AS "new_withholding_tax",
        "pp_pdate" AS "posting_period_end_date",
        "infmt" AS "information_system_format",
        "fstvare" AS "extended_funds_management_variant",
        "kopim",
        "dkweg" AS "dunning_procedure",
        "offsacct" AS "offsetting_account",
        "bapovar" AS "business_area_posting_variant",
        "xcos",
        "xcession" AS "factoring_indicator",
        "xsplt" AS "splitting_flag",
        "surccm" AS "surcharge_calculation_method",
        "dtprov" AS "provisions_doc_type",
        "dtamtc" AS "auto_clearing_doc_type",
        "dttaxc" AS "tax_clearing_doc_type",
        "dttdsp" AS "down_payment_doc_type",
        "dtaxr" AS "auto_tax_reporting_doc_type",
        "xvatdate" AS "vat_reporting_date_flag",
        "pst_per_var" AS "posting_period_variant",
        "xbbsc" AS "equity_changes_account",
        "fm_derive_acc" AS "fm_derive_accounts",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_t001_data_projected"
),

"sap_t001_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- country_key: The problem is that 'fn', 'ga', and 'so' are not standard ISO 3166-1 alpha-2 country codes. 'fn' likely stands for Finland, which should be 'FI'. 'ga' might be a typo for Gabon, which should be 'GA' (uppercase). 'so' is probably Somalia, which should be 'SO' (uppercase). The correct values should be standardized ISO 3166-1 alpha-2 country codes. 
    -- distribution_flag: The problem is that the distribution_flag column only contains the value 'x', which is not descriptive and doesn't clearly indicate the purpose of the flag. In flag columns, it's generally more informative to use boolean values (True/False) or more descriptive terms (e.g., 'distributed', 'not_distributed'). Since we don't have additional context about what 'x' specifically represents, we can't determine a more precise meaning. However, we can infer that the presence of 'x' likely indicates some form of distribution or selection. 
    -- business_area_flag: The problem is that the business_area_flag column contains only one value, 'x', which is not descriptive and doesn't represent a clear business area category. This value is unusual because it doesn't provide any meaningful information about the business area. The correct values for a business area flag should be more descriptive and represent actual business areas or categories. However, without additional context or information about the intended use of this column, it's difficult to suggest specific correct values. 
    -- customer_down_payment_flag: The problem is that 'x' is an unusual value for a flag field. Typically, flag fields use more descriptive values like 'true'/'false' or '1'/'0'. In this case, 'x' appears to be used to indicate a positive flag (i.e., the customer made a down payment). The correct values should be boolean 'true' or 'false', or numeric '1' or '0'. 
    -- purchasing_company_code: The problem is that 'x' is not a typical company code format. Company codes are usually more descriptive or follow a standardized format, such as alphanumeric combinations or abbreviations of company names. The value 'x' seems to be a placeholder or an error, rather than a meaningful company code. Without more context or information about the correct company codes, it's difficult to map this to a specific correct value. In this case, it might be best to mark this data as missing or invalid. 
    -- sd_flag: The problem is that the sd_flag column uses 'x' as its only value, which is unusual for a flag column. Typically, flag columns use more meaningful and explicit values such as 'true'/'false', 'yes'/'no', or '1'/'0'. The 'x' value doesn't clearly indicate what the flag represents or what its absence means. The correct values for a flag column should be more descriptive and follow a boolean logic. 
    -- new_withholding_tax: The problem is that 'x' is not a valid numeric value for a tax rate. Typically, withholding tax rates are expressed as percentages or decimal values. The 'x' likely represents missing or unknown data. In this case, since we don't have any other information about what the correct tax rate should be, the most appropriate action is to map this to an empty string to indicate missing data. 
    SELECT
        "company_code",
        "client",
        "company_name",
        "city",
        CASE
            WHEN "country_key" = '''fn''' THEN '''FI'''
            WHEN "country_key" = '''ga''' THEN '''GA'''
            WHEN "country_key" = '''so''' THEN '''SO'''
            ELSE "country_key"
        END AS "country_key",
        "currency_key",
        "language_key",
        "chart_of_accounts",
        "exchange_rate_tolerance",
        "fiscal_year_variant",
        "controlling_to_fi_interface",
        "rcomp",
        "address_number",
        "vat_registration_number",
        "financial_management_area",
        "pl_consolidation_flag",
        "balance_sheet_consolidation_flag",
        "mgmt_consolidation_flag",
        "tax_jurisdiction_code",
        "fiscal_year_variant_change_date",
        "business_transaction_variant",
        "fm_company_code",
        CASE
            WHEN "distribution_flag" = '''x''' THEN '''distributed'''
            ELSE "distribution_flag"
        END AS "distribution_flag",
        "valuation_flag",
        "special_gl_transactions_flag",
        "credit_control_area",
        "vat_flag",
        "material_ledger_regulation",
        CASE
            WHEN "business_area_flag" = '''x''' THEN ''''
            ELSE "business_area_flag"
        END AS "business_area_flag",
        "fiscal_year_variant_flag",
        CASE
            WHEN "customer_down_payment_flag" = '''x''' THEN '''true'''
            ELSE "customer_down_payment_flag"
        END AS "customer_down_payment_flag",
        "production_orders_flag",
        CASE
            WHEN "purchasing_company_code" = '''x''' THEN ''''
            ELSE "purchasing_company_code"
        END AS "purchasing_company_code",
        "joint_venture_accounting_flag",
        "foreign_currency_valuation_flag",
        "contract_management_flag",
        "mm_flag",
        CASE
            WHEN "sd_flag" = '''x''' THEN '''true'''
            ELSE "sd_flag"
        END AS "sd_flag",
        "extended_bookkeeping",
        "ebukr",
        "interest_calculation_profit_center",
        "sales_organization",
        "global_company_code",
        "funds_management_variant",
        "open_period_variant",
        "coverage_indicator",
        "tax_calculation_procedure",
        "cash_flow_variant",
        "cash_flow_account",
        "pl_statement_account",
        "balance_sheet_account",
        "cost_accounting_account",
        "statistical_postings_flag",
        "output_tax_category",
        "input_tax_category",
        "implementation_date",
        "negative_postings_flag",
        "vendor_down_payment_flag",
        CASE
            WHEN "new_withholding_tax" = '''x''' THEN ''''
            ELSE "new_withholding_tax"
        END AS "new_withholding_tax",
        "posting_period_end_date",
        "information_system_format",
        "extended_funds_management_variant",
        "kopim",
        "dunning_procedure",
        "offsetting_account",
        "business_area_posting_variant",
        "xcos",
        "factoring_indicator",
        "splitting_flag",
        "surcharge_calculation_method",
        "provisions_doc_type",
        "auto_clearing_doc_type",
        "tax_clearing_doc_type",
        "down_payment_doc_type",
        "auto_tax_reporting_doc_type",
        "vat_reporting_date_flag",
        "posting_period_variant",
        "equity_changes_account",
        "fm_derive_accounts",
        "row_id",
        "is_deleted"
    FROM "sap_t001_data_projected_renamed"
),

"sap_t001_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- address_number: from DECIMAL to INT
    -- auto_clearing_doc_type: from DECIMAL to VARCHAR
    -- auto_tax_reporting_doc_type: from DECIMAL to VARCHAR
    -- balance_sheet_account: from DECIMAL to VARCHAR
    -- balance_sheet_consolidation_flag: from DECIMAL to VARCHAR
    -- business_area_posting_variant: from DECIMAL to VARCHAR
    -- cash_flow_account: from DECIMAL to VARCHAR
    -- client: from INT to VARCHAR
    -- company_code: from INT to VARCHAR
    -- contract_management_flag: from DECIMAL to VARCHAR
    -- controlling_to_fi_interface: from INT to VARCHAR
    -- cost_accounting_account: from DECIMAL to VARCHAR
    -- coverage_indicator: from DECIMAL to VARCHAR
    -- down_payment_doc_type: from DECIMAL to VARCHAR
    -- dunning_procedure: from DECIMAL to VARCHAR
    -- ebukr: from DECIMAL to VARCHAR
    -- equity_changes_account: from DECIMAL to VARCHAR
    -- exchange_rate_tolerance: from INT to VARCHAR
    -- extended_bookkeeping: from DECIMAL to VARCHAR
    -- financial_management_area: from DECIMAL to VARCHAR
    -- fiscal_year_variant_change_date: from INT to DATE
    -- fm_company_code: from DECIMAL to VARCHAR
    -- fm_derive_accounts: from DECIMAL to VARCHAR
    -- foreign_currency_valuation_flag: from DECIMAL to VARCHAR
    -- funds_management_variant: from INT to VARCHAR
    -- global_company_code: from DECIMAL to VARCHAR
    -- information_system_format: from DECIMAL to VARCHAR
    -- joint_venture_accounting_flag: from DECIMAL to VARCHAR
    -- kopim: from DECIMAL to VARCHAR
    -- material_ledger_regulation: from DECIMAL to VARCHAR
    -- mgmt_consolidation_flag: from DECIMAL to VARCHAR
    -- offsetting_account: from INT to VARCHAR
    -- open_period_variant: from INT to VARCHAR
    -- pl_consolidation_flag: from DECIMAL to VARCHAR
    -- pl_statement_account: from DECIMAL to VARCHAR
    -- posting_period_end_date: from DECIMAL to VARCHAR
    -- posting_period_variant: from DECIMAL to VARCHAR
    -- production_orders_flag: from DECIMAL to VARCHAR
    -- provisions_doc_type: from DECIMAL to VARCHAR
    -- special_gl_transactions_flag: from DECIMAL to VARCHAR
    -- splitting_flag: from DECIMAL to VARCHAR
    -- statistical_postings_flag: from DECIMAL to VARCHAR
    -- surcharge_calculation_method: from DECIMAL to VARCHAR
    -- tax_calculation_procedure: from DECIMAL to VARCHAR
    -- tax_clearing_doc_type: from DECIMAL to VARCHAR
    -- tax_jurisdiction_code: from DECIMAL to VARCHAR
    -- vat_flag: from DECIMAL to VARCHAR
    -- vat_reporting_date_flag: from DECIMAL to VARCHAR
    -- vendor_down_payment_flag: from DECIMAL to VARCHAR
    SELECT
        "company_name",
        "city",
        "country_key",
        "currency_key",
        "language_key",
        "chart_of_accounts",
        "fiscal_year_variant",
        "rcomp",
        "vat_registration_number",
        "business_transaction_variant",
        "distribution_flag",
        "valuation_flag",
        "credit_control_area",
        "business_area_flag",
        "fiscal_year_variant_flag",
        "customer_down_payment_flag",
        "purchasing_company_code",
        "mm_flag",
        "sd_flag",
        "interest_calculation_profit_center",
        "sales_organization",
        "cash_flow_variant",
        "output_tax_category",
        "input_tax_category",
        "implementation_date",
        "negative_postings_flag",
        "new_withholding_tax",
        "extended_funds_management_variant",
        "xcos",
        "factoring_indicator",
        "row_id",
        "is_deleted",
        CAST("address_number" AS INT) AS "address_number",
        CAST("auto_clearing_doc_type" AS VARCHAR) AS "auto_clearing_doc_type",
        CAST("auto_tax_reporting_doc_type" AS VARCHAR) AS "auto_tax_reporting_doc_type",
        CAST("balance_sheet_account" AS VARCHAR) AS "balance_sheet_account",
        CAST("balance_sheet_consolidation_flag" AS VARCHAR) AS "balance_sheet_consolidation_flag",
        CAST("business_area_posting_variant" AS VARCHAR) AS "business_area_posting_variant",
        CAST("cash_flow_account" AS VARCHAR) AS "cash_flow_account",
        CAST("client" AS VARCHAR) AS "client",
        CAST("company_code" AS VARCHAR) AS "company_code",
        CAST("contract_management_flag" AS VARCHAR) AS "contract_management_flag",
        CAST("controlling_to_fi_interface" AS VARCHAR) AS "controlling_to_fi_interface",
        CAST("cost_accounting_account" AS VARCHAR) AS "cost_accounting_account",
        CAST("coverage_indicator" AS VARCHAR) AS "coverage_indicator",
        CAST("down_payment_doc_type" AS VARCHAR) AS "down_payment_doc_type",
        CAST("dunning_procedure" AS VARCHAR) AS "dunning_procedure",
        CAST("ebukr" AS VARCHAR) AS "ebukr",
        CAST("equity_changes_account" AS VARCHAR) AS "equity_changes_account",
        CAST("exchange_rate_tolerance" AS VARCHAR) AS "exchange_rate_tolerance",
        CAST("extended_bookkeeping" AS VARCHAR) AS "extended_bookkeeping",
        CAST("financial_management_area" AS VARCHAR) AS "financial_management_area",
        CASE 
            WHEN "fiscal_year_variant_change_date" = 0 THEN NULL
            ELSE strptime(CAST("fiscal_year_variant_change_date" AS VARCHAR), '%Y%m%d')
        END AS "fiscal_year_variant_change_date",
        CAST("fm_company_code" AS VARCHAR) AS "fm_company_code",
        CAST("fm_derive_accounts" AS VARCHAR) AS "fm_derive_accounts",
        CAST("foreign_currency_valuation_flag" AS VARCHAR) AS "foreign_currency_valuation_flag",
        CAST("funds_management_variant" AS VARCHAR) AS "funds_management_variant",
        CAST("global_company_code" AS VARCHAR) AS "global_company_code",
        CAST("information_system_format" AS VARCHAR) AS "information_system_format",
        CAST("joint_venture_accounting_flag" AS VARCHAR) AS "joint_venture_accounting_flag",
        CAST("kopim" AS VARCHAR) AS "kopim",
        CAST("material_ledger_regulation" AS VARCHAR) AS "material_ledger_regulation",
        CAST("mgmt_consolidation_flag" AS VARCHAR) AS "mgmt_consolidation_flag",
        CAST("offsetting_account" AS VARCHAR) AS "offsetting_account",
        CAST("open_period_variant" AS VARCHAR) AS "open_period_variant",
        CAST("pl_consolidation_flag" AS VARCHAR) AS "pl_consolidation_flag",
        CAST("pl_statement_account" AS VARCHAR) AS "pl_statement_account",
        CAST("posting_period_end_date" AS VARCHAR) AS "posting_period_end_date",
        CAST("posting_period_variant" AS VARCHAR) AS "posting_period_variant",
        CAST("production_orders_flag" AS VARCHAR) AS "production_orders_flag",
        CAST("provisions_doc_type" AS VARCHAR) AS "provisions_doc_type",
        CAST("special_gl_transactions_flag" AS VARCHAR) AS "special_gl_transactions_flag",
        CAST("splitting_flag" AS VARCHAR) AS "splitting_flag",
        CAST("statistical_postings_flag" AS VARCHAR) AS "statistical_postings_flag",
        CAST("surcharge_calculation_method" AS VARCHAR) AS "surcharge_calculation_method",
        CAST("tax_calculation_procedure" AS VARCHAR) AS "tax_calculation_procedure",
        CAST("tax_clearing_doc_type" AS VARCHAR) AS "tax_clearing_doc_type",
        CAST("tax_jurisdiction_code" AS VARCHAR) AS "tax_jurisdiction_code",
        CAST("vat_flag" AS VARCHAR) AS "vat_flag",
        CAST("vat_reporting_date_flag" AS VARCHAR) AS "vat_reporting_date_flag",
        CAST("vendor_down_payment_flag" AS VARCHAR) AS "vendor_down_payment_flag"
    FROM "sap_t001_data_projected_renamed_cleaned"
),

"sap_t001_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 50 columns with unacceptable missing values
    -- address_number has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- auto_clearing_doc_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- auto_tax_reporting_doc_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- balance_sheet_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- balance_sheet_consolidation_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_area_posting_variant has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_transaction_variant has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- cash_flow_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cash_flow_variant has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- contract_management_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_accounting_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- coverage_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- credit_control_area has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- down_payment_doc_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dunning_procedure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ebukr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- equity_changes_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- extended_bookkeeping has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- extended_funds_management_variant has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- financial_management_area has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- fm_company_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fm_derive_accounts has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- foreign_currency_valuation_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- global_company_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- implementation_date has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- information_system_format has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- interest_calculation_profit_center has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- joint_venture_accounting_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- kopim has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- material_ledger_regulation has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mm_flag has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- negative_postings_flag has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- new_withholding_tax has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- posting_period_end_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- posting_period_variant has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- production_orders_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- provisions_doc_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchasing_company_code has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- rcomp has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- special_gl_transactions_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- splitting_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statistical_postings_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- surcharge_calculation_method has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_calculation_procedure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_clearing_doc_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_jurisdiction_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vat_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vat_reporting_date_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vendor_down_payment_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xcos has 33.33 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "company_name",
        "city",
        "country_key",
        "currency_key",
        "language_key",
        "chart_of_accounts",
        "fiscal_year_variant",
        "rcomp",
        "vat_registration_number",
        "business_transaction_variant",
        "distribution_flag",
        "valuation_flag",
        "credit_control_area",
        "business_area_flag",
        "fiscal_year_variant_flag",
        "customer_down_payment_flag",
        "purchasing_company_code",
        "mm_flag",
        "sd_flag",
        "interest_calculation_profit_center",
        "sales_organization",
        "cash_flow_variant",
        "output_tax_category",
        "input_tax_category",
        "implementation_date",
        "negative_postings_flag",
        "new_withholding_tax",
        "extended_funds_management_variant",
        "xcos",
        "factoring_indicator",
        "row_id",
        "is_deleted",
        "address_number",
        "client",
        "company_code",
        "controlling_to_fi_interface",
        "exchange_rate_tolerance",
        "financial_management_area",
        "fiscal_year_variant_change_date",
        "funds_management_variant",
        "mgmt_consolidation_flag",
        "offsetting_account",
        "open_period_variant",
        "pl_consolidation_flag",
        "pl_statement_account"
    FROM "sap_t001_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_t001_data_projected_renamed_cleaned_casted_missing_handled"