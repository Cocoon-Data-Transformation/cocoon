-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"contact_property_history_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "contact_id",
        "timestamp_",
        "source",
        "name",
        "value_",
        "source_id"
    FROM "contact_property_history_data"
),

"contact_property_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- timestamp_ -> change_timestamp
    -- name -> property_name
    -- value_ -> property_value
    SELECT 
        "contact_id",
        "timestamp_" AS "change_timestamp",
        "source",
        "name" AS "property_name",
        "value_" AS "property_value",
        "source_id"
    FROM "contact_property_history_data_projected"
),

"contact_property_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- change_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "contact_id",
        "source",
        "property_name",
        "property_value",
        "source_id",
        CAST("change_timestamp" AS TIMESTAMP) AS "change_timestamp"
    FROM "contact_property_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "contact_property_history_data_projected_renamed_casted"