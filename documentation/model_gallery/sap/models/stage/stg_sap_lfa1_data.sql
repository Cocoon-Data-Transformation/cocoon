-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 05:02:19.038665+00:00
WITH 
"sap_lfa1_data_projected" AS (
    -- Projection: Selecting 141 out of 142 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "lifnr",
        "mandt",
        "land1",
        "name1",
        "name2",
        "name3",
        "name4",
        "ort01",
        "ort02",
        "pfach",
        "pstl2",
        "pstlz",
        "regio",
        "sortl",
        "stras",
        "adrnr",
        "mcod1",
        "mcod2",
        "mcod3",
        "anred",
        "bahns",
        "bbbnr",
        "bbsnr",
        "begru",
        "brsch",
        "bubkz",
        "datlt",
        "dtams",
        "dtaws",
        "erdat",
        "ernam",
        "esrnr",
        "konzs",
        "ktokk",
        "kunnr",
        "lnrza",
        "loevm",
        "sperr",
        "sperm",
        "spras",
        "stcd1",
        "stcd2",
        "stkza",
        "stkzu",
        "telbx",
        "telf1",
        "telf2",
        "telfx",
        "teltx",
        "telx1",
        "xcpdk",
        "xzemp",
        "vbund",
        "fiskn",
        "stceg",
        "stkzn",
        "sperq",
        "gbort",
        "gbdat",
        "sexkz",
        "kraus",
        "revdb",
        "qssys",
        "ktock",
        "pfort",
        "werks",
        "ltsna",
        "werkr",
        "plkal",
        "duefl",
        "txjcd",
        "sperz",
        "scacd",
        "sfrgr",
        "lzone",
        "xlfza",
        "dlgrp",
        "fityp",
        "stcdt",
        "regss",
        "actss",
        "stcd3",
        "stcd4",
        "stcd5",
        "ipisp",
        "taxbs",
        "profs",
        "stgdl",
        "emnfr",
        "lfurl",
        "j_1kfrepre",
        "j_1kftbus",
        "j_1kftind",
        "confs",
        "updat",
        "uptim",
        "nodel",
        "qssysdat",
        "podkzb",
        "fisku",
        "stenr",
        "carrier_conf",
        "min_comp",
        "term_li",
        "crc_num",
        "cvp_xblck",
        "rg",
        "exp",
        "uf",
        "rgdate",
        "ric",
        "rne",
        "rnedate",
        "cnae",
        "legalnat",
        "crtn",
        "icmstaxpay",
        "indtyp",
        "tdt",
        "comsize",
        "decregpc",
        "j_sc_capital",
        "j_sc_currency",
        "alc",
        "pmt_office",
        "ppa_relevant",
        "psofg",
        "psois",
        "pson1",
        "pson2",
        "pson3",
        "psovn",
        "psotl",
        "psohs",
        "psost",
        "transport_chain",
        "staging_time",
        "scheduling_type",
        "submi_relevant",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_lfa1_data"
),

