-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_contact_history_data_projected" AS (
    -- Projection: Selecting 31 out of 32 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "_fivetran_start",
        "_fivetran_end",
        "id",
        "account_id",
        "email",
        "first_name",
        "is_deleted",
        "last_activity_date",
        "last_modified_by_id",
        "last_modified_date",
        "last_name",
        "last_referenced_date",
        "last_viewed_date",
        "mailing_city",
        "mailing_country",
        "mailing_country_code",
        "mailing_postal_code",
        "mailing_state",
        "mailing_street",
        "master_record_id",
        "mobile_phone",
        "name",
        "owner_id",
        "phone",
        "reports_to_id",
        "title",
        "lead_source",
        "description",
        "individual_id",
        "home_phone"
    FROM "sf_contact_history_data"
),

"sf_contact_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- _fivetran_start -> validity_start_date
    -- _fivetran_end -> validity_end_date
    -- id -> contact_id
    -- name -> full_name
    -- phone -> primary_phone
    -- title -> job_title
    SELECT 
        "_fivetran_active" AS "is_active",
        "_fivetran_start" AS "validity_start_date",
        "_fivetran_end" AS "validity_end_date",
        "id" AS "contact_id",
        "account_id",
        "email",
        "first_name",
        "is_deleted",
        "last_activity_date",
        "last_modified_by_id",
        "last_modified_date",
        "last_name",
        "last_referenced_date",
        "last_viewed_date",
        "mailing_city",
        "mailing_country",
        "mailing_country_code",
        "mailing_postal_code",
        "mailing_state",
        "mailing_street",
        "master_record_id",
        "mobile_phone",
        "name" AS "full_name",
        "owner_id",
        "phone" AS "primary_phone",
        "reports_to_id",
        "title" AS "job_title",
        "lead_source",
        "description",
        "individual_id",
        "home_phone"
    FROM "sf_contact_history_data_projected"
),

"sf_contact_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- first_name: The problem is that 'x' is not a typical first name and appears to be a placeholder or anonymized value. In data anonymization, 'x' is often used to replace actual names to protect privacy. The correct value would depend on the purpose of the dataset and privacy requirements. If maintaining anonymity is crucial, 'x' could be kept. If more meaningful placeholders are desired, options like 'Anonymous' or leaving it as an empty string could be considered. 
    -- last_name: The problem is that 'G' is indeed an unusual value for a last name, as it's a single letter. This could be due to various reasons: 1. It might be an abbreviation of a longer last name. 2. It could be a data entry error where only the first letter of the last name was recorded. 3. In some rare cases, it might actually be a person's full last name. Without more context or additional data, it's difficult to determine the correct full last name.  Given the limited information, the best approach is to keep the value as is, since changing it without more information could introduce errors. 
    -- mailing_country: The problem is that 'Unied Saes' is a misspelling of 'United States' with missing letters. The correct value should be 'United States'. 
    -- full_name: The problem is inconsistent representation of Jerome Powell's name. The full name "Jerome Powell" is the correct and complete representation, while "Jerome" is incomplete. The correct values should all be full names. 
    -- job_title: The problem is that all job titles contain misspellings. The correct values should be: 'Data Science Director' instead of 'Daa Science Direcor', 'Director, Business Insights & Strategy' instead of 'Direcor, Business Insighs & Sraegy', and 'Marketing Director' instead of 'Markeing Direcor'. These corrections fix the typos in each job title. 
    -- lead_source: The problem is that both values in the lead_source column are unusual. 'oominfo' is likely a typo for 'ZoomInfo', a popular B2B contact database. 'Vendor Lis' appears to be an incomplete entry, probably meant to be 'Vendor List'. The correct values should be 'ZoomInfo' and 'Vendor List' respectively. 
    SELECT
        "is_active",
        "validity_start_date",
        "validity_end_date",
        "contact_id",
        "account_id",
        "email",
        CASE
            WHEN "first_name" = 'x' THEN ''
            ELSE "first_name"
        END AS "first_name",
        "is_deleted",
        "last_activity_date",
        "last_modified_by_id",
        "last_modified_date",
        "last_name",
        "last_referenced_date",
        "last_viewed_date",
        "mailing_city",
        CASE
            WHEN "mailing_country" = 'Unied Saes' THEN 'United States'
            ELSE "mailing_country"
        END AS "mailing_country",
        "mailing_country_code",
        "mailing_postal_code",
        "mailing_state",
        "mailing_street",
        "master_record_id",
        "mobile_phone",
        CASE
            WHEN "full_name" = 'Jerome' THEN 'Jerome Powell'
            ELSE "full_name"
        END AS "full_name",
        "owner_id",
        "primary_phone",
        "reports_to_id",
        CASE
            WHEN "job_title" = 'Daa Science Direcor' THEN 'Data Science Director'
            WHEN "job_title" = 'Direcor, Business Insighs & Sraegy' THEN 'Director, Business Insights & Strategy'
            WHEN "job_title" = 'Markeing Direcor' THEN 'Marketing Director'
            ELSE "job_title"
        END AS "job_title",
        CASE
            WHEN "lead_source" = 'oominfo' THEN 'ZoomInfo'
            WHEN "lead_source" = 'Vendor Lis' THEN 'Vendor List'
            ELSE "lead_source"
        END AS "lead_source",
        "description",
        "individual_id",
        "home_phone"
    FROM "sf_contact_history_data_projected_renamed"
),

