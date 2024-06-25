-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"engagement_note_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "engagement_id",
        "_fivetran_deleted",
        "property_hs_body_preview",
        "property_hs_createdate",
        "property_hs_lastmodifieddate",
        "property_hs_note_body",
        "property_hs_timestamp",
        "property_hubspot_owner_id",
        "property_hubspot_team_id",
        "type"
    FROM "engagement_note_data"
),

"engagement_note_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- property_hs_body_preview -> note_preview
    -- property_hs_createdate -> created_at
    -- property_hs_lastmodifieddate -> last_modified_at
    -- property_hs_note_body -> note_body
    -- property_hs_timestamp -> note_timestamp
    -- property_hubspot_owner_id -> owner_id
    -- property_hubspot_team_id -> team_id
    -- type -> engagement_type
    SELECT 
        "engagement_id",
        "_fivetran_deleted" AS "is_deleted",
        "property_hs_body_preview" AS "note_preview",
        "property_hs_createdate" AS "created_at",
        "property_hs_lastmodifieddate" AS "last_modified_at",
        "property_hs_note_body" AS "note_body",
        "property_hs_timestamp" AS "note_timestamp",
        "property_hubspot_owner_id" AS "owner_id",
        "property_hubspot_team_id" AS "team_id",
        "type" AS "engagement_type"
    FROM "engagement_note_data_projected"
),

"engagement_note_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- engagement_id: from INT to VARCHAR
    -- last_modified_at: from VARCHAR to TIMESTAMP
    -- note_timestamp: from VARCHAR to TIMESTAMP
    -- owner_id: from DECIMAL to VARCHAR
    -- team_id: from DECIMAL to VARCHAR
    SELECT
        "is_deleted",
        "note_preview",
        "note_body",
        "engagement_type",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("engagement_id" AS VARCHAR) AS "engagement_id",
        CAST("last_modified_at" AS TIMESTAMP) AS "last_modified_at",
        CAST("note_timestamp" AS TIMESTAMP) AS "note_timestamp",
        CAST("owner_id" AS VARCHAR) AS "owner_id",
        CAST("team_id" AS VARCHAR) AS "team_id"
    FROM "engagement_note_data_projected_renamed"
),

"engagement_note_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- owner_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- team_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_deleted",
        "note_preview",
        "note_body",
        "engagement_type",
        "created_at",
        "engagement_id",
        "last_modified_at",
        "note_timestamp"
    FROM "engagement_note_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "engagement_note_data_projected_renamed_casted_missing_handled"