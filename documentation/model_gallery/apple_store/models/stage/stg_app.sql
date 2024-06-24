-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"app_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "is_enabled",
        "name",
        "asset_token",
        "pre_order_info",
        "icon_url",
        "app_opt_in_rate",
        "ios",
        "tvos",
        "is_bundle"
    FROM "app"
),

"app_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> app_id
    -- name -> app_name
    -- pre_order_info -> pre_order_details
    -- app_opt_in_rate -> user_opt_in_percentage
    -- ios -> is_ios_compatible
    -- tvos -> is_tvos_compatible
    SELECT 
        id AS app_id,
        is_enabled,
        name AS app_name,
        asset_token,
        pre_order_info AS pre_order_details,
        icon_url,
        app_opt_in_rate AS user_opt_in_percentage,
        ios AS is_ios_compatible,
        tvos AS is_tvos_compatible,
        is_bundle
    FROM app_projected
),

"app_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- app_id: from INT to VARCHAR
    -- pre_order_details: from DECIMAL to VARCHAR
    SELECT
        "is_enabled",
        "app_name",
        "asset_token",
        "icon_url",
        "user_opt_in_percentage",
        "is_ios_compatible",
        "is_tvos_compatible",
        "is_bundle",
        CAST("app_id" AS VARCHAR) AS "app_id",
        CAST("pre_order_details" AS VARCHAR) AS "pre_order_details"
    FROM "app_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "app_projected_renamed_casted"