-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"web_sales_renamed" AS (
    -- Rename: Renaming columns
    -- WS_SOLD_DATE_SK -> sale_date_id
    -- WS_SOLD_TIME_SK -> sale_time_id
    -- WS_SHIP_DATE_SK -> shipping_date_id
    -- WS_ITEM_SK -> item_id
    -- WS_BILL_CUSTOMER_SK -> billing_customer_id
    -- WS_BILL_CDEMO_SK -> billing_customer_demo_id
    -- WS_BILL_HDEMO_SK -> billing_household_demo_id
    -- WS_BILL_ADDR_SK -> billing_address_id
    -- WS_SHIP_CUSTOMER_SK -> shipping_customer_id
    -- WS_SHIP_CDEMO_SK -> shipping_customer_demo_id
    -- WS_SHIP_HDEMO_SK -> shipping_household_demo_id
    -- WS_SHIP_ADDR_SK -> shipping_address_id
    -- WS_WEB_PAGE_SK -> web_page_id
    -- WS_WEB_SITE_SK -> website_id
    -- WS_SHIP_MODE_SK -> shipping_mode_id
    -- WS_WAREHOUSE_SK -> warehouse_id
    -- WS_PROMO_SK -> promotion_id
    -- WS_ORDER_NUMBER -> order_id
    -- WS_QUANTITY -> quantity
    -- WS_WHOLESALE_COST -> wholesale_cost
    -- WS_LIST_PRICE -> unit_list_price
    -- WS_SALES_PRICE -> unit_sales_price
    -- WS_EXT_DISCOUNT_AMT -> total_discount_amount
    -- WS_EXT_SALES_PRICE -> total_sales_price
    -- WS_EXT_WHOLESALE_COST -> total_wholesale_cost
    -- WS_EXT_LIST_PRICE -> total_list_price
    -- WS_EXT_TAX -> total_tax_amount
    -- WS_COUPON_AMT -> coupon_amount
    -- WS_EXT_SHIP_COST -> total_shipping_cost
    -- WS_NET_PAID -> net_paid_amount
    -- WS_NET_PAID_INC_TAX -> net_paid_with_tax
    -- WS_NET_PAID_INC_SHIP -> net_paid_with_shipping
    -- WS_NET_PAID_INC_SHIP_TAX -> total_net_paid
    -- WS_NET_PROFIT -> net_profit
    SELECT 
        "WS_SOLD_DATE_SK" AS "sale_date_id",
        "WS_SOLD_TIME_SK" AS "sale_time_id",
        "WS_SHIP_DATE_SK" AS "shipping_date_id",
        "WS_ITEM_SK" AS "item_id",
        "WS_BILL_CUSTOMER_SK" AS "billing_customer_id",
        "WS_BILL_CDEMO_SK" AS "billing_customer_demo_id",
        "WS_BILL_HDEMO_SK" AS "billing_household_demo_id",
        "WS_BILL_ADDR_SK" AS "billing_address_id",
        "WS_SHIP_CUSTOMER_SK" AS "shipping_customer_id",
        "WS_SHIP_CDEMO_SK" AS "shipping_customer_demo_id",
        "WS_SHIP_HDEMO_SK" AS "shipping_household_demo_id",
        "WS_SHIP_ADDR_SK" AS "shipping_address_id",
        "WS_WEB_PAGE_SK" AS "web_page_id",
        "WS_WEB_SITE_SK" AS "website_id",
        "WS_SHIP_MODE_SK" AS "shipping_mode_id",
        "WS_WAREHOUSE_SK" AS "warehouse_id",
        "WS_PROMO_SK" AS "promotion_id",
        "WS_ORDER_NUMBER" AS "order_id",
        "WS_QUANTITY" AS "quantity",
        "WS_WHOLESALE_COST" AS "wholesale_cost",
        "WS_LIST_PRICE" AS "unit_list_price",
        "WS_SALES_PRICE" AS "unit_sales_price",
        "WS_EXT_DISCOUNT_AMT" AS "total_discount_amount",
        "WS_EXT_SALES_PRICE" AS "total_sales_price",
        "WS_EXT_WHOLESALE_COST" AS "total_wholesale_cost",
        "WS_EXT_LIST_PRICE" AS "total_list_price",
        "WS_EXT_TAX" AS "total_tax_amount",
        "WS_COUPON_AMT" AS "coupon_amount",
        "WS_EXT_SHIP_COST" AS "total_shipping_cost",
        "WS_NET_PAID" AS "net_paid_amount",
        "WS_NET_PAID_INC_TAX" AS "net_paid_with_tax",
        "WS_NET_PAID_INC_SHIP" AS "net_paid_with_shipping",
        "WS_NET_PAID_INC_SHIP_TAX" AS "total_net_paid",
        "WS_NET_PROFIT" AS "net_profit"
    FROM "web_sales"
)

-- COCOON BLOCK END
SELECT * FROM "web_sales_renamed"