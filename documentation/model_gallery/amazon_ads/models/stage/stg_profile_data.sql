-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"profile_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "account_id",
        "account_marketplace_string_id",
        "account_name",
        "account_sub_type",
        "account_type",
        "account_valid_payment_method",
        "country_code",
        "currency_code",
        "daily_budget",
        "timezone"
    FROM "profile_data"
),

"profile_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> profile_id
    -- _fivetran_deleted -> is_deleted
    -- account_marketplace_string_id -> marketplace_account_id
    -- account_valid_payment_method -> has_valid_payment_method
    SELECT 
        id AS profile_id,
        _fivetran_deleted AS is_deleted,
        account_id,
        account_marketplace_string_id AS marketplace_account_id,
        account_name,
        account_sub_type,
        account_type,
        account_valid_payment_method AS has_valid_payment_method,
        country_code,
        currency_code,
        daily_budget,
        timezone
    FROM profile_data_projected
),

"profile_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- daily_budget: from INT to DECIMAL
    SELECT
        "profile_id",
        "is_deleted",
        "account_id",
        "marketplace_account_id",
        "account_name",
        "account_sub_type",
        "account_type",
        "has_valid_payment_method",
        "country_code",
        "currency_code",
        "timezone",
        CAST("daily_budget" AS DECIMAL) AS "daily_budget"
    FROM "profile_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "profile_data_projected_renamed_casted"