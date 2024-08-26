-- Slowly Changing Dimension: Dimension keys are "DEAL_ID"
-- Version columns are DATE_ENTERED, _FIVETRAN_START, _FIVETRAN_END, _FIVETRAN_ACTIVE
-- We will create Type 1 SCD (latest snapshot)

SELECT 
    "DEAL_ID",
    "VALUE_",
    "SOURCE_ID",
    "SOURCE",
    "_FIVETRAN_SYNCED"
FROM "stg_DEAL_STAGE"
QUALIFY ROW_NUMBER() OVER ( 
    PARTITION BY "DEAL_ID"
    ORDER BY
        _FIVETRAN_ACTIVE DESC,
        _FIVETRAN_END IS NULL DESC,
        _FIVETRAN_START DESC,
        DATE_ENTERED DESC
) = 1