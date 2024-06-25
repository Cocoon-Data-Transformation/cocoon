-- Slowly Changing Dimension: Dimension keys are "price_rule_id"
-- Effective date columns are "last_updated"
-- We will create Type 1 SCD (latest snapshot)
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
    "start_date",
    "usage_limit"
FROM (
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
            "start_date",
            "usage_limit",
            ROW_NUMBER() OVER (
                PARTITION BY "price_rule_id" 
                ORDER BY "last_updated" 
            DESC) AS "cocoon_rn"
    FROM "stg_shopify_price_rule_data"
) ranked
WHERE "cocoon_rn" = 1