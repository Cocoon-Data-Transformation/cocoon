-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_account_data_projected" AS (
    -- Projection: Selecting 49 out of 50 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "account_number",
        "account_source",
        "annual_revenue",
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_geocode_accuracy",
        "billing_latitude",
        "billing_longitude",
        "billing_postal_code",
        "billing_state",
        "billing_state_code",
        "billing_street",
        "description",
        "fax",
        "id",
        "industry",
        "is_deleted",
        "jigsaw_company_id",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "master_record_id",
        "name",
        "number_of_employees",
        "owner_id",
        "ownership",
        "parent_id",
        "phone",
        "photo_url",
        "rating",
        "record_type_id",
        "shipping_city",
        "shipping_country",
        "shipping_country_code",
        "shipping_geocode_accuracy",
        "shipping_latitude",
        "shipping_longitude",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street",
        "sic",
        "sic_desc",
        "site",
        "ticker_symbol",
        "type",
        "website",
        "_fivetran_active"
    FROM "sf_account_data"
),

"sf_account_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- description -> account_description
    -- fax -> fax_number
    -- id -> account_id
    -- name -> account_name
    -- number_of_employees -> employee_count
    -- ownership -> ownership_type
    -- parent_id -> parent_account_id
    -- phone -> phone_number
    -- photo_url -> account_photo_url
    -- rating -> account_rating
    -- sic -> sic_code
    -- sic_desc -> sic_description
    -- site -> account_site
    -- type -> account_type
    -- website -> account_website
    -- _fivetran_active -> is_active
    SELECT 
        "account_number",
        "account_source",
        "annual_revenue",
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_geocode_accuracy",
        "billing_latitude",
        "billing_longitude",
        "billing_postal_code",
        "billing_state",
        "billing_state_code",
        "billing_street",
        "description" AS "account_description",
        "fax" AS "fax_number",
        "id" AS "account_id",
        "industry",
        "is_deleted",
        "jigsaw_company_id",
        "last_activity_date",
        "last_referenced_date",
        "last_viewed_date",
        "master_record_id",
        "name" AS "account_name",
        "number_of_employees" AS "employee_count",
        "owner_id",
        "ownership" AS "ownership_type",
        "parent_id" AS "parent_account_id",
        "phone" AS "phone_number",
        "photo_url" AS "account_photo_url",
        "rating" AS "account_rating",
        "record_type_id",
        "shipping_city",
        "shipping_country",
        "shipping_country_code",
        "shipping_geocode_accuracy",
        "shipping_latitude",
        "shipping_longitude",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street",
        "sic" AS "sic_code",
        "sic_desc" AS "sic_description",
        "site" AS "account_site",
        "ticker_symbol",
        "type" AS "account_type",
        "website" AS "account_website",
        "_fivetran_active" AS "is_active"
    FROM "sf_account_data_projected"
),

