-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:25:13.064323+00:00
WITH 
"order_renamed" AS (
    -- Rename: Renaming columns
    -- O_ORDERKEY -> order_id
    -- O_CUSTKEY -> customer_id
    -- O_ORDERSTATUS -> order_status
    -- O_TOTALPRICE -> total_price
    -- O_ORDERDATE -> order_date
    -- O_ORDERPRIORITY -> order_priority
    -- O_CLERK -> clerk_id
    -- O_SHIPPRIORITY -> shipping_priority
    -- O_COMMENT -> order_comments
    SELECT 
        "O_ORDERKEY" AS "order_id",
        "O_CUSTKEY" AS "customer_id",
        "O_ORDERSTATUS" AS "order_status",
        "O_TOTALPRICE" AS "total_price",
        "O_ORDERDATE" AS "order_date",
        "O_ORDERPRIORITY" AS "order_priority",
        "O_CLERK" AS "clerk_id",
        "O_SHIPPRIORITY" AS "shipping_priority",
        "O_COMMENT" AS "order_comments"
    FROM "memory"."main"."order"
),

"order_renamed_casted" AS (
    -- Column Type Casting: 
    -- order_date: from VARCHAR to DATE
    SELECT
        "order_id",
        "customer_id",
        "order_status",
        "total_price",
        "order_priority",
        "clerk_id",
        "shipping_priority",
        "order_comments",
        CAST("order_date" AS DATE) 
        AS "order_date"
    FROM "order_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "order_renamed_casted"