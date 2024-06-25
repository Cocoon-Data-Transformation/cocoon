-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_customer_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "first_name",
        "last_name",
        "email",
        "phone",
        "state",
        "orders_count",
        "total_spent",
        "created_at",
        "updated_at",
        "accepts_marketing",
        "tax_exempt",
        "verified_email",
        "default_address_id"
    FROM "shopify_customer_data"
),

"shopify_customer_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> customer_id
    -- first_name -> encrypted_first_name
    -- last_name -> encrypted_last_name
    -- email -> encrypted_email
    -- state -> account_state
    -- created_at -> account_creation_date
    -- updated_at -> last_updated_date
    -- accepts_marketing -> marketing_consent
    -- verified_email -> email_verified
    SELECT 
        "id" AS "customer_id",
        "first_name" AS "encrypted_first_name",
        "last_name" AS "encrypted_last_name",
        "email" AS "encrypted_email",
        "phone",
        "state" AS "account_state",
        "orders_count",
        "total_spent",
        "created_at" AS "account_creation_date",
        "updated_at" AS "last_updated_date",
        "accepts_marketing" AS "marketing_consent",
        "tax_exempt",
        "verified_email" AS "email_verified",
        "default_address_id"
    FROM "shopify_customer_data_projected"
),

"shopify_customer_data_projected_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "customer_id",
        "encrypted_first_name",
        "encrypted_last_name",
        "encrypted_email",
        "phone",
        "account_state",
        "orders_count",
        "total_spent",
        "marketing_consent",
        "tax_exempt",
        "email_verified",
        "default_address_id",
        TRIM("account_creation_date") AS "account_creation_date",
        TRIM("last_updated_date") AS "last_updated_date"
    FROM "shopify_customer_data_projected_renamed"
),

"shopify_customer_data_projected_renamed_trimmed_casted" AS (
    -- Column Type Casting: 
    -- account_creation_date: from VARCHAR to TIMESTAMP
    -- customer_id: from INT to VARCHAR
    -- default_address_id: from INT to VARCHAR
    -- last_updated_date: from VARCHAR to TIMESTAMP
    -- phone: from DECIMAL to VARCHAR
    SELECT
        "encrypted_first_name",
        "encrypted_last_name",
        "encrypted_email",
        "account_state",
        "orders_count",
        "total_spent",
        "marketing_consent",
        "tax_exempt",
        "email_verified",
        CAST("account_creation_date" AS TIMESTAMP) AS "account_creation_date",
        CAST("customer_id" AS VARCHAR) AS "customer_id",
        CAST("default_address_id" AS VARCHAR) AS "default_address_id",
        CAST("last_updated_date" AS TIMESTAMP) AS "last_updated_date",
        CAST("phone" AS VARCHAR) AS "phone"
    FROM "shopify_customer_data_projected_renamed_trimmed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_customer_data_projected_renamed_trimmed_casted"