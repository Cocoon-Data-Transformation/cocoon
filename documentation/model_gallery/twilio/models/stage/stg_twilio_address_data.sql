-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:30:22.217681+00:00
WITH 
"twilio_address_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "account_id",
        "city",
        "created_at",
        "customer_name",
        "emergency_enabled",
        "friendly_name",
        "iso_country",
        "postal_code",
        "region",
        "street",
        "updated_at",
        "validated",
        "verified"
    FROM "memory"."main"."twilio_address_data"
),

"twilio_address_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> address_id
    -- created_at -> creation_timestamp
    -- iso_country -> country_code
    -- region -> state_or_region
    -- street -> street_address
    -- updated_at -> last_updated_timestamp
    -- validated -> is_validated
    -- verified -> is_verified
    SELECT 
        "id" AS "address_id",
        "account_id",
        "city",
        "created_at" AS "creation_timestamp",
        "customer_name",
        "emergency_enabled",
        "friendly_name",
        "iso_country" AS "country_code",
        "postal_code",
        "region" AS "state_or_region",
        "street" AS "street_address",
        "updated_at" AS "last_updated_timestamp",
        "validated" AS "is_validated",
        "verified" AS "is_verified"
    FROM "twilio_address_data_projected"
),

"twilio_address_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- friendly_name: The problem is that the friendly_name column contains a single unusual value that combines a general label ("Address") with a precise timestamp. This is not a typical format for a friendly name, which should be more human-readable and less technical. The correct value should be just "Address" without the timestamp. 
    SELECT
        "address_id",
        "account_id",
        "city",
        "creation_timestamp",
        "customer_name",
        "emergency_enabled",
        CASE
            WHEN "friendly_name" = 'Address 2022-06-23T06:01:26.506384Z' THEN 'Address'
            ELSE "friendly_name"
        END AS "friendly_name",
        "country_code",
        "postal_code",
        "state_or_region",
        "street_address",
        "last_updated_timestamp",
        "is_validated",
        "is_verified"
    FROM "twilio_address_data_projected_renamed"
),

"twilio_address_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- customer_name: from DECIMAL to VARCHAR
    -- last_updated_timestamp: from VARCHAR to TIMESTAMP
    -- postal_code: from INT to VARCHAR
    SELECT
        "address_id",
        "account_id",
        "city",
        "emergency_enabled",
        "friendly_name",
        "country_code",
        "state_or_region",
        "street_address",
        "is_validated",
        "is_verified",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("customer_name" AS VARCHAR) AS "customer_name",
        CAST("last_updated_timestamp" AS TIMESTAMP) AS "last_updated_timestamp",
        CAST("postal_code" AS VARCHAR) AS "postal_code"
    FROM "twilio_address_data_projected_renamed_cleaned"
),

"twilio_address_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- customer_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "address_id",
        "account_id",
        "city",
        "emergency_enabled",
        "friendly_name",
        "country_code",
        "state_or_region",
        "street_address",
        "is_validated",
        "is_verified",
        "creation_timestamp",
        "last_updated_timestamp",
        "postal_code"
    FROM "twilio_address_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_address_data_projected_renamed_cleaned_casted_missing_handled"