"sap_lfa1_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- lifnr -> vendor_number
    -- mandt -> client
    -- land1 -> country_key
    -- name3 -> vendor_name_3
    -- name4 -> vendor_name_4
    -- ort02 -> district
    -- pfach -> po_box
    -- pstl2 -> po_box_postal_code_2
    -- pstlz -> postal_code
    -- regio -> region
    -- sortl -> sort_field
    -- stras -> street_address
    -- adrnr -> address_number
    -- anred -> title
    -- bahns -> train_station
    -- bbbnr -> international_location_number
    -- bbsnr -> location_number_check_digit
    -- begru -> authorization_group
    -- brsch -> industry_key
    -- bubkz -> cash_management_indicator
    -- datlt -> communication_line_type
    -- dtams -> data_medium_exchange_indicator
    -- dtaws -> data_medium_exchange_instruction
    -- erdat -> creation_date
    -- ernam -> created_by
    -- esrnr -> isr_subscriber_number
    -- konzs -> group_key
    -- ktokk -> vendor_account_group
    -- kunnr -> customer_number
    -- lnrza -> alternative_payee_account
    -- sperr -> central_block
    -- sperm -> permitted_functions
    -- spras -> language_key
    -- stcd2 -> tax_number_2
    -- stkzu -> alternative_payee_account_indicator
    -- telbx -> telebox_number
    -- telf1 -> telephone_number_1
    -- telf2 -> telephone_number_2
    -- telfx -> fax_number
    -- teltx -> teletex_number
    -- telx1 -> telex_number
    -- xcpdk -> one_time_account_indicator
    -- xzemp -> payment_block_indicator
    -- vbund -> trading_partner_company_id
    -- fiskn -> fiscal_number
    -- stceg -> vat_registration_number
    -- stkzn -> natural_person_indicator
    -- sperq -> blocked_functions
    -- gbort -> birth_place
    -- gbdat -> birth_date
    -- sexkz -> gender_indicator
    -- kraus -> credit_info_number
    -- revdb -> revision_indicator
    -- qssys -> quality_management_system
    -- ktock -> payment_tolerance_group
    -- pfort -> po_box_city
    -- werks -> plant
    -- werkr -> reference_plant
    -- plkal -> plant_calendar_key
    -- duefl -> data_transfer_status
    -- txjcd -> tax_jurisdiction_code
    -- scacd -> supply_chain_activity_code
    -- sfrgr -> group_status
    -- lzone -> transportation_zone
    -- dlgrp -> dunning_level
    -- fityp -> tax_type
    -- stcdt -> tax_number_type
    -- regss -> regional_subdivision
    -- actss -> active_sales_service_status
    -- stcd3 -> tax_number_3
    -- stcd4 -> tax_number_4
    -- stcd5 -> tax_number_5
    -- ipisp -> ipi_taxpayer
    -- taxbs -> tax_base_amount
    -- profs -> profession
    -- stgdl -> statistics_group
    -- emnfr -> external_manufacturer
    -- lfurl -> vendor_url
    -- j_1kfrepre -> foreign_representative
    -- j_1kftbus -> business_type
    -- j_1kftind -> industry_classification
    -- confs -> confirmation_status
    -- updat -> last_update_date
    -- uptim -> last_update_time
    -- qssysdat -> qm_system_validity_date
    -- podkzb -> po_box_postal_code
    -- stenr -> statistical_number
    -- carrier_conf -> carrier_confirmation
    -- min_comp -> minimum_comparison
    -- term_li -> delivery_terms
    -- crc_num -> crc_number
    -- rg -> reference_group
    -- exp -> export_indicator
    -- uf -> user_field
    -- rgdate -> reference_group_date
    -- ric -> risk_indicator
    -- rne -> risk_notification_email
    -- rnedate -> risk_notification_date
    -- cnae -> brazilian_industry_code
    -- legalnat -> legal_nature
    -- crtn -> tax_related_number
    -- icmstaxpay -> icms_taxpayer
    -- indtyp -> industry_type
    -- tdt -> transaction_datetime
    -- comsize -> company_size
    -- decregpc -> declaration_regimen
    -- j_sc_capital -> registered_capital
    -- j_sc_currency -> capital_currency
    -- alc -> alternative_payee_allowed
    -- pmt_office -> payment_office
    -- ppa_relevant -> pci_relevant
    -- psofg -> post_office_branch
    -- psois -> street
    -- pson1 -> street_2
    -- pson2 -> street_3
    -- pson3 -> street_4
    -- psovn -> house_number_supplement
    -- psotl -> street_number
    -- psohs -> house_number
    -- psost -> street_abbreviation
    -- submi_relevant -> submission_relevance
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "lifnr" AS "vendor_number",
        "mandt" AS "client",
        "land1" AS "country_key",
        "name1",
        "name2",
        "name3" AS "vendor_name_3",
        "name4" AS "vendor_name_4",
        "ort01",
        "ort02" AS "district",
        "pfach" AS "po_box",
        "pstl2" AS "po_box_postal_code_2",
        "pstlz" AS "postal_code",
        "regio" AS "region",
        "sortl" AS "sort_field",
        "stras" AS "street_address",
        "adrnr" AS "address_number",
        "mcod1",
        "mcod2",
        "mcod3",
        "anred" AS "title",
        "bahns" AS "train_station",
        "bbbnr" AS "international_location_number",
        "bbsnr" AS "location_number_check_digit",
        "begru" AS "authorization_group",
        "brsch" AS "industry_key",
        "bubkz" AS "cash_management_indicator",
        "datlt" AS "communication_line_type",
        "dtams" AS "data_medium_exchange_indicator",
        "dtaws" AS "data_medium_exchange_instruction",
        "erdat" AS "creation_date",
        "ernam" AS "created_by",
        "esrnr" AS "isr_subscriber_number",
        "konzs" AS "group_key",
        "ktokk" AS "vendor_account_group",
        "kunnr" AS "customer_number",
        "lnrza" AS "alternative_payee_account",
        "loevm",
        "sperr" AS "central_block",
        "sperm" AS "permitted_functions",
        "spras" AS "language_key",
        "stcd1",
        "stcd2" AS "tax_number_2",
        "stkza",
        "stkzu" AS "alternative_payee_account_indicator",
        "telbx" AS "telebox_number",
        "telf1" AS "telephone_number_1",
        "telf2" AS "telephone_number_2",
        "telfx" AS "fax_number",
        "teltx" AS "teletex_number",
        "telx1" AS "telex_number",
        "xcpdk" AS "one_time_account_indicator",
        "xzemp" AS "payment_block_indicator",
        "vbund" AS "trading_partner_company_id",
        "fiskn" AS "fiscal_number",
        "stceg" AS "vat_registration_number",
        "stkzn" AS "natural_person_indicator",
        "sperq" AS "blocked_functions",
        "gbort" AS "birth_place",
        "gbdat" AS "birth_date",
        "sexkz" AS "gender_indicator",
        "kraus" AS "credit_info_number",
        "revdb" AS "revision_indicator",
        "qssys" AS "quality_management_system",
        "ktock" AS "payment_tolerance_group",
        "pfort" AS "po_box_city",
        "werks" AS "plant",
        "ltsna",
        "werkr" AS "reference_plant",
        "plkal" AS "plant_calendar_key",
        "duefl" AS "data_transfer_status",
        "txjcd" AS "tax_jurisdiction_code",
        "sperz",
        "scacd" AS "supply_chain_activity_code",
        "sfrgr" AS "group_status",
        "lzone" AS "transportation_zone",
        "xlfza",
        "dlgrp" AS "dunning_level",
        "fityp" AS "tax_type",
        "stcdt" AS "tax_number_type",
        "regss" AS "regional_subdivision",
        "actss" AS "active_sales_service_status",
        "stcd3" AS "tax_number_3",
        "stcd4" AS "tax_number_4",
        "stcd5" AS "tax_number_5",
        "ipisp" AS "ipi_taxpayer",
        "taxbs" AS "tax_base_amount",
        "profs" AS "profession",
        "stgdl" AS "statistics_group",
        "emnfr" AS "external_manufacturer",
        "lfurl" AS "vendor_url",
        "j_1kfrepre" AS "foreign_representative",
        "j_1kftbus" AS "business_type",
        "j_1kftind" AS "industry_classification",
        "confs" AS "confirmation_status",
        "updat" AS "last_update_date",
        "uptim" AS "last_update_time",
        "nodel",
        "qssysdat" AS "qm_system_validity_date",
        "podkzb" AS "po_box_postal_code",
        "fisku",
        "stenr" AS "statistical_number",
        "carrier_conf" AS "carrier_confirmation",
        "min_comp" AS "minimum_comparison",
        "term_li" AS "delivery_terms",
        "crc_num" AS "crc_number",
        "cvp_xblck",
        "rg" AS "reference_group",
        "exp" AS "export_indicator",
        "uf" AS "user_field",
        "rgdate" AS "reference_group_date",
        "ric" AS "risk_indicator",
        "rne" AS "risk_notification_email",
        "rnedate" AS "risk_notification_date",
        "cnae" AS "brazilian_industry_code",
        "legalnat" AS "legal_nature",
        "crtn" AS "tax_related_number",
        "icmstaxpay" AS "icms_taxpayer",
        "indtyp" AS "industry_type",
        "tdt" AS "transaction_datetime",
        "comsize" AS "company_size",
        "decregpc" AS "declaration_regimen",
        "j_sc_capital" AS "registered_capital",
        "j_sc_currency" AS "capital_currency",
        "alc" AS "alternative_payee_allowed",
        "pmt_office" AS "payment_office",
        "ppa_relevant" AS "pci_relevant",
        "psofg" AS "post_office_branch",
        "psois" AS "street",
        "pson1" AS "street_2",
        "pson2" AS "street_3",
        "pson3" AS "street_4",
        "psovn" AS "house_number_supplement",
        "psotl" AS "street_number",
        "psohs" AS "house_number",
        "psost" AS "street_abbreviation",
        "transport_chain",
        "staging_time",
        "scheduling_type",
        "submi_relevant" AS "submission_relevance",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_lfa1_data_projected"
),

