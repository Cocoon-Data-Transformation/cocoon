-- Slowly Changing Dimension: Dimension keys are "directory_id", "id"
-- Effective date columns are "last_modified"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "directory_id",
    "id",
    "creation_date",
    "directory_unsubscribed",
    "email",
    "email_domain",
    "first_name",
    "last_name",
    "phone"
FROM (
     SELECT 
            "directory_id",
            "id",
            "creation_date",
            "directory_unsubscribed",
            "email",
            "email_domain",
            "first_name",
            "last_name",
            "phone",
            ROW_NUMBER() OVER (
                PARTITION BY "directory_id", "id" 
                ORDER BY "last_modified" 
            DESC) AS "cocoon_rn"
    FROM "stg_directory_contact"
) ranked
WHERE "cocoon_rn" = 1