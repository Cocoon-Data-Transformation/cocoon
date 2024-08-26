-- Slowly Changing Dimension: Dimension keys are "GUID"
-- Version columns are CREATED_AT, UPDATED_AT, _FIVETRAN_SYNCED
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "GUID",
    "PORTAL_ID",
    "NAME",
    "ACTION_",
    "METHOD",
    "CSS_CLASS",
    "REDIRECT",
    "SUBMIT_TEXT",
    "FOLLOW_UP_ID",
    "NOTIFY_RECIPIENTS",
    "LEAD_NURTURING_CAMPAIGN_ID",
    "FORM_TYPE",
    "_FIVETRAN_DELETED"
FROM "stg_FORM"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "GUID"
    ORDER BY
        UPDATED_AT DESC,
        CREATED_AT DESC,
        _FIVETRAN_SYNCED DESC
) = 1