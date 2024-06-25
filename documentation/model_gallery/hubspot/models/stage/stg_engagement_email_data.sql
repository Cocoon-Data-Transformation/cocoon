-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_email_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "engagement_id",
        "_fivetran_deleted",
        "property_hs_all_owner_ids",
        "property_hs_all_team_ids",
        "property_hs_createdate",
        "property_hs_email_subject",
        "property_hs_email_text",
        "property_hs_lastmodifieddate",
        "property_hs_modified_by",
        "property_hs_timestamp",
        "property_hubspot_owner_id",
        "property_hubspot_team_id",
        "type"
    FROM "engagement_email_data"
),

"engagement_email_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- property_hs_all_owner_ids -> all_owner_ids
    -- property_hs_all_team_ids -> all_team_ids
    -- property_hs_createdate -> created_at
    -- property_hs_email_subject -> email_subject
    -- property_hs_email_text -> email_body
    -- property_hs_lastmodifieddate -> last_modified_at
    -- property_hs_modified_by -> modified_by_id
    -- property_hs_timestamp -> engagement_timestamp
    -- property_hubspot_owner_id -> primary_owner_id
    -- property_hubspot_team_id -> primary_team_id
    -- type -> engagement_type
    SELECT 
        "engagement_id",
        "_fivetran_deleted" AS "is_deleted",
        "property_hs_all_owner_ids" AS "all_owner_ids",
        "property_hs_all_team_ids" AS "all_team_ids",
        "property_hs_createdate" AS "created_at",
        "property_hs_email_subject" AS "email_subject",
        "property_hs_email_text" AS "email_body",
        "property_hs_lastmodifieddate" AS "last_modified_at",
        "property_hs_modified_by" AS "modified_by_id",
        "property_hs_timestamp" AS "engagement_timestamp",
        "property_hubspot_owner_id" AS "primary_owner_id",
        "property_hubspot_team_id" AS "primary_team_id",
        "type" AS "engagement_type"
    FROM "engagement_email_data_projected"
),

"engagement_email_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- all_owner_ids: from DECIMAL to ARRAY
    -- all_team_ids: from DECIMAL to ARRAY
    -- created_at: from VARCHAR to TIMESTAMP
    -- engagement_id: from INT to VARCHAR
    -- engagement_timestamp: from VARCHAR to TIMESTAMP
    -- last_modified_at: from VARCHAR to TIMESTAMP
    -- modified_by_id: from DECIMAL to VARCHAR
    -- primary_owner_id: from DECIMAL to VARCHAR
    -- primary_team_id: from DECIMAL to VARCHAR
    SELECT
        "is_deleted",
        "email_subject",
        "email_body",
        "engagement_type",
        CAST("all_owner_ids" AS INTEGER[]) AS "all_owner_ids",
        CAST("all_team_ids" AS INTEGER[]) AS "all_team_ids",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id",
        CAST("engagement_timestamp" AS TIMESTAMP) AS "engagement_timestamp",
        CAST("last_modified_at" AS TIMESTAMP) AS "last_modified_at",
        CAST("modified_by_id" AS VARCHAR) AS "modified_by_id",
        CAST("primary_owner_id" AS VARCHAR) AS "primary_owner_id",
        CAST("primary_team_id" AS VARCHAR) AS "primary_team_id"
    FROM "engagement_email_data_projected_renamed"
),

"engagement_email_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 5 columns with unacceptable missing values
    -- all_owner_ids has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- all_team_ids has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- modified_by_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- primary_owner_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- primary_team_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_deleted",
        "email_subject",
        "email_body",
        "engagement_type",
        "created_at",
        "engagement_id",
        "engagement_timestamp",
        "last_modified_at"
    FROM "engagement_email_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_email_data_projected_renamed_casted_missing_handled"