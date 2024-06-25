-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
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
    FROM "sf_user_data"
),

"sf_user_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- about_me -> user_bio
    -- alias -> user_alias
    -- default_group_notification_frequency -> group_notification_frequency
    -- email_preferences_auto_bcc -> auto_bcc_enabled
    -- extension -> phone_extension
    -- fax -> fax_number
    -- id -> user_id
    -- individual_id -> secondary_id
    -- is_profile_photo_active -> is_photo_active
    -- language_locale_key -> language_locale
    -- last_login_date -> last_login
    -- last_referenced_date -> last_referenced
    -- last_viewed_date -> last_viewed
    -- locale_sid_key -> locale_key
    -- medium_banner_photo_url -> medium_banner_url
    -- name -> full_name
    -- offline_trial_expiration_date -> offline_trial_expiration
    -- receives_admin_info_emails -> receives_admin_emails
    -- signature -> email_signature
    -- small_banner_photo_url -> small_banner_url
    -- street -> street_address
    -- time_zone_sid_key -> user_time_zone
    -- title -> job_title
    -- user_role_id -> role_id
    SELECT 
        "_fivetran_deleted" AS "is_deleted",
        "about_me" AS "user_bio",
        "account_id",
        "alias" AS "user_alias",
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
        "id" AS "user_id",
        "individual_id" AS "secondary_id",
        "is_active",
        "is_profile_photo_active" AS "is_photo_active",
        "language_locale_key" AS "language_locale",
        "last_login_date" AS "last_login",
        "last_name",
        "last_referenced_date" AS "last_referenced",
        "last_viewed_date" AS "last_viewed",
        "latitude",
        "locale_sid_key" AS "locale_key",
        "longitude",
        "manager_id",
        "medium_banner_photo_url" AS "medium_banner_url",
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
        "small_banner_photo_url" AS "small_banner_url",
        "small_photo_url",
        "state",
        "state_code",
        "street" AS "street_address",
        "time_zone_sid_key" AS "user_time_zone",
        "title" AS "job_title",
        "user_role_id" AS "role_id",
        "user_type",
        "username",
        "_fivetran_active"
    FROM "sf_user_data_projected"
),

"sf_user_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- country: The problem is that the country column contains an encoded string '8lPv4wLTKrJkp24M5lvnaQ==' instead of an actual country name. This value appears to be a Base64 encoded string, which is not a valid representation for a country. The correct value should be an actual country name, but without additional context or information about what this encoded string represents, it's impossible to determine the intended country. Therefore, the most appropriate action is to map this unusual value to an empty string. 
    -- country_code: The problem is that the value 'dRb9Q62qXguKZaZyw5hF0g==' is not a valid country code. Country codes are typically 2 or 3 letter alphabetic codes (like 'US' for United States or 'GBR' for Great Britain). The given value appears to be a Base64 encoded string, which is completely inappropriate for a country code field. Without additional context about what this encoded value represents, it's impossible to map it to a correct country code. The correct values for this field should be standard ISO country codes. 
    -- digest_frequency: The problem is that the digest_frequency column contains a Base64 encoded string instead of a clear frequency value. Base64 encoding is typically used for binary data or to obfuscate information, not for representing simple frequency values. The correct values for a digest frequency field would normally be clear text representations of time intervals like "daily", "weekly", "monthly", etc. 
    -- language_locale: The problem is that the value 'cQlcVsZB8sSk8Ym53816OA==' is not a standard language locale format. It appears to be an encoded string, possibly Base64, which is not appropriate for a language_locale column. Language locales typically follow patterns like 'en-US', 'fr-FR', 'de-DE', etc. The correct values should be actual language locales, but without more information about the intended locale, it's impossible to determine the correct mapping. 
    -- full_name: The problem is that 'Nomadmktg Nomadmktg' repeats a term, which is unusual for a full name. 'empty account' is not a name but a placeholder or system-generated entry. The other names appear to be in the correct format of 'First Last'. The correct values should maintain the proper name format and remove or replace placeholder entries. 
    -- job_title: The problem is that the job_title column contains an encoded or encrypted string rather than a readable job title. The value 'ieakxsZwGEBdpS1879Gv/Q==' appears to be a Base64 encoded string, which is not a meaningful job title. Since we don't have the key to decode this string and no other information about what the actual job title should be, the correct approach is to map this unusual value to an empty string. 
    SELECT
        "is_deleted",
        "user_bio",
        "account_id",
        "user_alias",
        "badge_text",
        "banner_photo_url",
        "call_center_id",
        "city",
        "community_nickname",
        "company_name",
        "contact_id",
        CASE
            WHEN "country" = '8lPv4wLTKrJkp24M5lvnaQ==' THEN ''
            ELSE "country"
        END AS "country",
        CASE
            WHEN "country_code" = 'dRb9Q62qXguKZaZyw5hF0g==' THEN ''
            ELSE "country_code"
        END AS "country_code",
        "group_notification_frequency",
        "delegated_approver_id",
        "department",
        CASE
            WHEN "digest_frequency" = '9iPnWvMOYrvXPW31tQu3tQ==' THEN ''
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
        "user_id",
        "secondary_id",
        "is_active",
        "is_photo_active",
        CASE
            WHEN "language_locale" = 'cQlcVsZB8sSk8Ym53816OA==' THEN ''
            ELSE "language_locale"
        END AS "language_locale",
        "last_login",
        "last_name",
        "last_referenced",
        "last_viewed",
        "latitude",
        "locale_key",
        "longitude",
        "manager_id",
        "medium_banner_url",
        "mobile_phone",
        CASE
            WHEN "full_name" = 'Nomadmktg Nomadmktg' THEN 'Nomadmktg'
            WHEN "full_name" = 'empty account' THEN ''
            ELSE "full_name"
        END AS "full_name",
        "offline_trial_expiration",
        "phone",
        "postal_code",
        "profile_id",
        "receives_admin_emails",
        "receives_info_emails",
        "sender_email",
        "sender_name",
        "email_signature",
        "small_banner_url",
        "small_photo_url",
        "state",
        "state_code",
        "street_address",
        "user_time_zone",
        CASE
            WHEN "job_title" = 'ieakxsZwGEBdpS1879Gv/Q==' THEN ''
            ELSE "job_title"
        END AS "job_title",
        "role_id",
        "user_type",
        "username",
        "_fivetran_active"
    FROM "sf_user_data_projected_renamed"
),

