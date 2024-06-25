-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "is_deleted",
        "property_closed_date",
        "property_createdate",
        "property_first_agent_reply_date",
        "property_hs_pipeline",
        "property_hs_pipeline_stage",
        "property_hs_ticket_category",
        "property_hs_ticket_priority",
        "property_hubspot_owner_id",
        "property_subject",
        "property_content"
    FROM "ticket_data"
),

"ticket_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> ticket_id
    -- property_closed_date -> closed_date
    -- property_createdate -> created_date
    -- property_first_agent_reply_date -> first_reply_date
    -- property_hs_pipeline -> pipeline_id
    -- property_hs_pipeline_stage -> pipeline_stage_id
    -- property_hs_ticket_category -> ticket_category_hash
    -- property_hs_ticket_priority -> ticket_priority
    -- property_hubspot_owner_id -> owner_id
    -- property_subject -> ticket_subject_hash
    -- property_content -> ticket_content_hash
    SELECT 
        "id" AS "ticket_id",
        "is_deleted",
        "property_closed_date" AS "closed_date",
        "property_createdate" AS "created_date",
        "property_first_agent_reply_date" AS "first_reply_date",
        "property_hs_pipeline" AS "pipeline_id",
        "property_hs_pipeline_stage" AS "pipeline_stage_id",
        "property_hs_ticket_category" AS "ticket_category_hash",
        "property_hs_ticket_priority" AS "ticket_priority",
        "property_hubspot_owner_id" AS "owner_id",
        "property_subject" AS "ticket_subject_hash",
        "property_content" AS "ticket_content_hash"
    FROM "ticket_data_projected"
),

"ticket_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- closed_date: from VARCHAR to TIMESTAMP
    -- created_date: from VARCHAR to TIMESTAMP
    -- first_reply_date: from VARCHAR to TIMESTAMP
    -- owner_id: from DECIMAL to VARCHAR
    -- pipeline_id: from INT to VARCHAR
    -- pipeline_stage_id: from INT to VARCHAR
    -- ticket_id: from INT to VARCHAR
    -- ticket_priority: from DECIMAL to VARCHAR
    SELECT
        "is_deleted",
        "ticket_category_hash",
        "ticket_subject_hash",
        "ticket_content_hash",
        CAST("closed_date" AS TIMESTAMP) AS "closed_date",
        CAST("created_date" AS TIMESTAMP) AS "created_date",
        CAST("first_reply_date" AS TIMESTAMP) AS "first_reply_date",
        CAST("owner_id" AS VARCHAR) AS "owner_id",
        CAST("pipeline_id" AS VARCHAR) AS "pipeline_id",
        CAST("pipeline_stage_id" AS VARCHAR) AS "pipeline_stage_id",
        CAST("ticket_id" AS VARCHAR) AS "ticket_id",
        CAST("ticket_priority" AS VARCHAR) AS "ticket_priority"
    FROM "ticket_data_projected_renamed"
),

"ticket_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- owner_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ticket_category_hash has 87.5 percent missing. Strategy: 🔄 Unchanged
    -- ticket_priority has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_deleted",
        "ticket_category_hash",
        "ticket_subject_hash",
        "ticket_content_hash",
        "closed_date",
        "created_date",
        "first_reply_date",
        "pipeline_id",
        "pipeline_stage_id",
        "ticket_id"
    FROM "ticket_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_data_projected_renamed_casted_missing_handled"