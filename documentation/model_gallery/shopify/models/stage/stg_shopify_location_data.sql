-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_location_data_projected" AS (
    -- Projection: Selecting 19 out of 20 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "active",
        "address_1",
        "address_2",
        "city",
        "country",
        "created_at",
        "legacy",
        "name",
        "phone",
        "province",
        "updated_at",
        "zip",
        "country_code",
        "country_name",
        "localized_country_name",
        "localized_province_name",
        "province_code",
        "_fivetran_deleted"
    FROM "shopify_location_data"
),

"shopify_location_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> location_id
    -- active -> is_active
    -- address_1 -> primary_address
    -- address_2 -> secondary_address
    -- country -> country_code
    -- created_at -> creation_timestamp
    -- legacy -> is_legacy
    -- name -> location_name
    -- phone -> phone_number
    -- province -> province_state
    -- updated_at -> last_update_timestamp
    -- zip -> postal_code
    -- country_code -> iso_country_code
    -- localized_country_name -> local_country_name
    -- localized_province_name -> local_province_name
    -- province_code -> province_state_code
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "id" AS "location_id",
        "active" AS "is_active",
        "address_1" AS "primary_address",
        "address_2" AS "secondary_address",
        "city",
        "country" AS "country_code",
        "created_at" AS "creation_timestamp",
        "legacy" AS "is_legacy",
        "name" AS "location_name",
        "phone" AS "phone_number",
        "province" AS "province_state",
        "updated_at" AS "last_update_timestamp",
        "zip" AS "postal_code",
        "country_code" AS "iso_country_code",
        "country_name",
        "localized_country_name" AS "local_country_name",
        "localized_province_name" AS "local_province_name",
        "province_code" AS "province_state_code",
        "_fivetran_deleted" AS "is_deleted"
    FROM "shopify_location_data_projected"
),

"shopify_location_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- city: The problem is that 'Tree' is not a valid city name. It appears that this column has been mistakenly populated with data that should belong to a different column, likely one describing types of vegetation or natural features. Since we don't have the correct city information and 'Tree' is meaningless in this context, we should map it to an empty string to indicate missing data. 
    -- local_province_name: The problem is a misspelling in the local_province_name column. The value 'New Yorl' is a typo and should be corrected to 'New York'. This is likely a data entry error where the 'k' was accidentally typed as 'l'. 
    SELECT
        "location_id",
        "is_active",
        "primary_address",
        "secondary_address",
        CASE
            WHEN "city" = 'Tree' THEN ''
            ELSE "city"
        END AS "city",
        "country_code",
        "creation_timestamp",
        "is_legacy",
        "location_name",
        "phone_number",
        "province_state",
        "last_update_timestamp",
        "postal_code",
        "iso_country_code",
        "country_name",
        "local_country_name",
        CASE
            WHEN "local_province_name" = 'New Yorl' THEN 'New York'
            ELSE "local_province_name"
        END AS "local_province_name",
        "province_state_code",
        "is_deleted"
    FROM "shopify_location_data_projected_renamed"
),

"shopify_location_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- city: ['']
    SELECT 
        CASE
            WHEN "city" = '' THEN NULL
            ELSE "city"
        END AS "city",
        "is_deleted",
        "location_name",
        "is_active",
        "province_state",
        "is_legacy",
        "local_province_name",
        "country_name",
        "province_state_code",
        "postal_code",
        "primary_address",
        "iso_country_code",
        "location_id",
        "secondary_address",
        "local_country_name",
        "phone_number",
        "country_code",
        "creation_timestamp",
        "last_update_timestamp"
    FROM "shopify_location_data_projected_renamed_cleaned"
),

"shopify_location_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_update_timestamp: from VARCHAR to TIMESTAMP
    -- phone_number: from DECIMAL to VARCHAR
    -- postal_code: from DECIMAL to VARCHAR
    -- secondary_address: from DECIMAL to VARCHAR
    SELECT
        "city",
        "is_deleted",
        "location_name",
        "is_active",
        "province_state",
        "is_legacy",
        "local_province_name",
        "country_name",
        "province_state_code",
        "primary_address",
        "iso_country_code",
        "location_id",
        "local_country_name",
        "country_code",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("last_update_timestamp" AS TIMESTAMP) AS "last_update_timestamp",
        CAST("phone_number" AS VARCHAR) AS "phone_number",
        CAST("postal_code" AS VARCHAR) AS "postal_code",
        CAST("secondary_address" AS VARCHAR) AS "secondary_address"
    FROM "shopify_location_data_projected_renamed_cleaned_null"
),

"shopify_location_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 7 columns with unacceptable missing values
    -- city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- local_province_name has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- phone_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- postal_code has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- primary_address has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- province_state has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- province_state_code has 50.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "is_deleted",
        "location_name",
        "is_active",
        "province_state",
        "is_legacy",
        "local_province_name",
        "country_name",
        "province_state_code",
        "primary_address",
        "iso_country_code",
        "location_id",
        "local_country_name",
        "country_code",
        "creation_timestamp",
        "last_update_timestamp",
        "postal_code",
        "secondary_address"
    FROM "shopify_location_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_location_data_projected_renamed_cleaned_null_casted_missing_handled"