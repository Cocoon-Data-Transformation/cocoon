-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"property_data_projected" AS (
    -- Projection: Selecting 13 out of 14 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_id",
        "calculated",
        "created_at",
        "description",
        "field_type",
        "group_name",
        "hubspot_defined",
        "hubspot_object",
        "label",
        "name",
        "show_currency_symbol",
        "type",
        "updated_at"
    FROM "property_data"
),

"property_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_id -> fivetran_sync_id
    -- calculated -> is_calculated
    -- created_at -> creation_timestamp
    -- description -> property_description
    -- group_name -> property_group
    -- hubspot_defined -> is_hubspot_defined
    -- hubspot_object -> hubspot_object_type
    -- label -> display_label
    -- name -> property_name
    -- type -> data_type
    -- updated_at -> last_update_timestamp
    SELECT 
        "_fivetran_id" AS "fivetran_sync_id",
        "calculated" AS "is_calculated",
        "created_at" AS "creation_timestamp",
        "description" AS "property_description",
        "field_type",
        "group_name" AS "property_group",
        "hubspot_defined" AS "is_hubspot_defined",
        "hubspot_object" AS "hubspot_object_type",
        "label" AS "display_label",
        "name" AS "property_name",
        "show_currency_symbol",
        "type" AS "data_type",
        "updated_at" AS "last_update_timestamp"
    FROM "property_data_projected"
),

"property_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- property_description: The problem is that all values in the property_description column are Base64 encoded strings instead of readable property descriptions. Base64 encoding is typically used to represent binary data as ASCII text, but in this case it's obscuring the actual property descriptions. The correct values would be the decoded versions of these strings, but without access to the original data or decoding key, we can't determine the actual property descriptions. 
    -- display_label: The problem is inconsistent capitalization for the same concept ('Create Date' and 'Create date'). Additionally, 'test_date' and 'test_pro' appear to be test or placeholder values that don't fit with the other date-related labels. The correct values should maintain consistency and remove test entries. 
    -- property_name: The problem is that 'test_pro' doesn't follow the '_date' pattern of the other values. The correct values should all end with '_date'. Additionally, 'createdate' and 'closedate' don't follow the pattern of having an underscore before 'date'. The most consistent format would be to have all values with an underscore before 'date'. 
    SELECT
        "fivetran_sync_id",
        "is_calculated",
        "creation_timestamp",
        CASE
            WHEN "property_description" = '1B2M2Y8AsgTpgAmY7PhCfg==' THEN ''
            WHEN "property_description" = 'HRIf2XFKVmDQxMzI2w3mcA==' THEN ''
            WHEN "property_description" = 'M0xKTEL9t51+vD5ztRfm+A==' THEN ''
            WHEN "property_description" = 'MD3INB3ab4k2LqaTom0eEA==' THEN ''
            WHEN "property_description" = 'jjSyQlM9DMhpVol12tp4fg==' THEN ''
            WHEN "property_description" = 'k+VMRhjE/W4QB470Jor1yA==' THEN ''
            WHEN "property_description" = 'lMRanmvFHjNC0pQdw79H5Q==' THEN ''
            WHEN "property_description" = 'nBljQWslMNrEDwXeYmRYyg==' THEN ''
            WHEN "property_description" = 'nRGOJjIZrs4d0WJLkC15fg==' THEN ''
            WHEN "property_description" = 'wyvwVnWdqsdNRapzG8Y/RA==' THEN ''
            ELSE "property_description"
        END AS "property_description",
        "field_type",
        "property_group",
        "is_hubspot_defined",
        "hubspot_object_type",
        CASE
            WHEN "display_label" = 'Create date' THEN 'Create Date'
            WHEN "display_label" = 'test_date' THEN ''
            WHEN "display_label" = 'test_pro' THEN ''
            ELSE "display_label"
        END AS "display_label",
        CASE
            WHEN "property_name" = 'createdate' THEN 'create_date'
            WHEN "property_name" = 'closedate' THEN 'close_date'
            WHEN "property_name" = 'test_pro' THEN 'test_date'
            ELSE "property_name"
        END AS "property_name",
        "show_currency_symbol",
        "data_type",
        "last_update_timestamp"
    FROM "property_data_projected_renamed"
),

"property_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- property_description: ['']
    -- display_label: ['']
    SELECT 
        CASE
            WHEN "property_description" = '' THEN NULL
            ELSE "property_description"
        END AS "property_description",
        CASE
            WHEN "display_label" = '' THEN NULL
            ELSE "display_label"
        END AS "display_label",
        "creation_timestamp",
        "hubspot_object_type",
        "show_currency_symbol",
        "field_type",
        "is_hubspot_defined",
        "data_type",
        "fivetran_sync_id",
        "last_update_timestamp",
        "property_name",
        "is_calculated",
        "property_group"
    FROM "property_data_projected_renamed_cleaned"
),

"property_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- creation_timestamp: from VARCHAR to TIMESTAMP
    -- is_hubspot_defined: from BOOLEAN to VARCHAR
    -- last_update_timestamp: from VARCHAR to TIMESTAMP
    SELECT
        "property_description",
        "display_label",
        "hubspot_object_type",
        "show_currency_symbol",
        "field_type",
        "data_type",
        "fivetran_sync_id",
        "property_name",
        "is_calculated",
        "property_group",
        CAST("creation_timestamp" AS TIMESTAMP) AS "creation_timestamp",
        CAST("is_hubspot_defined" AS VARCHAR) AS "is_hubspot_defined",
        CAST("last_update_timestamp" AS TIMESTAMP) AS "last_update_timestamp"
    FROM "property_data_projected_renamed_cleaned_null"
),

"property_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- display_label has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- is_hubspot_defined has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- property_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
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
        "last_update_timestamp"
    FROM "property_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "property_data_projected_renamed_cleaned_null_casted_missing_handled"