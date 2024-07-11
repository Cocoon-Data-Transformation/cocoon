-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 04:38:06.086647+00:00
WITH 
"sap_bseg_data_projected" AS (
    -- Projection: Selecting 349 out of 350 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "belnr",
        "bukrs",
        "buzei",
        "gjahr",
        "mandt",
        "buzid",
        "augdt",
        "augcp",
        "augbl",
        "bschl",
        "koart",
        "umskz",
        "umsks",
        "zumsk",
        "shkzg",
        "gsber",
        "pargb",
        "mwskz",
        "qsskz",
        "dmbtr",
        "wrbtr",
        "kzbtr",
        "pswbt",
        "pswsl",
        "txbhw",
        "txbfw",
        "mwsts",
        "wmwst",
        "hwbas",
        "fwbas",
        "hwzuz",
        "fwzuz",
        "shzuz",
        "stekz",
        "mwart",
        "txgrp",
        "ktosl",
        "qsshb",
        "kursr",
        "gbetr",
        "bdiff",
        "bdif2",
        "valut",
        "zuonr",
        "sgtxt",
        "zinkz",
        "vbund",
        "bewar",
        "altkt",
        "vorgn",
        "fdlev",
        "fdgrp",
        "fdwbt",
        "fdtag",
        "fkont",
        "kokrs",
        "kostl",
        "projn",
        "aufnr",
        "vbeln",
        "vbel2",
        "posn2",
        "eten2",
        "anln1",
        "anln2",
        "anbwa",
        "bzdat",
        "pernr",
        "xumsw",
        "xhres",
        "xkres",
        "xopvw",
        "xcpdd",
        "xskst",
        "xsauf",
        "xspro",
        "xserg",
        "xfakt",
        "xuman",
        "xanet",
        "xskrl",
        "xinve",
        "xpanz",
        "xauto",
        "xncop",
        "xzahl",
        "saknr",
        "hkont",
        "kunnr",
        "lifnr",
        "filkd",
        "xbilk",
        "gvtyp",
        "hzuon",
        "zfbdt",
        "zterm",
        "zbd1t",
        "zbd2t",
        "zbd3t",
        "zbd1p",
        "zbd2p",
        "skfbt",
        "sknto",
        "wskto",
        "zlsch",
        "zlspr",
        "zbfix",
        "hbkid",
        "bvtyp",
        "nebtr",
        "mwsk1",
        "dmbt1",
        "wrbt1",
        "mwsk2",
        "dmbt2",
        "wrbt2",
        "mwsk3",
        "dmbt3",
        "wrbt3",
        "rebzg",
        "rebzj",
        "rebzz",
        "rebzt",
        "zollt",
        "zolld",
        "lzbkz",
        "landl",
        "diekz",
        "samnr",
        "abper",
        "vrskz",
        "vrsdt",
        "disbn",
        "disbj",
        "disbz",
        "wverw",
        "anfbn",
        "anfbj",
        "anfbu",
        "anfae",
        "blnbt",
        "blnkz",
        "blnpz",
        "mschl",
        "mansp",
        "madat",
        "manst",
        "maber",
        "esrnr",
        "esrre",
        "esrpz",
        "klibt",
        "qsznr",
        "qbshb",
        "qsfbt",
        "navhw",
        "navfw",
        "matnr",
        "werks",
        "menge",
        "meins",
        "erfmg",
        "erfme",
        "bpmng",
        "bprme",
        "ebeln",
        "ebelp",
        "zekkn",
        "elikz",
        "vprsv",
        "peinh",
        "bwkey",
        "bwtar",
        "bustw",
        "rewrt",
        "rewwr",
        "bonfb",
        "bualt",
        "psalt",
        "nprei",
        "tbtkz",
        "spgrp",
        "spgrm",
        "spgrt",
        "spgrg",
        "spgrv",
        "spgrq",
        "stceg",
        "egbld",
        "eglld",
        "rstgr",
        "ryacq",
        "rpacq",
        "rdiff",
        "rdif2",
        "prctr",
        "xhkom",
        "vname",
        "recid",
        "egrup",
        "vptnr",
        "vertt",
        "vertn",
        "vbewa",
        "depot",
        "txjcd",
        "imkey",
        "dabrz",
        "popts",
        "fipos",
        "kstrg",
        "nplnr",
        "aufpl",
        "aplzl",
        "projk",
        "paobjnr",
        "pasubnr",
        "spgrs",
        "spgrc",
        "btype",
        "etype",
        "xegdr",
        "lnran",
        "hrkft",
        "dmbe2",
        "dmbe3",
        "dmb21",
        "dmb22",
        "dmb23",
        "dmb31",
        "dmb32",
        "dmb33",
        "mwst2",
        "mwst3",
        "navh2",
        "navh3",
        "sknt2",
        "sknt3",
        "bdif3",
        "rdif3",
        "hwmet",
        "glupm",
        "xragl",
        "uzawe",
        "lokkt",
        "fistl",
        "geber",
        "stbuk",
        "txbh2",
        "txbh3",
        "pprct",
        "xref1",
        "xref2",
        "kblnr",
        "kblpos",
        "sttax",
        "fkber",
        "obzei",
        "xnegp",
        "rfzei",
        "ccbtc",
        "kkber",
        "empfb",
        "xref3",
        "dtws1",
        "dtws2",
        "dtws3",
        "dtws4",
        "gricd",
        "grirg",
        "gityp",
        "xpypr",
        "kidno",
        "absbt",
        "idxsp",
        "linfv",
        "kontt",
        "kontl",
        "txdat",
        "agzei",
        "pycur",
        "pyamt",
        "bupla",
        "secco",
        "lstar",
        "cession_kz",
        "prznr",
        "ppdiff",
        "ppdif2",
        "ppdif3",
        "penlc1",
        "penlc2",
        "penlc3",
        "penfc",
        "pendays",
        "penrc",
        "grant_nbr",
        "sctax",
        "fkber_long",
        "gmvkz",
        "srtype",
        "intreno",
        "measure",
        "auggj",
        "ppa_ex_ind",
        "docln",
        "segment",
        "psegment",
        "pfkber",
        "hktid",
        "kstar",
        "xlgclr",
        "taxps",
        "pays_prov",
        "pays_tran",
        "mndid",
        "xfrge_bseg",
        "squan",
        "zzspreg",
        "zzbuspartn",
        "zzchan",
        "zzproduct",
        "zzloca",
        "zzlob",
        "zzuserfld1",
        "zzuserfld2",
        "zzuserfld3",
        "zzstate",
        "zzregion",
        "re_bukrs",
        "re_account",
        "pgeber",
        "pgrant_nbr",
        "budget_pd",
        "pbudget_pd",
        "j_1tpbupl",
        "perop_beg",
        "perop_end",
        "fastpay",
        "ignr_ivref",
        "fmfgus_key",
        "fmxdocnr",
        "fmxyear",
        "fmxdocln",
        "fmxzekkn",
        "prodper",
        "recrf",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_bseg_data"
),

