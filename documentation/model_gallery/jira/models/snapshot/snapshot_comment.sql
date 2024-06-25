-- Slowly Changing Dimension: Dimension keys are "comment_id"
-- Effective date columns are "last_update_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "comment_id",
    "comment_text",
    "is_public",
    "issue_id",
    "author_id",
    "creation_timestamp",
    "last_update_author_id"
FROM (
     SELECT 
            "comment_id",
            "comment_text",
            "is_public",
            "issue_id",
            "author_id",
            "creation_timestamp",
            "last_update_author_id",
            ROW_NUMBER() OVER (
                PARTITION BY "comment_id" 
                ORDER BY "last_update_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_comment"
) ranked
WHERE "cocoon_rn" = 1