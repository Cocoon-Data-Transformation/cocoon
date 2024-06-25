-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"pinterest_ad_group_history_data_projected" AS (
    -- Projection: Selecting 11 out of 12 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "campaign_id",
        "created_time",
        "name",
        "status",
        "start_time",
        "end_time",
        "pacing_delivery_type",
        "placement_group",
        "summary_status",
        "ad_account_id"
    FROM "pinterest_ad_group_history_data"
),

"pinterest_ad_group_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ad_group_id
    -- created_time -> creation_timestamp
    -- name -> ad_group_name
    -- status -> ad_group_status
    -- start_time -> start_timestamp
    -- end_time -> end_timestamp
    SELECT 
        "id" AS "ad_group_id",
        "campaign_id",
        "created_time" AS "creation_timestamp",
        "name" AS "ad_group_name",
        "status" AS "ad_group_status",
        "start_time" AS "start_timestamp",
        "end_time" AS "end_timestamp",
        "pacing_delivery_type",
        "placement_group",
        "summary_status",
        "ad_account_id"
    FROM "pinterest_ad_group_history_data_projected"
),

"pinterest_ad_group_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- ad_account_id: from INT to VARCHAR
    -- ad_group_id: from INT to VARCHAR
    -- campaign_id: from INT to VARCHAR
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- end_timestamp: from DECIMAL to TIMESTAMP
    -- start_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "ad_group_name",
        "ad_group_status",
        "pacing_delivery_type",
        "placement_group",
        "summary_status",
        CAST("ad_account_id" AS VARCHAR) AS "ad_account_id",
        CAST("ad_group_id" AS VARCHAR) AS "ad_group_id",
        CAST("campaign_id" AS VARCHAR) AS "campaign_id",
        strptime("creation_timestamp", '%Y-%m-%d %H:%M:%S.%f %z') AS "creation_timestamp",
        CAST("end_timestamp" AS TIMESTAMP) AS "end_timestamp",
        CAST(strptime(SUBSTRING("start_timestamp", 1, 23), '%Y-%m-%d %H:%M:%S.%f') AS TIMESTAMP) AS "start_timestamp"
    FROM "pinterest_ad_group_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "pinterest_ad_group_history_data_projected_renamed_casted"