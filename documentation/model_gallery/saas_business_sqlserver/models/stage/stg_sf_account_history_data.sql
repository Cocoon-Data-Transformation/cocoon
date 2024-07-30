-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:36:43.081612+00:00
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
    FROM "MyAppDB"."dbo"."sf_account_history_data"
),

"sf_account_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- _fivetran_start -> valid_from
    -- _fivetran_end -> valid_to
    -- id -> record_id
    -- name -> account_name
    -- number_of_employees -> employee_count
    -- ownership -> ownership_type
    -- parent_id -> parent_account_id
    -- rating -> account_rating
    -- type -> account_type_encrypted
    -- website -> website_encrypted
    SELECT 
        "_fivetran_active" AS "is_active",
        "_fivetran_start" AS "valid_from",
        "_fivetran_end" AS "valid_to",
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
        "type" AS "account_type_encrypted",
        "website" AS "website_encrypted"
    FROM "sf_account_history_data_projected"
),

"sf_account_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_country: The problem is that the billing_country column contains an encoded string '8lPv4wLTKrJkp24M5lvnaQ==' instead of a recognizable country name. This encoded string appears to be the only value in the column, which is highly unusual for a country field. The correct values should be actual country names. However, without additional information or a way to decode this string, it's impossible to determine what country it represents.
    -- industry: The problem is that the industry column contains a base64 encoded string instead of a clear industry name. Base64 encoding is typically used for binary data or to obfuscate information, which is unusual and inappropriate for an industry field. The correct values should be clear, human-readable industry names.
    -- shipping_country: The problem is that the shipping_country column contains an encoded string ('8lPv4wLTKrJkp24M5lvnaQ==') instead of a recognizable country name. This value appears to be a Base64 encoded string, which is not a valid or meaningful representation for a country. Without additional information or a decoding key, it's impossible to determine what country this encoded string represents. The correct values should be actual country names.
    SELECT
        "is_active",
        "valid_from",
        "valid_to",
        "account_number",
        "account_source",
        "annual_revenue",
        "billing_city",
        CASE
            WHEN "billing_country" = '8lPv4wLTKrJkp24M5lvnaQ==' THEN NULL
            ELSE "billing_country"
        END AS "billing_country",
        "billing_postal_code",
        "billing_state",
        "billing_street",
        "description",
        "record_id",
        CASE
            WHEN "industry" = 'yCBcdjbnKNRIwndOakqUSw==' THEN NULL
            ELSE "industry"
        END AS "industry",
        "is_deleted",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "master_record_id",
        "account_name",
        "employee_count",
        "owner_id",
        "ownership_type",
        "parent_account_id",
        "account_rating",
        "record_type_id",
        "shipping_city",
        CASE
            WHEN "shipping_country" = '8lPv4wLTKrJkp24M5lvnaQ==' THEN NULL
            ELSE "shipping_country"
        END AS "shipping_country",
        "shipping_postal_code",
        "shipping_state",
        "shipping_street",
        "account_type_encrypted",
        "website_encrypted"
    FROM "sf_account_history_data_projected_renamed"
),

"sf_account_history_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- valid_to: ['9999-12-31 23:59:59']
    SELECT 
        CASE
            WHEN "valid_to" = '9999-12-31 23:59:59' THEN NULL
            ELSE "valid_to"
        END AS "valid_to",
        "account_type_encrypted",
        "billing_street",
        "parent_account_id",
        "annual_revenue",
        "last_activity_date",
        "industry",
        "shipping_city",
        "shipping_country",
        "record_type_id",
        "record_id",
        "master_record_id",
        "account_source",
        "is_active",
        "description",
        "ownership_type",
        "website_encrypted",
        "last_viewed_date",
        "valid_from",
        "is_deleted",
        "account_rating",
        "shipping_postal_code",
        "shipping_state",
        "owner_id",
        "last_referenced_date",
        "billing_city",
        "account_number",
        "billing_state",
        "shipping_street",
        "billing_country",
        "employee_count",
        "billing_postal_code",
        "account_name"
    FROM "sf_account_history_data_projected_renamed_cleaned"
),

"sf_account_history_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_number: from FLOAT to VARCHAR
    -- account_rating: from FLOAT to VARCHAR
    -- annual_revenue: from FLOAT to DECIMAL
    -- employee_count: from FLOAT to INT
    -- is_active: from VARCHAR to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- last_activity_date: from FLOAT to DATE
    -- last_referenced_date: from FLOAT to DATETIME
    -- last_viewed_date: from FLOAT to DATETIME
    -- ownership_type: from FLOAT to VARCHAR
    -- parent_account_id: from FLOAT to VARCHAR
    -- shipping_city: from FLOAT to VARCHAR
    -- shipping_postal_code: from FLOAT to VARCHAR
    -- shipping_state: from FLOAT to VARCHAR
    -- shipping_street: from FLOAT to VARCHAR
    -- valid_from: from VARCHAR to DATETIME
    -- valid_to: from VARCHAR to DATETIME
    SELECT
        "account_type_encrypted",
        "billing_street",
        "industry",
        "shipping_country",
        "record_type_id",
        "record_id",
        "master_record_id",
        "account_source",
        "description",
        "website_encrypted",
        "owner_id",
        "billing_city",
        "billing_state",
        "billing_country",
        "billing_postal_code",
        "account_name",
        CAST("account_number" AS VARCHAR) 
        AS "account_number",
        CAST("account_rating" AS VARCHAR) 
        AS "account_rating",
        CAST("annual_revenue" AS DECIMAL) 
        AS "annual_revenue",
        CAST("employee_count" AS INT) 
        AS "employee_count",
        CASE WHEN "is_active" = '1' THEN 1 ELSE 0 END 
        AS "is_active",
        CASE WHEN "is_deleted" = '1' THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END 
        AS "is_deleted",
        CAST(DATEADD(SECOND, CAST("last_activity_date" AS bigint), '1970-01-01') AS DATE) 
        AS "last_activity_date",
        CONVERT(DATETIME, CONVERT(VARCHAR(23), "last_referenced_date", 121)) 
        AS "last_referenced_date",
        DATEADD(second, CAST("last_viewed_date" AS BIGINT), '1970-01-01') 
        AS "last_viewed_date",
        CAST("ownership_type" AS VARCHAR) 
        AS "ownership_type",
        CAST("parent_account_id" AS VARCHAR) 
        AS "parent_account_id",
        CAST("shipping_city" AS VARCHAR) 
        AS "shipping_city",
        CAST("shipping_postal_code" AS VARCHAR) 
        AS "shipping_postal_code",
        CAST("shipping_state" AS VARCHAR) 
        AS "shipping_state",
        CAST("shipping_street" AS VARCHAR(255)) 
        AS "shipping_street",
        CAST("valid_from" AS DATETIME) 
        AS "valid_from",
        CAST("valid_to" AS DATETIME) 
        AS "valid_to"
    FROM "sf_account_history_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_account_history_data_projected_renamed_cleaned_null_casted"