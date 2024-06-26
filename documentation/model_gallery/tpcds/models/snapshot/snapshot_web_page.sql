-- Slowly Changing Dimension: Dimension keys are "page_id"
-- Effective date columns are "record_end_date"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "page_surrogate_key",
    "page_id",
    "customer_id",
    "url",
    "page_type",
    "character_count",
    "link_count",
    "image_count",
    "max_ad_count",
    "creation_date",
    "is_auto_generated",
    "last_access_date",
    "record_start_date"
FROM (
     SELECT 
            "page_surrogate_key",
            "page_id",
            "customer_id",
            "url",
            "page_type",
            "character_count",
            "link_count",
            "image_count",
            "max_ad_count",
            "creation_date",
            "is_auto_generated",
            "last_access_date",
            "record_start_date",
            ROW_NUMBER() OVER (
                PARTITION BY "page_id" 
                ORDER BY "record_end_date" 
            DESC) AS "cocoon_rn"
    FROM "stg_web_page"
) ranked
WHERE "cocoon_rn" = 1