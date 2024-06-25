-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_abandoned_checkout_discount_code_data_projected" AS (
    -- Projection: Selecting 9 out of 10 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "checkout_id",
        "index_",
        "amount",
        "discount_id",
        "code",
        "created_at",
        "type",
        "updated_at",
        "usage_count"
    FROM "shopify_abandoned_checkout_discount_code_data"
),

"shopify_abandoned_checkout_discount_code_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- index_ -> discount_index
    -- amount -> discount_amount
    -- code -> discount_code
    -- created_at -> discount_created_at
    -- type -> discount_type
    -- updated_at -> discount_updated_at
    -- usage_count -> discount_usage_count
    SELECT 
        "checkout_id",
        "index_" AS "discount_index",
        "amount" AS "discount_amount",
        "discount_id",
        "code" AS "discount_code",
        "created_at" AS "discount_created_at",
        "type" AS "discount_type",
        "updated_at" AS "discount_updated_at",
        "usage_count" AS "discount_usage_count"
    FROM "shopify_abandoned_checkout_discount_code_data_projected"
),

"shopify_abandoned_checkout_discount_code_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- discount_created_at: from DECIMAL to TIMESTAMP
    -- discount_id: from DECIMAL to VARCHAR
    -- discount_updated_at: from DECIMAL to TIMESTAMP
    -- discount_usage_count: from DECIMAL to INT
    SELECT
        "checkout_id",
        "discount_index",
        "discount_amount",
        "discount_code",
        "discount_type",
        CAST("discount_created_at" AS TIMESTAMP) AS "discount_created_at",
        CAST("discount_id" AS VARCHAR) AS "discount_id",
        CAST("discount_updated_at" AS TIMESTAMP) AS "discount_updated_at",
        CAST("discount_usage_count" AS INT) AS "discount_usage_count"
    FROM "shopify_abandoned_checkout_discount_code_data_projected_renamed"
),

"shopify_abandoned_checkout_discount_code_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- discount_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- discount_usage_count has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "checkout_id",
        "discount_index",
        "discount_amount",
        "discount_code",
        "discount_type",
        "discount_created_at",
        "discount_updated_at"
    FROM "shopify_abandoned_checkout_discount_code_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_abandoned_checkout_discount_code_data_projected_renamed_casted_missing_handled"