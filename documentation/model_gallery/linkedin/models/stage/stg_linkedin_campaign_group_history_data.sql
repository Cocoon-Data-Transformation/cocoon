-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"linkedin_campaign_group_history_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> campaign_group_id
    -- last_modified_time -> last_modified_timestamp
    -- created_time -> creation_timestamp
    -- name -> encrypted_group_name
    SELECT 
        "id" AS "campaign_group_id",
        "last_modified_time" AS "last_modified_timestamp",
        "account_id",
        "created_time" AS "creation_timestamp",
        "name" AS "encrypted_group_name"
    FROM "linkedin_campaign_group_history_data"
),

"linkedin_campaign_group_history_data_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- last_modified_timestamp: The problem is that one timestamp '2018-09-06 16:52:33.720' includes millisecond precision, while the others do not. The correct values should all follow the same format without milliseconds for consistency. The most frequent format is 'YYYY-MM-DD HH:MM:SS', so we'll map the unusual value to this format. 
    SELECT
        "campaign_group_id",
        CASE
            WHEN "last_modified_timestamp" = '2018-09-06 16:52:33.720' THEN '2018-09-06 16:52:33'
            ELSE "last_modified_timestamp"
        END AS "last_modified_timestamp",
        "account_id",
        "creation_timestamp",
        "encrypted_group_name"
    FROM "linkedin_campaign_group_history_data_renamed"
),

"linkedin_campaign_group_history_data_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    -- campaign_group_id: from INT to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- last_modified_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "encrypted_group_name",
        CAST("account_id" AS VARCHAR) AS "account_id",
        CAST("campaign_group_id" AS VARCHAR) AS "campaign_group_id",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("last_modified_timestamp" AS TIMESTAMP) AS "last_modified_timestamp"
    FROM "linkedin_campaign_group_history_data_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "linkedin_campaign_group_history_data_renamed_cleaned_casted"