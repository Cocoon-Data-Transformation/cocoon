-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 03:14:19.817793+00:00
WITH 
"sf_user_role_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_deleted",
        "case_access_for_account_owner",
        "contact_access_for_account_owner",
        "developer_name",
        "forecast_user_id",
        "id",
        "may_forecast_manager_share",
        "name",
        "opportunity_access_for_account_owner",
        "parent_role_id",
        "portal_type",
        "rollup_description",
        "_fivetran_active"
    FROM "MyAppDB"."dbo"."sf_user_role_data"
),

"sf_user_role_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- case_access_for_account_owner -> case_access_level
    -- contact_access_for_account_owner -> contact_access_level
    -- id -> role_id
    -- may_forecast_manager_share -> can_manager_share_forecast
    -- name -> role_name
    -- opportunity_access_for_account_owner -> opportunity_access_level
    -- _fivetran_active -> is_active
    SELECT 
        "_fivetran_deleted" AS "is_deleted",
        "case_access_for_account_owner" AS "case_access_level",
        "contact_access_for_account_owner" AS "contact_access_level",
        "developer_name",
        "forecast_user_id",
        "id" AS "role_id",
        "may_forecast_manager_share" AS "can_manager_share_forecast",
        "name" AS "role_name",
        "opportunity_access_for_account_owner" AS "opportunity_access_level",
        "parent_role_id",
        "portal_type",
        "rollup_description",
        "_fivetran_active" AS "is_active"
    FROM "sf_user_role_data_projected"
),

"sf_user_role_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- can_manager_share_forecast: from VARCHAR to BOOLEAN
    -- forecast_user_id: from FLOAT to VARCHAR
    -- is_active: from VARCHAR to BOOLEAN
    -- is_deleted: from VARCHAR to BOOLEAN
    SELECT
        "case_access_level",
        "contact_access_level",
        "developer_name",
        "role_id",
        "role_name",
        "opportunity_access_level",
        "parent_role_id",
        "portal_type",
        "rollup_description",
        CAST("can_manager_share_forecast" AS BIT) 
        AS "can_manager_share_forecast",
        CAST("forecast_user_id" AS VARCHAR) 
        AS "forecast_user_id",
        CASE WHEN "is_active" = '1' THEN 1 ELSE 0 END 
        AS "is_active",
        CAST("is_deleted" AS BIT) 
        AS "is_deleted"
    FROM "sf_user_role_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "sf_user_role_data_projected_renamed_casted"