"sf_user_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- country: ['']
    -- country_code: ['']
    -- digest_frequency: ['']
    -- language_locale: ['']
    -- full_name: ['']
    -- job_title: ['']
    SELECT 
        CASE
            WHEN "country" = '' THEN NULL
            ELSE "country"
        END AS "country",
        CASE
            WHEN "country_code" = '' THEN NULL
            ELSE "country_code"
        END AS "country_code",
        CASE
            WHEN "digest_frequency" = '' THEN NULL
            ELSE "digest_frequency"
        END AS "digest_frequency",
        CASE
            WHEN "language_locale" = '' THEN NULL
            ELSE "language_locale"
        END AS "language_locale",
        CASE
            WHEN "full_name" = '' THEN NULL
            ELSE "full_name"
        END AS "full_name",
        CASE
            WHEN "job_title" = '' THEN NULL
            ELSE "job_title"
        END AS "job_title",
        "first_name",
        "phone",
        "last_referenced",
        "mobile_phone",
        "account_id",
        "last_viewed",
        "manager_id",
        "secondary_id",
        "latitude",
        "call_center_id",
        "small_banner_url",
        "community_nickname",
        "longitude",
        "city",
        "group_notification_frequency",
        "last_name",
        "forecast_enabled",
        "employee_number",
        "username",
        "user_alias",
        "sender_name",
        "banner_photo_url",
        "last_login",
        "medium_banner_url",
        "email_signature",
        "email_encoding_key",
        "badge_text",
        "contact_id",
        "auto_bcc_enabled",
        "is_photo_active",
        "geocode_accuracy",
        "profile_id",
        "department",
        "street_address",
        "phone_extension",
        "sender_email",
        "_fivetran_active",
        "company_name",
        "fax_number",
        "locale_key",
        "state",
        "role_id",
        "offline_trial_expiration",
        "small_photo_url",
        "is_active",
        "receives_admin_emails",
        "user_type",
        "division",
        "user_time_zone",
        "postal_code",
        "is_deleted",
        "user_id",
        "receives_info_emails",
        "email",
        "full_photo_url",
        "state_code",
        "delegated_approver_id",
        "user_bio",
        "federation_identifier"
    FROM "sf_user_data_projected_renamed_cleaned"
),

