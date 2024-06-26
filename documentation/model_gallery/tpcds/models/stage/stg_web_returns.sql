-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"web_returns_renamed" AS (
    -- Rename: Renaming columns
    -- WR_RETURNED_DATE_SK -> return_date_key
    -- WR_RETURNED_TIME_SK -> return_time_key
    -- WR_ITEM_SK -> item_key
    -- WR_REFUNDED_CUSTOMER_SK -> refunded_customer_key
    -- WR_REFUNDED_CDEMO_SK -> refunded_customer_demo_key
    -- WR_REFUNDED_HDEMO_SK -> refunded_household_demo_key
    -- WR_REFUNDED_ADDR_SK -> refunded_address_key
    -- WR_RETURNING_CUSTOMER_SK -> returning_customer_key
    -- WR_RETURNING_CDEMO_SK -> returning_customer_demo_key
    -- WR_RETURNING_HDEMO_SK -> returning_household_demo_key
    -- WR_RETURNING_ADDR_SK -> returning_address_key
    -- WR_WEB_PAGE_SK -> web_page_key
    -- WR_REASON_SK -> reason_key
    -- WR_ORDER_NUMBER -> order_number
    -- WR_RETURN_QUANTITY -> return_quantity
    -- WR_RETURN_AMT -> return_amount
    -- WR_RETURN_TAX -> return_tax
    -- WR_RETURN_AMT_INC_TAX -> return_amount_with_tax
    -- WR_FEE -> return_fee
    -- WR_RETURN_SHIP_COST -> return_shipping_cost
    -- WR_REFUNDED_CASH -> refunded_cash
    -- WR_REVERSED_CHARGE -> reversed_charge
    -- WR_ACCOUNT_CREDIT -> account_credit
    -- WR_NET_LOSS -> net_loss
    SELECT 
        "WR_RETURNED_DATE_SK" AS "return_date_key",
        "WR_RETURNED_TIME_SK" AS "return_time_key",
        "WR_ITEM_SK" AS "item_key",
        "WR_REFUNDED_CUSTOMER_SK" AS "refunded_customer_key",
        "WR_REFUNDED_CDEMO_SK" AS "refunded_customer_demo_key",
        "WR_REFUNDED_HDEMO_SK" AS "refunded_household_demo_key",
        "WR_REFUNDED_ADDR_SK" AS "refunded_address_key",
        "WR_RETURNING_CUSTOMER_SK" AS "returning_customer_key",
        "WR_RETURNING_CDEMO_SK" AS "returning_customer_demo_key",
        "WR_RETURNING_HDEMO_SK" AS "returning_household_demo_key",
        "WR_RETURNING_ADDR_SK" AS "returning_address_key",
        "WR_WEB_PAGE_SK" AS "web_page_key",
        "WR_REASON_SK" AS "reason_key",
        "WR_ORDER_NUMBER" AS "order_number",
        "WR_RETURN_QUANTITY" AS "return_quantity",
        "WR_RETURN_AMT" AS "return_amount",
        "WR_RETURN_TAX" AS "return_tax",
        "WR_RETURN_AMT_INC_TAX" AS "return_amount_with_tax",
        "WR_FEE" AS "return_fee",
        "WR_RETURN_SHIP_COST" AS "return_shipping_cost",
        "WR_REFUNDED_CASH" AS "refunded_cash",
        "WR_REVERSED_CHARGE" AS "reversed_charge",
        "WR_ACCOUNT_CREDIT" AS "account_credit",
        "WR_NET_LOSS" AS "net_loss"
    FROM "web_returns"
)

-- COCOON BLOCK END
SELECT * FROM "web_returns_renamed"