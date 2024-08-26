-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 17:29:36.726415+00:00
WITH 
"ad_group_history_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['id', 'last_updated_date', '_fivetran_synced', 'campaign_id', 'creation_date', 'default_bid', 'name', 'serving_status', 'state']
    SELECT 
        "id",
        "last_updated_date",
        "campaign_id",
        "creation_date",
        "default_bid",
        "name",
        "serving_status",
        "state"
    FROM "memory"."main"."ad_group_history_data"
),

"ad_group_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ad_group_id
    -- name -> ad_group_name
    -- state -> ad_group_state
    SELECT 
        "id" AS "ad_group_id",
        "last_updated_date",
        "campaign_id",
        "creation_date",
        "default_bid",
        "name" AS "ad_group_name",
        "serving_status",
        "state" AS "ad_group_state"
    FROM "ad_group_history_data_projected"
),

"ad_group_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to TIMESTAMP
    -- last_updated_date: from VARCHAR to TIMESTAMP
    SELECT
        "ad_group_id",
        "campaign_id",
        "default_bid",
        "ad_group_name",
        "serving_status",
        "ad_group_state",
        CAST("creation_date" AS TIMESTAMP) 
        AS "creation_date",
        CAST("last_updated_date" AS TIMESTAMP) 
        AS "last_updated_date"
    FROM "ad_group_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "ad_group_history_data_projected_renamed_casted"