-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"payment_method_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "billing_detail_address_city",
        "billing_detail_address_country",
        "billing_detail_address_line_1",
        "billing_detail_address_line_2",
        "billing_detail_address_postal_code",
        "billing_detail_address_state",
        "billing_detail_email",
        "billing_detail_name",
        "billing_detail_phone",
        "created",
        "customer_id",
        "livemode",
        "type"
    FROM "payment_method_data"
),

"payment_method_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payment_method_id
    -- billing_detail_address_city -> billing_city
    -- billing_detail_address_country -> billing_country
    -- billing_detail_address_line_1 -> billing_address_1
    -- billing_detail_address_line_2 -> billing_address_2
    -- billing_detail_address_postal_code -> billing_postal_code
    -- billing_detail_address_state -> billing_state
    -- billing_detail_email -> billing_email
    -- billing_detail_name -> billing_name
    -- billing_detail_phone -> billing_phone
    -- created -> created_at
    -- livemode -> is_live
    -- type -> payment_method_type
    SELECT 
        "id" AS "payment_method_id",
        "billing_detail_address_city" AS "billing_city",
        "billing_detail_address_country" AS "billing_country",
        "billing_detail_address_line_1" AS "billing_address_1",
        "billing_detail_address_line_2" AS "billing_address_2",
        "billing_detail_address_postal_code" AS "billing_postal_code",
        "billing_detail_address_state" AS "billing_state",
        "billing_detail_email" AS "billing_email",
        "billing_detail_name" AS "billing_name",
        "billing_detail_phone" AS "billing_phone",
        "created" AS "created_at",
        "customer_id",
        "livemode" AS "is_live",
        "type" AS "payment_method_type"
    FROM "payment_method_data_projected"
),

"payment_method_data_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- billing_postal_code: ['d41d8cd98f00b204e9800998ecf8427e']
    SELECT 
        CASE
            WHEN "billing_postal_code" = 'd41d8cd98f00b204e9800998ecf8427e' THEN NULL
            ELSE "billing_postal_code"
        END AS "billing_postal_code",
        "payment_method_id",
        "billing_name",
        "billing_address_2",
        "payment_method_type",
        "customer_id",
        "billing_city",
        "billing_address_1",
        "billing_country",
        "billing_email",
        "created_at",
        "billing_phone",
        "is_live",
        "billing_state"
    FROM "payment_method_data_projected_renamed"
),

"payment_method_data_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- billing_address_1: from DECIMAL to VARCHAR
    -- billing_address_2: from DECIMAL to VARCHAR
    -- billing_city: from DECIMAL to VARCHAR
    -- billing_country: from DECIMAL to VARCHAR
    -- billing_phone: from DECIMAL to VARCHAR
    -- billing_state: from DECIMAL to VARCHAR
    -- created_at: from VARCHAR to TIMESTAMP
    SELECT
        "billing_postal_code",
        "payment_method_id",
        "billing_name",
        "payment_method_type",
        "customer_id",
        "billing_email",
        "is_live",
        CAST("billing_address_1" AS VARCHAR) AS "billing_address_1",
        CAST("billing_address_2" AS VARCHAR) AS "billing_address_2",
        CAST("billing_city" AS VARCHAR) AS "billing_city",
        CAST("billing_country" AS VARCHAR) AS "billing_country",
        CAST("billing_phone" AS VARCHAR) AS "billing_phone",
        CAST("billing_state" AS VARCHAR) AS "billing_state",
        CAST("created_at" AS TIMESTAMP) AS "created_at"
    FROM "payment_method_data_projected_renamed_null"
),

"payment_method_data_projected_renamed_null_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- billing_email has 76.92 percent missing. Strategy: 🔄 Unchanged
    -- billing_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_postal_code has 7.69 percent missing. Strategy: 🔄 Unchanged
    -- customer_id has 23.08 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "billing_postal_code",
        "payment_method_id",
        "billing_name",
        "payment_method_type",
        "customer_id",
        "billing_email",
        "is_live",
        "billing_address_1",
        "billing_address_2",
        "billing_city",
        "billing_country",
        "billing_state",
        "created_at"
    FROM "payment_method_data_projected_renamed_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "payment_method_data_projected_renamed_null_casted_missing_handled"