"sf_account_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_city: The problem is that all values in the billing_city column are encrypted or encoded strings instead of readable city names. This makes the data unusable for analysis or display purposes. The correct values should be decrypted city names, but without access to the decryption key or method, it's impossible to determine the actual city names these represent. 
    -- billing_country: The problem is that the billing_country column contains an encoded string '8lPv4wLTKrJkp24M5lvnaQ==' instead of clear country names. This encoded string appears to be the only value in the column and doesn't represent any recognizable country information. The correct values should be actual country names or codes, but without additional information or a decryption key, it's impossible to determine what this encoded string represents. 
    -- billing_country_code: The problem is that the value 'dRb9Q62qXguKZaZyw5hF0g==' appears to be an encoded string, likely in Base64 format. This is unusual for a country code field, which typically contains 2-3 letter ISO country codes (e.g., 'US', 'CA', 'GB'). Without additional information to decode this string or map it to actual country codes, it's impossible to determine the correct values. The encoded string may be masking the actual country codes for privacy or security reasons. 
    -- billing_state: The problem is that all values in the billing_state column are encoded strings, likely using base64 encoding, instead of readable state names. These encoded values do not provide any meaningful information about the actual billing states. The correct values should be the actual state names or abbreviations. 
    -- account_name: The problem is that there are multiple test accounts ('Blue Test', 'Test 123', 'Test 1234', "Eric's Test", 'Testins Opp Close', 'allbound ID test') which are likely not real accounts and should be removed. There's also inconsistency in naming formats, with some using possessive forms ("Eric's Test") and others using company names ('Rick Thomas Company'). The correct values should be real account names in a consistent format, preferably company names where applicable. 
    -- shipping_country: The problem is that the shipping_country column contains an encoded or encrypted value '8lPv4wLTKrJkp24M5lvnaQ==' instead of a recognizable country name. This value appears to be a Base64 encoded string, which is not a valid representation for a country. The correct values should be actual country names or codes. Without additional information to decode this value, it's impossible to determine the intended country. Therefore, the safest approach is to map this unusual value to an empty string to indicate missing data. 
    -- shipping_country_code: The problem is that the value 'dRb9Q62qXguKZaZyw5hF0g==' is not a standard country code. It appears to be an encrypted or encoded string, possibly due to data anonymization or a processing error. Standard country codes are typically 2 or 3 letter codes (like 'US' for United States or 'GBR' for Great Britain). Without additional information or a decryption key, it's impossible to determine what country this code represents.  
    SELECT
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
        CASE
            WHEN "billing_country_code" = 'dRb9Q62qXguKZaZyw5hF0g==' THEN ''
            ELSE "billing_country_code"
        END AS "billing_country_code",
        "billing_geocode_accuracy",
        "billing_latitude",
        "billing_longitude",
        "billing_postal_code",
        CASE
            WHEN "billing_state" = 'FeSUdeQlOf7tk/xcziXTyw==' THEN ''
            WHEN "billing_state" = 'mAzuwdui02wrqGf2g7R4OA==' THEN ''
            WHEN "billing_state" = 'NWd5qaFpZxRID1f6P7ZtTA==' THEN ''
            ELSE "billing_state"
        END AS "billing_state",
        "billing_state_code",
        "billing_street",
        "account_description",
        "fax_number",
        "account_id",
        "industry",
        "is_deleted",
        "jigsaw_company_id",
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
        "phone_number",
        "account_photo_url",
        "account_rating",
        "record_type_id",
        "shipping_city",
        CASE
            WHEN "shipping_country" = '8lPv4wLTKrJkp24M5lvnaQ==' THEN ''
            ELSE "shipping_country"
        END AS "shipping_country",
        CASE
            WHEN "shipping_country_code" = 'dRb9Q62qXguKZaZyw5hF0g==' THEN ''
            ELSE "shipping_country_code"
        END AS "shipping_country_code",
        "shipping_geocode_accuracy",
        "shipping_latitude",
        "shipping_longitude",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street",
        "sic_code",
        "sic_description",
        "account_site",
        "ticker_symbol",
        "account_type",
        "account_website",
        "is_active"
    FROM "sf_account_data_projected_renamed"
),

"sf_account_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- billing_city: ['']
    -- billing_country: ['']
    -- billing_country_code: ['']
    -- billing_state: ['']
    -- account_name: ['']
    -- shipping_country: ['']
    -- shipping_country_code: ['']
    SELECT 
        CASE
            WHEN "billing_city" = '' THEN NULL
            ELSE "billing_city"
        END AS "billing_city",
        CASE
            WHEN "billing_country" = '' THEN NULL
            ELSE "billing_country"
        END AS "billing_country",
        CASE
            WHEN "billing_country_code" = '' THEN NULL
            ELSE "billing_country_code"
        END AS "billing_country_code",
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
        CASE
            WHEN "shipping_country_code" = '' THEN NULL
            ELSE "shipping_country_code"
        END AS "shipping_country_code",
        "account_source",
        "shipping_postal_code",
        "shipping_longitude",
        "shipping_city",
        "shipping_state_code",
        "shipping_latitude",
        "annual_revenue",
        "employee_count",
        "parent_account_id",
        "billing_longitude",
        "is_deleted",
        "account_description",
        "record_type_id",
        "account_type",
        "account_photo_url",
        "account_id",
        "jigsaw_company_id",
        "ticker_symbol",
        "industry",
        "sic_description",
        "shipping_street",
        "billing_state_code",
        "last_viewed_date",
        "billing_latitude",
        "account_number",
        "last_referenced_date",
        "ownership_type",
        "master_record_id",
        "shipping_geocode_accuracy",
        "fax_number",
        "owner_id",
        "account_rating",
        "account_site",
        "shipping_state",
        "billing_street",
        "billing_postal_code",
        "billing_geocode_accuracy",
        "sic_code",
        "phone_number",
        "is_active",
        "account_website",
        "last_activity_date"
    FROM "sf_account_data_projected_renamed_cleaned"
),

