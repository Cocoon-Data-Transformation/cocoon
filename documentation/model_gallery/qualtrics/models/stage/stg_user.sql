-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:02:37.875113+00:00
WITH 
"user_projected" AS (
    -- Projection: Selecting 21 out of 22 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "account_creation_date",
        "account_expiration_date",
        "account_status",
        "division_id",
        "email",
        "first_name",
        "language_",
        "last_login_date",
        "last_name",
        "organization_id",
        "password_expiration_date",
        "password_last_changed_date",
        "response_count_auditable",
        "response_count_deleted",
        "response_count_generated",
        "time_zone",
        "unsubscribed",
        "user_type",
        "username"
    FROM "memory"."main"."user"
),

"user_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> user_id
    -- _fivetran_deleted -> is_deleted
    -- language_ -> preferred_language
    -- response_count_auditable -> auditable_response_count
    -- response_count_deleted -> deleted_response_count
    -- response_count_generated -> generated_response_count
    -- unsubscribed -> is_unsubscribed
    SELECT 
        "id" AS "user_id",
        "_fivetran_deleted" AS "is_deleted",
        "account_creation_date",
        "account_expiration_date",
        "account_status",
        "division_id",
        "email",
        "first_name",
        "language_" AS "preferred_language",
        "last_login_date",
        "last_name",
        "organization_id",
        "password_expiration_date",
        "password_last_changed_date",
        "response_count_auditable" AS "auditable_response_count",
        "response_count_deleted" AS "deleted_response_count",
        "response_count_generated" AS "generated_response_count",
        "time_zone",
        "unsubscribed" AS "is_unsubscribed",
        "user_type",
        "username"
    FROM "user_projected"
),

"user_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- first_name: The problem is that 'Cat' and 'Puppy' are animal names, not typical human first names. They are likely placeholder or test data that was mistakenly left in the dataset. Since these values do not represent actual human first names, they should be replaced with empty strings to indicate missing or invalid data. 
    -- last_name: The problem is that both "Developers" and "Meow" are unusual for last names. "Developers" appears to be a job title or group name rather than a family name. "Meow" is typically associated with the sound a cat makes and is not a common surname. Neither of these represents typical family names. Since we don't have additional information to determine the correct last names for these entries, the best approach is to map these unusual values to an empty string, indicating that the last name is unknown or not provided. 
    SELECT
        "user_id",
        "is_deleted",
        "account_creation_date",
        "account_expiration_date",
        "account_status",
        "division_id",
        "email",
        CASE
            WHEN "first_name" = '''Cat''' THEN ''''
            WHEN "first_name" = '''Puppy''' THEN ''''
            ELSE "first_name"
        END AS "first_name",
        "preferred_language",
        "last_login_date",
        CASE
            WHEN "last_name" = '''Developers''' THEN ''''
            WHEN "last_name" = '''Meow''' THEN ''''
            ELSE "last_name"
        END AS "last_name",
        "organization_id",
        "password_expiration_date",
        "password_last_changed_date",
        "auditable_response_count",
        "deleted_response_count",
        "generated_response_count",
        "time_zone",
        "is_unsubscribed",
        "user_type",
        "username"
    FROM "user_projected_renamed"
),

"user_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_creation_date: from DECIMAL to TIMESTAMP
    -- account_expiration_date: from DECIMAL to TIMESTAMP
    -- auditable_response_count: from DECIMAL to INT
    -- deleted_response_count: from DECIMAL to INT
    -- division_id: from DECIMAL to VARCHAR
    -- generated_response_count: from DECIMAL to INT
    -- is_unsubscribed: from DECIMAL to BOOLEAN
    -- last_login_date: from DECIMAL to TIMESTAMP
    -- organization_id: from DECIMAL to VARCHAR
    -- password_expiration_date: from DECIMAL to TIMESTAMP
    -- password_last_changed_date: from DECIMAL to TIMESTAMP
    -- preferred_language: from DECIMAL to VARCHAR
    -- time_zone: from DECIMAL to VARCHAR
    SELECT
        "user_id",
        "is_deleted",
        "account_status",
        "email",
        "first_name",
        "last_name",
        "user_type",
        "username",
        CAST("account_creation_date" AS TIMESTAMP) AS "account_creation_date",
        CAST("account_expiration_date" AS TIMESTAMP) AS "account_expiration_date",
        CAST("auditable_response_count" AS INT) AS "auditable_response_count",
        CAST("deleted_response_count" AS INT) AS "deleted_response_count",
        CAST("division_id" AS VARCHAR) AS "division_id",
        CAST("generated_response_count" AS INT) AS "generated_response_count",
        CAST("is_unsubscribed" AS BOOLEAN) AS "is_unsubscribed",
        CAST("last_login_date" AS TIMESTAMP) AS "last_login_date",
        CAST("organization_id" AS VARCHAR) AS "organization_id",
        CAST("password_expiration_date" AS TIMESTAMP) AS "password_expiration_date",
        CAST("password_last_changed_date" AS TIMESTAMP) AS "password_last_changed_date",
        CAST("preferred_language" AS VARCHAR) AS "preferred_language",
        CAST("time_zone" AS VARCHAR) AS "time_zone"
    FROM "user_projected_renamed_cleaned"
),

"user_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 12 columns with unacceptable missing values
    -- account_creation_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- auditable_response_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- deleted_response_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- division_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- generated_response_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_unsubscribed has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_login_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- organization_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- password_expiration_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- password_last_changed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- preferred_language has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- time_zone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "user_id",
        "is_deleted",
        "account_status",
        "email",
        "first_name",
        "last_name",
        "user_type",
        "username",
        "account_expiration_date"
    FROM "user_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "user_projected_renamed_cleaned_casted_missing_handled"