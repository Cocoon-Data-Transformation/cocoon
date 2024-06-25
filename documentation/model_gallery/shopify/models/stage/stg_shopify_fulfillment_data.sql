-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_fulfillment_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_at",
        "location_id",
        "order_id",
        "status",
        "tracking_company",
        "tracking_number",
        "updated_at",
        "tracking_numbers",
        "tracking_urls",
        "shipment_status",
        "service",
        "name",
        "receipt_authorization"
    FROM "shopify_fulfillment_data"
),

"shopify_fulfillment_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> fulfillment_id
    -- status -> fulfillment_status
    -- tracking_number -> primary_tracking_number
    -- tracking_numbers -> all_tracking_numbers
    -- service -> fulfillment_service
    -- name -> fulfillment_name
    SELECT 
        "id" AS "fulfillment_id",
        "created_at",
        "location_id",
        "order_id",
        "status" AS "fulfillment_status",
        "tracking_company",
        "tracking_number" AS "primary_tracking_number",
        "updated_at",
        "tracking_numbers" AS "all_tracking_numbers",
        "tracking_urls",
        "shipment_status",
        "service" AS "fulfillment_service",
        "name" AS "fulfillment_name",
        "receipt_authorization"
    FROM "shopify_fulfillment_data_projected"
),

"shopify_fulfillment_data_projected_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- all_tracking_numbers: ['[]']
    SELECT 
        CASE
            WHEN "all_tracking_numbers" = '[]' THEN NULL
            ELSE "all_tracking_numbers"
        END AS "all_tracking_numbers",
        "receipt_authorization",
        "fulfillment_name",
        "fulfillment_service",
        "created_at",
        "primary_tracking_number",
        "order_id",
        "updated_at",
        "tracking_company",
        "tracking_urls",
        "fulfillment_id",
        "location_id",
        "fulfillment_status",
        "shipment_status"
    FROM "shopify_fulfillment_data_projected_renamed"
),

"shopify_fulfillment_data_projected_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- fulfillment_id: from INT to VARCHAR
    -- location_id: from INT to VARCHAR
    -- order_id: from INT to VARCHAR
    -- primary_tracking_number: from DECIMAL to VARCHAR
    -- receipt_authorization: from DECIMAL to VARCHAR
    -- shipment_status: from DECIMAL to VARCHAR
    -- tracking_company: from DECIMAL to VARCHAR
    -- tracking_urls: from VARCHAR to JSON
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "all_tracking_numbers",
        "fulfillment_name",
        "fulfillment_service",
        "fulfillment_status",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("fulfillment_id" AS VARCHAR) AS "fulfillment_id",
        CAST("location_id" AS VARCHAR) AS "location_id",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("primary_tracking_number" AS VARCHAR) AS "primary_tracking_number",
        CAST("receipt_authorization" AS VARCHAR) AS "receipt_authorization",
        CAST("shipment_status" AS VARCHAR) AS "shipment_status",
        CAST("tracking_company" AS VARCHAR) AS "tracking_company",
        CAST("tracking_urls" AS JSON) AS "tracking_urls",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "shopify_fulfillment_data_projected_renamed_null"
),

"shopify_fulfillment_data_projected_renamed_null_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- primary_tracking_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- receipt_authorization has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipment_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tracking_company has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "all_tracking_numbers",
        "fulfillment_name",
        "fulfillment_service",
        "fulfillment_status",
        "created_at",
        "fulfillment_id",
        "location_id",
        "order_id",
        "tracking_urls",
        "updated_at"
    FROM "shopify_fulfillment_data_projected_renamed_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_fulfillment_data_projected_renamed_null_casted_missing_handled"