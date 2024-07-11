-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 04:54:40.061772+00:00
WITH 
"sap_kna1_data_projected" AS (
    -- Projection: Selecting 196 out of 197 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "kunnr",
        "mandt",
        "land1",
        "name1",
        "name2",
        "ort01",
        "pstlz",
        "regio",
        "sortl",
        "stras",
        "telf1",
        "telfx",
        "xcpdk",
        "adrnr",
        "mcod1",
        "mcod2",
        "mcod3",
        "anred",
        "aufsd",
        "bahne",
        "bahns",
        "bbbnr",
        "bbsnr",
        "begru",
        "brsch",
        "bubkz",
        "datlt",
        "erdat",
        "ernam",
        "exabl",
        "faksd",
        "fiskn",
        "knazk",
        "knrza",
        "konzs",
        "ktokd",
        "kukla",
        "lifnr",
        "lifsd",
        "locco",
        "loevm",
        "name3",
        "name4",
        "niels",
        "ort02",
        "pfach",
        "pstl2",
        "counc",
        "cityc",
        "rpmkr",
        "sperr",
        "spras",
        "stcd1",
        "stcd2",
        "stkza",
        "stkzu",
        "telbx",
        "telf2",
        "teltx",
        "telx1",
        "lzone",
        "xzemp",
        "vbund",
        "stceg",
        "dear1",
        "dear2",
        "dear3",
        "dear4",
        "dear5",
        "gform",
        "bran1",
        "bran2",
        "bran3",
        "bran4",
        "bran5",
        "ekont",
        "umsat",
        "umjah",
        "uwaer",
        "jmzah",
        "jmjah",
        "katr1",
        "katr2",
        "katr3",
        "katr4",
        "katr5",
        "katr6",
        "katr7",
        "katr8",
        "katr9",
        "katr10",
        "stkzn",
        "umsa1",
        "txjcd",
        "periv",
        "abrvw",
        "inspbydebi",
        "inspatdebi",
        "ktocd",
        "pfort",
        "werks",
        "dtams",
        "dtaws",
        "duefl",
        "hzuor",
        "sperz",
        "etikg",
        "civve",
        "milve",
        "kdkg1",
        "kdkg2",
        "kdkg3",
        "kdkg4",
        "kdkg5",
        "xknza",
        "fityp",
        "stcdt",
        "stcd3",
        "stcd4",
        "stcd5",
        "xicms",
        "xxipi",
        "xsubt",
        "cfopc",
        "txlw1",
        "txlw2",
        "ccc01",
        "ccc02",
        "ccc03",
        "ccc04",
        "cassd",
        "knurl",
        "j_1kfrepre",
        "j_1kftbus",
        "j_1kftind",
        "confs",
        "updat",
        "uptim",
        "nodel",
        "dear6",
        "cvp_xblck",
        "suframa",
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
        "_vso_r_palhgt",
        "_vso_r_pal_ul",
        "_vso_r_pk_mat",
        "_vso_r_matpal",
        "_vso_r_i_no_lyr",
        "_vso_r_one_mat",
        "_vso_r_one_sort",
        "_vso_r_uld_side",
        "_vso_r_load_pref",
        "_vso_r_dpoint",
        "_xlso_customer",
        "_xlso_sysid",
        "_xlso_client",
        "_xlso_partner",
        "_xlso_pref_pay",
        "alc",
        "pmt_office",
        "fee_schedule",
        "duns",
        "duns4",
        "psofg",
        "psois",
        "pson1",
        "pson2",
        "pson3",
        "psovn",
        "psotl",
        "psohs",
        "psost",
        "psoo1",
        "psoo2",
        "psoo3",
        "psoo4",
        "psoo5",
        "oidrc",
        "oid_poreqd",
        "oipbl",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_kna1_data"
),

