-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_account_history_data_projected" AS (
    -- Projection: Selecting 33 out of 34 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "_fivetran_start",
        "_fivetran_end",
        "account_number",
        "account_source",
        "annual_revenue",
        "billing_city",
        "billing_country",
        "billing_postal_code",
        "billing_state",
        "billing_street",
        "description",
        "id",
        "industry",
        "is_deleted",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "master_record_id",
        "name",
        "number_of_employees",
        "owner_id",
        "ownership",
        "parent_id",
        "rating",
        "record_type_id",
        "shipping_city",
        "shipping_country",
        "shipping_postal_code",
        "shipping_state",
        "shipping_street",
        "type",
        "website"
    FROM "sf_account_history_data"
),

"sf_account_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- _fivetran_start -> valid_from
    -- _fivetran_end -> valid_until
    -- id -> record_id
    -- name -> account_name
    -- number_of_employees -> employee_count
    -- ownership -> ownership_type
    -- parent_id -> parent_account_id
    -- rating -> account_rating
    -- type -> encrypted_account_type
    -- website -> encrypted_website
    SELECT 
        "_fivetran_active" AS "is_active",
        "_fivetran_start" AS "valid_from",
        "_fivetran_end" AS "valid_until",
        "account_number",
        "account_source",
        "annual_revenue",
        "billing_city",
        "billing_country",
        "billing_postal_code",
        "billing_state",
        "billing_street",
        "description",
        "id" AS "record_id",
        "industry",
        "is_deleted",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "master_record_id",
        "name" AS "account_name",
        "number_of_employees" AS "employee_count",
        "owner_id",
        "ownership" AS "ownership_type",
        "parent_id" AS "parent_account_id",
        "rating" AS "account_rating",
        "record_type_id",
        "shipping_city",
        "shipping_country",
        "shipping_postal_code",
        "shipping_state",
        "shipping_street",
        "type" AS "encrypted_account_type",
        "website" AS "encrypted_website"
    FROM "sf_account_history_data_projected"
),

"sf_account_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_city: The problem is that all values in the billing_city column are encrypted or encoded strings instead of readable city names. This makes the data unusable for analysis or display purposes. The correct values should be decrypted city names, but without access to the decryption key or method, it's impossible to determine the actual city names these represent. 
    -- billing_country: The problem is that the billing_country column contains an encoded string '8lPv4wLTKrJkp24M5lvnaQ==' instead of clear country names. This encoded string appears to be the only value in the column and doesn't represent any recognizable country information. The correct values should be actual country names or codes, but without additional information or a decryption key, it's impossible to determine what this encoded string represents. 
    -- billing_state: The problem is that all values in the billing_state column are encoded strings, likely using base64 encoding, instead of readable state names. These encoded values do not provide any meaningful information about the actual billing states. The correct values should be the actual state names or abbreviations. 
    -- account_name: The problem is that there are multiple test accounts ('Blue Test', 'Test 123', 'Test 1234', "Eric's Test", 'Testins Opp Close', 'allbound ID test') which are likely not real accounts and should be removed. There's also inconsistency in naming formats, with some using possessive forms ("Eric's Test") and others using company names ('Rick Thomas Company'). The correct values should be real account names in a consistent format, preferably company names where applicable. 
    -- shipping_country: The problem is that the shipping_country column contains an encoded or encrypted value '8lPv4wLTKrJkp24M5lvnaQ==' instead of a recognizable country name. This value appears to be a Base64 encoded string, which is not a valid representation for a country. The correct values should be actual country names or codes. Without additional information to decode this value, it's impossible to determine the intended country. Therefore, the safest approach is to map this unusual value to an empty string to indicate missing data. 
    SELECT
        "is_active",
        "valid_from",
        "valid_until",
        "account_number",
        "account_source",
        "annual_revenue",
        CASE
            WHEN "billing_city" = 'ZxAK+LCOBzw7p/TeJwdYSw==' THEN ''
            WHEN "billing_city" = 'n9oradGMpYOT/QxsY/psmw==' THEN ''
            WHEN "billing_city" = 'W08cDivYvBunJs1R3XDBpg==' THEN ''
            ELSE "billing_city"
        END AS "billing_city",
        CASE
            WHEN "billing_country" = '8lPv4wLTKrJkp24M5lvnaQ==' THEN ''
            ELSE "billing_country"
        END AS "billing_country",
        "billing_postal_code",
        CASE
            WHEN "billing_state" = 'FeSUdeQlOf7tk/xcziXTyw==' THEN ''
            WHEN "billing_state" = 'mAzuwdui02wrqGf2g7R4OA==' THEN ''
            WHEN "billing_state" = 'NWd5qaFpZxRID1f6P7ZtTA==' THEN ''
            ELSE "billing_state"
        END AS "billing_state",
        "billing_street",
        "description",
        "record_id",
        "industry",
        "is_deleted",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "master_record_id",
        CASE
            WHEN "account_name" = 'Blue Test' THEN ''
            WHEN "account_name" = 'Test 123' THEN ''
            WHEN "account_name" = 'Test 1234' THEN ''
            WHEN "account_name" = 'Eric''s Test' THEN ''
            WHEN "account_name" = 'Testins Opp Close' THEN ''
            WHEN "account_name" = 'allbound ID test' THEN ''
            WHEN "account_name" = 'Balto Dog' THEN 'Balto Dog Company'
            WHEN "account_name" = 'Seinfeld' THEN 'Seinfeld Company'
            ELSE "account_name"
        END AS "account_name",
        "employee_count",
        "owner_id",
        "ownership_type",
        "parent_account_id",
        "account_rating",
        "record_type_id",
        "shipping_city",
        CASE
            WHEN "shipping_country" = '8lPv4wLTKrJkp24M5lvnaQ==' THEN ''
            ELSE "shipping_country"
        END AS "shipping_country",
        "shipping_postal_code",
        "shipping_state",
        "shipping_street",
        "encrypted_account_type",
        "encrypted_website"
    FROM "sf_account_history_data_projected_renamed"
),

