-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 03:13:44.551700+00:00
WITH 
"sf_user_data_projected" AS (
    -- Projection: Selecting 65 out of 66 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_deleted",
        "about_me",
        "account_id",
        "alias",
        "badge_text",
        "banner_photo_url",
        "call_center_id",
        "city",
        "community_nickname",
        "company_name",
        "contact_id",
        "country",
        "country_code",
        "default_group_notification_frequency",
        "delegated_approver_id",
        "department",
        "digest_frequency",
        "division",
        "email",
        "email_encoding_key",
        "email_preferences_auto_bcc",
        "employee_number",
        "extension",
        "fax",
        "federation_identifier",
        "first_name",
        "forecast_enabled",
        "full_photo_url",
        "geocode_accuracy",
        "id",
        "individual_id",
        "is_active",
        "is_profile_photo_active",
        "language_locale_key",
        "last_login_date",
        "last_name",
        "last_referenced_date",
        "last_viewed_date",
        "latitude",
        "locale_sid_key",
        "longitude",
        "manager_id",
        "medium_banner_photo_url",
        "mobile_phone",
        "name",
        "offline_trial_expiration_date",
        "phone",
        "postal_code",
        "profile_id",
        "receives_admin_info_emails",
        "receives_info_emails",
        "sender_email",
        "sender_name",
        "signature",
        "small_banner_photo_url",
        "small_photo_url",
        "state",
        "state_code",
        "street",
        "time_zone_sid_key",
        "title",
        "user_role_id",
        "user_type",
        "username",
        "_fivetran_active"
    FROM "MyAppDB"."dbo"."sf_user_data"
),

"sf_user_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- default_group_notification_frequency -> group_notification_frequency
    -- email_preferences_auto_bcc -> auto_bcc_enabled
    -- extension -> phone_extension
    -- fax -> fax_number
    -- is_profile_photo_active -> has_active_profile_photo
    -- language_locale_key -> language_locale
    -- locale_sid_key -> locale_sid
    -- name -> full_name
    -- offline_trial_expiration_date -> offline_trial_expiration
    -- receives_admin_info_emails -> receives_admin_emails
    -- signature -> email_signature
    -- street -> street_address
    -- time_zone_sid_key -> time_zone_sid
    -- title -> user_title
    SELECT 
        "_fivetran_deleted" AS "is_deleted",
        "about_me",
        "account_id",
        "alias",
        "badge_text",
        "banner_photo_url",
        "call_center_id",
        "city",
        "community_nickname",
        "company_name",
        "contact_id",
        "country",
        "country_code",
        "default_group_notification_frequency" AS "group_notification_frequency",
        "delegated_approver_id",
        "department",
        "digest_frequency",
        "division",
        "email",
        "email_encoding_key",
        "email_preferences_auto_bcc" AS "auto_bcc_enabled",
        "employee_number",
        "extension" AS "phone_extension",
        "fax" AS "fax_number",
        "federation_identifier",
        "first_name",
        "forecast_enabled",
        "full_photo_url",
        "geocode_accuracy",
        "id",
        "individual_id",
        "is_active",
        "is_profile_photo_active" AS "has_active_profile_photo",
        "language_locale_key" AS "language_locale",
        "last_login_date",
        "last_name",
        "last_referenced_date",
        "last_viewed_date",
        "latitude",
        "locale_sid_key" AS "locale_sid",
        "longitude",
        "manager_id",
        "medium_banner_photo_url",
        "mobile_phone",
        "name" AS "full_name",
        "offline_trial_expiration_date" AS "offline_trial_expiration",
        "phone",
        "postal_code",
        "profile_id",
        "receives_admin_info_emails" AS "receives_admin_emails",
        "receives_info_emails",
        "sender_email",
        "sender_name",
        "signature" AS "email_signature",
        "small_banner_photo_url",
        "small_photo_url",
        "state",
        "state_code",
        "street" AS "street_address",
        "time_zone_sid_key" AS "time_zone_sid",
        "title" AS "user_title",
        "user_role_id",
        "user_type",
        "username",
        "_fivetran_active"
    FROM "sf_user_data_projected"
),