"sap_kna1_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- kunnr -> customer_number
    -- mandt -> client
    -- land1 -> country_code
    -- name1 -> name_1
    -- name2 -> name_2
    -- ort01 -> city
    -- pstlz -> postal_code
    -- regio -> region
    -- sortl -> customer_id
    -- stras -> street_address
    -- telf1 -> telephone_1
    -- telfx -> fax_number
    -- xcpdk -> one_time_customer_flag
    -- adrnr -> address_number
    -- mcod1 -> search_term_1
    -- mcod2 -> search_term_2
    -- mcod3 -> search_term_3
    -- anred -> form_of_address
    -- aufsd -> order_block
    -- bahne -> railway_station_name
    -- bahns -> railway_station_code
    -- bbbnr -> international_location_number
    -- bbsnr -> location_number_check_digit
    -- begru -> authorization_group
    -- brsch -> business_region_school
    -- bubkz -> company_code_indicator
    -- datlt -> data_line_type
    -- erdat -> creation_date
    -- ernam -> creator_name
    -- exabl -> credit_limit
    -- faksd -> central_billing_block
    -- fiskn -> fiscal_number
    -- knazk -> customer_category
    -- knrza -> reference_number
    -- konzs -> customer_classification
    -- kukla -> customer_class
    -- lifnr -> vendor_number
    -- lifsd -> vendor_lockout_status
    -- locco -> location_code
    -- loevm -> deletion_flag
    -- name3 -> name_3
    -- name4 -> customer_name_4
    -- niels -> nielsen_code
    -- ort02 -> district
    -- pfach -> po_box
    -- pstl2 -> district_code
    -- counc -> county_code
    -- cityc -> city_code
    -- rpmkr -> risk_profile_marker
    -- sperr -> blocking_indicator
    -- spras -> language_key
    -- stcd1 -> tax_number_1
    -- stcd2 -> tax_number_2
    -- stkza -> statistical_group
    -- stkzu -> sales_tax_liability
    -- telbx -> telebox_number
    -- telf2 -> telephone_2
    -- teltx -> teletex_number
    -- telx1 -> telex_number
    -- lzone -> transportation_zone
    -- xzemp -> central_payment_allowed
    -- vbund -> company_code
    -- stceg -> vat_number
    -- dear1 -> address_form_1
    -- dear2 -> address_form_2
    -- dear3 -> address_form_3
    -- dear4 -> address_form_4
    -- dear5 -> address_form_5
    -- gform -> legal_form
    -- bran1 -> industry_sector_1
    -- bran2 -> industry_sector_2
    -- bran3 -> industry_sector_3
    -- bran4 -> branch_code_4
    -- bran5 -> branch_code_5
    -- ekont -> purchasing_account
    -- umsat -> monthly_turnover
    -- umjah -> last_turnover_year
    -- uwaer -> currency_code
    -- jmzah -> last_dunning_number
    -- jmjah -> last_dunning_year
    -- katr6 -> customer_attribute_6
    -- katr7 -> customer_attribute_7
    -- katr8 -> custom_attribute_1
    -- katr9 -> custom_attribute_2
    -- katr10 -> customer_attribute_10
    -- stkzn -> natural_person_indicator
    -- umsa1 -> annual_turnover
    -- txjcd -> tax_jurisdiction
    -- periv -> fiscal_year_variant
    -- abrvw -> communication_preference
    -- inspbydebi -> payment_instruction_key_alt
    -- inspatdebi -> payment_instruction_key
    -- ktocd -> account_code
    -- pfort -> po_box_city
    -- werks -> plant_code
    -- dtams -> data_medium_exchange
    -- dtaws -> data_transfer_method
    -- duefl -> due_diligence_flag
    -- hzuor -> dunning_level
    -- sperz -> central_blocking_indicator
    -- etikg -> delivery_priority
    -- civve -> civil_servant
    -- milve -> military_verification
    -- kdkg4 -> customer_group_4
    -- kdkg5 -> customer_group_5
    -- xknza -> alternative_payee_allowed
    -- fityp -> tax_type
    -- stcdt -> tax_number_type
    -- stcd3 -> tax_number_3
    -- stcd4 -> tax_number_4
    -- stcd5 -> tax_number_5
    -- xicms -> icms_tax_liable
    -- xxipi -> ipi_tax_liable
    -- xsubt -> subtotal_per_delivery
    -- cfopc -> financial_operations_center
    -- txlw1 -> tax_law_classification
    -- txlw2 -> tax_law_indicator
    -- ccc01 -> customer_classification_1
    -- ccc02 -> customer_classification_2
    -- ccc03 -> customer_classification_3
    -- ccc04 -> customer_classification_4
    -- cassd -> central_address_service
    -- knurl -> customer_url
    -- j_1kfrepre -> representative_name
    -- j_1kftbus -> business_type
    -- j_1kftind -> industry_category
    -- confs -> statement_confirmation
    -- updat -> last_update_date
    -- uptim -> last_update_time
    -- nodel -> delivery_block
    -- dear6 -> address_form_6
    -- cvp_xblck -> vendor_master_block
    -- suframa -> suframa_number
    -- rg -> account_number_prefix
    -- exp -> export_indicator
    -- uf -> state_code
    -- rgdate -> registration_date
    -- ric -> risk_classification
    -- rne -> registration_number
    -- rnedate -> registration_number_date
    -- cnae -> economic_activity_classification
    -- legalnat -> legal_nature
    -- crtn -> certificate_registration_number
    -- icmstaxpay -> icms_taxpayer
    -- indtyp -> industry_type
    -- tdt -> transit_time
    -- comsize -> company_size
    -- decregpc -> decree_registration_code
    -- _vso_r_palhgt -> vso_palette_height
    -- _vso_r_pal_ul -> vso_palette_unit_load
    -- _vso_r_pk_mat -> vso_packing_material
    -- _vso_r_matpal -> vso_material_palette
    -- _vso_r_i_no_lyr -> vso_integer_value
    -- _vso_r_one_mat -> vso_one_material_flag
    -- _vso_r_one_sort -> vso_one_sort_flag
    -- _vso_r_uld_side -> vso_unload_side
    -- _vso_r_load_pref -> vso_loading_preference
    -- _vso_r_dpoint -> vso_data_point
    -- _xlso_customer -> xlso_customer_id
    -- _xlso_sysid -> xlso_system_id
    -- _xlso_client -> xlso_client_id
    -- _xlso_partner -> xlso_partner_id
    -- _xlso_pref_pay -> xlso_preferred_payment
    -- alc -> alcohol_info
    -- pmt_office -> payment_office
    -- psofg -> sales_office
    -- psois -> sales_district
    -- psovn -> customer_account_group
    -- psotl -> order_probability
    -- psohs -> sales_group
    -- psost -> statistics_group
    -- oidrc -> risk_category
    -- oid_poreqd -> one_time_customer
    -- oipbl -> payment_block
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "kunnr" AS "customer_number",
        "mandt" AS "client",
        "land1" AS "country_code",
        "name1" AS "name_1",
        "name2" AS "name_2",
        "ort01" AS "city",
        "pstlz" AS "postal_code",
        "regio" AS "region",
        "sortl" AS "customer_id",
        "stras" AS "street_address",
        "telf1" AS "telephone_1",
        "telfx" AS "fax_number",
        "xcpdk" AS "one_time_customer_flag",
        "adrnr" AS "address_number",
        "mcod1" AS "search_term_1",
        "mcod2" AS "search_term_2",
        "mcod3" AS "search_term_3",
        "anred" AS "form_of_address",
        "aufsd" AS "order_block",
        "bahne" AS "railway_station_name",
        "bahns" AS "railway_station_code",
        "bbbnr" AS "international_location_number",
        "bbsnr" AS "location_number_check_digit",
        "begru" AS "authorization_group",
        "brsch" AS "business_region_school",
        "bubkz" AS "company_code_indicator",
        "datlt" AS "data_line_type",
        "erdat" AS "creation_date",
        "ernam" AS "creator_name",
        "exabl" AS "credit_limit",
        "faksd" AS "central_billing_block",
        "fiskn" AS "fiscal_number",
        "knazk" AS "customer_category",
        "knrza" AS "reference_number",
        "konzs" AS "customer_classification",
        "ktokd",
        "kukla" AS "customer_class",
        "lifnr" AS "vendor_number",
        "lifsd" AS "vendor_lockout_status",
        "locco" AS "location_code",
        "loevm" AS "deletion_flag",
        "name3" AS "name_3",
        "name4" AS "customer_name_4",
        "niels" AS "nielsen_code",
        "ort02" AS "district",
        "pfach" AS "po_box",
        "pstl2" AS "district_code",
        "counc" AS "county_code",
        "cityc" AS "city_code",
        "rpmkr" AS "risk_profile_marker",
        "sperr" AS "blocking_indicator",
        "spras" AS "language_key",
        "stcd1" AS "tax_number_1",
        "stcd2" AS "tax_number_2",
        "stkza" AS "statistical_group",
        "stkzu" AS "sales_tax_liability",
        "telbx" AS "telebox_number",
        "telf2" AS "telephone_2",
        "teltx" AS "teletex_number",
        "telx1" AS "telex_number",
        "lzone" AS "transportation_zone",
        "xzemp" AS "central_payment_allowed",
        "vbund" AS "company_code",
        "stceg" AS "vat_number",
        "dear1" AS "address_form_1",
        "dear2" AS "address_form_2",
        "dear3" AS "address_form_3",
        "dear4" AS "address_form_4",
        "dear5" AS "address_form_5",
        "gform" AS "legal_form",
        "bran1" AS "industry_sector_1",
        "bran2" AS "industry_sector_2",
        "bran3" AS "industry_sector_3",
        "bran4" AS "branch_code_4",
        "bran5" AS "branch_code_5",
        "ekont" AS "purchasing_account",
        "umsat" AS "monthly_turnover",
        "umjah" AS "last_turnover_year",
        "uwaer" AS "currency_code",
        "jmzah" AS "last_dunning_number",
        "jmjah" AS "last_dunning_year",
        "katr1",
        "katr2",
        "katr3",
        "katr4",
        "katr5",
        "katr6" AS "customer_attribute_6",
        "katr7" AS "customer_attribute_7",
        "katr8" AS "custom_attribute_1",
        "katr9" AS "custom_attribute_2",
        "katr10" AS "customer_attribute_10",
        "stkzn" AS "natural_person_indicator",
        "umsa1" AS "annual_turnover",
        "txjcd" AS "tax_jurisdiction",
        "periv" AS "fiscal_year_variant",
        "abrvw" AS "communication_preference",
        "inspbydebi" AS "payment_instruction_key_alt",
        "inspatdebi" AS "payment_instruction_key",
        "ktocd" AS "account_code",
        "pfort" AS "po_box_city",
        "werks" AS "plant_code",
        "dtams" AS "data_medium_exchange",
        "dtaws" AS "data_transfer_method",
        "duefl" AS "due_diligence_flag",
        "hzuor" AS "dunning_level",
        "sperz" AS "central_blocking_indicator",
        "etikg" AS "delivery_priority",
        "civve" AS "civil_servant",
        "milve" AS "military_verification",
        "kdkg1",
        "kdkg2",
        "kdkg3",
        "kdkg4" AS "customer_group_4",
        "kdkg5" AS "customer_group_5",
        "xknza" AS "alternative_payee_allowed",
        "fityp" AS "tax_type",
        "stcdt" AS "tax_number_type",
        "stcd3" AS "tax_number_3",
        "stcd4" AS "tax_number_4",
        "stcd5" AS "tax_number_5",
        "xicms" AS "icms_tax_liable",
        "xxipi" AS "ipi_tax_liable",
        "xsubt" AS "subtotal_per_delivery",
        "cfopc" AS "financial_operations_center",
        "txlw1" AS "tax_law_classification",
        "txlw2" AS "tax_law_indicator",
        "ccc01" AS "customer_classification_1",
        "ccc02" AS "customer_classification_2",
        "ccc03" AS "customer_classification_3",
        "ccc04" AS "customer_classification_4",
        "cassd" AS "central_address_service",
        "knurl" AS "customer_url",
        "j_1kfrepre" AS "representative_name",
        "j_1kftbus" AS "business_type",
        "j_1kftind" AS "industry_category",
        "confs" AS "statement_confirmation",
        "updat" AS "last_update_date",
        "uptim" AS "last_update_time",
        "nodel" AS "delivery_block",
        "dear6" AS "address_form_6",
        "cvp_xblck" AS "vendor_master_block",
        "suframa" AS "suframa_number",
        "rg" AS "account_number_prefix",
        "exp" AS "export_indicator",
        "uf" AS "state_code",
        "rgdate" AS "registration_date",
        "ric" AS "risk_classification",
        "rne" AS "registration_number",
        "rnedate" AS "registration_number_date",
        "cnae" AS "economic_activity_classification",
        "legalnat" AS "legal_nature",
        "crtn" AS "certificate_registration_number",
        "icmstaxpay" AS "icms_taxpayer",
        "indtyp" AS "industry_type",
        "tdt" AS "transit_time",
        "comsize" AS "company_size",
        "decregpc" AS "decree_registration_code",
        "_vso_r_palhgt" AS "vso_palette_height",
        "_vso_r_pal_ul" AS "vso_palette_unit_load",
        "_vso_r_pk_mat" AS "vso_packing_material",
        "_vso_r_matpal" AS "vso_material_palette",
        "_vso_r_i_no_lyr" AS "vso_integer_value",
        "_vso_r_one_mat" AS "vso_one_material_flag",
        "_vso_r_one_sort" AS "vso_one_sort_flag",
        "_vso_r_uld_side" AS "vso_unload_side",
        "_vso_r_load_pref" AS "vso_loading_preference",
        "_vso_r_dpoint" AS "vso_data_point",
        "_xlso_customer" AS "xlso_customer_id",
        "_xlso_sysid" AS "xlso_system_id",
        "_xlso_client" AS "xlso_client_id",
        "_xlso_partner" AS "xlso_partner_id",
        "_xlso_pref_pay" AS "xlso_preferred_payment",
        "alc" AS "alcohol_info",
        "pmt_office" AS "payment_office",
        "fee_schedule",
        "duns",
        "duns4",
        "psofg" AS "sales_office",
        "psois" AS "sales_district",
        "pson1",
        "pson2",
        "pson3",
        "psovn" AS "customer_account_group",
        "psotl" AS "order_probability",
        "psohs" AS "sales_group",
        "psost" AS "statistics_group",
        "psoo1",
        "psoo2",
        "psoo3",
        "psoo4",
        "psoo5",
        "oidrc" AS "risk_category",
        "oid_poreqd" AS "one_time_customer",
        "oipbl" AS "payment_block",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_kna1_data_projected"
),