"sap_bseg_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- bukrs -> company_code
    -- gjahr -> fiscal_year
    -- mandt -> client_id
    -- buzid -> line_item_identifier
    -- augdt -> clearing_date
    -- augcp -> clearing_fiscal_period
    -- augbl -> clearing_document_number
    -- bschl -> posting_key
    -- umsks -> special_gl_transaction_type
    -- shkzg -> debit_credit_indicator
    -- gsber -> business_area
    -- pargb -> partner_business_area
    -- mwskz -> vat_tax_code
    -- qsskz -> accounting_code_1
    -- dmbtr -> total_local_amount
    -- kzbtr -> document_currency_amount
    -- pswbt -> transaction_amount
    -- pswsl -> transaction_currency
    -- txbhw -> transaction_currency_tax_base
    -- txbfw -> tax_base_amount
    -- mwsts -> foreign_tax_amount
    -- wmwst -> tax_amount
    -- hwbas -> home_currency_amount
    -- fwbas -> functional_area_amount
    -- hwzuz -> home_currency_assignment_amount
    -- fwzuz -> functional_area_assignment_amount
    -- stekz -> tax_exempt_indicator
    -- mwart -> foreign_currency_valuation_type
    -- txgrp -> tax_group
    -- ktosl -> account_key
    -- qsshb -> accounting_value_3
    -- bdiff -> valuation_difference
    -- bdif2 -> valuation_difference_2
    -- valut -> value_date
    -- sgtxt -> line_item_text
    -- zinkz -> internal_code
    -- vbund -> trading_partner
    -- bewar -> asset_valuation_type
    -- altkt -> alternative_account
    -- vorgn -> transaction_type
    -- fdlev -> planning_level
    -- fdgrp -> planning_group
    -- fdwbt -> planned_price
    -- fdtag -> factory_calendar_date
    -- fkont -> funds_reservation_number
    -- kokrs -> controlling_area
    -- projn -> project_number
    -- aufnr -> order_number
    -- vbeln -> sales_document_number
    -- posn2 -> position_number
    -- eten2 -> delivery_date
    -- anln1 -> main_asset_number
    -- anln2 -> asset_subnumber
    -- anbwa -> asset_transaction_type
    -- bzdat -> asset_value_date
    -- pernr -> personnel_number
    -- xumsw -> tax_code_change_indicator
    -- xhres -> clearing_reversal_indicator
    -- xkres -> document_reversal_indicator
    -- xopvw -> open_item_management_indicator
    -- xcpdd -> clearing_with_down_payment
    -- xskst -> tax_posting_reversal_indicator
    -- xspro -> sample_document_indicator
    -- xserg -> recurring_entry_original_indicator
    -- xuman -> manual_entry_indicator
    -- xanet -> net_payment_indicator
    -- xskrl -> grir_clearing_reversal_indicator
    -- xinve -> invoice_indicator
    -- xpanz -> partial_payment_indicator
    -- xauto -> automatic_posting_indicator
    -- xncop -> noted_item_indicator
    -- xzahl -> payment_indicator
    -- saknr -> gl_account_number
    -- hkont -> gl_account
    -- kunnr -> customer_number
    -- lifnr -> vendor_number
    -- filkd -> billing_type
    -- xbilk -> balance_sheet_update_indicator
    -- zfbdt -> due_date_baseline
    -- zterm -> payment_terms
    -- zbd1t -> cash_discount_days_1
    -- zbd2t -> cash_discount_days_2
    -- zbd3t -> net_payment_terms_days
    -- zbd1p -> cash_discount_percent_1
    -- zbd2p -> cash_discount_percent_2
    -- sknto -> transaction_currency_amount
    -- wskto -> cash_discount_amount
    -- zlsch -> payment_method
    -- zlspr -> payment_block
    -- zbfix -> fixed_payment_terms_indicator
    -- hbkid -> house_bank_id
    -- bvtyp -> partner_bank_type
    -- nebtr -> net_amount
    -- mwsk1 -> tax_code_1
    -- dmbt1 -> local_amount_1
    -- wrbt1 -> withholding_tax_amount_1
    -- mwsk2 -> tax_code_2
    -- dmbt2 -> local_amount_2
    -- wrbt2 -> withholding_tax_amount_2
    -- mwsk3 -> tax_code_3
    -- dmbt3 -> local_amount_3
    -- wrbt3 -> withholding_tax_amount_3
    -- rebzj -> reference_fiscal_year
    -- rebzz -> reference_line_item
    -- rebzt -> reference_document_type
    -- zollt -> customs_tariff
    -- zolld -> customs_amount
    -- lzbkz -> payment_terms_key
    -- landl -> country_key
    -- diekz -> service_indicator
    -- samnr -> sample_number
    -- abper -> depreciation_period
    -- vrskz -> insurance_indicator
    -- vrsdt -> insurance_date
    -- disbn -> discount_base_period_number
    -- disbj -> discount_base_year
    -- disbz -> discount_base_period
    -- anfbn -> asset_acquisition_period
    -- anfbj -> asset_acquisition_year
    -- anfbu -> acquisition_date
    -- anfae -> apc_area
    -- blnbt -> document_amount_local
    -- blnkz -> balance_indicator
    -- blnpz -> balance_carryforward
    -- mschl -> dunning_level
    -- mansp -> manual_split_indicator
    -- madat -> material_document_date
    -- manst -> manual_stats_update
    -- esrnr -> gr_ir_clearing_number
    -- esrre -> bill_of_exchange_procedure
    -- esrpz -> payment_term
    -- qsznr -> accounting_number_1
    -- qbshb -> accounting_value_1
    -- qsfbt -> accounting_value_2
    -- navhw -> foreign_non_deductible_tax_base
    -- navfw -> non_deductible_input_tax
    -- matnr -> material_number
    -- werks -> plant
    -- meins -> base_unit_of_measure
    -- bprme -> partner_measurement_unit
    -- ebeln -> purchase_order_number
    -- ebelp -> purchase_order_item_number
    -- zekkn -> account_assignment_sequence
    -- elikz -> delivery_completed
    -- vprsv -> price_control_indicator
    -- bwtar -> valuation_type
    -- bustw -> tax_indicator
    -- rewrt -> reference_amount
    -- rewwr -> reference_exchange_rate
    -- bonfb -> investment_support_amount
    -- nprei -> net_price
    -- tbtkz -> subsequent_billing_indicator
    -- spgrp -> price_reason_code
    -- spgrm -> material_reason_code
    -- spgrt -> text_reason_code
    -- spgrg -> goods_movement_reason_code
    -- spgrv -> insurance_reason_code
    -- spgrq -> quantity_reason_code
    -- stceg -> vat_registration_number
    -- egbld -> billing_block
    -- eglld -> delivery_block
    -- rstgr -> reason_code
    -- ryacq -> accounting_value_5
    -- rpacq -> accounting_value_4
    -- rdiff -> difference_value_3
    -- rdif2 -> difference_value_1
    -- xhkom -> header_comment_indicator
    -- vname -> name
    -- recid -> record_id
    -- egrup -> item_group
    -- vptnr -> partner_account_number
    -- vertt -> contract_type
    -- vertn -> contract_number
    -- vbewa -> sales_movement_type
    -- depot -> securities_account
    -- txjcd -> tax_jurisdiction_code
    -- imkey -> item_key
    -- dabrz -> days_in_arrears
    -- popts -> option_selection
    -- fipos -> financial_position
    -- kstrg -> cost_object
    -- nplnr -> network_activity_number
    -- aufpl -> order_item_number
    -- aplzl -> asset_sequence_number
    -- projk -> project_key
    -- paobjnr -> profitability_segment_number
    -- pasubnr -> profitability_subsegment_number
    -- spgrs -> reservation_reason_code
    -- spgrc -> blocking_reason_code
    -- btype -> balance_type
    -- etype -> po_history_category
    -- xegdr -> single_statement_indicator
    -- lnran -> line_number_range
    -- hrkft -> profitability_segment
    -- dmbe3 -> group_currency_amount
    -- dmb31 -> group_currency_amount_1
    -- dmb32 -> group_currency_amount_2
    -- dmb33 -> group_currency_amount_3
    -- mwst2 -> local_tax_amount
    -- mwst3 -> document_tax_amount
    -- navh2 -> local_non_deductible_tax_base
    -- navh3 -> document_non_deductible_tax_base
    -- sknt2 -> second_local_currency_amount
    -- sknt3 -> third_local_currency_amount
    -- bdif3 -> valuation_difference_3
    -- rdif3 -> difference_value_2
    -- hwmet -> base_unit_quantity
    -- glupm -> consolidation_business_area
    -- xragl -> balance_carryforward_indicator
    -- uzawe -> payment_method_supplement
    -- stbuk -> tax_reporting_company_code
    -- txbh2 -> second_local_currency_tax_base
    -- txbh3 -> third_local_currency_tax_base
    -- pprct -> profit_center
    -- xref1 -> reference_key_1
    -- xref2 -> reference_key_2
    -- sttax -> local_currency_tax_amount
    -- fkber -> funds_center
    -- obzei -> original_line_item_number
    -- xnegp -> negative_posting_indicator
    -- rfzei -> reference_line_indicator
    -- ccbtc -> coding_block
    -- kkber -> credit_control_area
    -- empfb -> goods_recipient
    -- xref3 -> reference_key_3
    -- dtws1 -> tax_amount_1
    -- dtws2 -> tax_amount_2
    -- dtws3 -> tax_amount_3
    -- dtws4 -> tax_amount_4
    -- gricd -> consolidation_functional_area
    -- grirg -> consolidation_region
    -- gityp -> grant_type
    -- xpypr -> payment_processing_indicator
    -- kidno -> customer_id
    -- absbt -> write_off_amount
    -- idxsp -> special_index
    -- linfv -> line_item_reference
    -- kontt -> account_assignment_type
    -- kontl -> account_assignment
    -- txdat -> tax_reporting_date
    -- agzei -> settlement_period
    -- pycur -> payment_currency
    -- pyamt -> payment_amount
    -- bupla -> business_place
    -- secco -> section_code
    -- lstar -> activity_type
    -- cession_kz -> cession_indicator
    -- prznr -> business_process
    -- ppdiff -> price_difference
    -- ppdif2 -> price_difference_2
    -- ppdif3 -> price_difference_3
    -- penfc -> foreign_currency_amount
    -- pendays -> number_of_days
    -- penrc -> reporting_currency
    -- sctax -> sales_use_tax_amount
    -- fkber_long -> funds_center_description
    -- gmvkz -> reporting_value_type
    -- srtype -> reversal_transaction_type
    -- intreno -> internal_renumbering
    -- auggj -> clearing_fiscal_year
    -- ppa_ex_ind -> pa_exchange_rate_indicator
    -- docln -> document_line_number
    -- hktid -> account_id
    -- kstar -> cost_element
    -- xlgclr -> legacy_clearing_indicator
    -- taxps -> tax_splitting
    -- pays_prov -> payment_service_provider
    -- pays_tran -> payment_provider_transaction_id
    -- mndid -> mandate_id
    -- xfrge_bseg -> ready_for_input_indicator
    -- zzspreg -> sales_promotion_region
    -- zzbuspartn -> business_partner
    -- zzchan -> distribution_channel
    -- zzproduct -> product
    -- zzloca -> location
    -- zzlob -> line_of_business
    -- zzuserfld1 -> user_field_1
    -- zzuserfld2 -> user_field_2
    -- zzuserfld3 -> user_field_3
    -- zzstate -> state
    -- zzregion -> region
    -- re_bukrs -> re_company_code
    -- j_1tpbupl -> brazil_tax_upload
    -- perop_beg -> operation_begin_date
    -- perop_end -> operation_end_date
    -- fastpay -> fast_pay_indicator
    -- ignr_ivref -> ignore_invoice_reference
    -- fmfgus_key -> us_federal_grant_key
    -- fmxdocnr -> original_document_number
    -- fmxyear -> original_fiscal_year
    -- fmxdocln -> original_document_line_number
    -- fmxzekkn -> original_line_item_sequence
    -- prodper -> production_period
    -- recrf -> record_reference
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "belnr",
        "bukrs" AS "company_code",
        "buzei",
        "gjahr" AS "fiscal_year",
        "mandt" AS "client_id",
        "buzid" AS "line_item_identifier",
        "augdt" AS "clearing_date",
        "augcp" AS "clearing_fiscal_period",
        "augbl" AS "clearing_document_number",
        "bschl" AS "posting_key",
        "koart",
        "umskz",
        "umsks" AS "special_gl_transaction_type",
        "zumsk",
        "shkzg" AS "debit_credit_indicator",
        "gsber" AS "business_area",
        "pargb" AS "partner_business_area",
        "mwskz" AS "vat_tax_code",
        "qsskz" AS "accounting_code_1",
        "dmbtr" AS "total_local_amount",
        "wrbtr",
        "kzbtr" AS "document_currency_amount",
        "pswbt" AS "transaction_amount",
        "pswsl" AS "transaction_currency",
        "txbhw" AS "transaction_currency_tax_base",
        "txbfw" AS "tax_base_amount",
        "mwsts" AS "foreign_tax_amount",
        "wmwst" AS "tax_amount",
        "hwbas" AS "home_currency_amount",
        "fwbas" AS "functional_area_amount",
        "hwzuz" AS "home_currency_assignment_amount",
        "fwzuz" AS "functional_area_assignment_amount",
        "shzuz",
        "stekz" AS "tax_exempt_indicator",
        "mwart" AS "foreign_currency_valuation_type",
        "txgrp" AS "tax_group",
        "ktosl" AS "account_key",
        "qsshb" AS "accounting_value_3",
        "kursr",
        "gbetr",
        "bdiff" AS "valuation_difference",
        "bdif2" AS "valuation_difference_2",
        "valut" AS "value_date",
        "zuonr",
        "sgtxt" AS "line_item_text",
        "zinkz" AS "internal_code",
        "vbund" AS "trading_partner",
        "bewar" AS "asset_valuation_type",
        "altkt" AS "alternative_account",
        "vorgn" AS "transaction_type",
        "fdlev" AS "planning_level",
        "fdgrp" AS "planning_group",
        "fdwbt" AS "planned_price",
        "fdtag" AS "factory_calendar_date",
        "fkont" AS "funds_reservation_number",
        "kokrs" AS "controlling_area",
        "kostl",
        "projn" AS "project_number",
        "aufnr" AS "order_number",
        "vbeln" AS "sales_document_number",
        "vbel2",
        "posn2" AS "position_number",
        "eten2" AS "delivery_date",
        "anln1" AS "main_asset_number",
        "anln2" AS "asset_subnumber",
        "anbwa" AS "asset_transaction_type",
        "bzdat" AS "asset_value_date",
        "pernr" AS "personnel_number",
        "xumsw" AS "tax_code_change_indicator",
        "xhres" AS "clearing_reversal_indicator",
        "xkres" AS "document_reversal_indicator",
        "xopvw" AS "open_item_management_indicator",
        "xcpdd" AS "clearing_with_down_payment",
        "xskst" AS "tax_posting_reversal_indicator",
        "xsauf",
        "xspro" AS "sample_document_indicator",
        "xserg" AS "recurring_entry_original_indicator",
        "xfakt",
        "xuman" AS "manual_entry_indicator",
        "xanet" AS "net_payment_indicator",
        "xskrl" AS "grir_clearing_reversal_indicator",
        "xinve" AS "invoice_indicator",
        "xpanz" AS "partial_payment_indicator",
        "xauto" AS "automatic_posting_indicator",
        "xncop" AS "noted_item_indicator",
        "xzahl" AS "payment_indicator",
        "saknr" AS "gl_account_number",
        "hkont" AS "gl_account",
        "kunnr" AS "customer_number",
        "lifnr" AS "vendor_number",
        "filkd" AS "billing_type",
        "xbilk" AS "balance_sheet_update_indicator",
        "gvtyp",
        "hzuon",
        "zfbdt" AS "due_date_baseline",
        "zterm" AS "payment_terms",
        "zbd1t" AS "cash_discount_days_1",
        "zbd2t" AS "cash_discount_days_2",
        "zbd3t" AS "net_payment_terms_days",
        "zbd1p" AS "cash_discount_percent_1",
        "zbd2p" AS "cash_discount_percent_2",
        "skfbt",
        "sknto" AS "transaction_currency_amount",
        "wskto" AS "cash_discount_amount",
        "zlsch" AS "payment_method",
        "zlspr" AS "payment_block",
        "zbfix" AS "fixed_payment_terms_indicator",
        "hbkid" AS "house_bank_id",
        "bvtyp" AS "partner_bank_type",
        "nebtr" AS "net_amount",
        "mwsk1" AS "tax_code_1",
        "dmbt1" AS "local_amount_1",
        "wrbt1" AS "withholding_tax_amount_1",
        "mwsk2" AS "tax_code_2",
        "dmbt2" AS "local_amount_2",
        "wrbt2" AS "withholding_tax_amount_2",
        "mwsk3" AS "tax_code_3",
        "dmbt3" AS "local_amount_3",
        "wrbt3" AS "withholding_tax_amount_3",
        "rebzg",
        "rebzj" AS "reference_fiscal_year",
        "rebzz" AS "reference_line_item",
        "rebzt" AS "reference_document_type",
        "zollt" AS "customs_tariff",
        "zolld" AS "customs_amount",
        "lzbkz" AS "payment_terms_key",
        "landl" AS "country_key",
        "diekz" AS "service_indicator",
        "samnr" AS "sample_number",
        "abper" AS "depreciation_period",
        "vrskz" AS "insurance_indicator",
        "vrsdt" AS "insurance_date",
        "disbn" AS "discount_base_period_number",
        "disbj" AS "discount_base_year",
        "disbz" AS "discount_base_period",
        "wverw",
        "anfbn" AS "asset_acquisition_period",
        "anfbj" AS "asset_acquisition_year",
        "anfbu" AS "acquisition_date",
        "anfae" AS "apc_area",
        "blnbt" AS "document_amount_local",
        "blnkz" AS "balance_indicator",
        "blnpz" AS "balance_carryforward",
        "mschl" AS "dunning_level",
        "mansp" AS "manual_split_indicator",
        "madat" AS "material_document_date",
        "manst" AS "manual_stats_update",
        "maber",
        "esrnr" AS "gr_ir_clearing_number",
        "esrre" AS "bill_of_exchange_procedure",
        "esrpz" AS "payment_term",
        "klibt",
        "qsznr" AS "accounting_number_1",
        "qbshb" AS "accounting_value_1",
        "qsfbt" AS "accounting_value_2",
        "navhw" AS "foreign_non_deductible_tax_base",
        "navfw" AS "non_deductible_input_tax",
        "matnr" AS "material_number",
        "werks" AS "plant",
        "menge",
        "meins" AS "base_unit_of_measure",
        "erfmg",
        "erfme",
        "bpmng",
        "bprme" AS "partner_measurement_unit",
        "ebeln" AS "purchase_order_number",
        "ebelp" AS "purchase_order_item_number",
        "zekkn" AS "account_assignment_sequence",
        "elikz" AS "delivery_completed",
        "vprsv" AS "price_control_indicator",
        "peinh",
        "bwkey",
        "bwtar" AS "valuation_type",
        "bustw" AS "tax_indicator",
        "rewrt" AS "reference_amount",
        "rewwr" AS "reference_exchange_rate",
        "bonfb" AS "investment_support_amount",
        "bualt",
        "psalt",
        "nprei" AS "net_price",
        "tbtkz" AS "subsequent_billing_indicator",
        "spgrp" AS "price_reason_code",
        "spgrm" AS "material_reason_code",
        "spgrt" AS "text_reason_code",
        "spgrg" AS "goods_movement_reason_code",
        "spgrv" AS "insurance_reason_code",
        "spgrq" AS "quantity_reason_code",
        "stceg" AS "vat_registration_number",
        "egbld" AS "billing_block",
        "eglld" AS "delivery_block",
        "rstgr" AS "reason_code",
        "ryacq" AS "accounting_value_5",
        "rpacq" AS "accounting_value_4",
        "rdiff" AS "difference_value_3",
        "rdif2" AS "difference_value_1",
        "prctr",
        "xhkom" AS "header_comment_indicator",
        "vname" AS "name",
        "recid" AS "record_id",
        "egrup" AS "item_group",
        "vptnr" AS "partner_account_number",
        "vertt" AS "contract_type",
        "vertn" AS "contract_number",
        "vbewa" AS "sales_movement_type",
        "depot" AS "securities_account",
        "txjcd" AS "tax_jurisdiction_code",
        "imkey" AS "item_key",
        "dabrz" AS "days_in_arrears",
        "popts" AS "option_selection",
        "fipos" AS "financial_position",
        "kstrg" AS "cost_object",
        "nplnr" AS "network_activity_number",
        "aufpl" AS "order_item_number",
        "aplzl" AS "asset_sequence_number",
        "projk" AS "project_key",
        "paobjnr" AS "profitability_segment_number",
        "pasubnr" AS "profitability_subsegment_number",
        "spgrs" AS "reservation_reason_code",
        "spgrc" AS "blocking_reason_code",
        "btype" AS "balance_type",
        "etype" AS "po_history_category",
        "xegdr" AS "single_statement_indicator",
        "lnran" AS "line_number_range",
        "hrkft" AS "profitability_segment",
        "dmbe2",
        "dmbe3" AS "group_currency_amount",
        "dmb21",
        "dmb22",
        "dmb23",
        "dmb31" AS "group_currency_amount_1",
        "dmb32" AS "group_currency_amount_2",
        "dmb33" AS "group_currency_amount_3",
        "mwst2" AS "local_tax_amount",
        "mwst3" AS "document_tax_amount",
        "navh2" AS "local_non_deductible_tax_base",
        "navh3" AS "document_non_deductible_tax_base",
        "sknt2" AS "second_local_currency_amount",
        "sknt3" AS "third_local_currency_amount",
        "bdif3" AS "valuation_difference_3",
        "rdif3" AS "difference_value_2",
        "hwmet" AS "base_unit_quantity",
        "glupm" AS "consolidation_business_area",
        "xragl" AS "balance_carryforward_indicator",
        "uzawe" AS "payment_method_supplement",
        "lokkt",
        "fistl",
        "geber",
        "stbuk" AS "tax_reporting_company_code",
        "txbh2" AS "second_local_currency_tax_base",
        "txbh3" AS "third_local_currency_tax_base",
        "pprct" AS "profit_center",
        "xref1" AS "reference_key_1",
        "xref2" AS "reference_key_2",
        "kblnr",
        "kblpos",
        "sttax" AS "local_currency_tax_amount",
        "fkber" AS "funds_center",
        "obzei" AS "original_line_item_number",
        "xnegp" AS "negative_posting_indicator",
        "rfzei" AS "reference_line_indicator",
        "ccbtc" AS "coding_block",
        "kkber" AS "credit_control_area",
        "empfb" AS "goods_recipient",
        "xref3" AS "reference_key_3",
        "dtws1" AS "tax_amount_1",
        "dtws2" AS "tax_amount_2",
        "dtws3" AS "tax_amount_3",
        "dtws4" AS "tax_amount_4",
        "gricd" AS "consolidation_functional_area",
        "grirg" AS "consolidation_region",
        "gityp" AS "grant_type",
        "xpypr" AS "payment_processing_indicator",
        "kidno" AS "customer_id",
        "absbt" AS "write_off_amount",
        "idxsp" AS "special_index",
        "linfv" AS "line_item_reference",
        "kontt" AS "account_assignment_type",
        "kontl" AS "account_assignment",
        "txdat" AS "tax_reporting_date",
        "agzei" AS "settlement_period",
        "pycur" AS "payment_currency",
        "pyamt" AS "payment_amount",
        "bupla" AS "business_place",
        "secco" AS "section_code",
        "lstar" AS "activity_type",
        "cession_kz" AS "cession_indicator",
        "prznr" AS "business_process",
        "ppdiff" AS "price_difference",
        "ppdif2" AS "price_difference_2",
        "ppdif3" AS "price_difference_3",
        "penlc1",
        "penlc2",
        "penlc3",
        "penfc" AS "foreign_currency_amount",
        "pendays" AS "number_of_days",
        "penrc" AS "reporting_currency",
        "grant_nbr",
        "sctax" AS "sales_use_tax_amount",
        "fkber_long" AS "funds_center_description",
        "gmvkz" AS "reporting_value_type",
        "srtype" AS "reversal_transaction_type",
        "intreno" AS "internal_renumbering",
        "measure",
        "auggj" AS "clearing_fiscal_year",
        "ppa_ex_ind" AS "pa_exchange_rate_indicator",
        "docln" AS "document_line_number",
        "segment",
        "psegment",
        "pfkber",
        "hktid" AS "account_id",
        "kstar" AS "cost_element",
        "xlgclr" AS "legacy_clearing_indicator",
        "taxps" AS "tax_splitting",
        "pays_prov" AS "payment_service_provider",
        "pays_tran" AS "payment_provider_transaction_id",
        "mndid" AS "mandate_id",
        "xfrge_bseg" AS "ready_for_input_indicator",
        "squan",
        "zzspreg" AS "sales_promotion_region",
        "zzbuspartn" AS "business_partner",
        "zzchan" AS "distribution_channel",
        "zzproduct" AS "product",
        "zzloca" AS "location",
        "zzlob" AS "line_of_business",
        "zzuserfld1" AS "user_field_1",
        "zzuserfld2" AS "user_field_2",
        "zzuserfld3" AS "user_field_3",
        "zzstate" AS "state",
        "zzregion" AS "region",
        "re_bukrs" AS "re_company_code",
        "re_account",
        "pgeber",
        "pgrant_nbr",
        "budget_pd",
        "pbudget_pd",
        "j_1tpbupl" AS "brazil_tax_upload",
        "perop_beg" AS "operation_begin_date",
        "perop_end" AS "operation_end_date",
        "fastpay" AS "fast_pay_indicator",
        "ignr_ivref" AS "ignore_invoice_reference",
        "fmfgus_key" AS "us_federal_grant_key",
        "fmxdocnr" AS "original_document_number",
        "fmxyear" AS "original_fiscal_year",
        "fmxdocln" AS "original_document_line_number",
        "fmxzekkn" AS "original_line_item_sequence",
        "prodper" AS "production_period",
        "recrf" AS "record_reference",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_bseg_data_projected"
),

