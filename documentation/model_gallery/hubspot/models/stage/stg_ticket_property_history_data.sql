-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ticket_property_history_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_start",
        "name",
        "ticket_id",
        "_fivetran_active",
        "_fivetran_end",
        "source",
        "source_id",
        "timestamp_instant",
        "value_"
    FROM "ticket_property_history_data"
),

"ticket_property_history_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_start -> valid_from
    -- name -> property_name
    -- _fivetran_active -> is_active
    -- _fivetran_end -> valid_until
    -- source -> value_source
    -- source_id -> source_identifier
    -- timestamp_instant -> recorded_at
    -- value_ -> property_value
    SELECT 
        "_fivetran_start" AS "valid_from",
        "name" AS "property_name",
        "ticket_id",
        "_fivetran_active" AS "is_active",
        "_fivetran_end" AS "valid_until",
        "source" AS "value_source",
        "source_id" AS "source_identifier",
        "timestamp_instant" AS "recorded_at",
        "value_" AS "property_value"
    FROM "ticket_property_history_data_projected"
),

"ticket_property_history_data_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- valid_until: ['9999-12-31 23:59:59.999000']
    SELECT 
        CASE
            WHEN "valid_until" = '9999-12-31 23:59:59.999000' THEN NULL
            ELSE "valid_until"
        END AS "valid_until",
        "property_name",
        "property_value",
        "recorded_at",
        "valid_from",
        "value_source",
        "source_identifier",
        "ticket_id",
        "is_active"
    FROM "ticket_property_history_data_projected_renamed"
),

"ticket_property_history_data_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- recorded_at: from VARCHAR to TIMESTAMP
    -- source_identifier: from DECIMAL to VARCHAR
    -- ticket_id: from INT to VARCHAR
    -- valid_from: from VARCHAR to TIMESTAMP
    -- valid_until: from VARCHAR to TIMESTAMP
    SELECT
        "property_name",
        "property_value",
        "value_source",
        "is_active",
        CAST("recorded_at" AS TIMESTAMP) AS "recorded_at",
        CAST("source_identifier" AS VARCHAR) AS "source_identifier",
        CAST("ticket_id" AS VARCHAR) AS "ticket_id",
        CAST("valid_from" AS TIMESTAMP) AS "valid_from",
        CAST("valid_until" AS TIMESTAMP) AS "valid_until"
    FROM "ticket_property_history_data_projected_renamed_null"
),

"ticket_property_history_data_projected_renamed_null_casted_missing_handled" AS (
    -- Handling missing values: There are 1 columns with unacceptable missing values
    -- source_identifier has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "property_name",
        "property_value",
        "value_source",
        "is_active",
        "recorded_at",
        "ticket_id",
        "valid_from",
        "valid_until"
    FROM "ticket_property_history_data_projected_renamed_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "ticket_property_history_data_projected_renamed_null_casted_missing_handled"