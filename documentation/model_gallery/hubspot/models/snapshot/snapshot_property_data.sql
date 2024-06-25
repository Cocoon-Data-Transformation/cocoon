-- Slowly Changing Dimension: Dimension keys are "hubspot_object_type", "property_name"
-- Effective date columns are "last_update_timestamp"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "display_label",
    "hubspot_object_type",
    "show_currency_symbol",
    "field_type",
    "data_type",
    "fivetran_sync_id",
    "property_name",
    "is_calculated",
    "property_group",
    "creation_timestamp",
    "is_hubspot_defined"
FROM (
     SELECT 
            "display_label",
            "hubspot_object_type",
            "show_currency_symbol",
            "field_type",
            "data_type",
            "fivetran_sync_id",
            "property_name",
            "is_calculated",
            "property_group",
            "creation_timestamp",
            "is_hubspot_defined",
            ROW_NUMBER() OVER (
                PARTITION BY "hubspot_object_type", "property_name" 
                ORDER BY "last_update_timestamp" 
            DESC) AS "cocoon_rn"
    FROM "stg_property_data"
) ranked
WHERE "cocoon_rn" = 1