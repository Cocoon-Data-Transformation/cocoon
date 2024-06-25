-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"comment_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "author_id",
        "body",
        "created",
        "is_public",
        "issue_id",
        "update_author_id",
        "updated"
    FROM "comment"
),

"comment_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> comment_id
    -- body -> comment_text
    -- created -> creation_timestamp
    -- update_author_id -> last_update_author_id
    -- updated -> last_update_timestamp
    SELECT 
        "id" AS "comment_id",
        "author_id",
        "body" AS "comment_text",
        "created" AS "creation_timestamp",
        "is_public",
        "issue_id",
        "update_author_id" AS "last_update_author_id",
        "updated" AS "last_update_timestamp"
    FROM "comment_projected"
),

"comment_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- author_id: from VARCHAR to UUID
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_update_author_id: from VARCHAR to UUID
    -- last_update_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "comment_id",
        "comment_text",
        "is_public",
        "issue_id",
        CAST(SPLIT_PART("author_id", ':', 2) AS UUID) AS "author_id",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST(SUBSTRING("last_update_author_id" FROM POSITION(':' IN "last_update_author_id") + 1) AS UUID) AS "last_update_author_id",
        CAST("last_update_timestamp" AS TIMESTAMP) AS "last_update_timestamp"
    FROM "comment_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "comment_projected_renamed_casted"