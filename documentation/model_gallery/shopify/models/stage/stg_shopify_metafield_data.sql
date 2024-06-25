-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_metafield_data_projected" AS (
    -- Projection: Selecting 11 out of 12 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_at",
        "description",
        "key_",
        "namespace",
        "owner_id",
        "owner_resource",
        "updated_at",
        "value_",
        "value_type",
        "type"
    FROM "shopify_metafield_data"
),

"shopify_metafield_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> record_id
    -- key_ -> data_key
    -- owner_id -> order_id
    -- owner_resource -> resource_type
    -- value_ -> return_authorization_data
    -- type -> value_data_type
    SELECT 
        "id" AS "record_id",
        "created_at",
        "description",
        "key_" AS "data_key",
        "namespace",
        "owner_id" AS "order_id",
        "owner_resource" AS "resource_type",
        "updated_at",
        "value_" AS "return_authorization_data",
        "value_type",
        "type" AS "value_data_type"
    FROM "shopify_metafield_data_projected"
),

"shopify_metafield_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- description: from DECIMAL to VARCHAR
    -- order_id: from INT to VARCHAR
    -- record_id: from INT to VARCHAR
    -- return_authorization_data: from VARCHAR to JSON
    -- updated_at: from VARCHAR to TIMESTAMP
    -- value_type: from DECIMAL to VARCHAR
    SELECT
        "data_key",
        "namespace",
        "resource_type",
        "value_data_type",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("description" AS VARCHAR) AS "description",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("record_id" AS VARCHAR) AS "record_id",
        CAST("return_authorization_data" AS JSON) AS "return_authorization_data",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at",
        CAST("value_type" AS VARCHAR) AS "value_type"
    FROM "shopify_metafield_data_projected_renamed"
),

"shopify_metafield_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- value_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "data_key",
        "namespace",
        "resource_type",
        "value_data_type",
        "created_at",
        "order_id",
        "record_id",
        "return_authorization_data",
        "updated_at"
    FROM "shopify_metafield_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_metafield_data_projected_renamed_casted_missing_handled"