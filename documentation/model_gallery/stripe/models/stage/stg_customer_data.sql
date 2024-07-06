-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"customer_data_projected" AS (
    -- Projection: Selecting 39 out of 40 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "account_balance",
        "address_city",
        "address_country",
        "address_line_1",
        "address_line_2",
        "address_postal_code",
        "address_state",
        "balance",
        "bank_account_id",
        "created",
        "currency",
        "default_card_id",
        "delinquent",
        "description",
        "email",
        "invoice_prefix",
        "invoice_settings_default_payment_method",
        "invoice_settings_footer",
        "is_deleted",
        "livemode",
        "name",
        "phone",
        "shipping_address_city",
        "shipping_address_country",
        "shipping_address_line_1",
        "shipping_address_line_2",
        "shipping_address_postal_code",
        "shipping_address_state",
        "shipping_carrier",
        "shipping_name",
        "shipping_phone",
        "shipping_tracking_number",
        "source_id",
        "tax_exempt",
        "tax_info_tax_id",
        "tax_info_type",
        "tax_info_verification_status",
        "tax_info_verification_verified_name"
    FROM "customer_data"
),

"customer_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> customer_id
    -- created -> account_creation_date
    -- delinquent -> is_delinquent
    -- description -> customer_description
    -- invoice_settings_default_payment_method -> default_invoice_payment_method
    -- invoice_settings_footer -> invoice_footer
    -- livemode -> is_live_mode
    -- name -> hashed_customer_name
    -- source_id -> customer_data_source_id
    -- tax_exempt -> tax_exempt_status
    -- tax_info_tax_id -> tax_id
    -- tax_info_verification_status -> tax_verification_status
    -- tax_info_verification_verified_name -> tax_verified_name
    SELECT 
        "id" AS "customer_id",
        "account_balance",
        "address_city",
        "address_country",
        "address_line_1",
        "address_line_2",
        "address_postal_code",
        "address_state",
        "balance",
        "bank_account_id",
        "created" AS "account_creation_date",
        "currency",
        "default_card_id",
        "delinquent" AS "is_delinquent",
        "description" AS "customer_description",
        "email",
        "invoice_prefix",
        "invoice_settings_default_payment_method" AS "default_invoice_payment_method",
        "invoice_settings_footer" AS "invoice_footer",
        "is_deleted",
        "livemode" AS "is_live_mode",
        "name" AS "hashed_customer_name",
        "phone",
        "shipping_address_city",
        "shipping_address_country",
        "shipping_address_line_1",
        "shipping_address_line_2",
        "shipping_address_postal_code",
        "shipping_address_state",
        "shipping_carrier",
        "shipping_name",
        "shipping_phone",
        "shipping_tracking_number",
        "source_id" AS "customer_data_source_id",
        "tax_exempt" AS "tax_exempt_status",
        "tax_info_tax_id" AS "tax_id",
        "tax_info_type",
        "tax_info_verification_status" AS "tax_verification_status",
        "tax_info_verification_verified_name" AS "tax_verified_name"
    FROM "customer_data_projected"
),

