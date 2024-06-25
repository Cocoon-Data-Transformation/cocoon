-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"linkedin_campaign_history_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> campaign_id
    -- last_modified_time -> last_updated_timestamp
    -- created_time -> creation_timestamp
    -- name -> encrypted_campaign_name
    -- version_tag -> campaign_version
    SELECT 
        "id" AS "campaign_id",
        "last_modified_time" AS "last_updated_timestamp",
        "account_id",
        "campaign_group_id",
        "created_time" AS "creation_timestamp",
        "name" AS "encrypted_campaign_name",
        "version_tag" AS "campaign_version"
    FROM "linkedin_campaign_history_data"
),

"linkedin_campaign_history_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- campaign_group_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_updated_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "encrypted_campaign_name",
        "campaign_version",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("campaign_group_id" AS VARCHAR) AS "campaign_group_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("last_updated_timestamp" AS TIMESTAMP) AS "last_updated_timestamp"
    FROM "linkedin_campaign_history_data_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "linkedin_campaign_history_data_renamed_casted"