"sap_lfa1_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- data_transfer_status: The problem is that 'X' is the only value present in the data_transfer_status column, and it's not descriptive of any actual data transfer status. This severely limits the usefulness of the column. Typically, a data transfer status column would contain values that indicate the current state of a data transfer, such as 'Completed', 'In Progress', 'Failed', or 'Pending'. The 'X' value is meaningless in this context and doesn't provide any useful information about the status of data transfers. 
    SELECT
        "vendor_number",
        "client",
        "country_key",
        "name1",
        "name2",
        "vendor_name_3",
        "vendor_name_4",
        "ort01",
        "district",
        "po_box",
        "po_box_postal_code_2",
        "postal_code",
        "region",
        "sort_field",
        "street_address",
        "address_number",
        "mcod1",
        "mcod2",
        "mcod3",
        "title",
        "train_station",
        "international_location_number",
        "location_number_check_digit",
        "authorization_group",
        "industry_key",
        "cash_management_indicator",
        "communication_line_type",
        "data_medium_exchange_indicator",
        "data_medium_exchange_instruction",
        "creation_date",
        "created_by",
        "isr_subscriber_number",
        "group_key",
        "vendor_account_group",
        "customer_number",
        "alternative_payee_account",
        "loevm",
        "central_block",
        "permitted_functions",
        "language_key",
        "stcd1",
        "tax_number_2",
        "stkza",
        "alternative_payee_account_indicator",
        "telebox_number",
        "telephone_number_1",
        "telephone_number_2",
        "fax_number",
        "teletex_number",
        "telex_number",
        "one_time_account_indicator",
        "payment_block_indicator",
        "trading_partner_company_id",
        "fiscal_number",
        "vat_registration_number",
        "natural_person_indicator",
        "blocked_functions",
        "birth_place",
        "birth_date",
        "gender_indicator",
        "credit_info_number",
        "revision_indicator",
        "quality_management_system",
        "payment_tolerance_group",
        "po_box_city",
        "plant",
        "ltsna",
        "reference_plant",
        "plant_calendar_key",
        CASE
            WHEN "data_transfer_status" = '''X''' THEN ''''
            ELSE "data_transfer_status"
        END AS "data_transfer_status",
        "tax_jurisdiction_code",
        "sperz",
        "supply_chain_activity_code",
        "group_status",
        "transportation_zone",
        "xlfza",
        "dunning_level",
        "tax_type",
        "tax_number_type",
        "regional_subdivision",
        "active_sales_service_status",
        "tax_number_3",
        "tax_number_4",
        "tax_number_5",
        "ipi_taxpayer",
        "tax_base_amount",
        "profession",
        "statistics_group",
        "external_manufacturer",
        "vendor_url",
        "foreign_representative",
        "business_type",
        "industry_classification",
        "confirmation_status",
        "last_update_date",
        "last_update_time",
        "nodel",
        "qm_system_validity_date",
        "po_box_postal_code",
        "fisku",
        "statistical_number",
        "carrier_confirmation",
        "minimum_comparison",
        "delivery_terms",
        "crc_number",
        "cvp_xblck",
        "reference_group",
        "export_indicator",
        "user_field",
        "reference_group_date",
        "risk_indicator",
        "risk_notification_email",
        "risk_notification_date",
        "brazilian_industry_code",
        "legal_nature",
        "tax_related_number",
        "icms_taxpayer",
        "industry_type",
        "transaction_datetime",
        "company_size",
        "declaration_regimen",
        "registered_capital",
        "capital_currency",
        "alternative_payee_allowed",
        "payment_office",
        "pci_relevant",
        "post_office_branch",
        "street",
        "street_2",
        "street_3",
        "street_4",
        "house_number_supplement",
        "street_number",
        "house_number",
        "street_abbreviation",
        "transport_chain",
        "staging_time",
        "scheduling_type",
        "submission_relevance",
        "row_id",
        "is_deleted"
    FROM "sap_lfa1_data_projected_renamed"
),

"sap_lfa1_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- active_sales_service_status: from DECIMAL to VARCHAR
    -- alternative_payee_account: from DECIMAL to VARCHAR
    -- alternative_payee_account_indicator: from DECIMAL to VARCHAR
    -- alternative_payee_allowed: from DECIMAL to VARCHAR
    -- authorization_group: from DECIMAL to VARCHAR
    -- birth_place: from DECIMAL to VARCHAR
    -- blocked_functions: from DECIMAL to VARCHAR
    -- brazilian_industry_code: from DECIMAL to VARCHAR
    -- business_type: from DECIMAL to VARCHAR
    -- capital_currency: from DECIMAL to VARCHAR
    -- carrier_confirmation: from DECIMAL to VARCHAR
    -- central_block: from DECIMAL to VARCHAR
    -- communication_line_type: from DECIMAL to VARCHAR
    -- company_size: from DECIMAL to VARCHAR
    -- confirmation_status: from DECIMAL to VARCHAR
    -- crc_number: from DECIMAL to VARCHAR
    -- creation_date: from INT to DATE
    -- credit_info_number: from DECIMAL to VARCHAR
    -- customer_number: from DECIMAL to VARCHAR
    -- cvp_xblck: from DECIMAL to VARCHAR
    -- data_medium_exchange_indicator: from DECIMAL to VARCHAR
    -- data_medium_exchange_instruction: from DECIMAL to VARCHAR
    -- declaration_regimen: from DECIMAL to VARCHAR
    -- delivery_terms: from DECIMAL to VARCHAR
    -- dunning_level: from DECIMAL to VARCHAR
    -- export_indicator: from DECIMAL to VARCHAR
    -- external_manufacturer: from DECIMAL to VARCHAR
    -- fax_number: from DECIMAL to VARCHAR
    -- fiscal_number: from DECIMAL to VARCHAR
    -- fisku: from DECIMAL to VARCHAR
    -- foreign_representative: from DECIMAL to VARCHAR
    -- gender_indicator: from DECIMAL to VARCHAR
    -- group_key: from DECIMAL to VARCHAR
    -- group_status: from DECIMAL to VARCHAR
    -- house_number: from DECIMAL to VARCHAR
    -- house_number_supplement: from DECIMAL to VARCHAR
    -- icms_taxpayer: from DECIMAL to VARCHAR
    -- industry_classification: from DECIMAL to VARCHAR
    -- industry_type: from DECIMAL to VARCHAR
    -- international_location_number: from INT to VARCHAR
    -- ipi_taxpayer: from DECIMAL to VARCHAR
    -- isr_subscriber_number: from DECIMAL to VARCHAR
    -- last_update_date: from INT to VARCHAR
    -- last_update_time: from INT to VARCHAR
    -- legal_nature: from INT to VARCHAR
    -- location_number_check_digit: from INT to VARCHAR
    -- loevm: from DECIMAL to VARCHAR
    -- ltsna: from DECIMAL to VARCHAR
    -- mcod2: from DECIMAL to VARCHAR
    -- minimum_comparison: from DECIMAL to VARCHAR
    -- name2: from DECIMAL to VARCHAR
    -- natural_person_indicator: from DECIMAL to VARCHAR
    -- nodel: from DECIMAL to VARCHAR
    -- one_time_account_indicator: from DECIMAL to VARCHAR
    -- payment_block_indicator: from DECIMAL to VARCHAR
    -- payment_office: from DECIMAL to VARCHAR
    -- payment_tolerance_group: from DECIMAL to VARCHAR
    -- pci_relevant: from DECIMAL to VARCHAR
    -- permitted_functions: from DECIMAL to VARCHAR
    -- plant: from DECIMAL to VARCHAR
    -- plant_calendar_key: from DECIMAL to VARCHAR
    -- po_box: from DECIMAL to VARCHAR
    -- po_box_city: from DECIMAL to VARCHAR
    -- po_box_postal_code: from DECIMAL to VARCHAR
    -- po_box_postal_code_2: from DECIMAL to VARCHAR
    -- post_office_branch: from DECIMAL to VARCHAR
    -- postal_code: from INT to VARCHAR
    -- profession: from DECIMAL to VARCHAR
    -- quality_management_system: from DECIMAL to VARCHAR
    -- reference_group: from DECIMAL to VARCHAR
    -- reference_plant: from DECIMAL to VARCHAR
    -- regional_subdivision: from DECIMAL to VARCHAR
    -- risk_notification_email: from DECIMAL to VARCHAR
    -- scheduling_type: from DECIMAL to VARCHAR
    -- sperz: from DECIMAL to VARCHAR
    -- statistical_number: from DECIMAL to VARCHAR
    -- statistics_group: from DECIMAL to VARCHAR
    -- stcd1: from DECIMAL to VARCHAR
    -- stkza: from DECIMAL to VARCHAR
    -- street: from DECIMAL to VARCHAR
    -- street_2: from DECIMAL to VARCHAR
    -- street_3: from DECIMAL to VARCHAR
    -- street_4: from DECIMAL to VARCHAR
    -- street_abbreviation: from DECIMAL to VARCHAR
    -- street_number: from DECIMAL to VARCHAR
    -- submission_relevance: from DECIMAL to VARCHAR
    -- supply_chain_activity_code: from DECIMAL to VARCHAR
    -- tax_number_2: from DECIMAL to VARCHAR
    -- tax_number_3: from DECIMAL to VARCHAR
    -- tax_number_4: from DECIMAL to VARCHAR
    -- tax_number_5: from DECIMAL to VARCHAR
    -- tax_number_type: from DECIMAL to VARCHAR
    -- tax_related_number: from DECIMAL to VARCHAR
    -- tax_type: from DECIMAL to VARCHAR
    -- telebox_number: from DECIMAL to VARCHAR
    -- telephone_number_1: from DECIMAL to VARCHAR
    -- telephone_number_2: from DECIMAL to VARCHAR
    -- teletex_number: from DECIMAL to VARCHAR
    -- telex_number: from DECIMAL to VARCHAR
    -- trading_partner_company_id: from DECIMAL to VARCHAR
    -- train_station: from DECIMAL to VARCHAR
    -- transaction_datetime: from DECIMAL to TIMESTAMP
    -- transport_chain: from DECIMAL to VARCHAR
    -- transportation_zone: from DECIMAL to VARCHAR
    -- user_field: from DECIMAL to VARCHAR
    -- vat_registration_number: from DECIMAL to VARCHAR
    -- vendor_name_3: from DECIMAL to VARCHAR
    -- vendor_name_4: from DECIMAL to VARCHAR
    -- vendor_url: from DECIMAL to VARCHAR
    -- xlfza: from DECIMAL to VARCHAR
    SELECT
        "vendor_number",
        "client",
        "country_key",
        "name1",
        "ort01",
        "district",
        "region",
        "sort_field",
        "street_address",
        "address_number",
        "mcod1",
        "mcod3",
        "title",
        "industry_key",
        "cash_management_indicator",
        "created_by",
        "vendor_account_group",
        "language_key",
        "birth_date",
        "revision_indicator",
        "data_transfer_status",
        "tax_jurisdiction_code",
        "tax_base_amount",
        "qm_system_validity_date",
        "reference_group_date",
        "risk_indicator",
        "risk_notification_date",
        "registered_capital",
        "staging_time",
        "row_id",
        "is_deleted",
        CAST("active_sales_service_status" AS VARCHAR) AS "active_sales_service_status",
        CAST("alternative_payee_account" AS VARCHAR) AS "alternative_payee_account",
        CAST("alternative_payee_account_indicator" AS VARCHAR) AS "alternative_payee_account_indicator",
        CAST("alternative_payee_allowed" AS VARCHAR) AS "alternative_payee_allowed",
        CAST("authorization_group" AS VARCHAR) AS "authorization_group",
        CAST("birth_place" AS VARCHAR) AS "birth_place",
        CAST("blocked_functions" AS VARCHAR) AS "blocked_functions",
        CAST("brazilian_industry_code" AS VARCHAR) AS "brazilian_industry_code",
        CAST("business_type" AS VARCHAR) AS "business_type",
        CAST("capital_currency" AS VARCHAR) AS "capital_currency",
        CAST("carrier_confirmation" AS VARCHAR) AS "carrier_confirmation",
        CAST("central_block" AS VARCHAR) AS "central_block",
        CAST("communication_line_type" AS VARCHAR) AS "communication_line_type",
        CAST("company_size" AS VARCHAR) AS "company_size",
        CAST("confirmation_status" AS VARCHAR) AS "confirmation_status",
        CAST("crc_number" AS VARCHAR) AS "crc_number",
        strptime(CAST("creation_date" AS VARCHAR), '%Y%m%d') AS "creation_date",
        CAST("credit_info_number" AS VARCHAR) AS "credit_info_number",
        CAST("customer_number" AS VARCHAR) AS "customer_number",
        CAST("cvp_xblck" AS VARCHAR) AS "cvp_xblck",
        CAST("data_medium_exchange_indicator" AS VARCHAR) AS "data_medium_exchange_indicator",
        CAST("data_medium_exchange_instruction" AS VARCHAR) AS "data_medium_exchange_instruction",
        CAST("declaration_regimen" AS VARCHAR) AS "declaration_regimen",
        CAST("delivery_terms" AS VARCHAR) AS "delivery_terms",
        CAST("dunning_level" AS VARCHAR) AS "dunning_level",
        CAST("export_indicator" AS VARCHAR) AS "export_indicator",
        CAST("external_manufacturer" AS VARCHAR) AS "external_manufacturer",
        CAST("fax_number" AS VARCHAR) AS "fax_number",
        CAST("fiscal_number" AS VARCHAR) AS "fiscal_number",
        CAST("fisku" AS VARCHAR) AS "fisku",
        CAST("foreign_representative" AS VARCHAR) AS "foreign_representative",
        CAST("gender_indicator" AS VARCHAR) AS "gender_indicator",
        CAST("group_key" AS VARCHAR) AS "group_key",
        CAST("group_status" AS VARCHAR) AS "group_status",
        CAST("house_number" AS VARCHAR) AS "house_number",
        CAST("house_number_supplement" AS VARCHAR) AS "house_number_supplement",
        CAST("icms_taxpayer" AS VARCHAR) AS "icms_taxpayer",
        CAST("industry_classification" AS VARCHAR) AS "industry_classification",
        CAST("industry_type" AS VARCHAR) AS "industry_type",
        CAST("international_location_number" AS VARCHAR) AS "international_location_number",
        CAST("ipi_taxpayer" AS VARCHAR) AS "ipi_taxpayer",
        CAST("isr_subscriber_number" AS VARCHAR) AS "isr_subscriber_number",
        CAST("last_update_date" AS VARCHAR) AS "last_update_date",
        CAST("last_update_time" AS VARCHAR) AS "last_update_time",
        CAST("legal_nature" AS VARCHAR) AS "legal_nature",
        CAST("location_number_check_digit" AS VARCHAR) AS "location_number_check_digit",
        CAST("loevm" AS VARCHAR) AS "loevm",
        CAST("ltsna" AS VARCHAR) AS "ltsna",
        CAST("mcod2" AS VARCHAR) AS "mcod2",
        CAST("minimum_comparison" AS VARCHAR) AS "minimum_comparison",
        CAST("name2" AS VARCHAR) AS "name2",
        CAST("natural_person_indicator" AS VARCHAR) AS "natural_person_indicator",
        CAST("nodel" AS VARCHAR) AS "nodel",
        CAST("one_time_account_indicator" AS VARCHAR) AS "one_time_account_indicator",
        CAST("payment_block_indicator" AS VARCHAR) AS "payment_block_indicator",
        CAST("payment_office" AS VARCHAR) AS "payment_office",
        CAST("payment_tolerance_group" AS VARCHAR) AS "payment_tolerance_group",
        CAST("pci_relevant" AS VARCHAR) AS "pci_relevant",
        CAST("permitted_functions" AS VARCHAR) AS "permitted_functions",
        CAST("plant" AS VARCHAR) AS "plant",
        CAST("plant_calendar_key" AS VARCHAR) AS "plant_calendar_key",
        CAST("po_box" AS VARCHAR) AS "po_box",
        CAST("po_box_city" AS VARCHAR) AS "po_box_city",
        CAST("po_box_postal_code" AS VARCHAR) AS "po_box_postal_code",
        CAST("po_box_postal_code_2" AS VARCHAR) AS "po_box_postal_code_2",
        CAST("post_office_branch" AS VARCHAR) AS "post_office_branch",
        CAST("postal_code" AS VARCHAR) AS "postal_code",
        CAST("profession" AS VARCHAR) AS "profession",
        CAST("quality_management_system" AS VARCHAR) AS "quality_management_system",
        CAST("reference_group" AS VARCHAR) AS "reference_group",
        CAST("reference_plant" AS VARCHAR) AS "reference_plant",
        CAST("regional_subdivision" AS VARCHAR) AS "regional_subdivision",
        CAST("risk_notification_email" AS VARCHAR) AS "risk_notification_email",
        CAST("scheduling_type" AS VARCHAR) AS "scheduling_type",
        CAST("sperz" AS VARCHAR) AS "sperz",
        CAST("statistical_number" AS VARCHAR) AS "statistical_number",
        CAST("statistics_group" AS VARCHAR) AS "statistics_group",
        CAST("stcd1" AS VARCHAR) AS "stcd1",
        CAST("stkza" AS VARCHAR) AS "stkza",
        CAST("street" AS VARCHAR) AS "street",
        CAST("street_2" AS VARCHAR) AS "street_2",
        CAST("street_3" AS VARCHAR) AS "street_3",
        CAST("street_4" AS VARCHAR) AS "street_4",
        CAST("street_abbreviation" AS VARCHAR) AS "street_abbreviation",
        CAST("street_number" AS VARCHAR) AS "street_number",
        CAST("submission_relevance" AS VARCHAR) AS "submission_relevance",
        CAST("supply_chain_activity_code" AS VARCHAR) AS "supply_chain_activity_code",
        CAST("tax_number_2" AS VARCHAR) AS "tax_number_2",
        CAST("tax_number_3" AS VARCHAR) AS "tax_number_3",
        CAST("tax_number_4" AS VARCHAR) AS "tax_number_4",
        CAST("tax_number_5" AS VARCHAR) AS "tax_number_5",
        CAST("tax_number_type" AS VARCHAR) AS "tax_number_type",
        CAST("tax_related_number" AS VARCHAR) AS "tax_related_number",
        CAST("tax_type" AS VARCHAR) AS "tax_type",
        CAST("telebox_number" AS VARCHAR) AS "telebox_number",
        CAST("telephone_number_1" AS VARCHAR) AS "telephone_number_1",
        CAST("telephone_number_2" AS VARCHAR) AS "telephone_number_2",
        CAST("teletex_number" AS VARCHAR) AS "teletex_number",
        CAST("telex_number" AS VARCHAR) AS "telex_number",
        CAST("trading_partner_company_id" AS VARCHAR) AS "trading_partner_company_id",
        CAST("train_station" AS VARCHAR) AS "train_station",
        CAST("transaction_datetime" AS TIMESTAMP) AS "transaction_datetime",
        CAST("transport_chain" AS VARCHAR) AS "transport_chain",
        CAST("transportation_zone" AS VARCHAR) AS "transportation_zone",
        CAST("user_field" AS VARCHAR) AS "user_field",
        CAST("vat_registration_number" AS VARCHAR) AS "vat_registration_number",
        CAST("vendor_name_3" AS VARCHAR) AS "vendor_name_3",
        CAST("vendor_name_4" AS VARCHAR) AS "vendor_name_4",
        CAST("vendor_url" AS VARCHAR) AS "vendor_url",
        CAST("xlfza" AS VARCHAR) AS "xlfza"
    FROM "sap_lfa1_data_projected_renamed_cleaned"
),

"sap_lfa1_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 77 columns with unacceptable missing values
    -- active_sales_service_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- authorization_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- blocked_functions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- brazilian_industry_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- capital_currency has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- carrier_confirmation has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- central_block has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- communication_line_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_size has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- confirmation_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- crc_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- credit_info_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cvp_xblck has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_medium_exchange_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_medium_exchange_instruction has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- declaration_regimen has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- delivery_terms has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_manufacturer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fax_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fiscal_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fisku has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- house_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- house_number_supplement has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- icms_taxpayer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_classification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_key has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- industry_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- isr_subscriber_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- loevm has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ltsna has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mcod2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- minimum_comparison has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- name2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- nodel has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_office has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_tolerance_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pci_relevant has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- permitted_functions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- plant has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quality_management_system has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_plant has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- regional_subdivision has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- scheduling_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sperz has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statistical_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statistics_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- stcd1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- stkza has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- street has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- street_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- submission_relevance has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- supply_chain_activity_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_jurisdiction_code has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- tax_number_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_related_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- telephone_number_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- telephone_number_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- trading_partner_company_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transaction_datetime has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transport_chain has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transportation_zone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_field has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vat_registration_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vendor_name_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vendor_name_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vendor_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xlfza has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "vendor_number",
        "client",
        "country_key",
        "name1",
        "ort01",
        "district",
        "region",
        "sort_field",
        "street_address",
        "address_number",
        "mcod1",
        "mcod3",
        "title",
        "industry_key",
        "cash_management_indicator",
        "created_by",
        "vendor_account_group",
        "language_key",
        "birth_date",
        "revision_indicator",
        "data_transfer_status",
        "tax_jurisdiction_code",
        "tax_base_amount",
        "qm_system_validity_date",
        "reference_group_date",
        "risk_indicator",
        "risk_notification_date",
        "registered_capital",
        "staging_time",
        "row_id",
        "is_deleted",
        "alternative_payee_account",
        "alternative_payee_account_indicator",
        "alternative_payee_allowed",
        "birth_place",
        "creation_date",
        "dunning_level",
        "export_indicator",
        "foreign_representative",
        "gender_indicator",
        "international_location_number",
        "ipi_taxpayer",
        "last_update_date",
        "last_update_time",
        "legal_nature",
        "location_number_check_digit",
        "natural_person_indicator",
        "one_time_account_indicator",
        "payment_block_indicator",
        "plant_calendar_key",
        "po_box",
        "po_box_city",
        "po_box_postal_code",
        "po_box_postal_code_2",
        "post_office_branch",
        "postal_code",
        "profession",
        "risk_notification_email",
        "street_2",
        "street_3",
        "street_4",
        "street_abbreviation",
        "telebox_number",
        "teletex_number",
        "telex_number",
        "train_station"
    FROM "sap_lfa1_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_lfa1_data_projected_renamed_cleaned_casted_missing_handled"