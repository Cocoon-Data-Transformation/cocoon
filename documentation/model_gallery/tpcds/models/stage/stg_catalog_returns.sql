-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"catalog_returns_renamed" AS (
    -- Rename: Renaming columns
    -- CR_RETURNED_DATE_SK -> return_date_id
    -- CR_RETURNED_TIME_SK -> return_time_id
    -- CR_ITEM_SK -> item_id
    -- CR_REFUNDED_CUSTOMER_SK -> refunded_customer_id
    -- CR_REFUNDED_CDEMO_SK -> refunded_customer_demo_id
    -- CR_REFUNDED_HDEMO_SK -> refunded_household_demo_id
    -- CR_REFUNDED_ADDR_SK -> refunded_address_id
    -- CR_RETURNING_CUSTOMER_SK -> returning_customer_id
    -- CR_RETURNING_CDEMO_SK -> returning_customer_demo_id
    -- CR_RETURNING_HDEMO_SK -> returning_household_demo_id
    -- CR_RETURNING_ADDR_SK -> returning_address_id
    -- CR_CALL_CENTER_SK -> call_center_id
    -- CR_CATALOG_PAGE_SK -> catalog_page_id
    -- CR_SHIP_MODE_SK -> shipping_mode_id
    -- CR_WAREHOUSE_SK -> warehouse_id
    -- CR_REASON_SK -> return_reason_id
    -- CR_ORDER_NUMBER -> order_number
    -- CR_RETURN_QUANTITY -> return_quantity
    -- CR_RETURN_AMOUNT -> return_amount
    -- CR_RETURN_TAX -> return_tax
    -- CR_RETURN_AMT_INC_TAX -> return_amount_with_tax
    -- CR_FEE -> return_fee
    -- CR_RETURN_SHIP_COST -> return_shipping_cost
    -- CR_REFUNDED_CASH -> refunded_cash
    -- CR_REVERSED_CHARGE -> reversed_charge
    -- CR_STORE_CREDIT -> store_credit
    -- CR_NET_LOSS -> net_loss
    SELECT 
        "CR_RETURNED_DATE_SK" AS "return_date_id",
        "CR_RETURNED_TIME_SK" AS "return_time_id",
        "CR_ITEM_SK" AS "item_id",
        "CR_REFUNDED_CUSTOMER_SK" AS "refunded_customer_id",
        "CR_REFUNDED_CDEMO_SK" AS "refunded_customer_demo_id",
        "CR_REFUNDED_HDEMO_SK" AS "refunded_household_demo_id",
        "CR_REFUNDED_ADDR_SK" AS "refunded_address_id",
        "CR_RETURNING_CUSTOMER_SK" AS "returning_customer_id",
        "CR_RETURNING_CDEMO_SK" AS "returning_customer_demo_id",
        "CR_RETURNING_HDEMO_SK" AS "returning_household_demo_id",
        "CR_RETURNING_ADDR_SK" AS "returning_address_id",
        "CR_CALL_CENTER_SK" AS "call_center_id",
        "CR_CATALOG_PAGE_SK" AS "catalog_page_id",
        "CR_SHIP_MODE_SK" AS "shipping_mode_id",
        "CR_WAREHOUSE_SK" AS "warehouse_id",
        "CR_REASON_SK" AS "return_reason_id",
        "CR_ORDER_NUMBER" AS "order_number",
        "CR_RETURN_QUANTITY" AS "return_quantity",
        "CR_RETURN_AMOUNT" AS "return_amount",
        "CR_RETURN_TAX" AS "return_tax",
        "CR_RETURN_AMT_INC_TAX" AS "return_amount_with_tax",
        "CR_FEE" AS "return_fee",
        "CR_RETURN_SHIP_COST" AS "return_shipping_cost",
        "CR_REFUNDED_CASH" AS "refunded_cash",
        "CR_REVERSED_CHARGE" AS "reversed_charge",
        "CR_STORE_CREDIT" AS "store_credit",
        "CR_NET_LOSS" AS "net_loss"
    FROM "catalog_returns"
)

-- COCOON BLOCK END
SELECT * FROM "catalog_returns_renamed"