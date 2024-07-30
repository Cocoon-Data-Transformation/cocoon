-- Slowly Changing Dimension: Dimension keys are "contact_id"
-- Version columns are validity_start_date, validity_end_date, last_modified_date
-- We will create Type 1 SCD (latest snapshot)

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
    "home_phone",
    "individual_id",
    "is_active",
    "is_deleted",
    "last_activity_date",
    "last_referenced_date",
    "last_viewed_date",
    "mailing_postal_code",
    "master_record_id",
    "mobile_phone",
    "reports_to_id"
FROM "stg_sf_contact_history_data"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "contact_id"
    ORDER BY
        validity_end_date DESC,
        validity_start_date DESC,
        last_modified_date DESC
) = 1