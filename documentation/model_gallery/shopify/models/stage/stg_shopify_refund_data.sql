-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_refund_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "created_at",
        "processed_at",
        "note",
        "restock",
        "user_id",
        "total_duties_set",
        "order_id"
    FROM "shopify_refund_data"
),

"shopify_refund_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> refund_id
    -- created_at -> refund_created_at
    -- processed_at -> refund_processed_at
    -- note -> refund_note
    -- restock -> items_restocked
    -- user_id -> customer_id
    -- total_duties_set -> refund_duties
    -- order_id -> original_order_id
    SELECT 
        "id" AS "refund_id",
        "created_at" AS "refund_created_at",
        "processed_at" AS "refund_processed_at",
        "note" AS "refund_note",
        "restock" AS "items_restocked",
        "user_id" AS "customer_id",
        "total_duties_set" AS "refund_duties",
        "order_id" AS "original_order_id"
    FROM "shopify_refund_data_projected"
),

"shopify_refund_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- refund_note: The problem is that 'my refund note' appears to be a placeholder value rather than genuine refund notes. It's unusual because it's generic and doesn't provide any specific information about individual refunds. The correct values should be actual refund notes or an empty string if no specific note is available. 
    SELECT
        "refund_id",
        "refund_created_at",
        "refund_processed_at",
        CASE
            WHEN "refund_note" = 'my refund note' THEN ''
            ELSE "refund_note"
        END AS "refund_note",
        "items_restocked",
        "customer_id",
        "refund_duties",
        "original_order_id"
    FROM "shopify_refund_data_projected_renamed"
),

"shopify_refund_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- refund_note: ['']
    SELECT 
        CASE
            WHEN "refund_note" = '' THEN NULL
            ELSE "refund_note"
        END AS "refund_note",
        "original_order_id",
        "refund_created_at",
        "refund_duties",
        "customer_id",
        "refund_processed_at",
        "items_restocked",
        "refund_id"
    FROM "shopify_refund_data_projected_renamed_cleaned"
),

"shopify_refund_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- customer_id: from INT to VARCHAR
    -- original_order_id: from INT to VARCHAR
    -- refund_created_at: from VARCHAR to TIMESTAMP
    -- refund_duties: from DECIMAL to VARCHAR
    -- refund_id: from INT to VARCHAR
    -- refund_processed_at: from VARCHAR to TIMESTAMP
    SELECT
        "refund_note",
        "items_restocked",
        CAST("customer_id" AS VARCHAR) AS "customer_id",
        CAST("original_order_id" AS VARCHAR) AS "original_order_id",
        CAST("refund_created_at" AS TIMESTAMP) AS "refund_created_at",
        CAST("refund_duties" AS VARCHAR) AS "refund_duties",
        CAST("refund_id" AS VARCHAR) AS "refund_id",
        CAST("refund_processed_at" AS TIMESTAMP) AS "refund_processed_at"
    FROM "shopify_refund_data_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_refund_data_projected_renamed_cleaned_null_casted"