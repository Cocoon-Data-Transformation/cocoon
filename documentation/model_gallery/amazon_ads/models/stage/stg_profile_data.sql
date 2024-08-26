-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:37:43.834182+00:00
WITH 
"profile_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['id', '_fivetran_deleted', '_fivetran_synced', 'account_id', 'account_marketplace_string_id', 'account_name', 'account_sub_type', 'account_type', 'account_valid_payment_method', 'country_code', 'currency_code', 'daily_budget', 'timezone']
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
    FROM "memory"."main"."profile_data"
),

"profile_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- account_marketplace_string_id -> marketplace_id
    -- account_valid_payment_method -> has_valid_payment
    SELECT 
        "id",
        "_fivetran_deleted" AS "is_deleted",
        "account_id",
        "account_marketplace_string_id" AS "marketplace_id",
        "account_name",
        "account_sub_type",
        "account_type",
        "account_valid_payment_method" AS "has_valid_payment",
        "country_code",
        "currency_code",
        "daily_budget",
        "timezone"
    FROM "profile_data_projected"
),

"profile_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- daily_budget: from INT to DECIMAL
    SELECT
        "id",
        "is_deleted",
        "account_id",
        "marketplace_id",
        "account_name",
        "account_sub_type",
        "account_type",
        "has_valid_payment",
        "country_code",
        "currency_code",
        "timezone",
        CAST("daily_budget" AS DECIMAL) 
        AS "daily_budget"
    FROM "profile_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "profile_data_projected_renamed_casted"