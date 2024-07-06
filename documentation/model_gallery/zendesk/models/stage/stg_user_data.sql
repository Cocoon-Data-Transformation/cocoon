-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"user_data_projected" AS (
    -- Projection: Selecting 31 out of 32 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "active",
        "alias",
        "authenticity_token",
        "chat_only",
        "created_at",
        "details",
        "email",
        "external_id",
        "last_login_at",
        "locale",
        "locale_id",
        "moderator",
        "name",
        "notes",
        "only_private_comments",
        "organization_id",
        "phone",
        "remote_photo_url",
        "restricted_agent",
        "role",
        "shared",
        "shared_agent",
        "signature",
        "suspended",
        "ticket_restriction",
        "time_zone",
        "two_factor_auth_enabled",
        "updated_at",
        "url",
        "verified"
    FROM "user_data"
),

"user_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> user_id
    -- active -> is_active
    -- authenticity_token -> auth_token
    -- chat_only -> is_chat_only
    -- created_at -> creation_date
    -- details -> additional_details
    -- last_login_at -> last_login_date
    -- moderator -> is_moderator
    -- name -> full_name
    -- only_private_comments -> private_comments_only
    -- phone -> phone_number
    -- remote_photo_url -> photo_url
    -- restricted_agent -> is_restricted_agent
    -- role -> user_role
    -- shared -> is_shared
    -- shared_agent -> is_shared_agent
    -- suspended -> is_suspended
    -- two_factor_auth_enabled -> is_2fa_enabled
    -- updated_at -> last_update_date
    -- url -> api_url
    -- verified -> account_verified
    SELECT 
        "id" AS "user_id",
        "active" AS "is_active",
        "alias",
        "authenticity_token" AS "auth_token",
        "chat_only" AS "is_chat_only",
        "created_at" AS "creation_date",
        "details" AS "additional_details",
        "email",
        "external_id",
        "last_login_at" AS "last_login_date",
        "locale",
        "locale_id",
        "moderator" AS "is_moderator",
        "name" AS "full_name",
        "notes",
        "only_private_comments" AS "private_comments_only",
        "organization_id",
        "phone" AS "phone_number",
        "remote_photo_url" AS "photo_url",
        "restricted_agent" AS "is_restricted_agent",
        "role" AS "user_role",
        "shared" AS "is_shared",
        "shared_agent" AS "is_shared_agent",
        "signature",
        "suspended" AS "is_suspended",
        "ticket_restriction",
        "time_zone",
        "two_factor_auth_enabled" AS "is_2fa_enabled",
        "updated_at" AS "last_update_date",
        "url" AS "api_url",
        "verified" AS "account_verified"
    FROM "user_data_projected"
),

"user_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- additional_details: from DECIMAL to VARCHAR
    -- alias: from DECIMAL to VARCHAR
    -- auth_token: from DECIMAL to VARCHAR
    -- creation_date: from VARCHAR to TIMESTAMP
    -- external_id: from DECIMAL to VARCHAR
    -- last_login_date: from VARCHAR to TIMESTAMP
    -- last_update_date: from VARCHAR to TIMESTAMP
    -- notes: from DECIMAL to VARCHAR
    -- phone_number: from DECIMAL to VARCHAR
    -- photo_url: from DECIMAL to VARCHAR
    -- signature: from DECIMAL to VARCHAR
    -- user_id: from INT to VARCHAR
    SELECT
        "is_active",
        "is_chat_only",
        "email",
        "locale",
        "locale_id",
        "is_moderator",
        "full_name",
        "private_comments_only",
        "organization_id",
        "is_restricted_agent",
        "user_role",
        "is_shared",
        "is_shared_agent",
        "is_suspended",
        "ticket_restriction",
        "time_zone",
        "is_2fa_enabled",
        "api_url",
        "account_verified",
        CAST("additional_details" AS VARCHAR) AS "additional_details",
        CAST("alias" AS VARCHAR) AS "alias",
        CAST("auth_token" AS VARCHAR) AS "auth_token",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("external_id" AS VARCHAR) AS "external_id",
        CAST("last_login_date" AS TIMESTAMP) AS "last_login_date",
        CAST("last_update_date" AS TIMESTAMP) AS "last_update_date",
        CAST("notes" AS VARCHAR) AS "notes",
        CAST("phone_number" AS VARCHAR) AS "phone_number",
        CAST("photo_url" AS VARCHAR) AS "photo_url",
        CAST("signature" AS VARCHAR) AS "signature",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "user_data_projected_renamed"
),

"user_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 8 columns with unacceptable missing values
    -- additional_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- auth_token has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- organization_id has 10.0 percent missing. Strategy: 🔄 Unchanged
    -- phone_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- photo_url has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- signature has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_active",
        "is_chat_only",
        "email",
        "locale",
        "locale_id",
        "is_moderator",
        "full_name",
        "private_comments_only",
        "organization_id",
        "is_restricted_agent",
        "user_role",
        "is_shared",
        "is_shared_agent",
        "is_suspended",
        "ticket_restriction",
        "time_zone",
        "is_2fa_enabled",
        "api_url",
        "account_verified",
        "alias",
        "creation_date",
        "last_login_date",
        "last_update_date",
        "user_id"
    FROM "user_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "user_data_projected_renamed_casted_missing_handled"