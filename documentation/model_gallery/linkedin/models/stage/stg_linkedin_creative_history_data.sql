-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"linkedin_creative_history_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> creative_id
    -- last_modified_at -> last_modified_timestamp
    -- created_at -> creation_timestamp
    -- intended_status -> content_status
    -- click_uri -> click_through_url
    SELECT 
        "id" AS "creative_id",
        "last_modified_at" AS "last_modified_timestamp",
        "created_at" AS "creation_timestamp",
        "campaign_id",
        "intended_status" AS "content_status",
        "click_uri" AS "click_through_url"
    FROM "linkedin_creative_history_data"
),

"linkedin_creative_history_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_modified_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "creative_id",
        "campaign_id",
        "content_status",
        "click_through_url",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("last_modified_timestamp" AS TIMESTAMP) AS "last_modified_timestamp"
    FROM "linkedin_creative_history_data_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "linkedin_creative_history_data_renamed_casted"