"sap_bseg_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- koart: The problem is that the 'koart' column contains only a single value 's', which is unusual because it's a single character. This likely indicates incomplete or abbreviated data. Without more context about what 'koart' represents or what the full values should be, it's difficult to determine the correct mapping. The single character 's' could be an abbreviation for a longer word or term, but we don't have enough information to expand it accurately. 
    -- debit_credit_indicator: The problem is that 'h' is an unusual and non-standard value for a debit_credit_indicator column. Typically, this column should contain 'D' for debit and 'C' for credit. The value 'h' is not meaningful in this context and doesn't provide clear information about whether the transaction is a debit or credit. Since we don't have additional information about what 'h' might represent, it's safest to map it to an empty string to indicate missing or invalid data. 
    -- transaction_type: The problem is that 'rfbu' is the only value in the transaction_type column, and it's not a standard or commonly recognized transaction type abbreviation. Without more context about the data or the specific business domain, it's impossible to determine what 'rfbu' might stand for or what the correct value should be. In this case, since we can't confidently map it to a known transaction type, the best approach is to keep the value as is, assuming it has a specific meaning within the context of the data source. 
    -- payment_indicator: The problem is that 'x' is not a descriptive or standard value for a payment indicator. It's unclear what 'x' represents - whether it means paid, unpaid, or something else. The correct values for a payment indicator should be more explicit, such as 'paid' or 'unpaid'. 
    -- gvtyp: The problem is that 'x' is a single-character value that lacks clear meaning or context in the gvtyp column. Without additional information about what this column represents or what other values might be expected, it's difficult to determine the correct interpretation. In such cases, it's often best to either keep the value as is (if it might have a specific meaning in the dataset) or replace it with an empty string if it's deemed to be meaningless or a placeholder. 
    SELECT
        "belnr",
        "company_code",
        "buzei",
        "fiscal_year",
        "client_id",
        "line_item_identifier",
        "clearing_date",
        "clearing_fiscal_period",
        "clearing_document_number",
        "posting_key",
        "koart",
        "umskz",
        "special_gl_transaction_type",
        "zumsk",
        CASE
            WHEN "debit_credit_indicator" = '''h''' THEN ''''
            ELSE "debit_credit_indicator"
        END AS "debit_credit_indicator",
        "business_area",
        "partner_business_area",
        "vat_tax_code",
        "accounting_code_1",
        "total_local_amount",
        "wrbtr",
        "document_currency_amount",
        "transaction_amount",
        "transaction_currency",
        "transaction_currency_tax_base",
        "tax_base_amount",
        "foreign_tax_amount",
        "tax_amount",
        "home_currency_amount",
        "functional_area_amount",
        "home_currency_assignment_amount",
        "functional_area_assignment_amount",
        "shzuz",
        "tax_exempt_indicator",
        "foreign_currency_valuation_type",
        "tax_group",
        "account_key",
        "accounting_value_3",
        "kursr",
        "gbetr",
        "valuation_difference",
        "valuation_difference_2",
        "value_date",
        "zuonr",
        "line_item_text",
        "internal_code",
        "trading_partner",
        "asset_valuation_type",
        "alternative_account",
        "transaction_type",
        "planning_level",
        "planning_group",
        "planned_price",
        "factory_calendar_date",
        "funds_reservation_number",
        "controlling_area",
        "kostl",
        "project_number",
        "order_number",
        "sales_document_number",
        "vbel2",
        "position_number",
        "delivery_date",
        "main_asset_number",
        "asset_subnumber",
        "asset_transaction_type",
        "asset_value_date",
        "personnel_number",
        "tax_code_change_indicator",
        "clearing_reversal_indicator",
        "document_reversal_indicator",
        "open_item_management_indicator",
        "clearing_with_down_payment",
        "tax_posting_reversal_indicator",
        "xsauf",
        "sample_document_indicator",
        "recurring_entry_original_indicator",
        "xfakt",
        "manual_entry_indicator",
        "net_payment_indicator",
        "grir_clearing_reversal_indicator",
        "invoice_indicator",
        "partial_payment_indicator",
        "automatic_posting_indicator",
        "noted_item_indicator",
        CASE
            WHEN "payment_indicator" = '''x''' THEN '''paid'''
            ELSE "payment_indicator"
        END AS "payment_indicator",
        "gl_account_number",
        "gl_account",
        "customer_number",
        "vendor_number",
        "billing_type",
        "balance_sheet_update_indicator",
        CASE
            WHEN "gvtyp" = '''x''' THEN ''''
            ELSE "gvtyp"
        END AS "gvtyp",
        "hzuon",
        "due_date_baseline",
        "payment_terms",
        "cash_discount_days_1",
        "cash_discount_days_2",
        "net_payment_terms_days",
        "cash_discount_percent_1",
        "cash_discount_percent_2",
        "skfbt",
        "transaction_currency_amount",
        "cash_discount_amount",
        "payment_method",
        "payment_block",
        "fixed_payment_terms_indicator",
        "house_bank_id",
        "partner_bank_type",
        "net_amount",
        "tax_code_1",
        "local_amount_1",
        "withholding_tax_amount_1",
        "tax_code_2",
        "local_amount_2",
        "withholding_tax_amount_2",
        "tax_code_3",
        "local_amount_3",
        "withholding_tax_amount_3",
        "rebzg",
        "reference_fiscal_year",
        "reference_line_item",
        "reference_document_type",
        "customs_tariff",
        "customs_amount",
        "payment_terms_key",
        "country_key",
        "service_indicator",
        "sample_number",
        "depreciation_period",
        "insurance_indicator",
        "insurance_date",
        "discount_base_period_number",
        "discount_base_year",
        "discount_base_period",
        "wverw",
        "asset_acquisition_period",
        "asset_acquisition_year",
        "acquisition_date",
        "apc_area",
        "document_amount_local",
        "balance_indicator",
        "balance_carryforward",
        "dunning_level",
        "manual_split_indicator",
        "material_document_date",
        "manual_stats_update",
        "maber",
        "gr_ir_clearing_number",
        "bill_of_exchange_procedure",
        "payment_term",
        "klibt",
        "accounting_number_1",
        "accounting_value_1",
        "accounting_value_2",
        "foreign_non_deductible_tax_base",
        "non_deductible_input_tax",
        "material_number",
        "plant",
        "menge",
        "base_unit_of_measure",
        "erfmg",
        "erfme",
        "bpmng",
        "partner_measurement_unit",
        "purchase_order_number",
        "purchase_order_item_number",
        "account_assignment_sequence",
        "delivery_completed",
        "price_control_indicator",
        "peinh",
        "bwkey",
        "valuation_type",
        "tax_indicator",
        "reference_amount",
        "reference_exchange_rate",
        "investment_support_amount",
        "bualt",
        "psalt",
        "net_price",
        "subsequent_billing_indicator",
        "price_reason_code",
        "material_reason_code",
        "text_reason_code",
        "goods_movement_reason_code",
        "insurance_reason_code",
        "quantity_reason_code",
        "vat_registration_number",
        "billing_block",
        "delivery_block",
        "reason_code",
        "accounting_value_5",
        "accounting_value_4",
        "difference_value_3",
        "difference_value_1",
        "prctr",
        "header_comment_indicator",
        "name",
        "record_id",
        "item_group",
        "partner_account_number",
        "contract_type",
        "contract_number",
        "sales_movement_type",
        "securities_account",
        "tax_jurisdiction_code",
        "item_key",
        "days_in_arrears",
        "option_selection",
        "financial_position",
        "cost_object",
        "network_activity_number",
        "order_item_number",
        "asset_sequence_number",
        "project_key",
        "profitability_segment_number",
        "profitability_subsegment_number",
        "reservation_reason_code",
        "blocking_reason_code",
        "balance_type",
        "po_history_category",
        "single_statement_indicator",
        "line_number_range",
        "profitability_segment",
        "dmbe2",
        "group_currency_amount",
        "dmb21",
        "dmb22",
        "dmb23",
        "group_currency_amount_1",
        "group_currency_amount_2",
        "group_currency_amount_3",
        "local_tax_amount",
        "document_tax_amount",
        "local_non_deductible_tax_base",
        "document_non_deductible_tax_base",
        "second_local_currency_amount",
        "third_local_currency_amount",
        "valuation_difference_3",
        "difference_value_2",
        "base_unit_quantity",
        "consolidation_business_area",
        "balance_carryforward_indicator",
        "payment_method_supplement",
        "lokkt",
        "fistl",
        "geber",
        "tax_reporting_company_code",
        "second_local_currency_tax_base",
        "third_local_currency_tax_base",
        "profit_center",
        "reference_key_1",
        "reference_key_2",
        "kblnr",
        "kblpos",
        "local_currency_tax_amount",
        "funds_center",
        "original_line_item_number",
        "negative_posting_indicator",
        "reference_line_indicator",
        "coding_block",
        "credit_control_area",
        "goods_recipient",
        "reference_key_3",
        "tax_amount_1",
        "tax_amount_2",
        "tax_amount_3",
        "tax_amount_4",
        "consolidation_functional_area",
        "consolidation_region",
        "grant_type",
        "payment_processing_indicator",
        "customer_id",
        "write_off_amount",
        "special_index",
        "line_item_reference",
        "account_assignment_type",
        "account_assignment",
        "tax_reporting_date",
        "settlement_period",
        "payment_currency",
        "payment_amount",
        "business_place",
        "section_code",
        "activity_type",
        "cession_indicator",
        "business_process",
        "price_difference",
        "price_difference_2",
        "price_difference_3",
        "penlc1",
        "penlc2",
        "penlc3",
        "foreign_currency_amount",
        "number_of_days",
        "reporting_currency",
        "grant_nbr",
        "sales_use_tax_amount",
        "funds_center_description",
        "reporting_value_type",
        "reversal_transaction_type",
        "internal_renumbering",
        "measure",
        "clearing_fiscal_year",
        "pa_exchange_rate_indicator",
        "document_line_number",
        "segment",
        "psegment",
        "pfkber",
        "account_id",
        "cost_element",
        "legacy_clearing_indicator",
        "tax_splitting",
        "payment_service_provider",
        "payment_provider_transaction_id",
        "mandate_id",
        "ready_for_input_indicator",
        "squan",
        "sales_promotion_region",
        "business_partner",
        "distribution_channel",
        "product",
        "location",
        "line_of_business",
        "user_field_1",
        "user_field_2",
        "user_field_3",
        "state",
        "region",
        "re_company_code",
        "re_account",
        "pgeber",
        "pgrant_nbr",
        "budget_pd",
        "pbudget_pd",
        "brazil_tax_upload",
        "operation_begin_date",
        "operation_end_date",
        "fast_pay_indicator",
        "ignore_invoice_reference",
        "us_federal_grant_key",
        "original_document_number",
        "original_fiscal_year",
        "original_document_line_number",
        "original_line_item_sequence",
        "production_period",
        "record_reference",
        "row_id",
        "is_deleted"
    FROM "sap_bseg_data_projected_renamed"
),

