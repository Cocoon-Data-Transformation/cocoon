-- Slowly Changing Dimension: Dimension keys are "contact_id"
-- Effective date columns are "validity_end_date"
-- We will create Type 1 SCD (latest snapshot)
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
    "validity_start_date"
FROM (
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
            "validity_start_date",
            ROW_NUMBER() OVER (
                PARTITION BY "contact_id" 
                ORDER BY "validity_end_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_sf_contact_history_data"
) ranked
WHERE "cocoon_rn" = 1