"sf_user_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- badge_text: The problem is that the badge_text column contains a Base64 encoded string instead of human-readable text. Base64 encoding is typically used for binary data or to obfuscate information, not for displaying badge text. The value '1B2M2Y8AsgTpgAmY7PhCfg==' is a Base64 encoded string that, when decoded, actually represents an empty string. This suggests that the badge_text field was likely meant to be empty or null, but was incorrectly encoded. The correct value for a badge that doesn't have any text should be an empty string.
    -- country: The problem is that the value '8lPv4wLTKrJkp24M5lvnaQ==' in the country column appears to be an encoded string, possibly in Base64 format. This is unusual because country names are typically represented as plaintext strings (e.g., "United States", "Canada", "France"). The encoded string does not represent a recognizable country name and is likely the result of an error in data processing or storage. Since we cannot determine the actual country this encoded string was meant to represent, the correct approach would be to map it to an empty string or a placeholder indicating missing data.
    -- country_code: The problem is that the value 'dRb9Q62qXguKZaZyw5hF0g==' is not a valid country code. It appears to be an encoded string, possibly in Base64 format. Country codes are typically 2 or 3 letter abbreviations (e.g., 'US' for United States, 'GB' for Great Britain). Without additional information or context about what this encoded string represents, it's impossible to determine the correct country code. The correct values should be standard country codes.
    -- digest_frequency: The problem is that the digest_frequency column contains an encoded value '9iPnWvMOYrvXPW31tQu3tQ==' which is not human-readable and does not represent a typical frequency value. This appears to be a base64 encoded string, which is unusual for a digest frequency field. Typically, digest frequencies would be represented by more straightforward terms like 'daily', 'weekly', 'monthly', etc. Without more context or a way to decode this value, it's impossible to determine what frequency it represents. 
    -- language_locale: The problem is that the value 'cQlcVsZB8sSk8Ym53816OA==' appears to be an encoded string, possibly in Base64 format. This is not a valid language locale value. Language locales are typically represented in formats like 'en-US' for English (United States) or 'fr-FR' for French (France). The correct values should be standard language locale codes.
    -- phone: The problem is that the phone number appears to be encrypted or encoded, rather than in a standard phone number format. The value "GiIWsKPHcUq7qMJlqOKAWQ==" looks like it could be a Base64 encoded string, which is often used for encrypting or encoding data. Without knowing the decryption key or method, it's impossible to convert this back to a standard phone number format. The correct values would be actual phone numbers, but we don't have that information.
    -- user_title: The problem is that the user_title column contains an encoded string rather than a readable title. This encoded string 'ieakxsZwGEBdpS1879Gv/Q==' appears to be a Base64 encoded value, which is not meaningful or readable as a user title. The correct values for user titles should be human-readable text describing the user's title or role. Since we don't have the original unencoded value and can't determine what the actual title should be, the best approach is to map this encoded string to an empty string.
    -- user_type: The problem is that the user_type column contains Base64 encoded values, which is unusual for a user_type field. Typically, user types would be clear text values like "admin", "regular", "premium", etc. The Base64 encoding suggests the data may be encrypted or hashed for security reasons. However, without knowing the decryption key or hashing algorithm, we cannot determine the actual user types. Since there is only one unique value present, and we don't have enough information to decode it, the best approach is to keep the value as-is for now, pending further investigation or clarification from the data owners.
    SELECT
        "is_deleted",
        "about_me",
        "account_id",
        "alias",
        CASE
            WHEN "badge_text" = '1B2M2Y8AsgTpgAmY7PhCfg==' THEN NULL
            ELSE "badge_text"
        END AS "badge_text",
        "banner_photo_url",
        "call_center_id",
        "city",
        "community_nickname",
        "company_name",
        "contact_id",
        CASE
            WHEN "country" = '8lPv4wLTKrJkp24M5lvnaQ==' THEN NULL
            ELSE "country"
        END AS "country",
        CASE
            WHEN "country_code" = 'dRb9Q62qXguKZaZyw5hF0g==' THEN NULL
            ELSE "country_code"
        END AS "country_code",
        "group_notification_frequency",
        "delegated_approver_id",
        "department",
        CASE
            WHEN "digest_frequency" = '9iPnWvMOYrvXPW31tQu3tQ==' THEN NULL
            ELSE "digest_frequency"
        END AS "digest_frequency",
        "division",
        "email",
        "email_encoding_key",
        "auto_bcc_enabled",
        "employee_number",
        "phone_extension",
        "fax_number",
        "federation_identifier",
        "first_name",
        "forecast_enabled",
        "full_photo_url",
        "geocode_accuracy",
        "id",
        "individual_id",
        "is_active",
        "has_active_profile_photo",
        CASE
            WHEN "language_locale" = 'cQlcVsZB8sSk8Ym53816OA==' THEN NULL
            ELSE "language_locale"
        END AS "language_locale",
        "last_login_date",
        "last_name",
        "last_referenced_date",
        "last_viewed_date",
        "latitude",
        "locale_sid",
        "longitude",
        "manager_id",
        "medium_banner_photo_url",
        "mobile_phone",
        "full_name",
        "offline_trial_expiration",
        CASE
            WHEN "phone" = 'GiIWsKPHcUq7qMJlqOKAWQ==' THEN NULL
            ELSE "phone"
        END AS "phone",
        "postal_code",
        "profile_id",
        "receives_admin_emails",
        "receives_info_emails",
        "sender_email",
        "sender_name",
        "email_signature",
        "small_banner_photo_url",
        "small_photo_url",
        "state",
        "state_code",
        "street_address",
        "time_zone_sid",
        CASE
            WHEN "user_title" = 'ieakxsZwGEBdpS1879Gv/Q==' THEN NULL
            ELSE "user_title"
        END AS "user_title",
        "user_role_id",
        "user_type",
        "username",
        "_fivetran_active"
    FROM "sf_user_data_projected_renamed"
),

