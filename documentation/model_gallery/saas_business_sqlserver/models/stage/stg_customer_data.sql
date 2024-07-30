-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:44:53.334000+00:00
WITH 
"customer_data_projected" AS (
    -- Projection: Selecting 40 out of 41 columns
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
        "tax_info_verification_verified_name",
        "salesforce_user_id"
    FROM "MyAppDB"."dbo"."customer_data"
),

"customer_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> customer_id
    -- balance -> account_balance_duplicate
    -- created -> creation_date
    -- delinquent -> is_delinquent
    -- description -> customer_description
    -- invoice_settings_default_payment_method -> default_invoice_payment_method
    -- invoice_settings_footer -> invoice_footer
    -- livemode -> is_live_mode
    -- name -> customer_name
    -- phone -> phone_number
    -- shipping_address_city -> shipping_city
    -- shipping_address_country -> shipping_country
    -- shipping_address_line_1 -> shipping_line_1
    -- shipping_address_line_2 -> shipping_line_2
    -- shipping_address_postal_code -> shipping_postal_code
    -- shipping_address_state -> shipping_state
    -- source_id -> customer_source_id
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
        "balance" AS "account_balance_duplicate",
        "bank_account_id",
        "created" AS "creation_date",
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
        "name" AS "customer_name",
        "phone" AS "phone_number",
        "shipping_address_city" AS "shipping_city",
        "shipping_address_country" AS "shipping_country",
        "shipping_address_line_1" AS "shipping_line_1",
        "shipping_address_line_2" AS "shipping_line_2",
        "shipping_address_postal_code" AS "shipping_postal_code",
        "shipping_address_state" AS "shipping_state",
        "shipping_carrier",
        "shipping_name",
        "shipping_phone",
        "shipping_tracking_number",
        "source_id" AS "customer_source_id",
        "tax_exempt" AS "tax_exempt_status",
        "tax_info_tax_id" AS "tax_id",
        "tax_info_type",
        "tax_info_verification_status" AS "tax_verification_status",
        "tax_info_verification_verified_name" AS "tax_verified_name",
        "salesforce_user_id"
    FROM "customer_data_projected"
),

"customer_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_balance: from INT to DECIMAL
    -- account_balance_duplicate: from INT to DECIMAL
    -- address_city: from FLOAT to VARCHAR
    -- address_country: from FLOAT to VARCHAR
    -- address_line_1: from FLOAT to VARCHAR
    -- address_line_2: from FLOAT to VARCHAR
    -- address_postal_code: from FLOAT to VARCHAR
    -- address_state: from FLOAT to VARCHAR
    -- creation_date: from VARCHAR to DATETIME
    -- currency: from FLOAT to VARCHAR
    -- customer_description: from FLOAT to VARCHAR
    -- customer_source_id: from FLOAT to VARCHAR
    -- default_card_id: from FLOAT to VARCHAR
    -- default_invoice_payment_method: from FLOAT to VARCHAR
    -- email: from FLOAT to VARCHAR
    -- invoice_footer: from FLOAT to VARCHAR
    -- is_deleted: from VARCHAR to BOOLEAN
    -- is_delinquent: from VARCHAR to BOOLEAN
    -- is_live_mode: from VARCHAR to BOOLEAN
    -- phone_number: from FLOAT to VARCHAR
    -- shipping_carrier: from FLOAT to VARCHAR
    -- shipping_city: from FLOAT to VARCHAR
    -- shipping_country: from FLOAT to VARCHAR
    -- shipping_line_1: from FLOAT to VARCHAR
    -- shipping_line_2: from FLOAT to VARCHAR
    -- shipping_name: from FLOAT to VARCHAR
    -- shipping_phone: from FLOAT to VARCHAR
    -- shipping_postal_code: from FLOAT to VARCHAR
    -- shipping_state: from FLOAT to VARCHAR
    -- shipping_tracking_number: from FLOAT to VARCHAR
    -- tax_id: from FLOAT to VARCHAR
    -- tax_info_type: from FLOAT to VARCHAR
    -- tax_verification_status: from FLOAT to VARCHAR
    -- tax_verified_name: from FLOAT to VARCHAR
    SELECT
        "customer_id",
        "bank_account_id",
        "invoice_prefix",
        "customer_name",
        "tax_exempt_status",
        "salesforce_user_id",
        CAST("account_balance" AS DECIMAL) 
        AS "account_balance",
        CAST("account_balance_duplicate" AS DECIMAL(18,2)) 
        AS "account_balance_duplicate",
        CAST("address_city" AS VARCHAR(255)) 
        AS "address_city",
        CAST("address_country" AS VARCHAR(255)) 
        AS "address_country",
        CAST("address_line_1" AS VARCHAR) 
        AS "address_line_1",
        CAST("address_line_2" AS VARCHAR) 
        AS "address_line_2",
        CAST("address_postal_code" AS VARCHAR) 
        AS "address_postal_code",
        CAST("address_state" AS VARCHAR) 
        AS "address_state",
        CAST("creation_date" AS DATETIME) 
        AS "creation_date",
        CAST("currency" AS VARCHAR) 
        AS "currency",
        CAST("customer_description" AS VARCHAR) 
        AS "customer_description",
        CAST("customer_source_id" AS VARCHAR) 
        AS "customer_source_id",
        CAST("default_card_id" AS VARCHAR) 
        AS "default_card_id",
        CAST("default_invoice_payment_method" AS VARCHAR) 
        AS "default_invoice_payment_method",
        CAST("email" AS VARCHAR(255)) 
        AS "email",
        CAST("invoice_footer" AS VARCHAR) 
        AS "invoice_footer",
        CASE WHEN "is_deleted" = '0' THEN 0 ELSE 1 END 
        AS "is_deleted",
        CAST(CAST("is_delinquent" AS INT) AS BIT) 
        AS "is_delinquent",
        CAST("is_live_mode" AS BIT) 
        AS "is_live_mode",
        CAST("phone_number" AS VARCHAR) 
        AS "phone_number",
        CAST("shipping_carrier" AS VARCHAR) 
        AS "shipping_carrier",
        CAST("shipping_city" AS VARCHAR) 
        AS "shipping_city",
        CAST("shipping_country" AS VARCHAR) 
        AS "shipping_country",
        CAST("shipping_line_1" AS VARCHAR) 
        AS "shipping_line_1",
        CAST("shipping_line_2" AS VARCHAR(255)) 
        AS "shipping_line_2",
        CAST("shipping_name" AS VARCHAR) 
        AS "shipping_name",
        CAST("shipping_phone" AS VARCHAR) 
        AS "shipping_phone",
        CAST("shipping_postal_code" AS VARCHAR) 
        AS "shipping_postal_code",
        CAST("shipping_state" AS VARCHAR) 
        AS "shipping_state",
        CAST("shipping_tracking_number" AS VARCHAR) 
        AS "shipping_tracking_number",
        CAST("tax_id" AS VARCHAR) 
        AS "tax_id",
        CAST("tax_info_type" AS VARCHAR) 
        AS "tax_info_type",
        CAST("tax_verification_status" AS VARCHAR) 
        AS "tax_verification_status",
        CAST("tax_verified_name" AS VARCHAR) 
        AS "tax_verified_name"
    FROM "customer_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "customer_data_projected_renamed_casted"