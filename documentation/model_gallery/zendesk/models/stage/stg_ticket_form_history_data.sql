-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_form_history_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "updated_at",
        "_fivetran_deleted",
        "active",
        "created_at",
        "display_name",
        "end_user_visible",
        "name"
    FROM "ticket_form_history_data"
),

"ticket_form_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> form_id
    -- _fivetran_deleted -> is_deleted
    -- active -> is_active
    -- display_name -> form_identifier
    -- end_user_visible -> is_visible_to_end_user
    -- name -> form_name
    SELECT 
        "id" AS "form_id",
        "updated_at",
        "_fivetran_deleted" AS "is_deleted",
        "active" AS "is_active",
        "created_at",
        "display_name" AS "form_identifier",
        "end_user_visible" AS "is_visible_to_end_user",
        "name" AS "form_name"
    FROM "ticket_form_history_data_projected"
),

"ticket_form_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "form_id",
        "is_deleted",
        "is_active",
        "form_identifier",
        "is_visible_to_end_user",
        "form_name",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "ticket_form_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_form_history_data_projected_renamed_casted"