"sf_user_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- full_name: ['empty account']
    SELECT 
        CASE
            WHEN "full_name" = 'empty account' THEN NULL
            ELSE "full_name"
        END AS "full_name",
        "user_title",
        "division",
        "locale_sid",
        "federation_identifier",
        "digest_frequency",
        "call_center_id",
        "country_code",
        "contact_id",
        "offline_trial_expiration",
        "auto_bcc_enabled",
        "id",
        "account_id",
        "delegated_approver_id",
        "state",
        "mobile_phone",
        "state_code",
        "first_name",
        "group_notification_frequency",
        "email_encoding_key",
        "phone_extension",
        "forecast_enabled",
        "geocode_accuracy",
        "postal_code",
        "profile_id",
        "employee_number",
        "city",
        "medium_banner_photo_url",
        "phone",
        "is_active",
        "user_role_id",
        "last_login_date",
        "_fivetran_active",
        "small_banner_photo_url",
        "has_active_profile_photo",
        "last_referenced_date",
        "latitude",
        "user_type",
        "username",
        "community_nickname",
        "receives_info_emails",
        "language_locale",
        "receives_admin_emails",
        "alias",
        "badge_text",
        "company_name",
        "department",
        "street_address",
        "fax_number",
        "sender_name",
        "banner_photo_url",
        "manager_id",
        "country",
        "sender_email",
        "email",
        "about_me",
        "longitude",
        "email_signature",
        "individual_id",
        "last_name",
        "last_viewed_date",
        "small_photo_url",
        "time_zone_sid",
        "full_photo_url",
        "is_deleted"
    FROM "sf_user_data_projected_renamed_cleaned"
),

