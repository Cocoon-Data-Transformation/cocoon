-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"catalog_sales_renamed" AS (
    -- Rename: Renaming columns
    -- CS_SOLD_DATE_SK -> sale_date_key
    -- CS_SOLD_TIME_SK -> sale_time_key
    -- CS_SHIP_DATE_SK -> shipping_date_id
    -- CS_BILL_CUSTOMER_SK -> billing_customer_id
    -- CS_BILL_CDEMO_SK -> billing_customer_demographics_id
    -- CS_BILL_HDEMO_SK -> billing_household_demographics_id
    -- CS_BILL_ADDR_SK -> billing_address_id
    -- CS_SHIP_CUSTOMER_SK -> shipping_customer_id
    -- CS_SHIP_CDEMO_SK -> shipping_customer_demographics_id
    -- CS_SHIP_HDEMO_SK -> shipping_household_demographics_id
    -- CS_SHIP_ADDR_SK -> shipping_address_id
    -- CS_CALL_CENTER_SK -> call_center_id
    -- CS_CATALOG_PAGE_SK -> catalog_page_id
    -- CS_SHIP_MODE_SK -> shipping_mode_id
    -- CS_WAREHOUSE_SK -> warehouse_key
    -- CS_ITEM_SK -> item_id
    -- CS_PROMO_SK -> promotion_id
    -- CS_ORDER_NUMBER -> order_number
    -- CS_QUANTITY -> quantity
    -- CS_LIST_PRICE -> unit_list_price
    -- CS_SALES_PRICE -> unit_sales_price
    -- CS_EXT_DISCOUNT_AMT -> total_discount_amount
    -- CS_EXT_SALES_PRICE -> total_sales_price
    -- CS_EXT_WHOLESALE_COST -> total_wholesale_cost
    -- CS_EXT_LIST_PRICE -> total_list_price
    -- CS_EXT_TAX -> total_tax_amount
    -- CS_COUPON_AMT -> coupon_amount
    -- CS_EXT_SHIP_COST -> total_shipping_cost
    -- CS_NET_PAID -> net_paid
    -- CS_NET_PAID_INC_TAX -> net_paid_with_tax
    -- CS_NET_PAID_INC_SHIP -> net_paid_with_shipping
    -- CS_NET_PAID_INC_SHIP_TAX -> net_paid_with_shipping_and_tax
    -- CS_NET_PROFIT -> net_profit
    SELECT 
        "CS_SOLD_DATE_SK" AS "sale_date_key",
        "CS_SOLD_TIME_SK" AS "sale_time_key",
        "CS_SHIP_DATE_SK" AS "shipping_date_id",
        "CS_BILL_CUSTOMER_SK" AS "billing_customer_id",
        "CS_BILL_CDEMO_SK" AS "billing_customer_demographics_id",
        "CS_BILL_HDEMO_SK" AS "billing_household_demographics_id",
        "CS_BILL_ADDR_SK" AS "billing_address_id",
        "CS_SHIP_CUSTOMER_SK" AS "shipping_customer_id",
        "CS_SHIP_CDEMO_SK" AS "shipping_customer_demographics_id",
        "CS_SHIP_HDEMO_SK" AS "shipping_household_demographics_id",
        "CS_SHIP_ADDR_SK" AS "shipping_address_id",
        "CS_CALL_CENTER_SK" AS "call_center_id",
        "CS_CATALOG_PAGE_SK" AS "catalog_page_id",
        "CS_SHIP_MODE_SK" AS "shipping_mode_id",
        "CS_WAREHOUSE_SK" AS "warehouse_key",
        "CS_ITEM_SK" AS "item_id",
        "CS_PROMO_SK" AS "promotion_id",
        "CS_ORDER_NUMBER" AS "order_number",
        "CS_QUANTITY" AS "quantity",
        "CS_WHOLESALE_COST",
        "CS_LIST_PRICE" AS "unit_list_price",
        "CS_SALES_PRICE" AS "unit_sales_price",
        "CS_EXT_DISCOUNT_AMT" AS "total_discount_amount",
        "CS_EXT_SALES_PRICE" AS "total_sales_price",
        "CS_EXT_WHOLESALE_COST" AS "total_wholesale_cost",
        "CS_EXT_LIST_PRICE" AS "total_list_price",
        "CS_EXT_TAX" AS "total_tax_amount",
        "CS_COUPON_AMT" AS "coupon_amount",
        "CS_EXT_SHIP_COST" AS "total_shipping_cost",
        "CS_NET_PAID" AS "net_paid",
        "CS_NET_PAID_INC_TAX" AS "net_paid_with_tax",
        "CS_NET_PAID_INC_SHIP" AS "net_paid_with_shipping",
        "CS_NET_PAID_INC_SHIP_TAX" AS "net_paid_with_shipping_and_tax",
        "CS_NET_PROFIT" AS "net_profit"
    FROM "catalog_sales"
)

-- COCOON BLOCK END
SELECT * FROM "catalog_sales_renamed"