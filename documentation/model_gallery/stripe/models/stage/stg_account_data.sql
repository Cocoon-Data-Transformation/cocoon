-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"account_data_projected" AS (
    -- Projection: Selecting 110 out of 111 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "business_profile_mcc",
        "business_profile_name",
        "business_profile_product_description",
        "business_profile_support_address_city",
        "business_profile_support_address_country",
        "business_profile_support_address_line_1",
        "business_profile_support_address_line_2",
        "business_profile_support_address_postal_code",
        "business_profile_support_address_state",
        "business_profile_support_email",
        "business_profile_support_phone",
        "business_profile_support_url",
        "business_profile_url",
        "business_type",
        "capabilities_afterpay_clearpay_payments",
        "capabilities_au_becs_debit_payments",
        "capabilities_bacs_debit_payments",
        "capabilities_bancontact_payments",
        "capabilities_card_issuing",
        "capabilities_card_payments",
        "capabilities_cartes_bancaires_payments",
        "capabilities_eps_payments",
        "capabilities_fpx_payments",
        "capabilities_giropay_payments",
        "capabilities_grabpay_payments",
        "capabilities_ideal_payments",
        "capabilities_jcb_payments",
        "capabilities_legacy_payments",
        "capabilities_oxxo_payments",
        "capabilities_p_24_payments",
        "capabilities_platform_payments",
        "capabilities_sepa_debit_payments",
        "capabilities_sofort_payments",
        "capabilities_tax_reporting_us_1099_k",
        "capabilities_tax_reporting_us_1099_misc",
        "capabilities_transfers",
        "charges_enabled",
        "company_address_city",
        "company_address_country",
        "company_address_kana_city",
        "company_address_kana_country",
        "company_address_kana_line_1",
        "company_address_kana_line_2",
        "company_address_kana_postal_code",
        "company_address_kana_state",
        "company_address_kana_town",
        "company_address_kanji_city",
        "company_address_kanji_country",
        "company_address_kanji_line_1",
        "company_address_kanji_line_2",
        "company_address_kanji_postal_code",
        "company_address_kanji_state",
        "company_address_kanji_town",
        "company_address_line_1",
        "company_address_line_2",
        "company_address_postal_code",
        "company_address_state",
        "company_directors_provided",
        "company_executives_provided",
        "company_name",
        "company_name_kana",
        "company_name_kanji",
        "company_owners_provided",
        "company_phone",
        "company_structure",
        "company_tax_id_provided",
        "company_tax_id_registrar",
        "company_vat_id_provided",
        "company_verification_document_back",
        "company_verification_document_details",
        "company_verification_document_details_code",
        "company_verification_document_front",
        "country",
        "created",
        "default_currency",
        "details_submitted",
        "email",
        "individual_id",
        "is_deleted",
        "metadata",
        "payouts_enabled",
        "requirements_current_deadline",
        "requirements_currently_due",
        "requirements_disabled_reason",
        "requirements_errors",
        "requirements_eventually_due",
        "requirements_past_due",
        "requirements_pending_verification",
        "settings_branding_icon",
        "settings_branding_logo",
        "settings_branding_primary_color",
        "settings_card_payments_decline_on_avs_failure",
        "settings_card_payments_decline_on_cvc_failure",
        "settings_card_payments_statement_descriptor_prefix",
        "settings_dashboard_display_name",
        "settings_dashboard_timezone",
        "settings_payments_statement_descriptor",
        "settings_payments_statement_descriptor_kana",
        "settings_payments_statement_descriptor_kanji",
        "settings_payouts_debit_negative_balances",
        "settings_payouts_schedule_delay_days",
        "settings_payouts_schedule_interval",
        "settings_payouts_schedule_monthly_anchor",
        "settings_payouts_schedule_weekly_anchor",
        "settings_payouts_statement_descriptor",
        "tos_acceptance_date",
        "tos_acceptance_ip",
        "tos_acceptance_user_agent",
        "type"
    FROM "account_data"
),

