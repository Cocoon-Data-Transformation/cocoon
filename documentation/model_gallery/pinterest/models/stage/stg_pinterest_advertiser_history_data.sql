-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_advertiser_history_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "updated_time",
        "billing_profile_status",
        "billing_type",
        "country",
        "created_time",
        "currency",
        "merchant_id",
        "name",
        "owner_user_id",
        "status",
        "owner_username",
        "permissions"
    FROM "pinterest_advertiser_history_data"
),

"pinterest_advertiser_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> advertiser_id
    -- updated_time -> last_updated_date
    -- billing_profile_status -> billing_status
    -- billing_type -> payment_method
    -- created_time -> account_creation_date
    -- currency -> account_currency
    -- name -> account_name
    -- owner_user_id -> owner_id
    -- status -> account_status
    -- permissions -> account_permissions
    SELECT 
        "id" AS "advertiser_id",
        "updated_time" AS "last_updated_date",
        "billing_profile_status" AS "billing_status",
        "billing_type" AS "payment_method",
        "country",
        "created_time" AS "account_creation_date",
        "currency" AS "account_currency",
        "merchant_id",
        "name" AS "account_name",
        "owner_user_id" AS "owner_id",
        "status" AS "account_status",
        "owner_username",
        "permissions" AS "account_permissions"
    FROM "pinterest_advertiser_history_data_projected"
),

"pinterest_advertiser_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- owner_username: The problem is that 'username' is a generic placeholder value and not a real username. In a real dataset, this column should contain actual usernames of the owners. Since we don't have any real usernames to map to, and a generic placeholder is not meaningful data, we should map this to an empty string. 
    -- account_permissions: The problem is that 'string' is being used as a placeholder value for the account_permissions column, which is not a meaningful representation of actual account permissions. This suggests that either the real permission data is missing or was not properly populated. In a real-world scenario, account permissions would typically be specific descriptors like 'read', 'write', 'admin', or combinations of these. Without knowing the intended permission structure for this system, we can't map 'string' to a correct value. The best approach is to map it to an empty string to indicate missing data. 
    SELECT
        "advertiser_id",
        "last_updated_date",
        "billing_status",
        "payment_method",
        "country",
        "account_creation_date",
        "account_currency",
        "merchant_id",
        "account_name",
        "owner_id",
        "account_status",
        CASE
            WHEN "owner_username" = 'username' THEN ''
            ELSE "owner_username"
        END AS "owner_username",
        CASE
            WHEN "account_permissions" = 'string' THEN ''
            ELSE "account_permissions"
        END AS "account_permissions"
    FROM "pinterest_advertiser_history_data_projected_renamed"
),

"pinterest_advertiser_history_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- owner_username: ['']
    -- account_permissions: ['']
    SELECT 
        CASE
            WHEN "owner_username" = '' THEN NULL
            ELSE "owner_username"
        END AS "owner_username",
        CASE
            WHEN "account_permissions" = '' THEN NULL
            ELSE "account_permissions"
        END AS "account_permissions",
        "owner_id",
        "payment_method",
        "advertiser_id",
        "billing_status",
        "account_status",
        "country",
        "account_creation_date",
        "account_currency",
        "merchant_id",
        "account_name",
        "last_updated_date"
    FROM "pinterest_advertiser_history_data_projected_renamed_cleaned"
),

"pinterest_advertiser_history_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_creation_date: from VARCHAR to TIMESTAMP
    -- advertiser_id: from INT to VARCHAR
    -- last_updated_date: from VARCHAR to TIMESTAMP
    -- merchant_id: from DECIMAL to VARCHAR
    -- owner_id: from INT to VARCHAR
    SELECT
        "owner_username",
        "account_permissions",
        "payment_method",
        "billing_status",
        "account_status",
        "country",
        "account_currency",
        "account_name",
        CAST("account_creation_date" AS TIMESTAMP) AS "account_creation_date",
        CAST("advertiser_id" AS VARCHAR) AS "advertiser_id",
        CAST("last_updated_date" AS TIMESTAMP) AS "last_updated_date",
        CAST("merchant_id" AS VARCHAR) AS "merchant_id",
        CAST("owner_id" AS VARCHAR) AS "owner_id"
    FROM "pinterest_advertiser_history_data_projected_renamed_cleaned_null"
),

"pinterest_advertiser_history_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- account_permissions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- owner_username has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "payment_method",
        "billing_status",
        "account_status",
        "country",
        "account_currency",
        "account_name",
        "account_creation_date",
        "advertiser_id",
        "last_updated_date",
        "merchant_id",
        "owner_id"
    FROM "pinterest_advertiser_history_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_advertiser_history_data_projected_renamed_cleaned_null_casted_missing_handled"