"sf_user_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- _fivetran_active: from VARCHAR to BOOLEAN
    -- about_me: from FLOAT to VARCHAR
    -- account_id: from FLOAT to VARCHAR
    -- auto_bcc_enabled: from VARCHAR to BOOLEAN
    -- call_center_id: from FLOAT to VARCHAR
    -- city: from FLOAT to VARCHAR
    -- company_name: from FLOAT to VARCHAR
    -- contact_id: from FLOAT to VARCHAR
    -- department: from FLOAT to VARCHAR
    -- division: from FLOAT to VARCHAR
    -- email_signature: from FLOAT to VARCHAR
    -- employee_number: from FLOAT to VARCHAR
    -- fax_number: from FLOAT to VARCHAR
    -- federation_identifier: from FLOAT to VARCHAR
    -- forecast_enabled: from VARCHAR to BOOLEAN
    -- geocode_accuracy: from FLOAT to VARCHAR
    -- has_active_profile_photo: from VARCHAR to BOOLEAN
    -- individual_id: from FLOAT to VARCHAR
    -- is_active: from VARCHAR to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    -- last_login_date: from VARCHAR to DATETIME
    -- last_referenced_date: from VARCHAR to DATETIME
    -- last_viewed_date: from VARCHAR to DATETIME
    -- latitude: from FLOAT to DECIMAL
    -- longitude: from FLOAT to DECIMAL
    -- mobile_phone: from FLOAT to VARCHAR
    -- offline_trial_expiration: from FLOAT to DATE
    -- phone_extension: from FLOAT to VARCHAR
    -- postal_code: from FLOAT to VARCHAR
    -- receives_admin_emails: from VARCHAR to BOOLEAN
    -- receives_info_emails: from VARCHAR to BOOLEAN
    -- sender_email: from FLOAT to VARCHAR
    -- sender_name: from FLOAT to VARCHAR
    -- state: from FLOAT to VARCHAR
    -- state_code: from FLOAT to VARCHAR
    -- street_address: from FLOAT to VARCHAR
    SELECT
        "full_name",
        "user_title",
        "locale_sid",
        "digest_frequency",
        "country_code",
        "id",
        "delegated_approver_id",
        "first_name",
        "group_notification_frequency",
        "email_encoding_key",
        "profile_id",
        "medium_banner_photo_url",
        "phone",
        "user_role_id",
        "small_banner_photo_url",
        "user_type",
        "username",
        "community_nickname",
        "language_locale",
        "alias",
        "badge_text",
        "banner_photo_url",
        "manager_id",
        "country",
        "email",
        "last_name",
        "small_photo_url",
        "time_zone_sid",
        "full_photo_url",
        CASE WHEN "_fivetran_active" = '1' THEN 1 ELSE 0 END 
        AS "_fivetran_active",
        CAST("about_me" AS VARCHAR) 
        AS "about_me",
        CAST("account_id" AS VARCHAR) 
        AS "account_id",
        CAST("auto_bcc_enabled" AS BIT) 
        AS "auto_bcc_enabled",
        CAST("call_center_id" AS VARCHAR) 
        AS "call_center_id",
        CAST("city" AS VARCHAR) 
        AS "city",
        CAST("company_name" AS VARCHAR) 
        AS "company_name",
        CAST("contact_id" AS VARCHAR) 
        AS "contact_id",
        CAST("department" AS VARCHAR) 
        AS "department",
        CAST("division" AS VARCHAR) 
        AS "division",
        CAST("email_signature" AS VARCHAR(MAX)) 
        AS "email_signature",
        CAST("employee_number" AS VARCHAR) 
        AS "employee_number",
        CAST("fax_number" AS VARCHAR) 
        AS "fax_number",
        CAST("federation_identifier" AS VARCHAR) 
        AS "federation_identifier",
        CAST("forecast_enabled" AS BIT) 
        AS "forecast_enabled",
        CAST("geocode_accuracy" AS VARCHAR) 
        AS "geocode_accuracy",
        CAST("has_active_profile_photo" AS BIT) 
        AS "has_active_profile_photo",
        CAST("individual_id" AS VARCHAR) 
        AS "individual_id",
        CASE WHEN "is_active" = '1' THEN 1 ELSE 0 END 
        AS "is_active",
        CASE WHEN "is_deleted" = '0' THEN 0 ELSE 1 END 
        AS "is_deleted",
        CAST("last_login_date" AS DATETIME) 
        AS "last_login_date",
        CAST("last_referenced_date" AS DATETIME) 
        AS "last_referenced_date",
        CAST("last_viewed_date" AS DATETIME) 
        AS "last_viewed_date",
        CAST("latitude" AS DECIMAL(10,8)) 
        AS "latitude",
        CAST("longitude" AS DECIMAL(10,7)) 
        AS "longitude",
        CAST("mobile_phone" AS VARCHAR) 
        AS "mobile_phone",
        CASE 
            WHEN "offline_trial_expiration" IS NOT NULL AND "offline_trial_expiration" <> '' 
            THEN TRY_CONVERT(DATE, CONVERT(VARCHAR(23), "offline_trial_expiration", 121))
            ELSE NULL 
        END 
        AS "offline_trial_expiration",
        CAST("phone_extension" AS VARCHAR) 
        AS "phone_extension",
        CAST("postal_code" AS VARCHAR) 
        AS "postal_code",
        CASE WHEN "receives_admin_emails" = '1' THEN 1 ELSE 0 END 
        AS "receives_admin_emails",
        CAST("receives_info_emails" AS BIT) 
        AS "receives_info_emails",
        CAST("sender_email" AS VARCHAR) 
        AS "sender_email",
        CAST("sender_name" AS VARCHAR) 
        AS "sender_name",
        CAST("state" AS VARCHAR) 
        AS "state",
        CAST("state_code" AS VARCHAR) 
        AS "state_code",
        CAST("street_address" AS VARCHAR(MAX)) 
        AS "street_address"
    FROM "sf_user_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_user_data_projected_renamed_cleaned_null_casted"