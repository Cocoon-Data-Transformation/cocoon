-- Slowly Changing Dimension: Dimension keys are "directory_id", "id"
-- Effective date columns are "last_modified_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "directory_id",
    "id",
    "_fivetran_deleted",
    "creation_date",
    "name",
    "owner_id"
FROM (
     SELECT 
            "directory_id",
            "id",
            "_fivetran_deleted",
            "creation_date",
            "name",
            "owner_id",
            ROW_NUMBER() OVER (
                PARTITION BY "directory_id", "id" 
                ORDER BY "last_modified_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_directory_mailing_list"
) ranked
WHERE "cocoon_rn" = 1