"customer_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_balance: from INT to DECIMAL
    -- account_creation_date: from VARCHAR to TIMESTAMP
    -- address_city: from DECIMAL to VARCHAR
    -- address_country: from DECIMAL to VARCHAR
    -- address_line_1: from DECIMAL to VARCHAR
    -- address_line_2: from DECIMAL to VARCHAR
    -- address_postal_code: from DECIMAL to VARCHAR
    -- address_state: from DECIMAL to VARCHAR
    -- balance: from INT to DECIMAL
    -- currency: from DECIMAL to VARCHAR
    -- customer_data_source_id: from DECIMAL to VARCHAR
    -- customer_description: from DECIMAL to VARCHAR
    -- default_card_id: from DECIMAL to VARCHAR
    -- default_invoice_payment_method: from DECIMAL to VARCHAR
    -- email: from DECIMAL to VARCHAR
    -- invoice_footer: from DECIMAL to VARCHAR
    -- phone: from DECIMAL to VARCHAR
    -- shipping_address_city: from DECIMAL to VARCHAR
    -- shipping_address_country: from DECIMAL to VARCHAR
    -- shipping_address_line_1: from DECIMAL to VARCHAR
    -- shipping_address_line_2: from DECIMAL to VARCHAR
    -- shipping_address_postal_code: from DECIMAL to VARCHAR
    -- shipping_address_state: from DECIMAL to VARCHAR
    -- shipping_carrier: from DECIMAL to VARCHAR
    -- shipping_name: from DECIMAL to VARCHAR
    -- shipping_phone: from DECIMAL to VARCHAR
    -- shipping_tracking_number: from DECIMAL to VARCHAR
    -- tax_id: from DECIMAL to VARCHAR
    -- tax_info_type: from DECIMAL to VARCHAR
    -- tax_verification_status: from DECIMAL to VARCHAR
    -- tax_verified_name: from DECIMAL to VARCHAR
    SELECT
        "customer_id",
        "bank_account_id",
        "is_delinquent",
        "invoice_prefix",
        "is_deleted",
        "is_live_mode",
        "hashed_customer_name",
        "tax_exempt_status",
        CAST("account_balance" AS DECIMAL) AS "account_balance",
        CAST("account_creation_date" AS TIMESTAMP) AS "account_creation_date",
        CAST("address_city" AS VARCHAR) AS "address_city",
        CAST("address_country" AS VARCHAR) AS "address_country",
        CAST("address_line_1" AS VARCHAR) AS "address_line_1",
        CAST("address_line_2" AS VARCHAR) AS "address_line_2",
        CAST("address_postal_code" AS VARCHAR) AS "address_postal_code",
        CAST("address_state" AS VARCHAR) AS "address_state",
        CAST("balance" AS DECIMAL) AS "balance",
        CAST("currency" AS VARCHAR) AS "currency",
        CAST("customer_data_source_id" AS VARCHAR) AS "customer_data_source_id",
        CAST("customer_description" AS VARCHAR) AS "customer_description",
        CAST("default_card_id" AS VARCHAR) AS "default_card_id",
        CAST("default_invoice_payment_method" AS VARCHAR) AS "default_invoice_payment_method",
        CAST("email" AS VARCHAR) AS "email",
        CAST("invoice_footer" AS VARCHAR) AS "invoice_footer",
        CAST("phone" AS VARCHAR) AS "phone",
        CAST("shipping_address_city" AS VARCHAR) AS "shipping_address_city",
        CAST("shipping_address_country" AS VARCHAR) AS "shipping_address_country",
        CAST("shipping_address_line_1" AS VARCHAR) AS "shipping_address_line_1",
        CAST("shipping_address_line_2" AS VARCHAR) AS "shipping_address_line_2",
        CAST("shipping_address_postal_code" AS VARCHAR) AS "shipping_address_postal_code",
        CAST("shipping_address_state" AS VARCHAR) AS "shipping_address_state",
        CAST("shipping_carrier" AS VARCHAR) AS "shipping_carrier",
        CAST("shipping_name" AS VARCHAR) AS "shipping_name",
        CAST("shipping_phone" AS VARCHAR) AS "shipping_phone",
        CAST("shipping_tracking_number" AS VARCHAR) AS "shipping_tracking_number",
        CAST("tax_id" AS VARCHAR) AS "tax_id",
        CAST("tax_info_type" AS VARCHAR) AS "tax_info_type",
        CAST("tax_verification_status" AS VARCHAR) AS "tax_verification_status",
        CAST("tax_verified_name" AS VARCHAR) AS "tax_verified_name"
    FROM "customer_data_projected_renamed"
),

"customer_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 19 columns with unacceptable missing values
    -- address_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_line_1 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_line_2 has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_postal_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- address_state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- bank_account_id has 91.67 percent missing. Strategy: 🗑️ Drop Column
    -- currency has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_data_source_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- default_card_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- default_invoice_payment_method has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- invoice_footer has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_info_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_verification_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_verified_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "customer_id",
        "is_delinquent",
        "invoice_prefix",
        "is_deleted",
        "is_live_mode",
        "hashed_customer_name",
        "tax_exempt_status",
        "account_balance",
        "account_creation_date",
        "balance",
        "shipping_address_city",
        "shipping_address_country",
        "shipping_address_line_1",
        "shipping_address_line_2",
        "shipping_address_postal_code",
        "shipping_address_state",
        "shipping_carrier",
        "shipping_name",
        "shipping_phone",
        "shipping_tracking_number"
    FROM "customer_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "customer_data_projected_renamed_casted_missing_handled"