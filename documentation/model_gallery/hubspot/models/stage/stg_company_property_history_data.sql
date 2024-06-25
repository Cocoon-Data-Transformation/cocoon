-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"company_property_history_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "company_id",
        "timestamp_",
        "source",
        "source_id",
        "name",
        "value_"
    FROM "company_property_history_data"
),

"company_property_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- timestamp_ -> update_timestamp
    -- source -> data_source
    -- name -> property_name
    -- value_ -> property_value
    SELECT 
        company_id,
        timestamp_ AS update_timestamp,
        source AS data_source,
        source_id,
        name AS property_name,
        value_ AS property_value
    FROM company_property_history_data_projected
),

"company_property_history_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- company_id: from INT to VARCHAR
    -- source_id: from DECIMAL to VARCHAR
    -- update_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "data_source",
        "property_name",
        "property_value",
        CAST("company_id" AS VARCHAR) AS "company_id",
        CAST("source_id" AS VARCHAR) AS "source_id",
        CAST("update_timestamp" AS TIMESTAMP) AS "update_timestamp"
    FROM "company_property_history_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "company_property_history_data_projected_renamed_casted"