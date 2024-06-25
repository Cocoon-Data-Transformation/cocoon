-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"contact_list_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "created_at",
        "deleteable",
        "dynamic",
        "metadata_error",
        "metadata_last_processing_state_change_at",
        "metadata_last_size_change_at",
        "metadata_processing",
        "metadata_size",
        "offset",
        "portal_id",
        "updated_at",
        "name"
    FROM "contact_list_data"
),

"contact_list_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> list_id
    -- _fivetran_deleted -> is_deleted
    -- deleteable -> is_deletable
    -- dynamic -> is_dynamic
    -- metadata_error -> processing_error
    -- metadata_last_processing_state_change_at -> last_processing_state_change_at
    -- metadata_last_size_change_at -> last_size_change_at
    -- metadata_processing -> processing_state
    -- metadata_size -> list_size
    -- name -> hashed_list_name
    SELECT 
        "id" AS "list_id",
        "_fivetran_deleted" AS "is_deleted",
        "created_at",
        "deleteable" AS "is_deletable",
        "dynamic" AS "is_dynamic",
        "metadata_error" AS "processing_error",
        "metadata_last_processing_state_change_at" AS "last_processing_state_change_at",
        "metadata_last_size_change_at" AS "last_size_change_at",
        "metadata_processing" AS "processing_state",
        "metadata_size" AS "list_size",
        "offset",
        "portal_id",
        "updated_at",
        "name" AS "hashed_list_name"
    FROM "contact_list_data_projected"
),

"contact_list_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- last_processing_state_change_at: from VARCHAR to TIMESTAMP
    -- last_size_change_at: from VARCHAR to TIMESTAMP
    -- offset: from DECIMAL to VARCHAR
    -- processing_error: from DECIMAL to VARCHAR
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "list_id",
        "is_deleted",
        "is_deletable",
        "is_dynamic",
        "processing_state",
        "list_size",
        "portal_id",
        "hashed_list_name",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("last_processing_state_change_at" AS TIMESTAMP) AS "last_processing_state_change_at",
        CAST("last_size_change_at" AS TIMESTAMP) AS "last_size_change_at",
        CAST("offset" AS VARCHAR) AS "offset",
        CAST("processing_error" AS VARCHAR) AS "processing_error",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "contact_list_data_projected_renamed"
),

"contact_list_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- offset has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- processing_error has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "list_id",
        "is_deleted",
        "is_deletable",
        "is_dynamic",
        "processing_state",
        "list_size",
        "portal_id",
        "hashed_list_name",
        "created_at",
        "last_processing_state_change_at",
        "last_size_change_at",
        "updated_at"
    FROM "contact_list_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "contact_list_data_projected_renamed_casted_missing_handled"