"sap_bseg_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_assignment: from DECIMAL to VARCHAR
    -- account_assignment_type: from DECIMAL to VARCHAR
    -- account_id: from DECIMAL to VARCHAR
    -- account_key: from DECIMAL to VARCHAR
    -- accounting_code_1: from DECIMAL to VARCHAR
    -- accounting_number_1: from DECIMAL to VARCHAR
    -- accounting_value_5: from DECIMAL to VARCHAR
    -- acquisition_date: from DECIMAL to DATE
    -- activity_type: from DECIMAL to VARCHAR
    -- alternative_account: from INT to VARCHAR
    -- asset_acquisition_period: from DECIMAL to VARCHAR
    -- asset_subnumber: from DECIMAL to VARCHAR
    -- asset_transaction_type: from DECIMAL to VARCHAR
    -- asset_valuation_type: from DECIMAL to VARCHAR
    -- automatic_posting_indicator: from DECIMAL to VARCHAR
    -- balance_carryforward_indicator: from DECIMAL to VARCHAR
    -- balance_indicator: from DECIMAL to VARCHAR
    -- balance_sheet_update_indicator: from DECIMAL to VARCHAR
    -- balance_type: from DECIMAL to VARCHAR
    -- base_unit_of_measure: from DECIMAL to VARCHAR
    -- base_unit_quantity: from DECIMAL to VARCHAR
    -- belnr: from INT to VARCHAR
    -- bill_of_exchange_procedure: from DECIMAL to VARCHAR
    -- billing_block: from DECIMAL to VARCHAR
    -- billing_type: from DECIMAL to VARCHAR
    -- blocking_reason_code: from DECIMAL to VARCHAR
    -- brazil_tax_upload: from DECIMAL to VARCHAR
    -- budget_pd: from DECIMAL to VARCHAR
    -- business_area: from INT to VARCHAR
    -- business_partner: from DECIMAL to VARCHAR
    -- business_place: from DECIMAL to VARCHAR
    -- business_process: from DECIMAL to VARCHAR
    -- bwkey: from DECIMAL to VARCHAR
    -- cession_indicator: from DECIMAL to VARCHAR
    -- clearing_document_number: from DECIMAL to VARCHAR
    -- clearing_reversal_indicator: from DECIMAL to VARCHAR
    -- clearing_with_down_payment: from DECIMAL to VARCHAR
    -- client_id: from INT to VARCHAR
    -- coding_block: from DECIMAL to VARCHAR
    -- company_code: from INT to VARCHAR
    -- consolidation_business_area: from DECIMAL to VARCHAR
    -- consolidation_functional_area: from DECIMAL to VARCHAR
    -- consolidation_region: from DECIMAL to VARCHAR
    -- contract_number: from DECIMAL to VARCHAR
    -- contract_type: from DECIMAL to VARCHAR
    -- controlling_area: from INT to VARCHAR
    -- cost_element: from DECIMAL to VARCHAR
    -- cost_object: from DECIMAL to VARCHAR
    -- country_key: from DECIMAL to VARCHAR
    -- credit_control_area: from DECIMAL to VARCHAR
    -- customer_id: from DECIMAL to VARCHAR
    -- customer_number: from DECIMAL to VARCHAR
    -- customs_tariff: from DECIMAL to VARCHAR
    -- delivery_block: from DECIMAL to VARCHAR
    -- delivery_completed: from DECIMAL to VARCHAR
    -- discount_base_period_number: from DECIMAL to VARCHAR
    -- distribution_channel: from DECIMAL to VARCHAR
    -- document_line_number: from DECIMAL to VARCHAR
    -- dunning_level: from DECIMAL to VARCHAR
    -- erfme: from DECIMAL to VARCHAR
    -- fast_pay_indicator: from DECIMAL to VARCHAR
    -- financial_position: from INT to VARCHAR
    -- fistl: from DECIMAL to VARCHAR
    -- fixed_payment_terms_indicator: from DECIMAL to VARCHAR
    -- foreign_currency_valuation_type: from DECIMAL to VARCHAR
    -- funds_center: from INT to VARCHAR
    -- funds_center_description: from INT to VARCHAR
    -- funds_reservation_number: from INT to VARCHAR
    -- geber: from DECIMAL to VARCHAR
    -- gl_account: from INT to VARCHAR
    -- gl_account_number: from DECIMAL to VARCHAR
    -- goods_movement_reason_code: from DECIMAL to VARCHAR
    -- goods_recipient: from DECIMAL to VARCHAR
    -- gr_ir_clearing_number: from DECIMAL to VARCHAR
    -- grant_nbr: from DECIMAL to VARCHAR
    -- grant_type: from DECIMAL to VARCHAR
    -- grir_clearing_reversal_indicator: from DECIMAL to VARCHAR
    -- header_comment_indicator: from DECIMAL to VARCHAR
    -- house_bank_id: from DECIMAL to VARCHAR
    -- hzuon: from DECIMAL to VARCHAR
    -- ignore_invoice_reference: from DECIMAL to VARCHAR
    -- insurance_indicator: from DECIMAL to VARCHAR
    -- insurance_reason_code: from DECIMAL to VARCHAR
    -- internal_code: from DECIMAL to VARCHAR
    -- internal_renumbering: from DECIMAL to VARCHAR
    -- invoice_indicator: from DECIMAL to VARCHAR
    -- item_group: from DECIMAL to VARCHAR
    -- item_key: from DECIMAL to VARCHAR
    -- kblnr: from DECIMAL to VARCHAR
    -- kostl: from INT to VARCHAR
    -- legacy_clearing_indicator: from DECIMAL to VARCHAR
    -- line_item_identifier: from DECIMAL to VARCHAR
    -- line_item_reference: from INT to VARCHAR
    -- line_number_range: from INT to VARCHAR
    -- line_of_business: from DECIMAL to VARCHAR
    -- location: from DECIMAL to VARCHAR
    -- lokkt: from INT to VARCHAR
    -- maber: from DECIMAL to VARCHAR
    -- main_asset_number: from DECIMAL to VARCHAR
    -- mandate_id: from DECIMAL to VARCHAR
    -- manual_entry_indicator: from DECIMAL to VARCHAR
    -- manual_split_indicator: from DECIMAL to VARCHAR
    -- manual_stats_update: from INT to VARCHAR
    -- material_document_date: from INT to VARCHAR
    -- material_number: from DECIMAL to VARCHAR
    -- material_reason_code: from DECIMAL to VARCHAR
    -- measure: from DECIMAL to VARCHAR
    -- name: from DECIMAL to VARCHAR
    -- negative_posting_indicator: from DECIMAL to VARCHAR
    -- net_payment_indicator: from DECIMAL to VARCHAR
    -- network_activity_number: from DECIMAL to VARCHAR
    -- noted_item_indicator: from DECIMAL to VARCHAR
    -- open_item_management_indicator: from DECIMAL to VARCHAR
    -- operation_begin_date: from INT to DATE
    -- operation_end_date: from INT to DATE
    -- order_number: from DECIMAL to VARCHAR
    -- original_document_number: from DECIMAL to VARCHAR
    -- pa_exchange_rate_indicator: from DECIMAL to VARCHAR
    -- partial_payment_indicator: from DECIMAL to VARCHAR
    -- partner_account_number: from DECIMAL to VARCHAR
    -- partner_bank_type: from DECIMAL to VARCHAR
    -- partner_business_area: from DECIMAL to VARCHAR
    -- partner_measurement_unit: from DECIMAL to VARCHAR
    -- payment_block: from DECIMAL to VARCHAR
    -- payment_currency: from DECIMAL to VARCHAR
    -- payment_method: from DECIMAL to VARCHAR
    -- payment_method_supplement: from DECIMAL to VARCHAR
    -- payment_processing_indicator: from DECIMAL to VARCHAR
    -- payment_provider_transaction_id: from DECIMAL to VARCHAR
    -- payment_service_provider: from DECIMAL to VARCHAR
    -- payment_term: from DECIMAL to VARCHAR
    -- payment_terms: from DECIMAL to VARCHAR
    -- payment_terms_key: from DECIMAL to VARCHAR
    -- pbudget_pd: from DECIMAL to VARCHAR
    -- pfkber: from DECIMAL to VARCHAR
    -- pgeber: from DECIMAL to VARCHAR
    -- pgrant_nbr: from DECIMAL to VARCHAR
    -- planning_group: from DECIMAL to VARCHAR
    -- planning_level: from DECIMAL to VARCHAR
    -- plant: from DECIMAL to VARCHAR
    -- po_history_category: from DECIMAL to VARCHAR
    -- prctr: from INT to VARCHAR
    -- price_control_indicator: from DECIMAL to VARCHAR
    -- price_reason_code: from DECIMAL to VARCHAR
    -- product: from DECIMAL to VARCHAR
    -- profit_center: from DECIMAL to VARCHAR
    -- profitability_segment: from DECIMAL to VARCHAR
    -- project_number: from DECIMAL to VARCHAR
    -- psalt: from DECIMAL to VARCHAR
    -- psegment: from DECIMAL to VARCHAR
    -- purchase_order_number: from DECIMAL to VARCHAR
    -- quantity_reason_code: from DECIMAL to VARCHAR
    -- re_account: from DECIMAL to VARCHAR
    -- re_company_code: from DECIMAL to VARCHAR
    -- ready_for_input_indicator: from DECIMAL to VARCHAR
    -- reason_code: from DECIMAL to VARCHAR
    -- rebzg: from DECIMAL to VARCHAR
    -- record_id: from DECIMAL to VARCHAR
    -- record_reference: from DECIMAL to VARCHAR
    -- recurring_entry_original_indicator: from DECIMAL to VARCHAR
    -- reference_document_type: from DECIMAL to VARCHAR
    -- reference_key_1: from DECIMAL to VARCHAR
    -- reference_key_2: from DECIMAL to VARCHAR
    -- reference_key_3: from DECIMAL to VARCHAR
    -- region: from DECIMAL to VARCHAR
    -- reporting_currency: from DECIMAL to VARCHAR
    -- reporting_value_type: from DECIMAL to VARCHAR
    -- reservation_reason_code: from DECIMAL to VARCHAR
    -- reversal_transaction_type: from DECIMAL to VARCHAR
    -- sales_document_number: from DECIMAL to VARCHAR
    -- sales_movement_type: from DECIMAL to VARCHAR
    -- sales_promotion_region: from DECIMAL to VARCHAR
    -- sample_document_indicator: from DECIMAL to VARCHAR
    -- section_code: from DECIMAL to VARCHAR
    -- securities_account: from DECIMAL to VARCHAR
    -- segment: from DECIMAL to VARCHAR
    -- service_indicator: from DECIMAL to VARCHAR
    -- shzuz: from DECIMAL to VARCHAR
    -- single_statement_indicator: from DECIMAL to VARCHAR
    -- special_gl_transaction_type: from DECIMAL to VARCHAR
    -- special_index: from DECIMAL to VARCHAR
    -- squan: from DECIMAL to VARCHAR
    -- state: from DECIMAL to VARCHAR
    -- subsequent_billing_indicator: from DECIMAL to VARCHAR
    -- tax_code_1: from DECIMAL to VARCHAR
    -- tax_code_2: from DECIMAL to VARCHAR
    -- tax_code_3: from DECIMAL to VARCHAR
    -- tax_code_change_indicator: from DECIMAL to VARCHAR
    -- tax_exempt_indicator: from DECIMAL to VARCHAR
    -- tax_indicator: from DECIMAL to VARCHAR
    -- tax_jurisdiction_code: from DECIMAL to VARCHAR
    -- tax_posting_reversal_indicator: from DECIMAL to VARCHAR
    -- tax_reporting_company_code: from DECIMAL to VARCHAR
    -- text_reason_code: from DECIMAL to VARCHAR
    -- trading_partner: from DECIMAL to VARCHAR
    -- umskz: from DECIMAL to VARCHAR
    -- us_federal_grant_key: from DECIMAL to VARCHAR
    -- user_field_1: from DECIMAL to VARCHAR
    -- user_field_2: from DECIMAL to VARCHAR
    -- user_field_3: from DECIMAL to VARCHAR
    -- valuation_type: from DECIMAL to VARCHAR
    -- vat_registration_number: from DECIMAL to VARCHAR
    -- vat_tax_code: from DECIMAL to VARCHAR
    -- vbel2: from DECIMAL to VARCHAR
    -- vendor_number: from DECIMAL to VARCHAR
    -- wverw: from DECIMAL to VARCHAR
    -- xfakt: from DECIMAL to VARCHAR
    -- xsauf: from DECIMAL to VARCHAR
    -- zumsk: from DECIMAL to VARCHAR
    -- zuonr: from INT to VARCHAR
    SELECT
        "buzei",
        "fiscal_year",
        "clearing_date",
        "clearing_fiscal_period",
        "posting_key",
        "koart",
        "debit_credit_indicator",
        "total_local_amount",
        "wrbtr",
        "document_currency_amount",
        "transaction_amount",
        "transaction_currency",
        "transaction_currency_tax_base",
        "tax_base_amount",
        "foreign_tax_amount",
        "tax_amount",
        "home_currency_amount",
        "functional_area_amount",
        "home_currency_assignment_amount",
        "functional_area_assignment_amount",
        "tax_group",
        "accounting_value_3",
        "kursr",
        "gbetr",
        "valuation_difference",
        "valuation_difference_2",
        "value_date",
        "line_item_text",
        "transaction_type",
        "planned_price",
        "factory_calendar_date",
        "position_number",
        "delivery_date",
        "asset_value_date",
        "personnel_number",
        "document_reversal_indicator",
        "payment_indicator",
        "gvtyp",
        "due_date_baseline",
        "cash_discount_days_1",
        "cash_discount_days_2",
        "net_payment_terms_days",
        "cash_discount_percent_1",
        "cash_discount_percent_2",
        "skfbt",
        "transaction_currency_amount",
        "cash_discount_amount",
        "net_amount",
        "local_amount_1",
        "withholding_tax_amount_1",
        "local_amount_2",
        "withholding_tax_amount_2",
        "local_amount_3",
        "withholding_tax_amount_3",
        "reference_fiscal_year",
        "reference_line_item",
        "customs_amount",
        "sample_number",
        "depreciation_period",
        "insurance_date",
        "discount_base_year",
        "discount_base_period",
        "asset_acquisition_year",
        "apc_area",
        "document_amount_local",
        "balance_carryforward",
        "klibt",
        "accounting_value_1",
        "accounting_value_2",
        "foreign_non_deductible_tax_base",
        "non_deductible_input_tax",
        "menge",
        "erfmg",
        "bpmng",
        "purchase_order_item_number",
        "account_assignment_sequence",
        "peinh",
        "reference_amount",
        "reference_exchange_rate",
        "investment_support_amount",
        "bualt",
        "net_price",
        "accounting_value_4",
        "difference_value_3",
        "difference_value_1",
        "days_in_arrears",
        "option_selection",
        "order_item_number",
        "asset_sequence_number",
        "project_key",
        "profitability_segment_number",
        "profitability_subsegment_number",
        "dmbe2",
        "group_currency_amount",
        "dmb21",
        "dmb22",
        "dmb23",
        "group_currency_amount_1",
        "group_currency_amount_2",
        "group_currency_amount_3",
        "local_tax_amount",
        "document_tax_amount",
        "local_non_deductible_tax_base",
        "document_non_deductible_tax_base",
        "second_local_currency_amount",
        "third_local_currency_amount",
        "valuation_difference_3",
        "difference_value_2",
        "second_local_currency_tax_base",
        "third_local_currency_tax_base",
        "kblpos",
        "local_currency_tax_amount",
        "original_line_item_number",
        "reference_line_indicator",
        "tax_amount_1",
        "tax_amount_2",
        "tax_amount_3",
        "tax_amount_4",
        "write_off_amount",
        "tax_reporting_date",
        "settlement_period",
        "payment_amount",
        "price_difference",
        "price_difference_2",
        "price_difference_3",
        "penlc1",
        "penlc2",
        "penlc3",
        "foreign_currency_amount",
        "number_of_days",
        "sales_use_tax_amount",
        "clearing_fiscal_year",
        "tax_splitting",
        "original_fiscal_year",
        "original_document_line_number",
        "original_line_item_sequence",
        "production_period",
        "row_id",
        "is_deleted",
        CAST("account_assignment" AS VARCHAR) AS "account_assignment",
        CAST("account_assignment_type" AS VARCHAR) AS "account_assignment_type",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("account_key" AS VARCHAR) AS "account_key",
        CAST("accounting_code_1" AS VARCHAR) AS "accounting_code_1",
        CAST("accounting_number_1" AS VARCHAR) AS "accounting_number_1",
        CAST("accounting_value_5" AS VARCHAR) AS "accounting_value_5",
        CAST("acquisition_date" AS DATE) AS "acquisition_date",
        CAST("activity_type" AS VARCHAR) AS "activity_type",
        CAST("alternative_account" AS VARCHAR) AS "alternative_account",
        CAST("asset_acquisition_period" AS VARCHAR) AS "asset_acquisition_period",
        CAST("asset_subnumber" AS VARCHAR) AS "asset_subnumber",
        CAST("asset_transaction_type" AS VARCHAR) AS "asset_transaction_type",
        CAST("asset_valuation_type" AS VARCHAR) AS "asset_valuation_type",
        CAST("automatic_posting_indicator" AS VARCHAR) AS "automatic_posting_indicator",
        CAST("balance_carryforward_indicator" AS VARCHAR) AS "balance_carryforward_indicator",
        CAST("balance_indicator" AS VARCHAR) AS "balance_indicator",
        CAST("balance_sheet_update_indicator" AS VARCHAR) AS "balance_sheet_update_indicator",
        CAST("balance_type" AS VARCHAR) AS "balance_type",
        CAST("base_unit_of_measure" AS VARCHAR) AS "base_unit_of_measure",
        CAST("base_unit_quantity" AS VARCHAR) AS "base_unit_quantity",
        CAST("belnr" AS VARCHAR) AS "belnr",
        CAST("bill_of_exchange_procedure" AS VARCHAR) AS "bill_of_exchange_procedure",
        CAST("billing_block" AS VARCHAR) AS "billing_block",
        CAST("billing_type" AS VARCHAR) AS "billing_type",
        CAST("blocking_reason_code" AS VARCHAR) AS "blocking_reason_code",
        CAST("brazil_tax_upload" AS VARCHAR) AS "brazil_tax_upload",
        CAST("budget_pd" AS VARCHAR) AS "budget_pd",
        CAST("business_area" AS VARCHAR) AS "business_area",
        CAST("business_partner" AS VARCHAR) AS "business_partner",
        CAST("business_place" AS VARCHAR) AS "business_place",
        CAST("business_process" AS VARCHAR) AS "business_process",
        CAST("bwkey" AS VARCHAR) AS "bwkey",
        CAST("cession_indicator" AS VARCHAR) AS "cession_indicator",
        CAST("clearing_document_number" AS VARCHAR) AS "clearing_document_number",
        CAST("clearing_reversal_indicator" AS VARCHAR) AS "clearing_reversal_indicator",
        CAST("clearing_with_down_payment" AS VARCHAR) AS "clearing_with_down_payment",
        CAST("client_id" AS VARCHAR) AS "client_id",
        CAST("coding_block" AS VARCHAR) AS "coding_block",
        CAST("company_code" AS VARCHAR) AS "company_code",
        CAST("consolidation_business_area" AS VARCHAR) AS "consolidation_business_area",
        CAST("consolidation_functional_area" AS VARCHAR) AS "consolidation_functional_area",
        CAST("consolidation_region" AS VARCHAR) AS "consolidation_region",
        CAST("contract_number" AS VARCHAR) AS "contract_number",
        CAST("contract_type" AS VARCHAR) AS "contract_type",
        CAST("controlling_area" AS VARCHAR) AS "controlling_area",
        CAST("cost_element" AS VARCHAR) AS "cost_element",
        CAST("cost_object" AS VARCHAR) AS "cost_object",
        CAST("country_key" AS VARCHAR) AS "country_key",
        CAST("credit_control_area" AS VARCHAR) AS "credit_control_area",
        CAST("customer_id" AS VARCHAR) AS "customer_id",
        CAST("customer_number" AS VARCHAR) AS "customer_number",
        CAST("customs_tariff" AS VARCHAR) AS "customs_tariff",
        CAST("delivery_block" AS VARCHAR) AS "delivery_block",
        CAST("delivery_completed" AS VARCHAR) AS "delivery_completed",
        CAST("discount_base_period_number" AS VARCHAR) AS "discount_base_period_number",
        CAST("distribution_channel" AS VARCHAR) AS "distribution_channel",
        CAST("document_line_number" AS VARCHAR) AS "document_line_number",
        CAST("dunning_level" AS VARCHAR) AS "dunning_level",
        CAST("erfme" AS VARCHAR) AS "erfme",
        CAST("fast_pay_indicator" AS VARCHAR) AS "fast_pay_indicator",
        CAST("financial_position" AS VARCHAR) AS "financial_position",
        CAST("fistl" AS VARCHAR) AS "fistl",
        CAST("fixed_payment_terms_indicator" AS VARCHAR) AS "fixed_payment_terms_indicator",
        CAST("foreign_currency_valuation_type" AS VARCHAR) AS "foreign_currency_valuation_type",
        CAST("funds_center" AS VARCHAR) AS "funds_center",
        CAST("funds_center_description" AS VARCHAR) AS "funds_center_description",
        CAST("funds_reservation_number" AS VARCHAR) AS "funds_reservation_number",
        CAST("geber" AS VARCHAR) AS "geber",
        CAST("gl_account" AS VARCHAR) AS "gl_account",
        CAST("gl_account_number" AS VARCHAR) AS "gl_account_number",
        CAST("goods_movement_reason_code" AS VARCHAR) AS "goods_movement_reason_code",
        CAST("goods_recipient" AS VARCHAR) AS "goods_recipient",
        CAST("gr_ir_clearing_number" AS VARCHAR) AS "gr_ir_clearing_number",
        CAST("grant_nbr" AS VARCHAR) AS "grant_nbr",
        CAST("grant_type" AS VARCHAR) AS "grant_type",
        CAST("grir_clearing_reversal_indicator" AS VARCHAR) AS "grir_clearing_reversal_indicator",
        CAST("header_comment_indicator" AS VARCHAR) AS "header_comment_indicator",
        CAST("house_bank_id" AS VARCHAR) AS "house_bank_id",
        CAST("hzuon" AS VARCHAR) AS "hzuon",
        CAST("ignore_invoice_reference" AS VARCHAR) AS "ignore_invoice_reference",
        CAST("insurance_indicator" AS VARCHAR) AS "insurance_indicator",
        CAST("insurance_reason_code" AS VARCHAR) AS "insurance_reason_code",
        CAST("internal_code" AS VARCHAR) AS "internal_code",
        CAST("internal_renumbering" AS VARCHAR) AS "internal_renumbering",
        CAST("invoice_indicator" AS VARCHAR) AS "invoice_indicator",
        CAST("item_group" AS VARCHAR) AS "item_group",
        CAST("item_key" AS VARCHAR) AS "item_key",
        CAST("kblnr" AS VARCHAR) AS "kblnr",
        CAST("kostl" AS VARCHAR) AS "kostl",
        CAST("legacy_clearing_indicator" AS VARCHAR) AS "legacy_clearing_indicator",
        CAST("line_item_identifier" AS VARCHAR) AS "line_item_identifier",
        CAST("line_item_reference" AS VARCHAR) AS "line_item_reference",
        CAST("line_number_range" AS VARCHAR) AS "line_number_range",
        CAST("line_of_business" AS VARCHAR) AS "line_of_business",
        CAST("location" AS VARCHAR) AS "location",
        CAST("lokkt" AS VARCHAR) AS "lokkt",
        CAST("maber" AS VARCHAR) AS "maber",
        CAST("main_asset_number" AS VARCHAR) AS "main_asset_number",
        CAST("mandate_id" AS VARCHAR) AS "mandate_id",
        CAST("manual_entry_indicator" AS VARCHAR) AS "manual_entry_indicator",
        CAST("manual_split_indicator" AS VARCHAR) AS "manual_split_indicator",
        CAST("manual_stats_update" AS VARCHAR) AS "manual_stats_update",
        CAST("material_document_date" AS VARCHAR) AS "material_document_date",
        CAST("material_number" AS VARCHAR) AS "material_number",
        CAST("material_reason_code" AS VARCHAR) AS "material_reason_code",
        CAST("measure" AS VARCHAR) AS "measure",
        CAST("name" AS VARCHAR) AS "name",
        CAST("negative_posting_indicator" AS VARCHAR) AS "negative_posting_indicator",
        CAST("net_payment_indicator" AS VARCHAR) AS "net_payment_indicator",
        CAST("network_activity_number" AS VARCHAR) AS "network_activity_number",
        CAST("noted_item_indicator" AS VARCHAR) AS "noted_item_indicator",
        CAST("open_item_management_indicator" AS VARCHAR) AS "open_item_management_indicator",
        CASE 
            WHEN "operation_begin_date" = '0' THEN NULL
            ELSE strptime(CAST("operation_begin_date" AS VARCHAR), '%Y%m%d')
        END AS "operation_begin_date",
        CASE 
            WHEN "operation_end_date" = '0' THEN NULL
            ELSE strptime(CAST("operation_end_date" AS VARCHAR), '%Y%m%d')
        END AS "operation_end_date",
        CAST("order_number" AS VARCHAR) AS "order_number",
        CAST("original_document_number" AS VARCHAR) AS "original_document_number",
        CAST("pa_exchange_rate_indicator" AS VARCHAR) AS "pa_exchange_rate_indicator",
        CAST("partial_payment_indicator" AS VARCHAR) AS "partial_payment_indicator",
        CAST("partner_account_number" AS VARCHAR) AS "partner_account_number",
        CAST("partner_bank_type" AS VARCHAR) AS "partner_bank_type",
        CAST("partner_business_area" AS VARCHAR) AS "partner_business_area",
        CAST("partner_measurement_unit" AS VARCHAR) AS "partner_measurement_unit",
        CAST("payment_block" AS VARCHAR) AS "payment_block",
        CAST("payment_currency" AS VARCHAR) AS "payment_currency",
        CAST("payment_method" AS VARCHAR) AS "payment_method",
        CAST("payment_method_supplement" AS VARCHAR) AS "payment_method_supplement",
        CAST("payment_processing_indicator" AS VARCHAR) AS "payment_processing_indicator",
        CAST("payment_provider_transaction_id" AS VARCHAR) AS "payment_provider_transaction_id",
        CAST("payment_service_provider" AS VARCHAR) AS "payment_service_provider",
        CAST("payment_term" AS VARCHAR) AS "payment_term",
        CAST("payment_terms" AS VARCHAR) AS "payment_terms",
        CAST("payment_terms_key" AS VARCHAR) AS "payment_terms_key",
        CAST("pbudget_pd" AS VARCHAR) AS "pbudget_pd",
        CAST("pfkber" AS VARCHAR) AS "pfkber",
        CAST("pgeber" AS VARCHAR) AS "pgeber",
        CAST("pgrant_nbr" AS VARCHAR) AS "pgrant_nbr",
        CAST("planning_group" AS VARCHAR) AS "planning_group",
        CAST("planning_level" AS VARCHAR) AS "planning_level",
        CAST("plant" AS VARCHAR) AS "plant",
        CAST("po_history_category" AS VARCHAR) AS "po_history_category",
        CAST("prctr" AS VARCHAR) AS "prctr",
        CAST("price_control_indicator" AS VARCHAR) AS "price_control_indicator",
        CAST("price_reason_code" AS VARCHAR) AS "price_reason_code",
        CAST("product" AS VARCHAR) AS "product",
        CAST("profit_center" AS VARCHAR) AS "profit_center",
        CAST("profitability_segment" AS VARCHAR) AS "profitability_segment",
        CAST("project_number" AS VARCHAR) AS "project_number",
        CAST("psalt" AS VARCHAR) AS "psalt",
        CAST("psegment" AS VARCHAR) AS "psegment",
        CAST("purchase_order_number" AS VARCHAR) AS "purchase_order_number",
        CAST("quantity_reason_code" AS VARCHAR) AS "quantity_reason_code",
        CAST("re_account" AS VARCHAR) AS "re_account",
        CAST("re_company_code" AS VARCHAR) AS "re_company_code",
        CAST("ready_for_input_indicator" AS VARCHAR) AS "ready_for_input_indicator",
        CAST("reason_code" AS VARCHAR) AS "reason_code",
        CAST("rebzg" AS VARCHAR) AS "rebzg",
        CAST("record_id" AS VARCHAR) AS "record_id",
        CAST("record_reference" AS VARCHAR) AS "record_reference",
        CAST("recurring_entry_original_indicator" AS VARCHAR) AS "recurring_entry_original_indicator",
        CAST("reference_document_type" AS VARCHAR) AS "reference_document_type",
        CAST("reference_key_1" AS VARCHAR) AS "reference_key_1",
        CAST("reference_key_2" AS VARCHAR) AS "reference_key_2",
        CAST("reference_key_3" AS VARCHAR) AS "reference_key_3",
        CAST("region" AS VARCHAR) AS "region",
        CAST("reporting_currency" AS VARCHAR) AS "reporting_currency",
        CAST("reporting_value_type" AS VARCHAR) AS "reporting_value_type",
        CAST("reservation_reason_code" AS VARCHAR) AS "reservation_reason_code",
        CAST("reversal_transaction_type" AS VARCHAR) AS "reversal_transaction_type",
        CAST("sales_document_number" AS VARCHAR) AS "sales_document_number",
        CAST("sales_movement_type" AS VARCHAR) AS "sales_movement_type",
        CAST("sales_promotion_region" AS VARCHAR) AS "sales_promotion_region",
        CAST("sample_document_indicator" AS VARCHAR) AS "sample_document_indicator",
        CAST("section_code" AS VARCHAR) AS "section_code",
        CAST("securities_account" AS VARCHAR) AS "securities_account",
        CAST("segment" AS VARCHAR) AS "segment",
        CAST("service_indicator" AS VARCHAR) AS "service_indicator",
        CAST("shzuz" AS VARCHAR) AS "shzuz",
        CAST("single_statement_indicator" AS VARCHAR) AS "single_statement_indicator",
        CAST("special_gl_transaction_type" AS VARCHAR) AS "special_gl_transaction_type",
        CAST("special_index" AS VARCHAR) AS "special_index",
        CAST("squan" AS VARCHAR) AS "squan",
        CAST("state" AS VARCHAR) AS "state",
        CAST("subsequent_billing_indicator" AS VARCHAR) AS "subsequent_billing_indicator",
        CAST("tax_code_1" AS VARCHAR) AS "tax_code_1",
        CAST("tax_code_2" AS VARCHAR) AS "tax_code_2",
        CAST("tax_code_3" AS VARCHAR) AS "tax_code_3",
        CAST("tax_code_change_indicator" AS VARCHAR) AS "tax_code_change_indicator",
        CAST("tax_exempt_indicator" AS VARCHAR) AS "tax_exempt_indicator",
        CAST("tax_indicator" AS VARCHAR) AS "tax_indicator",
        CAST("tax_jurisdiction_code" AS VARCHAR) AS "tax_jurisdiction_code",
        CAST("tax_posting_reversal_indicator" AS VARCHAR) AS "tax_posting_reversal_indicator",
        CAST("tax_reporting_company_code" AS VARCHAR) AS "tax_reporting_company_code",
        CAST("text_reason_code" AS VARCHAR) AS "text_reason_code",
        CAST("trading_partner" AS VARCHAR) AS "trading_partner",
        CAST("umskz" AS VARCHAR) AS "umskz",
        CAST("us_federal_grant_key" AS VARCHAR) AS "us_federal_grant_key",
        CAST("user_field_1" AS VARCHAR) AS "user_field_1",
        CAST("user_field_2" AS VARCHAR) AS "user_field_2",
        CAST("user_field_3" AS VARCHAR) AS "user_field_3",
        CAST("valuation_type" AS VARCHAR) AS "valuation_type",
        CAST("vat_registration_number" AS VARCHAR) AS "vat_registration_number",
        CAST("vat_tax_code" AS VARCHAR) AS "vat_tax_code",
        CAST("vbel2" AS VARCHAR) AS "vbel2",
        CAST("vendor_number" AS VARCHAR) AS "vendor_number",
        CAST("wverw" AS VARCHAR) AS "wverw",
        CAST("xfakt" AS VARCHAR) AS "xfakt",
        CAST("xsauf" AS VARCHAR) AS "xsauf",
        CAST("zumsk" AS VARCHAR) AS "zumsk",
        CAST("zuonr" AS VARCHAR) AS "zuonr"
    FROM "sap_bseg_data_projected_renamed_cleaned"
),

