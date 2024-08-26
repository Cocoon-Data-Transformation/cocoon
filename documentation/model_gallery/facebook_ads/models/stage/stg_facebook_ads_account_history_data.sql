-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 15:52:41.052926+00:00
WITH 
"facebook_ads_account_history_data_projected" AS (
    -- Projection: Selecting 7 out of 8 columns
    -- Columns projected out: ['id', 'name', '_fivetran_synced', 'account_status', 'business_country_code', 'created_time', 'currency', 'timezone_name']
    SELECT 
        "id",
        "name",
        "account_status",
        "business_country_code",
        "created_time",
        "currency",
        "timezone_name"
    FROM "memory"."main"."facebook_ads_account_history_data"
),

"facebook_ads_account_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> account_id
    -- name -> encrypted_account_name
    -- business_country_code -> country_code
    -- created_time -> creation_timestamp
    -- currency -> account_currency
    -- timezone_name -> account_timezone
    SELECT 
        "id" AS "account_id",
        "name" AS "encrypted_account_name",
        "account_status",
        "business_country_code" AS "country_code",
        "created_time" AS "creation_timestamp",
        "currency" AS "account_currency",
        "timezone_name" AS "account_timezone"
    FROM "facebook_ads_account_history_data_projected"
),

"facebook_ads_account_history_data_projected_renamed_dedup" AS (
    -- Deduplication: Removed 7 duplicated rows
    SELECT DISTINCT *
    FROM "facebook_ads_account_history_data_projected_renamed"
),

"facebook_ads_account_history_data_projected_renamed_dedup_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "encrypted_account_name",
        "account_status",
        "country_code",
        "account_currency",
        "account_timezone",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("creation_timestamp" AS TIMESTAMP) 
        AS "creation_timestamp"
    FROM "facebook_ads_account_history_data_projected_renamed_dedup"
)

-- COCOON BLOCK END
SELECT *
FROM "facebook_ads_account_history_data_projected_renamed_dedup_casted"