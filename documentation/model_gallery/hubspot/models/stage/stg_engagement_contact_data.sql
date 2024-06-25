-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_contact_data_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "contact_id",
        "engagement_id",
        "engagement_type",
        "type_id"
    FROM "engagement_contact_data"
),

"engagement_contact_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- engagement_type -> engagement_category
    -- type_id -> engagement_type_id
    SELECT 
        "contact_id",
        "engagement_id",
        "engagement_type" AS "engagement_category",
        "type_id" AS "engagement_type_id"
    FROM "engagement_contact_data_projected"
),

"engagement_contact_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- engagement_id: from INT to VARCHAR
    SELECT
        "contact_id",
        "engagement_category",
        "engagement_type_id",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id"
    FROM "engagement_contact_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_contact_data_projected_renamed_casted"