"sf_account_history_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- valid_until: ['9999-12-31 23:59:59']
    -- billing_city: ['']
    -- billing_country: ['']
    -- billing_state: ['']
    -- account_name: ['']
    -- shipping_country: ['']
    SELECT 
        CASE
            WHEN "valid_until" = '9999-12-31 23:59:59' THEN NULL
            ELSE "valid_until"
        END AS "valid_until",
        CASE
            WHEN "billing_city" = '' THEN NULL
            ELSE "billing_city"
        END AS "billing_city",
        CASE
            WHEN "billing_country" = '' THEN NULL
            ELSE "billing_country"
        END AS "billing_country",
        CASE
            WHEN "billing_state" = '' THEN NULL
            ELSE "billing_state"
        END AS "billing_state",
        CASE
            WHEN "account_name" = '' THEN NULL
            ELSE "account_name"
        END AS "account_name",
        CASE
            WHEN "shipping_country" = '' THEN NULL
            ELSE "shipping_country"
        END AS "shipping_country",
        "account_source",
        "record_id",
        "shipping_postal_code",
        "shipping_city",
        "annual_revenue",
        "employee_count",
        "parent_account_id",
        "is_deleted",
        "record_type_id",
        "industry",
        "shipping_street",
        "last_viewed_date",
        "account_number",
        "last_referenced_date",
        "ownership_type",
        "master_record_id",
        "encrypted_website",
        "owner_id",
        "account_rating",
        "shipping_state",
        "billing_street",
        "description",
        "billing_postal_code",
        "valid_from",
        "encrypted_account_type",
        "is_active",
        "last_activity_date"
    FROM "sf_account_history_data_projected_renamed_cleaned"
),

"sf_account_history_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_number: from DECIMAL to VARCHAR
    -- account_rating: from DECIMAL to VARCHAR
    -- annual_revenue: from DECIMAL to VARCHAR
    -- employee_count: from DECIMAL to VARCHAR
    -- last_activity_date: from DECIMAL to DATE
    -- last_referenced_date: from DECIMAL to DATE
    -- last_viewed_date: from DECIMAL to DATE
    -- ownership_type: from DECIMAL to VARCHAR
    -- parent_account_id: from DECIMAL to VARCHAR
    -- shipping_city: from DECIMAL to VARCHAR
    -- shipping_postal_code: from DECIMAL to VARCHAR
    -- shipping_state: from DECIMAL to VARCHAR
    -- shipping_street: from DECIMAL to VARCHAR
    -- valid_from: from VARCHAR to TIMESTAMP
    -- valid_until: from VARCHAR to TIMESTAMP
    SELECT
        "billing_city",
        "billing_country",
        "billing_state",
        "account_name",
        "shipping_country",
        "account_source",
        "record_id",
        "is_deleted",
        "record_type_id",
        "industry",
        "master_record_id",
        "encrypted_website",
        "owner_id",
        "billing_street",
        "description",
        "billing_postal_code",
        "encrypted_account_type",
        "is_active",
        CAST("account_number" AS VARCHAR) AS "account_number",
        CAST("account_rating" AS VARCHAR) AS "account_rating",
        CAST("annual_revenue" AS VARCHAR) AS "annual_revenue",
        CAST("employee_count" AS VARCHAR) AS "employee_count",
        CAST("last_activity_date" AS DATE) AS "last_activity_date",
        CAST("last_referenced_date" AS DATE) AS "last_referenced_date",
        CAST("last_viewed_date" AS DATE) AS "last_viewed_date",
        CAST("ownership_type" AS VARCHAR) AS "ownership_type",
        CAST("parent_account_id" AS VARCHAR) AS "parent_account_id",
        CAST("shipping_city" AS VARCHAR) AS "shipping_city",
        CAST("shipping_postal_code" AS VARCHAR) AS "shipping_postal_code",
        CAST("shipping_state" AS VARCHAR) AS "shipping_state",
        CAST("shipping_street" AS VARCHAR) AS "shipping_street",
        CAST("valid_from" AS TIMESTAMP) AS "valid_from",
        CAST("valid_until" AS TIMESTAMP) AS "valid_until"
    FROM "sf_account_history_data_projected_renamed_cleaned_null"
),

"sf_account_history_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 20 columns with unacceptable missing values
    -- account_name has 70.0 percent missing. Strategy: 🔄 Unchanged
    -- account_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_rating has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_source has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- annual_revenue has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_postal_code has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- billing_state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- billing_street has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- description has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- employee_count has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- encrypted_website has 40.0 percent missing. Strategy: 🔄 Unchanged
    -- industry has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- last_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- master_record_id has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- ownership_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- valid_until has 70.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "account_name",
        "shipping_country",
        "account_source",
        "record_id",
        "is_deleted",
        "record_type_id",
        "industry",
        "master_record_id",
        "encrypted_website",
        "owner_id",
        "billing_street",
        "description",
        "billing_postal_code",
        "encrypted_account_type",
        "is_active",
        "employee_count",
        "parent_account_id",
        "shipping_city",
        "shipping_postal_code",
        "shipping_state",
        "shipping_street",
        "valid_from",
        "valid_until"
    FROM "sf_account_history_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_account_history_data_projected_renamed_cleaned_null_casted_missing_handled"