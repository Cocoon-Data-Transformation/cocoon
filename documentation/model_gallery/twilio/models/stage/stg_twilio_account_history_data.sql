-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 23:28:59.375739+00:00
WITH 
"twilio_account_history_data_projected" AS (
    -- Projection: Selecting 7 out of 8 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "updated_at",
        "created_at",
        "friendly_name",
        "owner_account_id",
        "status",
        "type"
    FROM "memory"."main"."twilio_account_history_data"
),

"twilio_account_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> account_id
    -- updated_at -> last_update_date
    -- created_at -> account_creation_date
    -- friendly_name -> account_display_name
    -- owner_account_id -> parent_account_id
    -- status -> account_status
    -- type -> account_type
    SELECT 
        "id" AS "account_id",
        "updated_at" AS "last_update_date",
        "created_at" AS "account_creation_date",
        "friendly_name" AS "account_display_name",
        "owner_account_id" AS "parent_account_id",
        "status" AS "account_status",
        "type" AS "account_type"
    FROM "twilio_account_history_data_projected"
),

"twilio_account_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_creation_date: from VARCHAR to TIMESTAMP
    -- last_update_date: from VARCHAR to TIMESTAMP
    SELECT
        "account_id",
        "account_display_name",
        "parent_account_id",
        "account_status",
        "account_type",
        CAST("account_creation_date" AS TIMESTAMP) AS "account_creation_date",
        CAST("last_update_date" AS TIMESTAMP) AS "last_update_date"
    FROM "twilio_account_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "twilio_account_history_data_projected_renamed_casted"