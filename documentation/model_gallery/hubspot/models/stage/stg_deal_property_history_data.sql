-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"deal_property_history_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "deal_id",
        "timestamp_",
        "source",
        "name",
        "source_id",
        "value_"
    FROM "deal_property_history_data"
),

"deal_property_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- timestamp_ -> change_timestamp
    -- name -> property_name
    -- value_ -> new_value
    SELECT 
        "deal_id",
        "timestamp_" AS "change_timestamp",
        "source",
        "name" AS "property_name",
        "source_id",
        "value_" AS "new_value"
    FROM "deal_property_history_data_projected"
),

"deal_property_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- change_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "deal_id",
        "source",
        "property_name",
        "source_id",
        "new_value",
        CAST("change_timestamp" AS TIMESTAMP) AS "change_timestamp"
    FROM "deal_property_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "deal_property_history_data_projected_renamed_casted"