"sf_account_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_number: from DECIMAL to VARCHAR
    -- account_rating: from DECIMAL to VARCHAR
    -- account_site: from DECIMAL to VARCHAR
    -- annual_revenue: from DECIMAL to VARCHAR
    -- billing_geocode_accuracy: from DECIMAL to VARCHAR
    -- employee_count: from DECIMAL to INT
    -- fax_number: from DECIMAL to VARCHAR
    -- jigsaw_company_id: from DECIMAL to VARCHAR
    -- last_activity_date: from DECIMAL to DATE
    -- last_referenced_date: from DECIMAL to DATE
    -- last_viewed_date: from DECIMAL to DATE
    -- ownership_type: from DECIMAL to VARCHAR
    -- parent_account_id: from DECIMAL to VARCHAR
    -- shipping_city: from DECIMAL to VARCHAR
    -- shipping_geocode_accuracy: from DECIMAL to VARCHAR
    -- shipping_postal_code: from DECIMAL to VARCHAR
    -- shipping_state: from DECIMAL to VARCHAR
    -- shipping_state_code: from DECIMAL to VARCHAR
    -- shipping_street: from DECIMAL to VARCHAR
    -- sic_code: from DECIMAL to VARCHAR
    -- sic_description: from DECIMAL to VARCHAR
    -- ticker_symbol: from DECIMAL to VARCHAR
    SELECT
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_state",
        "account_name",
        "shipping_country",
        "shipping_country_code",
        "account_source",
        "shipping_longitude",
        "shipping_latitude",
        "billing_longitude",
        "is_deleted",
        "account_description",
        "record_type_id",
        "account_type",
        "account_photo_url",
        "account_id",
        "industry",
        "billing_state_code",
        "billing_latitude",
        "master_record_id",
        "owner_id",
        "billing_street",
        "billing_postal_code",
        "phone_number",
        "is_active",
        "account_website",
        CAST("account_number" AS VARCHAR) AS "account_number",
        CAST("account_rating" AS VARCHAR) AS "account_rating",
        CAST("account_site" AS VARCHAR) AS "account_site",
        CAST("annual_revenue" AS VARCHAR) AS "annual_revenue",
        CAST("billing_geocode_accuracy" AS VARCHAR) AS "billing_geocode_accuracy",
        CAST("employee_count" AS INT) AS "employee_count",
        CAST("fax_number" AS VARCHAR) AS "fax_number",
        CAST("jigsaw_company_id" AS VARCHAR) AS "jigsaw_company_id",
        CAST("last_activity_date" AS DATE) AS "last_activity_date",
        CAST("last_referenced_date" AS DATE) AS "last_referenced_date",
        CAST("last_viewed_date" AS DATE) AS "last_viewed_date",
        CAST("ownership_type" AS VARCHAR) AS "ownership_type",
        CAST("parent_account_id" AS VARCHAR) AS "parent_account_id",
        CAST("shipping_city" AS VARCHAR) AS "shipping_city",
        CAST("shipping_geocode_accuracy" AS VARCHAR) AS "shipping_geocode_accuracy",
        CAST("shipping_postal_code" AS VARCHAR) AS "shipping_postal_code",
        CAST("shipping_state" AS VARCHAR) AS "shipping_state",
        CAST("shipping_state_code" AS VARCHAR) AS "shipping_state_code",
        CAST("shipping_street" AS VARCHAR) AS "shipping_street",
        CAST("sic_code" AS VARCHAR) AS "sic_code",
        CAST("sic_description" AS VARCHAR) AS "sic_description",
        CAST("ticker_symbol" AS VARCHAR) AS "ticker_symbol"
    FROM "sf_account_data_projected_renamed_cleaned_null"
),

"sf_account_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 20 columns with unacceptable missing values
    -- account_description has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- account_name has 70.0 percent missing. Strategy: 🔄 Unchanged
    -- account_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_rating has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_site has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- account_source has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- account_website has 40.0 percent missing. Strategy: 🔄 Unchanged
    -- annual_revenue has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_count has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- industry has 80.0 percent missing. Strategy: 🔄 Unchanged
    -- jigsaw_company_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_activity_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- master_record_id has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- ownership_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- phone_number has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- sic_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sic_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ticker_symbol has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_state",
        "account_name",
        "shipping_country",
        "shipping_country_code",
        "account_source",
        "shipping_longitude",
        "shipping_latitude",
        "billing_longitude",
        "is_deleted",
        "account_description",
        "record_type_id",
        "account_type",
        "account_photo_url",
        "account_id",
        "industry",
        "billing_state_code",
        "billing_latitude",
        "master_record_id",
        "owner_id",
        "billing_street",
        "billing_postal_code",
        "phone_number",
        "is_active",
        "account_website",
        "billing_geocode_accuracy",
        "employee_count",
        "fax_number",
        "parent_account_id",
        "shipping_city",
        "shipping_geocode_accuracy",
        "shipping_postal_code",
        "shipping_state",
        "shipping_state_code",
        "shipping_street"
    FROM "sf_account_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_account_data_projected_renamed_cleaned_null_casted_missing_handled"