"account_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> account_id
    -- business_profile_mcc -> merchant_category_code
    -- business_profile_name -> business_name
    -- business_profile_product_description -> product_description
    -- business_profile_support_address_city -> support_city
    -- business_profile_support_address_country -> support_country
    -- business_profile_support_address_line_1 -> support_address_line1
    -- business_profile_support_address_line_2 -> support_address_line2
    -- business_profile_support_address_postal_code -> support_postal_code
    -- business_profile_support_address_state -> support_state
    -- business_profile_support_email -> support_email
    -- business_profile_support_phone -> support_phone
    -- business_profile_support_url -> support_url
    -- business_profile_url -> business_url
    -- capabilities_afterpay_clearpay_payments -> afterpay_clearpay_status
    -- capabilities_au_becs_debit_payments -> au_becs_debit_status
    -- capabilities_bacs_debit_payments -> bacs_debit_status
    -- capabilities_bancontact_payments -> bancontact_status
    -- capabilities_card_issuing -> card_issuing_status
    -- capabilities_card_payments -> card_payments_status
    -- capabilities_cartes_bancaires_payments -> cartes_bancaires_status
    -- capabilities_eps_payments -> eps_status
    -- capabilities_fpx_payments -> fpx_status
    -- capabilities_giropay_payments -> giropay_status
    -- capabilities_grabpay_payments -> grabpay_status
    -- capabilities_ideal_payments -> ideal_status
    -- capabilities_jcb_payments -> jcb_status
    -- capabilities_legacy_payments -> legacy_payments_status
    -- capabilities_oxxo_payments -> oxxo_status
    -- capabilities_p_24_payments -> p24_status
    -- capabilities_platform_payments -> platform_payments_status
    -- capabilities_sepa_debit_payments -> sepa_debit_payments_status
    -- capabilities_sofort_payments -> sofort_payments_status
    -- capabilities_tax_reporting_us_1099_k -> tax_reporting_1099k_status
    -- capabilities_tax_reporting_us_1099_misc -> tax_reporting_1099misc_status
    -- capabilities_transfers -> transfers_status
    -- company_owners_provided -> owners_info_provided
    -- company_phone -> business_phone
    -- company_structure -> legal_structure
    -- company_tax_id_provided -> tax_id_provided
    -- company_tax_id_registrar -> tax_id_issuer
    -- company_vat_id_provided -> vat_id_provided
    -- company_verification_document_back -> verification_doc_back
    -- company_verification_document_details -> verification_doc_details
    -- company_verification_document_details_code -> verification_doc_code
    -- company_verification_document_front -> verification_doc_front
    -- created -> account_creation_date
    -- email -> account_email
    -- requirements_current_deadline -> current_requirements_deadline
    -- requirements_currently_due -> current_requirements
    -- requirements_errors -> requirement_errors
    -- requirements_eventually_due -> future_requirements
    -- requirements_past_due -> past_due_requirements
    -- requirements_pending_verification -> pending_verification
    -- settings_branding_icon -> branding_icon
    -- settings_branding_logo -> branding_logo_file_id
    -- settings_branding_primary_color -> branding_primary_color
    -- settings_card_payments_decline_on_avs_failure -> decline_on_avs_failure
    -- settings_card_payments_decline_on_cvc_failure -> decline_on_cvc_failure
    -- settings_card_payments_statement_descriptor_prefix -> statement_descriptor_prefix
    -- settings_dashboard_display_name -> dashboard_display_name
    -- settings_dashboard_timezone -> dashboard_timezone
    -- settings_payments_statement_descriptor -> payment_statement_descriptor
    -- settings_payments_statement_descriptor_kana -> payment_statement_descriptor_kana
    -- settings_payments_statement_descriptor_kanji -> payment_statement_descriptor_kanji
    -- settings_payouts_debit_negative_balances -> debit_negative_balances
    -- settings_payouts_schedule_delay_days -> payout_delay_days
    -- settings_payouts_schedule_interval -> payout_schedule_interval
    -- settings_payouts_schedule_monthly_anchor -> payout_monthly_anchor
    -- settings_payouts_schedule_weekly_anchor -> payout_weekly_anchor
    -- settings_payouts_statement_descriptor -> payout_statement_descriptor
    -- type -> account_type
    SELECT 
        "id" AS "account_id",
        "business_profile_mcc" AS "merchant_category_code",
        "business_profile_name" AS "business_name",
        "business_profile_product_description" AS "product_description",
        "business_profile_support_address_city" AS "support_city",
        "business_profile_support_address_country" AS "support_country",
        "business_profile_support_address_line_1" AS "support_address_line1",
        "business_profile_support_address_line_2" AS "support_address_line2",
        "business_profile_support_address_postal_code" AS "support_postal_code",
        "business_profile_support_address_state" AS "support_state",
        "business_profile_support_email" AS "support_email",
        "business_profile_support_phone" AS "support_phone",
        "business_profile_support_url" AS "support_url",
        "business_profile_url" AS "business_url",
        "business_type",
        "capabilities_afterpay_clearpay_payments" AS "afterpay_clearpay_status",
        "capabilities_au_becs_debit_payments" AS "au_becs_debit_status",
        "capabilities_bacs_debit_payments" AS "bacs_debit_status",
        "capabilities_bancontact_payments" AS "bancontact_status",
        "capabilities_card_issuing" AS "card_issuing_status",
        "capabilities_card_payments" AS "card_payments_status",
        "capabilities_cartes_bancaires_payments" AS "cartes_bancaires_status",
        "capabilities_eps_payments" AS "eps_status",
        "capabilities_fpx_payments" AS "fpx_status",
        "capabilities_giropay_payments" AS "giropay_status",
        "capabilities_grabpay_payments" AS "grabpay_status",
        "capabilities_ideal_payments" AS "ideal_status",
        "capabilities_jcb_payments" AS "jcb_status",
        "capabilities_legacy_payments" AS "legacy_payments_status",
        "capabilities_oxxo_payments" AS "oxxo_status",
        "capabilities_p_24_payments" AS "p24_status",
        "capabilities_platform_payments" AS "platform_payments_status",
        "capabilities_sepa_debit_payments" AS "sepa_debit_payments_status",
        "capabilities_sofort_payments" AS "sofort_payments_status",
        "capabilities_tax_reporting_us_1099_k" AS "tax_reporting_1099k_status",
        "capabilities_tax_reporting_us_1099_misc" AS "tax_reporting_1099misc_status",
        "capabilities_transfers" AS "transfers_status",
        "charges_enabled",
        "company_address_city",
        "company_address_country",
        "company_address_kana_city",
        "company_address_kana_country",
        "company_address_kana_line_1",
        "company_address_kana_line_2",
        "company_address_kana_postal_code",
        "company_address_kana_state",
        "company_address_kana_town",
        "company_address_kanji_city",
        "company_address_kanji_country",
        "company_address_kanji_line_1",
        "company_address_kanji_line_2",
        "company_address_kanji_postal_code",
        "company_address_kanji_state",
        "company_address_kanji_town",
        "company_address_line_1",
        "company_address_line_2",
        "company_address_postal_code",
        "company_address_state",
        "company_directors_provided",
        "company_executives_provided",
        "company_name",
        "company_name_kana",
        "company_name_kanji",
        "company_owners_provided" AS "owners_info_provided",
        "company_phone" AS "business_phone",
        "company_structure" AS "legal_structure",
        "company_tax_id_provided" AS "tax_id_provided",
        "company_tax_id_registrar" AS "tax_id_issuer",
        "company_vat_id_provided" AS "vat_id_provided",
        "company_verification_document_back" AS "verification_doc_back",
        "company_verification_document_details" AS "verification_doc_details",
        "company_verification_document_details_code" AS "verification_doc_code",
        "company_verification_document_front" AS "verification_doc_front",
        "country",
        "created" AS "account_creation_date",
        "default_currency",
        "details_submitted",
        "email" AS "account_email",
        "individual_id",
        "is_deleted",
        "metadata",
        "payouts_enabled",
        "requirements_current_deadline" AS "current_requirements_deadline",
        "requirements_currently_due" AS "current_requirements",
        "requirements_disabled_reason",
        "requirements_errors" AS "requirement_errors",
        "requirements_eventually_due" AS "future_requirements",
        "requirements_past_due" AS "past_due_requirements",
        "requirements_pending_verification" AS "pending_verification",
        "settings_branding_icon" AS "branding_icon",
        "settings_branding_logo" AS "branding_logo_file_id",
        "settings_branding_primary_color" AS "branding_primary_color",
        "settings_card_payments_decline_on_avs_failure" AS "decline_on_avs_failure",
        "settings_card_payments_decline_on_cvc_failure" AS "decline_on_cvc_failure",
        "settings_card_payments_statement_descriptor_prefix" AS "statement_descriptor_prefix",
        "settings_dashboard_display_name" AS "dashboard_display_name",
        "settings_dashboard_timezone" AS "dashboard_timezone",
        "settings_payments_statement_descriptor" AS "payment_statement_descriptor",
        "settings_payments_statement_descriptor_kana" AS "payment_statement_descriptor_kana",
        "settings_payments_statement_descriptor_kanji" AS "payment_statement_descriptor_kanji",
        "settings_payouts_debit_negative_balances" AS "debit_negative_balances",
        "settings_payouts_schedule_delay_days" AS "payout_delay_days",
        "settings_payouts_schedule_interval" AS "payout_schedule_interval",
        "settings_payouts_schedule_monthly_anchor" AS "payout_monthly_anchor",
        "settings_payouts_schedule_weekly_anchor" AS "payout_weekly_anchor",
        "settings_payouts_statement_descriptor" AS "payout_statement_descriptor",
        "tos_acceptance_date",
        "tos_acceptance_ip",
        "tos_acceptance_user_agent",
        "type" AS "account_type"
    FROM "account_data_projected"
),