"sf_contact_history_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- first_name: ['']
    SELECT 
        CASE
            WHEN "first_name" = '' THEN NULL
            ELSE "first_name"
        END AS "first_name",
        "last_modified_date",
        "last_activity_date",
        "mailing_country",
        "is_deleted",
        "last_referenced_date",
        "lead_source",
        "mailing_city",
        "master_record_id",
        "contact_id",
        "last_name",
        "reports_to_id",
        "owner_id",
        "mailing_country_code",
        "mailing_state",
        "last_modified_by_id",
        "validity_start_date",
        "email",
        "mobile_phone",
        "full_name",
        "mailing_street",
        "account_id",
        "home_phone",
        "validity_end_date",
        "is_active",
        "last_viewed_date",
        "description",
        "primary_phone",
        "job_title",
        "individual_id",
        "mailing_postal_code"
    FROM "sf_contact_history_data_projected_renamed_cleaned"
),

"sf_contact_history_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- home_phone: from DECIMAL to VARCHAR
    -- individual_id: from DECIMAL to VARCHAR
    -- is_deleted: from DECIMAL to BOOLEAN
    -- last_activity_date: from VARCHAR to TIMESTAMP
    -- last_modified_date: from VARCHAR to TIMESTAMP
    -- last_referenced_date: from DECIMAL to TIMESTAMP
    -- last_viewed_date: from VARCHAR to TIMESTAMP
    -- mailing_postal_code: from DECIMAL to VARCHAR
    -- master_record_id: from DECIMAL to VARCHAR
    -- mobile_phone: from DECIMAL to VARCHAR
    -- reports_to_id: from DECIMAL to VARCHAR
    -- validity_end_date: from VARCHAR to TIMESTAMP
    -- validity_start_date: from VARCHAR to TIMESTAMP
    SELECT
        "first_name",
        "mailing_country",
        "lead_source",
        "mailing_city",
        "contact_id",
        "last_name",
        "owner_id",
        "mailing_country_code",
        "mailing_state",
        "last_modified_by_id",
        "email",
        "full_name",
        "mailing_street",
        "account_id",
        "is_active",
        "description",
        "primary_phone",
        "job_title",
        CAST("home_phone" AS VARCHAR) AS "home_phone",
        CAST("individual_id" AS VARCHAR) AS "individual_id",
        CAST("is_deleted" AS BOOLEAN) AS "is_deleted",
        CAST("last_activity_date" AS TIMESTAMP) AS "last_activity_date",
        CAST("last_modified_date" AS TIMESTAMP) AS "last_modified_date",
        CAST("last_referenced_date" AS TIMESTAMP) AS "last_referenced_date",
        CAST("last_viewed_date" AS TIMESTAMP) AS "last_viewed_date",
        CAST("mailing_postal_code" AS VARCHAR) AS "mailing_postal_code",
        CAST("master_record_id" AS VARCHAR) AS "master_record_id",
        CAST("mobile_phone" AS VARCHAR) AS "mobile_phone",
        CAST("reports_to_id" AS VARCHAR) AS "reports_to_id",
        CAST("validity_end_date" AS VARCHAR) AS "validity_end_date",
        CAST("validity_start_date" AS TIMESTAMP) AS "validity_start_date"
    FROM "sf_contact_history_data_projected_renamed_cleaned_null"
),

"sf_contact_history_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 17 columns with unacceptable missing values
    -- account_id has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- description has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- email has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- first_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- full_name has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- job_title has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- last_modified_by_id has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- last_name has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- lead_source has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_city has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_country has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_country_code has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_postal_code has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_state has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- mailing_street has 75.0 percent missing. Strategy: 🔄 Unchanged
    -- owner_id has 25.0 percent missing. Strategy: 🔄 Unchanged
    -- primary_phone has 50.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "mailing_country",
        "lead_source",
        "mailing_city",
        "contact_id",
        "last_name",
        "owner_id",
        "mailing_country_code",
        "mailing_state",
        "last_modified_by_id",
        "email",
        "full_name",
        "mailing_street",
        "account_id",
        "is_active",
        "description",
        "primary_phone",
        "job_title",
        "home_phone",
        "individual_id",
        "is_deleted",
        "last_activity_date",
        "last_modified_date",
        "last_referenced_date",
        "last_viewed_date",
        "mailing_postal_code",
        "master_record_id",
        "mobile_phone",
        "reports_to_id",
        "validity_end_date",
        "validity_start_date"
    FROM "sf_contact_history_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_contact_history_data_projected_renamed_cleaned_null_casted_missing_handled"