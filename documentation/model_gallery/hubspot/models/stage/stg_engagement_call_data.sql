-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_call_data_projected" AS (
    -- Projection: Selecting 5 out of 6 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "engagement_id",
        "_fivetran_deleted",
        "property_hs_createdate",
        "property_hs_timestamp",
        "type"
    FROM "engagement_call_data"
),

"engagement_call_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- property_hs_createdate -> creation_datetime
    -- property_hs_timestamp -> call_datetime
    -- type -> engagement_type
    SELECT 
        "engagement_id",
        "_fivetran_deleted" AS "is_deleted",
        "property_hs_createdate" AS "creation_datetime",
        "property_hs_timestamp" AS "call_datetime",
        "type" AS "engagement_type"
    FROM "engagement_call_data_projected"
),

"engagement_call_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- call_datetime: from VARCHAR to TIMESTAMP
    -- creation_datetime: from VARCHAR to TIMESTAMP
    -- engagement_id: from INT to VARCHAR
    SELECT
        "is_deleted",
        "engagement_type",
        CAST("call_datetime" AS TIMESTAMP) AS "call_datetime",
        CAST("creation_datetime" AS TIMESTAMP) AS "creation_datetime",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id"
    FROM "engagement_call_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_call_data_projected_renamed_casted"