"account_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_creation_date: from DECIMAL to DATE
    -- account_id: from INT to VARCHAR
    -- au_becs_debit_status: from DECIMAL to VARCHAR
    -- bacs_debit_status: from DECIMAL to VARCHAR
    -- branding_icon: from DECIMAL to VARCHAR
    -- business_phone: from DECIMAL to VARCHAR
    -- business_type: from DECIMAL to VARCHAR
    -- card_issuing_status: from DECIMAL to VARCHAR
    -- cartes_bancaires_status: from DECIMAL to VARCHAR
    -- company_address_city: from DECIMAL to VARCHAR
    -- company_address_country: from DECIMAL to VARCHAR
    -- company_address_kana_city: from DECIMAL to VARCHAR
    -- company_address_kana_country: from DECIMAL to VARCHAR
    -- company_address_kana_line_1: from DECIMAL to VARCHAR
    -- company_address_kana_line_2: from DECIMAL to VARCHAR
    -- company_address_kana_postal_code: from DECIMAL to VARCHAR
    -- company_address_kana_state: from DECIMAL to VARCHAR
    -- company_address_kana_town: from DECIMAL to VARCHAR
    -- company_address_kanji_city: from DECIMAL to VARCHAR
    -- company_address_kanji_country: from DECIMAL to VARCHAR
    -- company_address_kanji_line_1: from DECIMAL to VARCHAR
    -- company_address_kanji_line_2: from DECIMAL to VARCHAR
    -- company_address_kanji_postal_code: from DECIMAL to VARCHAR
    -- company_address_kanji_state: from DECIMAL to VARCHAR
    -- company_address_kanji_town: from DECIMAL to VARCHAR
    -- company_address_line_1: from DECIMAL to VARCHAR
    -- company_address_line_2: from DECIMAL to VARCHAR
    -- company_address_postal_code: from DECIMAL to VARCHAR
    -- company_address_state: from DECIMAL to VARCHAR
    -- company_directors_provided: from DECIMAL to BOOLEAN
    -- company_executives_provided: from DECIMAL to BOOLEAN
    -- company_name: from DECIMAL to VARCHAR
    -- company_name_kana: from DECIMAL to VARCHAR
    -- company_name_kanji: from DECIMAL to VARCHAR
    -- current_requirements: from DECIMAL to VARCHAR
    -- current_requirements_deadline: from DECIMAL to DATE
    -- decline_on_avs_failure: from DECIMAL to BOOLEAN
    -- decline_on_cvc_failure: from DECIMAL to BOOLEAN
    -- fpx_status: from DECIMAL to VARCHAR
    -- future_requirements: from DECIMAL to VARCHAR
    -- grabpay_status: from DECIMAL to VARCHAR
    -- individual_id: from DECIMAL to VARCHAR
    -- jcb_status: from DECIMAL to VARCHAR
    -- legacy_payments_status: from DECIMAL to VARCHAR
    -- legal_structure: from DECIMAL to VARCHAR
    -- metadata: from DECIMAL to JSON
    -- owners_info_provided: from DECIMAL to BOOLEAN
    -- oxxo_status: from DECIMAL to VARCHAR
    -- past_due_requirements: from DECIMAL to ARRAY
    -- payment_statement_descriptor_kana: from DECIMAL to VARCHAR
    -- payment_statement_descriptor_kanji: from DECIMAL to VARCHAR
    -- payout_monthly_anchor: from DECIMAL to INT
    -- payout_statement_descriptor: from DECIMAL to VARCHAR
    -- payout_weekly_anchor: from DECIMAL to VARCHAR
    -- pending_verification: from DECIMAL to ARRAY
    -- product_description: from DECIMAL to VARCHAR
    -- requirement_errors: from DECIMAL to ARRAY
    -- requirements_disabled_reason: from DECIMAL to VARCHAR
    -- statement_descriptor_prefix: from DECIMAL to VARCHAR
    -- support_phone: from DECIMAL to VARCHAR
    -- support_postal_code: from INT to VARCHAR
    -- tax_id_issuer: from DECIMAL to VARCHAR
    -- tax_id_provided: from DECIMAL to BOOLEAN
    -- tax_reporting_1099k_status: from DECIMAL to VARCHAR
    -- tax_reporting_1099misc_status: from DECIMAL to VARCHAR
    -- tos_acceptance_date: from DECIMAL to TIMESTAMP
    -- tos_acceptance_ip: from DECIMAL to VARCHAR
    -- tos_acceptance_user_agent: from DECIMAL to VARCHAR
    -- transfers_status: from DECIMAL to VARCHAR
    -- vat_id_provided: from DECIMAL to BOOLEAN
    -- verification_doc_back: from DECIMAL to VARCHAR
    -- verification_doc_code: from DECIMAL to VARCHAR
    -- verification_doc_details: from DECIMAL to VARCHAR
    -- verification_doc_front: from DECIMAL to VARCHAR
    SELECT
        "merchant_category_code",
        "business_name",
        "support_city",
        "support_country",
        "support_address_line1",
        "support_address_line2",
        "support_state",
        "support_email",
        "support_url",
        "business_url",
        "afterpay_clearpay_status",
        "bancontact_status",
        "card_payments_status",
        "eps_status",
        "giropay_status",
        "ideal_status",
        "p24_status",
        "platform_payments_status",
        "sepa_debit_payments_status",
        "sofort_payments_status",
        "charges_enabled",
        "country",
        "default_currency",
        "details_submitted",
        "account_email",
        "is_deleted",
        "payouts_enabled",
        "branding_logo_file_id",
        "branding_primary_color",
        "dashboard_display_name",
        "dashboard_timezone",
        "payment_statement_descriptor",
        "debit_negative_balances",
        "payout_delay_days",
        "payout_schedule_interval",
        "account_type",
        CAST("account_creation_date" AS DATE) AS "account_creation_date",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("au_becs_debit_status" AS VARCHAR) AS "au_becs_debit_status",
        CAST("bacs_debit_status" AS VARCHAR) AS "bacs_debit_status",
        CAST("branding_icon" AS VARCHAR) AS "branding_icon",
        CAST("business_phone" AS VARCHAR) AS "business_phone",
        CAST("business_type" AS VARCHAR) AS "business_type",
        CAST("card_issuing_status" AS VARCHAR) AS "card_issuing_status",
        CAST("cartes_bancaires_status" AS VARCHAR) AS "cartes_bancaires_status",
        CAST("company_address_city" AS VARCHAR) AS "company_address_city",
        CAST("company_address_country" AS VARCHAR) AS "company_address_country",
        CAST("company_address_kana_city" AS VARCHAR) AS "company_address_kana_city",
        CAST("company_address_kana_country" AS VARCHAR) AS "company_address_kana_country",
        CAST("company_address_kana_line_1" AS VARCHAR) AS "company_address_kana_line_1",
        CAST("company_address_kana_line_2" AS VARCHAR) AS "company_address_kana_line_2",
        CAST("company_address_kana_postal_code" AS VARCHAR) AS "company_address_kana_postal_code",
        CAST("company_address_kana_state" AS VARCHAR) AS "company_address_kana_state",
        CAST("company_address_kana_town" AS VARCHAR) AS "company_address_kana_town",
        CAST("company_address_kanji_city" AS VARCHAR) AS "company_address_kanji_city",
        CAST("company_address_kanji_country" AS VARCHAR) AS "company_address_kanji_country",
        CAST("company_address_kanji_line_1" AS VARCHAR) AS "company_address_kanji_line_1",
        CAST("company_address_kanji_line_2" AS VARCHAR) AS "company_address_kanji_line_2",
        CAST("company_address_kanji_postal_code" AS VARCHAR) AS "company_address_kanji_postal_code",
        CAST("company_address_kanji_state" AS VARCHAR) AS "company_address_kanji_state",
        CAST("company_address_kanji_town" AS VARCHAR) AS "company_address_kanji_town",
        CAST("company_address_line_1" AS VARCHAR) AS "company_address_line_1",
        CAST("company_address_line_2" AS VARCHAR) AS "company_address_line_2",
        CAST("company_address_postal_code" AS VARCHAR) AS "company_address_postal_code",
        CAST("company_address_state" AS VARCHAR) AS "company_address_state",
        CAST("company_directors_provided" AS BOOLEAN) AS "company_directors_provided",
        CAST("company_executives_provided" AS BOOLEAN) AS "company_executives_provided",
        CAST("company_name" AS VARCHAR) AS "company_name",
        CAST("company_name_kana" AS VARCHAR) AS "company_name_kana",
        CAST("company_name_kanji" AS VARCHAR) AS "company_name_kanji",
        CAST("current_requirements" AS VARCHAR) AS "current_requirements",
        CAST("current_requirements_deadline" AS DATE) AS "current_requirements_deadline",
        CAST("decline_on_avs_failure" AS BOOLEAN) AS "decline_on_avs_failure",
        CAST("decline_on_cvc_failure" AS BOOLEAN) AS "decline_on_cvc_failure",
        CAST("fpx_status" AS VARCHAR) AS "fpx_status",
        CAST("future_requirements" AS VARCHAR) AS "future_requirements",
        CAST("grabpay_status" AS VARCHAR) AS "grabpay_status",
        CAST("individual_id" AS VARCHAR) AS "individual_id",
        CAST("jcb_status" AS VARCHAR) AS "jcb_status",
        CAST("legacy_payments_status" AS VARCHAR) AS "legacy_payments_status",
        CAST("legal_structure" AS VARCHAR) AS "legal_structure",
        CAST("metadata" AS JSON) AS "metadata",
        CAST("owners_info_provided" AS BOOLEAN) AS "owners_info_provided",
        CAST("oxxo_status" AS VARCHAR) AS "oxxo_status",
        "past_due_requirements" AS "past_due_requirements",
        CAST("payment_statement_descriptor_kana" AS VARCHAR) AS "payment_statement_descriptor_kana",
        CAST("payment_statement_descriptor_kanji" AS VARCHAR) AS "payment_statement_descriptor_kanji",
        CAST("payout_monthly_anchor" AS INT) AS "payout_monthly_anchor",
        CAST("payout_statement_descriptor" AS VARCHAR) AS "payout_statement_descriptor",
        CAST("payout_weekly_anchor" AS VARCHAR) AS "payout_weekly_anchor",
        "pending_verification" AS "pending_verification",
        CAST("product_description" AS VARCHAR) AS "product_description",
        string_split(CAST("requirement_errors" AS VARCHAR), ',') AS "requirement_errors",
        CAST("requirements_disabled_reason" AS VARCHAR) AS "requirements_disabled_reason",
        CAST("statement_descriptor_prefix" AS VARCHAR) AS "statement_descriptor_prefix",
        CAST("support_phone" AS VARCHAR) AS "support_phone",
        CAST("support_postal_code" AS VARCHAR) AS "support_postal_code",
        CAST("tax_id_issuer" AS VARCHAR) AS "tax_id_issuer",
        CAST("tax_id_provided" AS BOOLEAN) AS "tax_id_provided",
        CAST("tax_reporting_1099k_status" AS VARCHAR) AS "tax_reporting_1099k_status",
        CAST("tax_reporting_1099misc_status" AS VARCHAR) AS "tax_reporting_1099misc_status",
        CAST("tos_acceptance_date" AS TIMESTAMP) AS "tos_acceptance_date",
        CAST("tos_acceptance_ip" AS VARCHAR) AS "tos_acceptance_ip",
        CAST("tos_acceptance_user_agent" AS VARCHAR) AS "tos_acceptance_user_agent",
        CAST("transfers_status" AS VARCHAR) AS "transfers_status",
        CAST("vat_id_provided" AS BOOLEAN) AS "vat_id_provided",
        CAST("verification_doc_back" AS VARCHAR) AS "verification_doc_back",
        CAST("verification_doc_code" AS VARCHAR) AS "verification_doc_code",
        CAST("verification_doc_details" AS VARCHAR) AS "verification_doc_details",
        CAST("verification_doc_front" AS VARCHAR) AS "verification_doc_front"
    FROM "account_data_projected_renamed"
),

