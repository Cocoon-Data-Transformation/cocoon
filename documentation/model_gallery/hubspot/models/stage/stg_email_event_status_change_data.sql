-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"email_event_status_change_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "bounced",
        "portal_subscription_status",
        "requested_by",
        "source",
        "subscriptions"
    FROM "email_event_status_change_data"
),

"email_event_status_change_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> event_id
    -- bounced -> email_bounced
    -- portal_subscription_status -> subscription_status
    -- requested_by -> change_requester
    -- source -> change_source
    -- subscriptions -> active_subscriptions
    SELECT 
        "id" AS "event_id",
        "bounced" AS "email_bounced",
        "portal_subscription_status" AS "subscription_status",
        "requested_by" AS "change_requester",
        "source" AS "change_source",
        "subscriptions" AS "active_subscriptions"
    FROM "email_event_status_change_data_projected"
),

"email_event_status_change_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- active_subscriptions: from VARCHAR to ARRAY
    -- change_requester: from DECIMAL to VARCHAR
    -- email_bounced: from DECIMAL to BOOLEAN
    -- event_id: from VARCHAR to UUID
    SELECT
        "subscription_status",
        "change_source",
        CASE 
            WHEN "active_subscriptions" = '[]' THEN ARRAY[]::INTEGER[] 
            ELSE json_extract("active_subscriptions", '$')::INTEGER[]
        END AS "active_subscriptions",
        CAST("change_requester" AS VARCHAR) AS "change_requester",
        CAST("email_bounced" AS BOOLEAN) AS "email_bounced",
        CAST("event_id" AS UUID) AS "event_id"
    FROM "email_event_status_change_data_projected_renamed"
),

"email_event_status_change_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- email_bounced has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "subscription_status",
        "change_source",
        "active_subscriptions",
        "change_requester",
        "event_id"
    FROM "email_event_status_change_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "email_event_status_change_data_projected_renamed_casted_missing_handled"