"sap_bseg_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 143 columns with unacceptable missing values
    -- account_assignment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_assignment_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- accounting_code_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- accounting_number_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- accounting_value_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- acquisition_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- activity_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- automatic_posting_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- balance_carryforward_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- balance_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- balance_sheet_update_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- balance_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- base_unit_of_measure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- base_unit_quantity has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- blocking_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- brazil_tax_upload has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- budget_pd has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_partner has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_place has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_process has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bwkey has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- coding_block has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- consolidation_business_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- consolidation_functional_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- consolidation_region has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_element has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cost_object has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- credit_control_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customs_tariff has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- discount_base_period_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- distribution_channel has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- document_line_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- erfme has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fistl has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geber has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- gl_account_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- goods_movement_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- goods_recipient has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- grant_nbr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- grant_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- header_comment_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- house_bank_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- hzuon has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ignore_invoice_reference has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- internal_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- internal_renumbering has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- invoice_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- item_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- item_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- kblnr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legacy_clearing_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- line_item_identifier has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- line_of_business has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- location has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- maber has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- manual_entry_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- manual_split_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- material_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- material_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- measure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- negative_posting_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- net_payment_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- noted_item_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- open_item_management_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- operation_begin_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- operation_end_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pa_exchange_rate_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partial_payment_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_account_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_bank_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_business_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_measurement_unit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pbudget_pd has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pfkber has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pgeber has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pgrant_nbr has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- planning_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- planning_level has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- plant has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- po_history_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- price_control_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- price_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- profit_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- profitability_segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- project_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psalt has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psegment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchase_order_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- re_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- re_company_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ready_for_input_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- rebzg has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_reference has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- recurring_entry_original_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_document_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_key_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_key_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_key_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- region has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reporting_currency has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reporting_value_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reservation_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reversal_transaction_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_document_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_movement_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_promotion_region has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sample_document_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- section_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- securities_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- segment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- service_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shzuz has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- single_statement_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- special_gl_transaction_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- special_index has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- squan has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subsequent_billing_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_reporting_company_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- text_reason_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- trading_partner has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- umskz has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- us_federal_grant_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_field_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_field_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_field_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- valuation_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vbel2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vendor_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- wverw has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xfakt has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xsauf has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- zumsk has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "buzei",
        "fiscal_year",
        "clearing_date",
        "clearing_fiscal_period",
        "posting_key",
        "koart",
        "debit_credit_indicator",
        "total_local_amount",
        "wrbtr",
        "document_currency_amount",
        "transaction_amount",
        "transaction_currency",
        "transaction_currency_tax_base",
        "tax_base_amount",
        "foreign_tax_amount",
        "tax_amount",
        "home_currency_amount",
        "functional_area_amount",
        "home_currency_assignment_amount",
        "functional_area_assignment_amount",
        "tax_group",
        "accounting_value_3",
        "kursr",
        "gbetr",
        "valuation_difference",
        "valuation_difference_2",
        "value_date",
        "line_item_text",
        "transaction_type",
        "planned_price",
        "factory_calendar_date",
        "position_number",
        "delivery_date",
        "asset_value_date",
        "personnel_number",
        "document_reversal_indicator",
        "payment_indicator",
        "gvtyp",
        "due_date_baseline",
        "cash_discount_days_1",
        "cash_discount_days_2",
        "net_payment_terms_days",
        "cash_discount_percent_1",
        "cash_discount_percent_2",
        "skfbt",
        "transaction_currency_amount",
        "cash_discount_amount",
        "net_amount",
        "local_amount_1",
        "withholding_tax_amount_1",
        "local_amount_2",
        "withholding_tax_amount_2",
        "local_amount_3",
        "withholding_tax_amount_3",
        "reference_fiscal_year",
        "reference_line_item",
        "customs_amount",
        "sample_number",
        "depreciation_period",
        "insurance_date",
        "discount_base_year",
        "discount_base_period",
        "asset_acquisition_year",
        "apc_area",
        "document_amount_local",
        "balance_carryforward",
        "klibt",
        "accounting_value_1",
        "accounting_value_2",
        "foreign_non_deductible_tax_base",
        "non_deductible_input_tax",
        "menge",
        "erfmg",
        "bpmng",
        "purchase_order_item_number",
        "account_assignment_sequence",
        "peinh",
        "reference_amount",
        "reference_exchange_rate",
        "investment_support_amount",
        "bualt",
        "net_price",
        "accounting_value_4",
        "difference_value_3",
        "difference_value_1",
        "days_in_arrears",
        "option_selection",
        "order_item_number",
        "asset_sequence_number",
        "project_key",
        "profitability_segment_number",
        "profitability_subsegment_number",
        "dmbe2",
        "group_currency_amount",
        "dmb21",
        "dmb22",
        "dmb23",
        "group_currency_amount_1",
        "group_currency_amount_2",
        "group_currency_amount_3",
        "local_tax_amount",
        "document_tax_amount",
        "local_non_deductible_tax_base",
        "document_non_deductible_tax_base",
        "second_local_currency_amount",
        "third_local_currency_amount",
        "valuation_difference_3",
        "difference_value_2",
        "second_local_currency_tax_base",
        "third_local_currency_tax_base",
        "kblpos",
        "local_currency_tax_amount",
        "original_line_item_number",
        "reference_line_indicator",
        "tax_amount_1",
        "tax_amount_2",
        "tax_amount_3",
        "tax_amount_4",
        "write_off_amount",
        "tax_reporting_date",
        "settlement_period",
        "payment_amount",
        "price_difference",
        "price_difference_2",
        "price_difference_3",
        "penlc1",
        "penlc2",
        "penlc3",
        "foreign_currency_amount",
        "number_of_days",
        "sales_use_tax_amount",
        "clearing_fiscal_year",
        "tax_splitting",
        "original_fiscal_year",
        "original_document_line_number",
        "original_line_item_sequence",
        "production_period",
        "row_id",
        "is_deleted",
        "alternative_account",
        "asset_acquisition_period",
        "asset_subnumber",
        "asset_transaction_type",
        "asset_valuation_type",
        "belnr",
        "bill_of_exchange_procedure",
        "billing_block",
        "billing_type",
        "business_area",
        "cession_indicator",
        "clearing_document_number",
        "clearing_reversal_indicator",
        "clearing_with_down_payment",
        "client_id",
        "company_code",
        "contract_number",
        "contract_type",
        "controlling_area",
        "delivery_block",
        "delivery_completed",
        "dunning_level",
        "fast_pay_indicator",
        "financial_position",
        "fixed_payment_terms_indicator",
        "foreign_currency_valuation_type",
        "funds_center",
        "funds_center_description",
        "funds_reservation_number",
        "gl_account",
        "gr_ir_clearing_number",
        "grir_clearing_reversal_indicator",
        "insurance_indicator",
        "insurance_reason_code",
        "kostl",
        "line_item_reference",
        "line_number_range",
        "lokkt",
        "main_asset_number",
        "mandate_id",
        "manual_stats_update",
        "material_document_date",
        "network_activity_number",
        "order_number",
        "original_document_number",
        "payment_block",
        "payment_currency",
        "payment_method",
        "payment_method_supplement",
        "payment_processing_indicator",
        "payment_provider_transaction_id",
        "payment_service_provider",
        "payment_term",
        "payment_terms",
        "payment_terms_key",
        "prctr",
        "tax_code_1",
        "tax_code_2",
        "tax_code_3",
        "tax_code_change_indicator",
        "tax_exempt_indicator",
        "tax_indicator",
        "tax_jurisdiction_code",
        "tax_posting_reversal_indicator",
        "vat_registration_number",
        "vat_tax_code",
        "zuonr"
    FROM "sap_bseg_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_bseg_data_projected_renamed_cleaned_casted_missing_handled"