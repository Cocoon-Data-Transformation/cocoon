-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:36:48.380034+00:00
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
    FROM "MyAppDB"."dbo"."sf_contact_history_data"
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
    -- description -> contact_description
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
        "description" AS "contact_description",
        "individual_id",
        "home_phone"
    FROM "sf_contact_history_data_projected"
),

"sf_contact_history_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- first_name: The problem is that the first_name column contains only the value 'x', which is not a typical first name. This likely represents missing data or a placeholder used when the actual first name was not available or not provided. In such cases, it's generally better to represent missing data with an empty string or a null value, depending on the database system and requirements.
    -- last_name: The problem is that 'G' is an extremely short last name, which is unusual and could potentially be an abbreviation or a data entry error. However, without more context or additional data, it's difficult to determine if this is truly an error or if it's a legitimate last name. Some people do have single-letter last names, particularly in certain cultures or as a result of name changes. Given the lack of alternative information, the safest approach is to retain the value as is.
    -- mailing_country: The problem is that there is a misspelling in the country name "Unied Saes", which is clearly meant to be "United States". The missing 't' letters in both words need to be added to correct the spelling. There is only one value in this column, so we only need to fix this single misspelling.
    -- full_name: The problem is that 'Jerome' is missing a last name, which should be 'Powell'. The correct values should all include both first and last names consistently. 'Janet Yellen' is already in the correct format, so it doesn't need to be changed.
    -- job_title: The problem is that all job titles in the column have multiple typos and missing letters. The correct values should be properly spelled job titles without missing letters. Based on the given information, we can infer the intended job titles as follows: - "Daa Science Direcor" should be "Data Science Director" - "Direcor, Business Insighs & Sraegy" should be "Director, Business Insights & Strategy" - "Markeing Direcor" should be "Marketing Director"
    -- lead_source: The problem is that there are two unusual values in the lead_source column. 'oominfo' is likely a misspelling of 'zoominfo', a popular B2B contact database. 'Vendor Lis' appears to be a truncated version of 'Vendor List'. These issues are probably due to data entry errors or system limitations in storing the full text. The correct values should be 'zoominfo' and 'Vendor List' respectively.
    SELECT
        "is_active",
        "validity_start_date",
        "validity_end_date",
        "contact_id",
        "account_id",
        "email",
        CASE
            WHEN "first_name" = 'x' THEN NULL
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
            WHEN "lead_source" = 'oominfo' THEN 'zoominfo'
            WHEN "lead_source" = 'Vendor Lis' THEN 'Vendor List'
            ELSE "lead_source"
        END AS "lead_source",
        "contact_description",
        "individual_id",
        "home_phone"
    FROM "sf_contact_history_data_projected_renamed"
),

"sf_contact_history_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- home_phone: from FLOAT to VARCHAR
    -- individual_id: from FLOAT to VARCHAR
    -- is_active: from VARCHAR to BOOLEAN
    -- is_deleted: from FLOAT to BOOLEAN
    -- last_activity_date: from VARCHAR to DATETIME
    -- last_modified_date: from VARCHAR to DATETIME
    -- last_referenced_date: from FLOAT to DATETIME
    -- last_viewed_date: from VARCHAR to DATETIME
    -- mailing_postal_code: from FLOAT to VARCHAR
    -- master_record_id: from FLOAT to VARCHAR
    -- mobile_phone: from FLOAT to VARCHAR
    -- reports_to_id: from FLOAT to VARCHAR
    -- validity_end_date: from VARCHAR to DATETIME
    -- validity_start_date: from VARCHAR to DATETIME
    SELECT
        "contact_id",
        "account_id",
        "email",
        "first_name",
        "last_modified_by_id",
        "last_name",
        "mailing_city",
        "mailing_country",
        "mailing_country_code",
        "mailing_state",
        "mailing_street",
        "full_name",
        "owner_id",
        "primary_phone",
        "job_title",
        "lead_source",
        "contact_description",
        CAST("home_phone" AS VARCHAR) 
        AS "home_phone",
        CAST("individual_id" AS VARCHAR) 
        AS "individual_id",
        CAST("is_active" AS BIT) 
        AS "is_active",
        CAST(CASE WHEN "is_deleted" = 0.0 THEN 0 ELSE 1 END AS BIT) 
        AS "is_deleted",
        CAST("last_activity_date" AS DATETIME) 
        AS "last_activity_date",
        CAST("last_modified_date" AS DATETIME) 
        AS "last_modified_date",
        CONVERT(DATETIME, CONVERT(VARCHAR(23), "last_referenced_date", 121)) 
        AS "last_referenced_date",
        CAST("last_viewed_date" AS DATETIME) 
        AS "last_viewed_date",
        CAST("mailing_postal_code" AS VARCHAR) 
        AS "mailing_postal_code",
        CAST("master_record_id" AS VARCHAR) 
        AS "master_record_id",
        CAST("mobile_phone" AS VARCHAR) 
        AS "mobile_phone",
        CAST("reports_to_id" AS VARCHAR) 
        AS "reports_to_id",
        CAST("validity_end_date" AS DATETIME) 
        AS "validity_end_date",
        CAST("validity_start_date" AS DATETIME) 
        AS "validity_start_date"
    FROM "sf_contact_history_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_contact_history_data_projected_renamed_cleaned_casted"