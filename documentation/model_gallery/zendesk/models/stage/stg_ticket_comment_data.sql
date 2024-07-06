-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_comment_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "body",
        "created",
        "facebook_comment",
        "public_",
        "ticket_id",
        "tweet",
        "user_id",
        "voice_comment"
    FROM "ticket_comment_data"
),

"ticket_comment_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> comment_id
    -- body -> comment_content
    -- created -> creation_timestamp
    -- facebook_comment -> is_facebook_comment
    -- public_ -> is_public
    -- tweet -> is_tweet
    -- voice_comment -> is_voice_comment
    SELECT 
        "id" AS "comment_id",
        "body" AS "comment_content",
        "created" AS "creation_timestamp",
        "facebook_comment" AS "is_facebook_comment",
        "public_" AS "is_public",
        "ticket_id",
        "tweet" AS "is_tweet",
        "user_id",
        "voice_comment" AS "is_voice_comment"
    FROM "ticket_comment_data_projected"
),

"ticket_comment_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- comment_id: from INT to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- user_id: from INT to VARCHAR
    SELECT
        "comment_content",
        "is_facebook_comment",
        "is_public",
        "ticket_id",
        "is_tweet",
        "is_voice_comment",
        CAST("comment_id" AS VARCHAR) AS "comment_id",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "ticket_comment_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_comment_data_projected_renamed_casted"