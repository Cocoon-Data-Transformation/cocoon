-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"organization_data_projected" AS (
    -- Projection: Selecting 11 out of 12 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_at",
        "details",
        "external_id",
        "group_id",
        "name",
        "notes",
        "shared_comments",
        "shared_tickets",
        "updated_at",
        "url"
    FROM "organization_data"
),

"organization_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> organization_id
    -- created_at -> creation_date
    -- details -> organization_details
    -- name -> organization_name
    -- notes -> organization_notes
    -- shared_comments -> has_shared_comments
    -- shared_tickets -> has_shared_tickets
    -- updated_at -> last_updated_date
    -- url -> api_url
    SELECT 
        "id" AS "organization_id",
        "created_at" AS "creation_date",
        "details" AS "organization_details",
        "external_id",
        "group_id",
        "name" AS "organization_name",
        "notes" AS "organization_notes",
        "shared_comments" AS "has_shared_comments",
        "shared_tickets" AS "has_shared_tickets",
        "updated_at" AS "last_updated_date",
        "url" AS "api_url"
    FROM "organization_data_projected"
),

"organization_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- creation_date: from VARCHAR to TIMESTAMP
    -- external_id: from DECIMAL to VARCHAR
    -- group_id: from DECIMAL to VARCHAR
    -- last_updated_date: from VARCHAR to TIMESTAMP
    -- organization_details: from DECIMAL to VARCHAR
    -- organization_id: from INT to VARCHAR
    -- organization_notes: from DECIMAL to VARCHAR
    SELECT
        "organization_name",
        "has_shared_comments",
        "has_shared_tickets",
        "api_url",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("external_id" AS VARCHAR) AS "external_id",
        CAST("group_id" AS VARCHAR) AS "group_id",
        CAST("last_updated_date" AS TIMESTAMP) AS "last_updated_date",
        CAST("organization_details" AS VARCHAR) AS "organization_details",
        CAST("organization_id" AS VARCHAR) AS "organization_id",
        CAST("organization_notes" AS VARCHAR) AS "organization_notes"
    FROM "organization_data_projected_renamed"
),

"organization_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- external_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- group_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- organization_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- organization_notes has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "organization_name",
        "has_shared_comments",
        "has_shared_tickets",
        "api_url",
        "creation_date",
        "last_updated_date",
        "organization_id"
    FROM "organization_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "organization_data_projected_renamed_casted_missing_handled"