"account_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 46 columns with unacceptable missing values
    -- account_creation_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- branding_icon has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- business_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- card_issuing_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cartes_bancaires_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_address_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_address_country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_address_line_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_address_line_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_address_postal_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_address_state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_directors_provided has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_executives_provided has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- current_requirements has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- current_requirements_deadline has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- decline_on_avs_failure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- decline_on_cvc_failure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- future_requirements has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- individual_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legacy_payments_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- legal_structure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- metadata has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- owners_info_provided has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- past_due_requirements has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payout_statement_descriptor has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pending_verification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- requirement_errors has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- requirements_disabled_reason has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- statement_descriptor_prefix has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- support_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_id_issuer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_id_provided has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_reporting_1099k_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_reporting_1099misc_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tos_acceptance_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tos_acceptance_ip has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tos_acceptance_user_agent has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transfers_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- vat_id_provided has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- verification_doc_back has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- verification_doc_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- verification_doc_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- verification_doc_front has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "merchant_category_code",
        "business_name",
        "support_city",
        "support_country",
        "support_address_line1",
        "support_address_line2",
        "support_state",
        "support_email",
        "support_url",
        "business_url",
        "afterpay_clearpay_status",
        "bancontact_status",
        "card_payments_status",
        "eps_status",
        "giropay_status",
        "ideal_status",
        "p24_status",
        "platform_payments_status",
        "sepa_debit_payments_status",
        "sofort_payments_status",
        "charges_enabled",
        "country",
        "default_currency",
        "details_submitted",
        "account_email",
        "is_deleted",
        "payouts_enabled",
        "branding_logo_file_id",
        "branding_primary_color",
        "dashboard_display_name",
        "dashboard_timezone",
        "payment_statement_descriptor",
        "debit_negative_balances",
        "payout_delay_days",
        "payout_schedule_interval",
        "account_type",
        "account_id",
        "au_becs_debit_status",
        "bacs_debit_status",
        "company_address_kana_city",
        "company_address_kana_country",
        "company_address_kana_line_1",
        "company_address_kana_line_2",
        "company_address_kana_postal_code",
        "company_address_kana_state",
        "company_address_kana_town",
        "company_address_kanji_city",
        "company_address_kanji_country",
        "company_address_kanji_line_1",
        "company_address_kanji_line_2",
        "company_address_kanji_postal_code",
        "company_address_kanji_state",
        "company_address_kanji_town",
        "company_name_kana",
        "company_name_kanji",
        "fpx_status",
        "grabpay_status",
        "jcb_status",
        "oxxo_status",
        "payment_statement_descriptor_kana",
        "payment_statement_descriptor_kanji",
        "payout_monthly_anchor",
        "payout_weekly_anchor",
        "support_postal_code"
    FROM "account_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "account_data_projected_renamed_casted_missing_handled"