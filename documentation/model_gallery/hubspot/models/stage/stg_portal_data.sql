-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"portal_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "portal_id",
        "name",
        "currency",
        "subscription_type",
        "subscription_level"
    FROM "portal_data"
),

"portal_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- name -> company_name
    -- subscription_level -> subscription_tier
    SELECT 
        "portal_id",
        "name" AS "company_name",
        "currency",
        "subscription_type",
        "subscription_level" AS "subscription_tier"
    FROM "portal_data_projected"
),

"portal_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- portal_id: from INT to VARCHAR
    SELECT
        "company_name",
        "currency",
        "subscription_type",
        "subscription_tier",
        CAST("portal_id" AS VARCHAR) AS "portal_id"
    FROM "portal_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "portal_data_projected_renamed_casted"