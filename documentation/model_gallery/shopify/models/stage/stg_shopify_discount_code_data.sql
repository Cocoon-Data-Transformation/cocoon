-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_discount_code_data_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "code",
        "created_at",
        "price_rule_id",
        "updated_at",
        "usage_count"
    FROM "shopify_discount_code_data"
),

"shopify_discount_code_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> discount_id
    -- code -> discount_code
    SELECT 
        "id" AS "discount_id",
        "code" AS "discount_code",
        "created_at",
        "price_rule_id",
        "updated_at",
        "usage_count"
    FROM "shopify_discount_code_data_projected"
),

"shopify_discount_code_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "discount_id",
        "discount_code",
        "price_rule_id",
        "usage_count",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("updated_at" AS TIMESTAMP) AS "updated_at"
    FROM "shopify_discount_code_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_discount_code_data_projected_renamed_casted"