-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_price_rule_data_projected" AS (
    -- Projection: Selecting 21 out of 22 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "allocation_limit",
        "allocation_method",
        "created_at",
        "customer_selection",
        "ends_at",
        "once_per_customer",
        "prerequisite_quantity_range",
        "prerequisite_shipping_price_range",
        "prerequisite_subtotal_range",
        "quantity_ratio_entitled_quantity",
        "quantity_ratio_prerequisite_quantity",
        "starts_at",
        "target_selection",
        "target_type",
        "title",
        "updated_at",
        "usage_limit",
        "value_",
        "value_type",
        "prerequisite_to_entitlement_purchase_prerequisite_amount"
    FROM "shopify_price_rule_data"
),

"shopify_price_rule_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> price_rule_id
    -- created_at -> creation_date
    -- customer_selection -> customer_eligibility
    -- ends_at -> expiration_date
    -- once_per_customer -> one_time_use
    -- prerequisite_quantity_range -> quantity_prerequisite
    -- prerequisite_shipping_price_range -> shipping_price_prerequisite
    -- prerequisite_subtotal_range -> subtotal_prerequisite
    -- quantity_ratio_entitled_quantity -> entitled_quantity_ratio
    -- quantity_ratio_prerequisite_quantity -> prerequisite_quantity_ratio
    -- starts_at -> start_date
    -- target_selection -> discount_target
    -- title -> price_rule_name
    -- updated_at -> last_updated
    -- value_ -> discount_value
    -- value_type -> discount_type
    -- prerequisite_to_entitlement_purchase_prerequisite_amount -> entitlement_purchase_prerequisite
    SELECT 
        "id" AS "price_rule_id",
        "allocation_limit",
        "allocation_method",
        "created_at" AS "creation_date",
        "customer_selection" AS "customer_eligibility",
        "ends_at" AS "expiration_date",
        "once_per_customer" AS "one_time_use",
        "prerequisite_quantity_range" AS "quantity_prerequisite",
        "prerequisite_shipping_price_range" AS "shipping_price_prerequisite",
        "prerequisite_subtotal_range" AS "subtotal_prerequisite",
        "quantity_ratio_entitled_quantity" AS "entitled_quantity_ratio",
        "quantity_ratio_prerequisite_quantity" AS "prerequisite_quantity_ratio",
        "starts_at" AS "start_date",
        "target_selection" AS "discount_target",
        "target_type",
        "title" AS "price_rule_name",
        "updated_at" AS "last_updated",
        "usage_limit",
        "value_" AS "discount_value",
        "value_type" AS "discount_type",
        "prerequisite_to_entitlement_purchase_prerequisite_amount" AS "entitlement_purchase_prerequisite"
    FROM "shopify_price_rule_data_projected"
),

"shopify_price_rule_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- allocation_limit: from DECIMAL to VARCHAR
    -- creation_date: from VARCHAR to TIMESTAMP
    -- entitled_quantity_ratio: from DECIMAL to VARCHAR
    -- entitlement_purchase_prerequisite: from DECIMAL to VARCHAR
    -- expiration_date: from VARCHAR to TIMESTAMP
    -- last_updated: from VARCHAR to TIMESTAMP
    -- prerequisite_quantity_ratio: from DECIMAL to VARCHAR
    -- quantity_prerequisite: from DECIMAL to VARCHAR
    -- shipping_price_prerequisite: from DECIMAL to VARCHAR
    -- start_date: from VARCHAR to TIMESTAMP
    -- usage_limit: from DECIMAL to VARCHAR
    SELECT
        "price_rule_id",
        "allocation_method",
        "customer_eligibility",
        "one_time_use",
        "subtotal_prerequisite",
        "discount_target",
        "target_type",
        "price_rule_name",
        "discount_value",
        "discount_type",
        CAST("allocation_limit" AS VARCHAR) AS "allocation_limit",
        CAST("creation_date" AS TIMESTAMP) AS "creation_date",
        CAST("entitled_quantity_ratio" AS VARCHAR) AS "entitled_quantity_ratio",
        CAST("entitlement_purchase_prerequisite" AS VARCHAR) AS "entitlement_purchase_prerequisite",
        CAST("expiration_date" AS TIMESTAMP) AS "expiration_date",
        CAST("last_updated" AS TIMESTAMP) AS "last_updated",
        CAST("prerequisite_quantity_ratio" AS VARCHAR) AS "prerequisite_quantity_ratio",
        CAST("quantity_prerequisite" AS VARCHAR) AS "quantity_prerequisite",
        CAST("shipping_price_prerequisite" AS VARCHAR) AS "shipping_price_prerequisite",
        CAST("start_date" AS TIMESTAMP) AS "start_date",
        CAST("usage_limit" AS VARCHAR) AS "usage_limit"
    FROM "shopify_price_rule_data_projected_renamed"
),

"shopify_price_rule_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 5 columns with unacceptable missing values
    -- entitled_quantity_ratio has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- entitlement_purchase_prerequisite has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- prerequisite_quantity_ratio has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- quantity_prerequisite has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_price_prerequisite has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "price_rule_id",
        "allocation_method",
        "customer_eligibility",
        "one_time_use",
        "subtotal_prerequisite",
        "discount_target",
        "target_type",
        "price_rule_name",
        "discount_value",
        "discount_type",
        "allocation_limit",
        "creation_date",
        "expiration_date",
        "last_updated",
        "start_date",
        "usage_limit"
    FROM "shopify_price_rule_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_price_rule_data_projected_renamed_casted_missing_handled"