"sap_kna1_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- country_code: The problem is that the country codes are inconsistent and non-standard. 'PO' is not a standard ISO country code, 'UK' is often used but not the official ISO code, and 'USA' is the three-letter code instead of the two-letter code. The correct values should be ISO 3166-1 alpha-2 country codes. 'PO' likely stands for Poland, which should be 'PL'. 'UK' should be 'GB' (for Great Britain), and 'USA' should be 'US'. 
    -- postal_code: The problem is that '000001' is an unusual postal code format, as it's an all-zero code with leading zeros, which is atypical for most postal systems. The other two values ('18503' and 'NW1 6XE') appear to be valid postal codes for the US and UK respectively. Since '000001' is the most frequent value, it might be a placeholder or default value rather than a real postal code. The correct approach would be to replace it with an empty string to indicate missing data. 
    -- civil_servant: The problem is that the civil_servant column only contains the value 'X', which is ambiguous and doesn't clearly indicate civil servant status. Typically, a binary column like this should have clear 'Yes'/'No' or 'True'/'False' values. The correct values should be more explicit to indicate whether someone is a civil servant or not. 
    SELECT
        "customer_number",
        "client",
        CASE
            WHEN "country_code" = '''PO''' THEN '''PL'''
            WHEN "country_code" = '''UK''' THEN '''GB'''
            WHEN "country_code" = '''USA''' THEN '''US'''
            ELSE "country_code"
        END AS "country_code",
        "name_1",
        "name_2",
        "city",
        CASE
            WHEN "postal_code" = '''000001''' THEN ''''
            ELSE "postal_code"
        END AS "postal_code",
        "region",
        "customer_id",
        "street_address",
        "telephone_1",
        "fax_number",
        "one_time_customer_flag",
        "address_number",
        "search_term_1",
        "search_term_2",
        "search_term_3",
        "form_of_address",
        "order_block",
        "railway_station_name",
        "railway_station_code",
        "international_location_number",
        "location_number_check_digit",
        "authorization_group",
        "business_region_school",
        "company_code_indicator",
        "data_line_type",
        "creation_date",
        "creator_name",
        "credit_limit",
        "central_billing_block",
        "fiscal_number",
        "customer_category",
        "reference_number",
        "customer_classification",
        "ktokd",
        "customer_class",
        "vendor_number",
        "vendor_lockout_status",
        "location_code",
        "deletion_flag",
        "name_3",
        "customer_name_4",
        "nielsen_code",
        "district",
        "po_box",
        "district_code",
        "county_code",
        "city_code",
        "risk_profile_marker",
        "blocking_indicator",
        "language_key",
        "tax_number_1",
        "tax_number_2",
        "statistical_group",
        "sales_tax_liability",
        "telebox_number",
        "telephone_2",
        "teletex_number",
        "telex_number",
        "transportation_zone",
        "central_payment_allowed",
        "company_code",
        "vat_number",
        "address_form_1",
        "address_form_2",
        "address_form_3",
        "address_form_4",
        "address_form_5",
        "legal_form",
        "industry_sector_1",
        "industry_sector_2",
        "industry_sector_3",
        "branch_code_4",
        "branch_code_5",
        "purchasing_account",
        "monthly_turnover",
        "last_turnover_year",
        "currency_code",
        "last_dunning_number",
        "last_dunning_year",
        "katr1",
        "katr2",
        "katr3",
        "katr4",
        "katr5",
        "customer_attribute_6",
        "customer_attribute_7",
        "custom_attribute_1",
        "custom_attribute_2",
        "customer_attribute_10",
        "natural_person_indicator",
        "annual_turnover",
        "tax_jurisdiction",
        "fiscal_year_variant",
        "communication_preference",
        "payment_instruction_key_alt",
        "payment_instruction_key",
        "account_code",
        "po_box_city",
        "plant_code",
        "data_medium_exchange",
        "data_transfer_method",
        "due_diligence_flag",
        "dunning_level",
        "central_blocking_indicator",
        "delivery_priority",
        CASE
            WHEN "civil_servant" = '''X''' THEN '''Yes'''
            ELSE "civil_servant"
        END AS "civil_servant",
        "military_verification",
        "kdkg1",
        "kdkg2",
        "kdkg3",
        "customer_group_4",
        "customer_group_5",
        "alternative_payee_allowed",
        "tax_type",
        "tax_number_type",
        "tax_number_3",
        "tax_number_4",
        "tax_number_5",
        "icms_tax_liable",
        "ipi_tax_liable",
        "subtotal_per_delivery",
        "financial_operations_center",
        "tax_law_classification",
        "tax_law_indicator",
        "customer_classification_1",
        "customer_classification_2",
        "customer_classification_3",
        "customer_classification_4",
        "central_address_service",
        "customer_url",
        "representative_name",
        "business_type",
        "industry_category",
        "statement_confirmation",
        "last_update_date",
        "last_update_time",
        "delivery_block",
        "address_form_6",
        "vendor_master_block",
        "suframa_number",
        "account_number_prefix",
        "export_indicator",
        "state_code",
        "registration_date",
        "risk_classification",
        "registration_number",
        "registration_number_date",
        "economic_activity_classification",
        "legal_nature",
        "certificate_registration_number",
        "icms_taxpayer",
        "industry_type",
        "transit_time",
        "company_size",
        "decree_registration_code",
        "vso_palette_height",
        "vso_palette_unit_load",
        "vso_packing_material",
        "vso_material_palette",
        "vso_integer_value",
        "vso_one_material_flag",
        "vso_one_sort_flag",
        "vso_unload_side",
        "vso_loading_preference",
        "vso_data_point",
        "xlso_customer_id",
        "xlso_system_id",
        "xlso_client_id",
        "xlso_partner_id",
        "xlso_preferred_payment",
        "alcohol_info",
        "payment_office",
        "fee_schedule",
        "duns",
        "duns4",
        "sales_office",
        "sales_district",
        "pson1",
        "pson2",
        "pson3",
        "customer_account_group",
        "order_probability",
        "sales_group",
        "statistics_group",
        "psoo1",
        "psoo2",
        "psoo3",
        "psoo4",
        "psoo5",
        "risk_category",
        "one_time_customer",
        "payment_block",
        "row_id",
        "is_deleted"
    FROM "sap_kna1_data_projected_renamed"
),

"sap_kna1_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_code: from DECIMAL to VARCHAR
    -- account_number_prefix: from DECIMAL to VARCHAR
    -- address_form_1: from DECIMAL to VARCHAR
    -- address_form_2: from DECIMAL to VARCHAR
    -- address_form_3: from DECIMAL to VARCHAR
    -- address_form_4: from DECIMAL to VARCHAR
    -- address_form_5: from DECIMAL to VARCHAR
    -- address_form_6: from DECIMAL to VARCHAR
    -- address_number: from INT to VARCHAR
    -- alcohol_info: from DECIMAL to VARCHAR
    -- alternative_payee_allowed: from DECIMAL to VARCHAR
    -- authorization_group: from DECIMAL to VARCHAR
    -- blocking_indicator: from DECIMAL to VARCHAR
    -- branch_code_4: from DECIMAL to VARCHAR
    -- branch_code_5: from DECIMAL to VARCHAR
    -- business_region_school: from DECIMAL to VARCHAR
    -- business_type: from DECIMAL to VARCHAR
    -- central_address_service: from DECIMAL to VARCHAR
    -- central_billing_block: from DECIMAL to VARCHAR
    -- central_blocking_indicator: from DECIMAL to VARCHAR
    -- central_payment_allowed: from DECIMAL to VARCHAR
    -- certificate_registration_number: from DECIMAL to VARCHAR
    -- city_code: from DECIMAL to VARCHAR
    -- client: from INT to VARCHAR
    -- communication_preference: from DECIMAL to VARCHAR
    -- company_code: from DECIMAL to VARCHAR
    -- company_code_indicator: from INT to VARCHAR
    -- company_size: from DECIMAL to VARCHAR
    -- county_code: from DECIMAL to VARCHAR
    -- creation_date: from INT to DATE
    -- currency_code: from DECIMAL to VARCHAR
    -- custom_attribute_1: from DECIMAL to VARCHAR
    -- custom_attribute_2: from DECIMAL to VARCHAR
    -- customer_account_group: from DECIMAL to VARCHAR
    -- customer_attribute_10: from DECIMAL to VARCHAR
    -- customer_attribute_6: from DECIMAL to VARCHAR
    -- customer_attribute_7: from DECIMAL to VARCHAR
    -- customer_category: from DECIMAL to VARCHAR
    -- customer_class: from DECIMAL to VARCHAR
    -- customer_classification: from DECIMAL to VARCHAR
    -- customer_classification_1: from DECIMAL to VARCHAR
    -- customer_classification_2: from DECIMAL to VARCHAR
    -- customer_classification_3: from DECIMAL to VARCHAR
    -- customer_classification_4: from DECIMAL to VARCHAR
    -- customer_group_4: from DECIMAL to VARCHAR
    -- customer_group_5: from DECIMAL to VARCHAR
    -- customer_name_4: from DECIMAL to VARCHAR
    -- customer_url: from DECIMAL to VARCHAR
    -- data_line_type: from DECIMAL to VARCHAR
    -- data_medium_exchange: from DECIMAL to VARCHAR
    -- data_transfer_method: from DECIMAL to VARCHAR
    -- decree_registration_code: from DECIMAL to VARCHAR
    -- deletion_flag: from DECIMAL to VARCHAR
    -- delivery_block: from DECIMAL to VARCHAR
    -- delivery_priority: from DECIMAL to VARCHAR
    -- district: from DECIMAL to VARCHAR
    -- district_code: from DECIMAL to VARCHAR
    -- duns: from DECIMAL to VARCHAR
    -- duns4: from DECIMAL to VARCHAR
    -- economic_activity_classification: from DECIMAL to VARCHAR
    -- export_indicator: from DECIMAL to VARCHAR
    -- fax_number: from DECIMAL to VARCHAR
    -- fee_schedule: from DECIMAL to VARCHAR
    -- financial_operations_center: from DECIMAL to VARCHAR
    -- fiscal_number: from DECIMAL to VARCHAR
    -- fiscal_year_variant: from DECIMAL to VARCHAR
    -- form_of_address: from DECIMAL to VARCHAR
    -- icms_tax_liable: from DECIMAL to VARCHAR
    -- icms_taxpayer: from DECIMAL to VARCHAR
    -- industry_category: from DECIMAL to VARCHAR
    -- industry_sector_1: from DECIMAL to VARCHAR
    -- industry_sector_2: from DECIMAL to VARCHAR
    -- industry_sector_3: from DECIMAL to VARCHAR
    -- industry_type: from DECIMAL to VARCHAR
    -- ipi_tax_liable: from DECIMAL to VARCHAR
    -- katr1: from DECIMAL to VARCHAR
    -- katr2: from DECIMAL to VARCHAR
    -- katr3: from DECIMAL to VARCHAR
    -- katr4: from DECIMAL to VARCHAR
    -- katr5: from DECIMAL to VARCHAR
    -- kdkg1: from DECIMAL to VARCHAR
    -- kdkg2: from DECIMAL to VARCHAR
    -- kdkg3: from DECIMAL to VARCHAR
    -- language_key: from INT to VARCHAR
    -- legal_form: from DECIMAL to VARCHAR
    -- location_code: from DECIMAL to VARCHAR
    -- military_verification: from DECIMAL to VARCHAR
    -- name_2: from DECIMAL to VARCHAR
    -- name_3: from DECIMAL to VARCHAR
    -- natural_person_indicator: from DECIMAL to VARCHAR
    -- nielsen_code: from DECIMAL to VARCHAR
    -- one_time_customer: from DECIMAL to VARCHAR
    -- one_time_customer_flag: from DECIMAL to VARCHAR
    -- order_block: from DECIMAL to VARCHAR
    -- order_probability: from DECIMAL to VARCHAR
    -- payment_block: from DECIMAL to VARCHAR
    -- payment_instruction_key: from DECIMAL to VARCHAR
    -- payment_instruction_key_alt: from DECIMAL to VARCHAR
    -- payment_office: from DECIMAL to VARCHAR
    -- plant_code: from DECIMAL to VARCHAR
    -- po_box: from DECIMAL to VARCHAR
    -- po_box_city: from DECIMAL to VARCHAR
    -- pson1: from DECIMAL to VARCHAR
    -- pson2: from DECIMAL to VARCHAR
    -- pson3: from DECIMAL to VARCHAR
    -- psoo1: from DECIMAL to VARCHAR
    -- psoo2: from DECIMAL to VARCHAR
    -- psoo3: from DECIMAL to VARCHAR
    -- psoo4: from DECIMAL to VARCHAR
    -- psoo5: from DECIMAL to VARCHAR
    -- purchasing_account: from DECIMAL to VARCHAR
    -- railway_station_code: from DECIMAL to VARCHAR
    -- railway_station_name: from DECIMAL to VARCHAR
    -- reference_number: from DECIMAL to VARCHAR
    -- region: from INT to VARCHAR
    -- registration_number: from DECIMAL to VARCHAR
    -- representative_name: from DECIMAL to VARCHAR
    -- risk_category: from DECIMAL to VARCHAR
    -- risk_profile_marker: from DECIMAL to VARCHAR
    -- sales_district: from DECIMAL to VARCHAR
    -- sales_group: from DECIMAL to VARCHAR
    -- sales_office: from DECIMAL to VARCHAR
    -- sales_tax_liability: from DECIMAL to VARCHAR
    -- search_term_2: from DECIMAL to VARCHAR
    -- state_code: from DECIMAL to VARCHAR
    -- statement_confirmation: from DECIMAL to VARCHAR
    -- statistical_group: from DECIMAL to VARCHAR
    -- statistics_group: from DECIMAL to VARCHAR
    -- suframa_number: from DECIMAL to VARCHAR
    -- tax_jurisdiction: from DECIMAL to VARCHAR
    -- tax_law_classification: from DECIMAL to VARCHAR
    -- tax_law_indicator: from DECIMAL to VARCHAR
    -- tax_number_1: from DECIMAL to VARCHAR
    -- tax_number_2: from DECIMAL to VARCHAR
    -- tax_number_3: from DECIMAL to VARCHAR
    -- tax_number_4: from DECIMAL to VARCHAR
    -- tax_number_5: from DECIMAL to VARCHAR
    -- tax_number_type: from DECIMAL to VARCHAR
    -- tax_type: from DECIMAL to VARCHAR
    -- telebox_number: from DECIMAL to VARCHAR
    -- telephone_1: from DECIMAL to VARCHAR
    -- telephone_2: from DECIMAL to VARCHAR
    -- teletex_number: from DECIMAL to VARCHAR
    -- telex_number: from DECIMAL to VARCHAR
    -- transit_time: from DECIMAL to INT
    -- transportation_zone: from DECIMAL to VARCHAR
    -- vat_number: from DECIMAL to VARCHAR
    -- vendor_lockout_status: from DECIMAL to VARCHAR
    -- vendor_master_block: from DECIMAL to VARCHAR
    -- vendor_number: from DECIMAL to VARCHAR
    -- vso_data_point: from DECIMAL to VARCHAR
    -- vso_material_palette: from DECIMAL to VARCHAR
    -- vso_one_material_flag: from DECIMAL to VARCHAR
    -- vso_one_sort_flag: from DECIMAL to VARCHAR
    -- vso_packing_material: from DECIMAL to VARCHAR
    -- vso_palette_unit_load: from DECIMAL to VARCHAR
    -- xlso_client_id: from DECIMAL to VARCHAR
    -- xlso_customer_id: from DECIMAL to VARCHAR
    -- xlso_partner_id: from DECIMAL to VARCHAR
    -- xlso_preferred_payment: from DECIMAL to VARCHAR
    -- xlso_system_id: from DECIMAL to VARCHAR
    SELECT
        "customer_number",
        "country_code",
        "name_1",
        "city",
        "postal_code",
        "customer_id",
        "street_address",
        "search_term_1",
        "search_term_3",
        "international_location_number",
        "location_number_check_digit",
        "creator_name",
        "credit_limit",
        "ktokd",
        "monthly_turnover",
        "last_turnover_year",
        "last_dunning_number",
        "last_dunning_year",
        "annual_turnover",
        "due_diligence_flag",
        "dunning_level",
        "civil_servant",
        "subtotal_per_delivery",
        "last_update_date",
        "last_update_time",
        "registration_date",
        "risk_classification",
        "registration_number_date",
        "legal_nature",
        "vso_palette_height",
        "vso_integer_value",
        "vso_unload_side",
        "vso_loading_preference",
        "row_id",
        "is_deleted",
        CAST("account_code" AS VARCHAR) AS "account_code",
        CAST("account_number_prefix" AS VARCHAR) AS "account_number_prefix",
        CAST("address_form_1" AS VARCHAR) AS "address_form_1",
        CAST("address_form_2" AS VARCHAR) AS "address_form_2",
        CAST("address_form_3" AS VARCHAR) AS "address_form_3",
        CAST("address_form_4" AS VARCHAR) AS "address_form_4",
        CAST("address_form_5" AS VARCHAR) AS "address_form_5",
        CAST("address_form_6" AS VARCHAR) AS "address_form_6",
        CAST("address_number" AS VARCHAR) AS "address_number",
        CAST("alcohol_info" AS VARCHAR) AS "alcohol_info",
        CAST("alternative_payee_allowed" AS VARCHAR) AS "alternative_payee_allowed",
        CAST("authorization_group" AS VARCHAR) AS "authorization_group",
        CAST("blocking_indicator" AS VARCHAR) AS "blocking_indicator",
        CAST("branch_code_4" AS VARCHAR) AS "branch_code_4",
        CAST("branch_code_5" AS VARCHAR) AS "branch_code_5",
        CAST("business_region_school" AS VARCHAR) AS "business_region_school",
        CAST("business_type" AS VARCHAR) AS "business_type",
        CAST("central_address_service" AS VARCHAR) AS "central_address_service",
        CAST("central_billing_block" AS VARCHAR) AS "central_billing_block",
        CAST("central_blocking_indicator" AS VARCHAR) AS "central_blocking_indicator",
        CAST("central_payment_allowed" AS VARCHAR) AS "central_payment_allowed",
        CAST("certificate_registration_number" AS VARCHAR) AS "certificate_registration_number",
        CAST("city_code" AS VARCHAR) AS "city_code",
        CAST("client" AS VARCHAR) AS "client",
        CAST("communication_preference" AS VARCHAR) AS "communication_preference",
        CAST("company_code" AS VARCHAR) AS "company_code",
        CAST("company_code_indicator" AS VARCHAR) AS "company_code_indicator",
        CAST("company_size" AS VARCHAR) AS "company_size",
        CAST("county_code" AS VARCHAR) AS "county_code",
        strptime(CAST("creation_date" AS VARCHAR), '%Y%m%d') AS "creation_date",
        CAST("currency_code" AS VARCHAR) AS "currency_code",
        CAST("custom_attribute_1" AS VARCHAR) AS "custom_attribute_1",
        CAST("custom_attribute_2" AS VARCHAR) AS "custom_attribute_2",
        CAST("customer_account_group" AS VARCHAR) AS "customer_account_group",
        CAST("customer_attribute_10" AS VARCHAR) AS "customer_attribute_10",
        CAST("customer_attribute_6" AS VARCHAR) AS "customer_attribute_6",
        CAST("customer_attribute_7" AS VARCHAR) AS "customer_attribute_7",
        CAST("customer_category" AS VARCHAR) AS "customer_category",
        CAST("customer_class" AS VARCHAR) AS "customer_class",
        CAST("customer_classification" AS VARCHAR) AS "customer_classification",
        CAST("customer_classification_1" AS VARCHAR) AS "customer_classification_1",
        CAST("customer_classification_2" AS VARCHAR) AS "customer_classification_2",
        CAST("customer_classification_3" AS VARCHAR) AS "customer_classification_3",
        CAST("customer_classification_4" AS VARCHAR) AS "customer_classification_4",
        CAST("customer_group_4" AS VARCHAR) AS "customer_group_4",
        CAST("customer_group_5" AS VARCHAR) AS "customer_group_5",
        CAST("customer_name_4" AS VARCHAR) AS "customer_name_4",
        CAST("customer_url" AS VARCHAR) AS "customer_url",
        CAST("data_line_type" AS VARCHAR) AS "data_line_type",
        CAST("data_medium_exchange" AS VARCHAR) AS "data_medium_exchange",
        CAST("data_transfer_method" AS VARCHAR) AS "data_transfer_method",
        CAST("decree_registration_code" AS VARCHAR) AS "decree_registration_code",
        CAST("deletion_flag" AS VARCHAR) AS "deletion_flag",
        CAST("delivery_block" AS VARCHAR) AS "delivery_block",
        CAST("delivery_priority" AS VARCHAR) AS "delivery_priority",
        CAST("district" AS VARCHAR) AS "district",
        CAST("district_code" AS VARCHAR) AS "district_code",
        CAST("duns" AS VARCHAR) AS "duns",
        CAST("duns4" AS VARCHAR) AS "duns4",
        CAST("economic_activity_classification" AS VARCHAR) AS "economic_activity_classification",
        CAST("export_indicator" AS VARCHAR) AS "export_indicator",
        CAST("fax_number" AS VARCHAR) AS "fax_number",
        CAST("fee_schedule" AS VARCHAR) AS "fee_schedule",
        CAST("financial_operations_center" AS VARCHAR) AS "financial_operations_center",
        CAST("fiscal_number" AS VARCHAR) AS "fiscal_number",
        CAST("fiscal_year_variant" AS VARCHAR) AS "fiscal_year_variant",
        CAST("form_of_address" AS VARCHAR) AS "form_of_address",
        CAST("icms_tax_liable" AS VARCHAR) AS "icms_tax_liable",
        CAST("icms_taxpayer" AS VARCHAR) AS "icms_taxpayer",
        CAST("industry_category" AS VARCHAR) AS "industry_category",
        CAST("industry_sector_1" AS VARCHAR) AS "industry_sector_1",
        CAST("industry_sector_2" AS VARCHAR) AS "industry_sector_2",
        CAST("industry_sector_3" AS VARCHAR) AS "industry_sector_3",
        CAST("industry_type" AS VARCHAR) AS "industry_type",
        CAST("ipi_tax_liable" AS VARCHAR) AS "ipi_tax_liable",
        CAST("katr1" AS VARCHAR) AS "katr1",
        CAST("katr2" AS VARCHAR) AS "katr2",
        CAST("katr3" AS VARCHAR) AS "katr3",
        CAST("katr4" AS VARCHAR) AS "katr4",
        CAST("katr5" AS VARCHAR) AS "katr5",
        CAST("kdkg1" AS VARCHAR) AS "kdkg1",
        CAST("kdkg2" AS VARCHAR) AS "kdkg2",
        CAST("kdkg3" AS VARCHAR) AS "kdkg3",
        CAST("language_key" AS VARCHAR) AS "language_key",
        CAST("legal_form" AS VARCHAR) AS "legal_form",
        CAST("location_code" AS VARCHAR) AS "location_code",
        CAST("military_verification" AS VARCHAR) AS "military_verification",
        CAST("name_2" AS VARCHAR) AS "name_2",
        CAST("name_3" AS VARCHAR) AS "name_3",
        CAST("natural_person_indicator" AS VARCHAR) AS "natural_person_indicator",
        CAST("nielsen_code" AS VARCHAR) AS "nielsen_code",
        CAST("one_time_customer" AS VARCHAR) AS "one_time_customer",
        CAST("one_time_customer_flag" AS VARCHAR) AS "one_time_customer_flag",
        CAST("order_block" AS VARCHAR) AS "order_block",
        CAST("order_probability" AS VARCHAR) AS "order_probability",
        CAST("payment_block" AS VARCHAR) AS "payment_block",
        CAST("payment_instruction_key" AS VARCHAR) AS "payment_instruction_key",
        CAST("payment_instruction_key_alt" AS VARCHAR) AS "payment_instruction_key_alt",
        CAST("payment_office" AS VARCHAR) AS "payment_office",
        CAST("plant_code" AS VARCHAR) AS "plant_code",
        CAST("po_box" AS VARCHAR) AS "po_box",
        CAST("po_box_city" AS VARCHAR) AS "po_box_city",
        CAST("pson1" AS VARCHAR) AS "pson1",
        CAST("pson2" AS VARCHAR) AS "pson2",
        CAST("pson3" AS VARCHAR) AS "pson3",
        CAST("psoo1" AS VARCHAR) AS "psoo1",
        CAST("psoo2" AS VARCHAR) AS "psoo2",
        CAST("psoo3" AS VARCHAR) AS "psoo3",
        CAST("psoo4" AS VARCHAR) AS "psoo4",
        CAST("psoo5" AS VARCHAR) AS "psoo5",
        CAST("purchasing_account" AS VARCHAR) AS "purchasing_account",
        CAST("railway_station_code" AS VARCHAR) AS "railway_station_code",
        CAST("railway_station_name" AS VARCHAR) AS "railway_station_name",
        CAST("reference_number" AS VARCHAR) AS "reference_number",
        CAST("region" AS VARCHAR) AS "region",
        CAST("registration_number" AS VARCHAR) AS "registration_number",
        CAST("representative_name" AS VARCHAR) AS "representative_name",
        CAST("risk_category" AS VARCHAR) AS "risk_category",
        CAST("risk_profile_marker" AS VARCHAR) AS "risk_profile_marker",
        CAST("sales_district" AS VARCHAR) AS "sales_district",
        CAST("sales_group" AS VARCHAR) AS "sales_group",
        CAST("sales_office" AS VARCHAR) AS "sales_office",
        CAST("sales_tax_liability" AS VARCHAR) AS "sales_tax_liability",
        CAST("search_term_2" AS VARCHAR) AS "search_term_2",
        CAST("state_code" AS VARCHAR) AS "state_code",
        CAST("statement_confirmation" AS VARCHAR) AS "statement_confirmation",
        CAST("statistical_group" AS VARCHAR) AS "statistical_group",
        CAST("statistics_group" AS VARCHAR) AS "statistics_group",
        CAST("suframa_number" AS VARCHAR) AS "suframa_number",
        CAST("tax_jurisdiction" AS VARCHAR) AS "tax_jurisdiction",
        CAST("tax_law_classification" AS VARCHAR) AS "tax_law_classification",
        CAST("tax_law_indicator" AS VARCHAR) AS "tax_law_indicator",
        CAST("tax_number_1" AS VARCHAR) AS "tax_number_1",
        CAST("tax_number_2" AS VARCHAR) AS "tax_number_2",
        CAST("tax_number_3" AS VARCHAR) AS "tax_number_3",
        CAST("tax_number_4" AS VARCHAR) AS "tax_number_4",
        CAST("tax_number_5" AS VARCHAR) AS "tax_number_5",
        CAST("tax_number_type" AS VARCHAR) AS "tax_number_type",
        CAST("tax_type" AS VARCHAR) AS "tax_type",
        CAST("telebox_number" AS VARCHAR) AS "telebox_number",
        CAST("telephone_1" AS VARCHAR) AS "telephone_1",
        CAST("telephone_2" AS VARCHAR) AS "telephone_2",
        CAST("teletex_number" AS VARCHAR) AS "teletex_number",
        CAST("telex_number" AS VARCHAR) AS "telex_number",
        CAST("transit_time" AS INT) AS "transit_time",
        CAST("transportation_zone" AS VARCHAR) AS "transportation_zone",
        CAST("vat_number" AS VARCHAR) AS "vat_number",
        CAST("vendor_lockout_status" AS VARCHAR) AS "vendor_lockout_status",
        CAST("vendor_master_block" AS VARCHAR) AS "vendor_master_block",
        CAST("vendor_number" AS VARCHAR) AS "vendor_number",
        CAST("vso_data_point" AS VARCHAR) AS "vso_data_point",
        CAST("vso_material_palette" AS VARCHAR) AS "vso_material_palette",
        CAST("vso_one_material_flag" AS VARCHAR) AS "vso_one_material_flag",
        CAST("vso_one_sort_flag" AS VARCHAR) AS "vso_one_sort_flag",
        CAST("vso_packing_material" AS VARCHAR) AS "vso_packing_material",
        CAST("vso_palette_unit_load" AS VARCHAR) AS "vso_palette_unit_load",
        CAST("xlso_client_id" AS VARCHAR) AS "xlso_client_id",
        CAST("xlso_customer_id" AS VARCHAR) AS "xlso_customer_id",
        CAST("xlso_partner_id" AS VARCHAR) AS "xlso_partner_id",
        CAST("xlso_preferred_payment" AS VARCHAR) AS "xlso_preferred_payment",
        CAST("xlso_system_id" AS VARCHAR) AS "xlso_system_id"
    FROM "sap_kna1_data_projected_renamed_cleaned"
),

"sap_kna1_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 135 columns with unacceptable missing values
    -- account_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_number_prefix has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_form_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_form_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_form_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_form_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_form_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_form_6 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- alternative_payee_allowed has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- authorization_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- blocking_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- branch_code_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- branch_code_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- central_address_service has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- central_blocking_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- city_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- communication_preference has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- county_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- credit_limit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- currency_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_attribute_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- custom_attribute_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_account_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_attribute_10 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_attribute_6 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_attribute_7 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_class has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_classification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_classification_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_classification_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_classification_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_classification_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_group_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_group_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_name_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_line_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_medium_exchange has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- data_transfer_method has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- decree_registration_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- deletion_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- delivery_block has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- delivery_priority has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- district has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- district_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- duns has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- duns4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- economic_activity_classification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- export_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fax_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fee_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- financial_operations_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fiscal_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fiscal_year_variant has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- form_of_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- icms_tax_liable has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- icms_taxpayer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_sector_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_sector_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_sector_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ipi_tax_liable has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- katr1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- katr2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- katr3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- katr4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- katr5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- kdkg1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- kdkg2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- kdkg3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legal_form has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- location_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- military_verification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- name_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- name_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- natural_person_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- nielsen_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- order_block has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- order_probability has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_block has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_instruction_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_instruction_key_alt has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_office has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- plant_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pson1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pson2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pson3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psoo1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psoo2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psoo3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psoo4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- psoo5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchasing_account has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- reference_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- registration_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- representative_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- risk_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- risk_profile_marker has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_district has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_office has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_tax_liability has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- search_term_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statement_confirmation has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statistical_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statistics_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- subtotal_per_delivery has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_jurisdiction has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_law_classification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_law_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_3 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_4 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_5 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_number_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- telebox_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- telephone_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- telephone_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- teletex_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- telex_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transit_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transportation_zone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vendor_lockout_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vendor_master_block has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xlso_client_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xlso_customer_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xlso_partner_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xlso_preferred_payment has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- xlso_system_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "customer_number",
        "country_code",
        "name_1",
        "city",
        "postal_code",
        "customer_id",
        "street_address",
        "search_term_1",
        "search_term_3",
        "international_location_number",
        "location_number_check_digit",
        "creator_name",
        "ktokd",
        "monthly_turnover",
        "last_turnover_year",
        "last_dunning_number",
        "last_dunning_year",
        "annual_turnover",
        "due_diligence_flag",
        "dunning_level",
        "civil_servant",
        "last_update_date",
        "last_update_time",
        "registration_date",
        "risk_classification",
        "registration_number_date",
        "legal_nature",
        "vso_palette_height",
        "vso_integer_value",
        "vso_unload_side",
        "vso_loading_preference",
        "row_id",
        "is_deleted",
        "address_number",
        "alcohol_info",
        "business_region_school",
        "central_billing_block",
        "central_payment_allowed",
        "certificate_registration_number",
        "client",
        "company_code",
        "company_code_indicator",
        "company_size",
        "creation_date",
        "language_key",
        "one_time_customer",
        "one_time_customer_flag",
        "po_box",
        "po_box_city",
        "railway_station_code",
        "railway_station_name",
        "region",
        "suframa_number",
        "vat_number",
        "vendor_number",
        "vso_data_point",
        "vso_material_palette",
        "vso_one_material_flag",
        "vso_one_sort_flag",
        "vso_packing_material",
        "vso_palette_unit_load"
    FROM "sap_kna1_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_kna1_data_projected_renamed_cleaned_casted_missing_handled"