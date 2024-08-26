-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-26 00:50:02.289320+00:00
WITH 
"lineorder_renamed" AS (
    -- Rename: Renaming columns
    -- LO_ORDERKEY -> order_id
    -- LO_LINENUMBER -> line_number
    -- LO_CUSTKEY -> customer_id
    -- LO_PARTKEY -> product_id
    -- LO_SUPPKEY -> supplier_id
    -- LO_ORDERDATE -> order_date
    -- LO_ORDERPRIORITY -> order_priority
    -- LO_SHIPPRIORITY -> shipping_priority
    -- LO_QUANTITY -> quantity
    -- LO_EXTENDEDPRICE -> line_item_total
    -- LO_ORDTOTALPRICE -> order_total
    -- LO_DISCOUNT -> discount_percentage
    -- LO_REVENUE -> line_item_revenue
    -- LO_SUPPLYCOST -> supply_cost
    -- LO_TAX -> tax_percentage
    -- LO_COMMITDATE -> commit_date
    -- LO_SHIPMODE -> shipping_mode
    SELECT 
        "LO_ORDERKEY" AS "order_id",
        "LO_LINENUMBER" AS "line_number",
        "LO_CUSTKEY" AS "customer_id",
        "LO_PARTKEY" AS "product_id",
        "LO_SUPPKEY" AS "supplier_id",
        "LO_ORDERDATE" AS "order_date",
        "LO_ORDERPRIORITY" AS "order_priority",
        "LO_SHIPPRIORITY" AS "shipping_priority",
        "LO_QUANTITY" AS "quantity",
        "LO_EXTENDEDPRICE" AS "line_item_total",
        "LO_ORDTOTALPRICE" AS "order_total",
        "LO_DISCOUNT" AS "discount_percentage",
        "LO_REVENUE" AS "line_item_revenue",
        "LO_SUPPLYCOST" AS "supply_cost",
        "LO_TAX" AS "tax_percentage",
        "LO_COMMITDATE" AS "commit_date",
        "LO_SHIPMODE" AS "shipping_mode"
    FROM "memory"."main"."lineorder"
),

"lineorder_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- order_priority: ['4-NOT SPECIFIED']
    SELECT 
        CASE
            WHEN "order_priority" = '4-NOT SPECIFIED' THEN NULL
            ELSE "order_priority"
        END AS "order_priority",
        "supply_cost",
        "quantity",
        "line_item_total",
        "tax_percentage",
        "commit_date",
        "shipping_mode",
        "line_number",
        "shipping_priority",
        "product_id",
        "discount_percentage",
        "order_id",
        "customer_id",
        "order_total",
        "line_item_revenue",
        "order_date",
        "supplier_id"
    FROM "lineorder_renamed"
),

"lineorder_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- commit_date: from INT to DATE
    -- discount_percentage: from INT to DECIMAL
    -- line_item_revenue: from INT to DECIMAL
    -- line_item_total: from INT to DECIMAL
    -- order_date: from INT to DATE
    -- order_total: from INT to DECIMAL
    -- supply_cost: from INT to DECIMAL
    -- tax_percentage: from INT to DECIMAL
    SELECT
        "order_priority",
        "quantity",
        "shipping_mode",
        "line_number",
        "shipping_priority",
        "product_id",
        "order_id",
        "customer_id",
        "supplier_id",
        strptime(CAST("commit_date" AS VARCHAR), '%Y%m%d') 
        AS "commit_date",
        CAST("discount_percentage" AS DECIMAL) 
        AS "discount_percentage",
        CAST("line_item_revenue" AS DECIMAL) 
        AS "line_item_revenue",
        CAST("line_item_total" AS DECIMAL) 
        AS "line_item_total",
        strptime(CAST("order_date" AS VARCHAR), '%Y%m%d') 
        AS "order_date",
        CAST("order_total" AS DECIMAL) 
        AS "order_total",
        CAST("supply_cost" AS DECIMAL) 
        AS "supply_cost",
        CAST("tax_percentage" AS DECIMAL) 
        AS "tax_percentage"
    FROM "lineorder_renamed_null"
)

-- COCOON BLOCK END
SELECT *
FROM "lineorder_renamed_null_casted"