"sf_user_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- account_id: from DECIMAL to VARCHAR
    -- call_center_id: from DECIMAL to VARCHAR
    -- city: from DECIMAL to VARCHAR
    -- company_name: from DECIMAL to VARCHAR
    -- contact_id: from DECIMAL to VARCHAR
    -- department: from DECIMAL to VARCHAR
    -- division: from DECIMAL to VARCHAR
    -- email_signature: from DECIMAL to VARCHAR
    -- employee_number: from DECIMAL to VARCHAR
    -- fax_number: from DECIMAL to VARCHAR
    -- federation_identifier: from DECIMAL to VARCHAR
    -- geocode_accuracy: from DECIMAL to VARCHAR
    -- last_login: from VARCHAR to TIMESTAMP
    -- last_referenced: from VARCHAR to TIMESTAMP
    -- last_viewed: from VARCHAR to TIMESTAMP
    -- mobile_phone: from DECIMAL to VARCHAR
    -- offline_trial_expiration: from DECIMAL to TIMESTAMP
    -- phone_extension: from DECIMAL to VARCHAR
    -- postal_code: from DECIMAL to VARCHAR
    -- secondary_id: from DECIMAL to VARCHAR
    -- sender_email: from DECIMAL to VARCHAR
    -- sender_name: from DECIMAL to VARCHAR
    -- state: from DECIMAL to VARCHAR
    -- state_code: from DECIMAL to VARCHAR
    -- street_address: from DECIMAL to VARCHAR
    -- user_bio: from DECIMAL to VARCHAR
    SELECT
        "country",
        "country_code",
        "digest_frequency",
        "language_locale",
        "full_name",
        "job_title",
        "first_name",
        "phone",
        "manager_id",
        "latitude",
        "small_banner_url",
        "community_nickname",
        "longitude",
        "group_notification_frequency",
        "last_name",
        "forecast_enabled",
        "username",
        "user_alias",
        "banner_photo_url",
        "medium_banner_url",
        "email_encoding_key",
        "badge_text",
        "auto_bcc_enabled",
        "is_photo_active",
        "profile_id",
        "_fivetran_active",
        "locale_key",
        "role_id",
        "small_photo_url",
        "is_active",
        "receives_admin_emails",
        "user_type",
        "user_time_zone",
        "is_deleted",
        "user_id",
        "receives_info_emails",
        "email",
        "full_photo_url",
        "delegated_approver_id",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("call_center_id" AS VARCHAR) AS "call_center_id",
        CAST("city" AS VARCHAR) AS "city",
        CAST("company_name" AS VARCHAR) AS "company_name",
        CAST("contact_id" AS VARCHAR) AS "contact_id",
        CAST("department" AS VARCHAR) AS "department",
        CAST("division" AS VARCHAR) AS "division",
        CAST("email_signature" AS VARCHAR) AS "email_signature",
        CAST("employee_number" AS VARCHAR) AS "employee_number",
        CAST("fax_number" AS VARCHAR) AS "fax_number",
        CAST("federation_identifier" AS VARCHAR) AS "federation_identifier",
        CAST("geocode_accuracy" AS VARCHAR) AS "geocode_accuracy",
        CAST("last_login" AS TIMESTAMP) AS "last_login",
        CAST("last_referenced" AS TIMESTAMP) AS "last_referenced",
        CAST("last_viewed" AS TIMESTAMP) AS "last_viewed",
        CAST("mobile_phone" AS VARCHAR) AS "mobile_phone",
        CAST("offline_trial_expiration" AS TIMESTAMP) AS "offline_trial_expiration",
        CAST("phone_extension" AS VARCHAR) AS "phone_extension",
        CAST("postal_code" AS VARCHAR) AS "postal_code",
        CAST("secondary_id" AS VARCHAR) AS "secondary_id",
        CAST("sender_email" AS VARCHAR) AS "sender_email",
        CAST("sender_name" AS VARCHAR) AS "sender_name",
        CAST("state" AS VARCHAR) AS "state",
        CAST("state_code" AS VARCHAR) AS "state_code",
        CAST("street_address" AS VARCHAR) AS "street_address",
        CAST("user_bio" AS VARCHAR) AS "user_bio"
    FROM "sf_user_data_projected_renamed_cleaned_null"
),

"sf_user_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 32 columns with unacceptable missing values
    -- account_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- call_center_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- company_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contact_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- country_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- department has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- digest_frequency has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- division has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- email_signature has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employee_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- fax_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- federation_identifier has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- full_name has 10.0 percent missing. Strategy: 🔄 Unchanged
    -- geocode_accuracy has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- job_title has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- language_locale has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_login has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- latitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- longitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- mobile_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- offline_trial_expiration has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- phone_extension has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- postal_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- role_id has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- sender_email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sender_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- state_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- street_address has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_bio has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "full_name",
        "first_name",
        "phone",
        "manager_id",
        "small_banner_url",
        "community_nickname",
        "group_notification_frequency",
        "last_name",
        "forecast_enabled",
        "username",
        "user_alias",
        "banner_photo_url",
        "medium_banner_url",
        "email_encoding_key",
        "badge_text",
        "auto_bcc_enabled",
        "is_photo_active",
        "profile_id",
        "_fivetran_active",
        "locale_key",
        "role_id",
        "small_photo_url",
        "is_active",
        "receives_admin_emails",
        "user_type",
        "user_time_zone",
        "is_deleted",
        "user_id",
        "receives_info_emails",
        "email",
        "full_photo_url",
        "delegated_approver_id",
        "last_login",
        "last_referenced",
        "last_viewed",
        "secondary_id"
    FROM "sf_user_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_user_data_projected_renamed_cleaned_null_casted_missing_handled"