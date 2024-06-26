-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"store_returns_renamed" AS (
    -- Rename: Renaming columns
    -- SS_SOLD_DATE_SK -> sale_date_id
    -- SS_SOLD_TIME_SK -> sale_time_id
    -- SS_ITEM_SK -> item_id
    -- SS_CUSTOMER_SK -> customer_id
    -- SS_CDEMO_SK -> customer_demo_id
    -- SS_HDEMO_SK -> household_demo_id
    -- SS_ADDR_SK -> address_id
    -- SS_STORE_SK -> store_id
    -- SS_PROMO_SK -> promotion_id
    -- SS_TICKET_NUMBER -> ticket_number
    -- SS_QUANTITY -> quantity
    -- SS_WHOLESALE_COST -> unit_wholesale_cost
    -- SS_LIST_PRICE -> unit_list_price
    -- SS_SALES_PRICE -> unit_sales_price
    -- SS_EXT_DISCOUNT_AMT -> total_discount_amount
    -- SS_EXT_SALES_PRICE -> total_sales_price
    -- SS_EXT_WHOLESALE_COST -> total_wholesale_cost
    -- SS_EXT_LIST_PRICE -> total_list_price
    -- SS_EXT_TAX -> total_tax_amount
    -- SS_COUPON_AMT -> coupon_amount
    -- SS_NET_PAID -> net_paid
    -- SS_NET_PAID_INC_TAX -> net_paid_with_tax
    -- SS_NET_PROFIT -> net_profit
    SELECT 
        "SS_SOLD_DATE_SK" AS "sale_date_id",
        "SS_SOLD_TIME_SK" AS "sale_time_id",
        "SS_ITEM_SK" AS "item_id",
        "SS_CUSTOMER_SK" AS "customer_id",
        "SS_CDEMO_SK" AS "customer_demo_id",
        "SS_HDEMO_SK" AS "household_demo_id",
        "SS_ADDR_SK" AS "address_id",
        "SS_STORE_SK" AS "store_id",
        "SS_PROMO_SK" AS "promotion_id",
        "SS_TICKET_NUMBER" AS "ticket_number",
        "SS_QUANTITY" AS "quantity",
        "SS_WHOLESALE_COST" AS "unit_wholesale_cost",
        "SS_LIST_PRICE" AS "unit_list_price",
        "SS_SALES_PRICE" AS "unit_sales_price",
        "SS_EXT_DISCOUNT_AMT" AS "total_discount_amount",
        "SS_EXT_SALES_PRICE" AS "total_sales_price",
        "SS_EXT_WHOLESALE_COST" AS "total_wholesale_cost",
        "SS_EXT_LIST_PRICE" AS "total_list_price",
        "SS_EXT_TAX" AS "total_tax_amount",
        "SS_COUPON_AMT" AS "coupon_amount",
        "SS_NET_PAID" AS "net_paid",
        "SS_NET_PAID_INC_TAX" AS "net_paid_with_tax",
        "SS_NET_PROFIT" AS "net_profit"
    FROM "store_returns"
),

"store_returns_renamed_casted" AS (
    -- Column Type Casting: 
    -- address_id: from DECIMAL to INT
    -- customer_demo_id: from DECIMAL to INT
    -- customer_id: from DECIMAL to INT
    -- household_demo_id: from DECIMAL to INT
    -- promotion_id: from DECIMAL to INT
    -- quantity: from DECIMAL to INT
    -- sale_date_id: from DECIMAL to INT
    -- sale_time_id: from DECIMAL to INT
    -- store_id: from DECIMAL to INT
    SELECT
        "item_id",
        "ticket_number",
        "unit_wholesale_cost",
        "unit_list_price",
        "unit_sales_price",
        "total_discount_amount",
        "total_sales_price",
        "total_wholesale_cost",
        "total_list_price",
        "total_tax_amount",
        "coupon_amount",
        "net_paid",
        "net_paid_with_tax",
        "net_profit",
        CAST("address_id" AS INT) AS "address_id",
        CAST("customer_demo_id" AS INT) AS "customer_demo_id",
        CAST("customer_id" AS INT) AS "customer_id",
        CAST("household_demo_id" AS INT) AS "household_demo_id",
        CAST("promotion_id" AS INT) AS "promotion_id",
        CAST("quantity" AS INTEGER) AS "quantity",
        CAST("sale_date_id" AS INT) AS "sale_date_id",
        CAST("sale_time_id" AS INT) AS "sale_time_id",
        CAST("store_id" AS INT) AS "store_id"
    FROM "store_returns_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "store_returns_renamed_casted"