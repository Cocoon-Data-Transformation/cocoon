-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"orders_renamed" AS (
    -- Rename: Renaming columns
    -- Date_Order_was_placed -> order_date
    -- Delivery_Date -> delivery_date
    -- Quantity_Ordered -> order_quantity
    -- Total_Retail_Price_for_This_Order -> total_order_price
    -- Cost_Price_Per_Unit -> unit_cost_price
    SELECT 
        "Customer_ID",
        "Customer_Status",
        "Date_Order_was_placed" AS "order_date",
        "Delivery_Date" AS "delivery_date",
        "Order_ID",
        "Product_ID",
        "Quantity_Ordered" AS "order_quantity",
        "Total_Retail_Price_for_This_Order" AS "total_order_price",
        "Cost_Price_Per_Unit" AS "unit_cost_price"
    FROM "orders"
),

"orders_renamed_dedup" AS (
    -- Deduplication: Removed 1 duplicated rows
    SELECT DISTINCT * FROM "orders_renamed"
),

"orders_renamed_dedup_cleaned" AS (
    -- Clean unusual string values: 
    -- Customer_Status: The problem is inconsistent capitalization. 'Gold' and 'GOLD', 'Silver' and 'SILVER' refer to the same customer status but have different capitalizations. The correct values should use the more frequent capitalization - 'Gold' and 'Silver'. 
    SELECT
        "Customer_ID",
        CASE
            WHEN "Customer_Status" = 'GOLD' THEN 'Gold'
            WHEN "Customer_Status" = 'SILVER' THEN 'Silver'
            WHEN "Customer_Status" = 'PLATINUM' THEN 'Platinum'
            ELSE "Customer_Status"
        END AS "Customer_Status",
        "order_date",
        "delivery_date",
        "Order_ID",
        "Product_ID",
        "order_quantity",
        "total_order_price",
        "unit_cost_price"
    FROM "orders_renamed_dedup"
),

"orders_renamed_dedup_cleaned_casted" AS (
    -- Column Type Casting: 
    -- Customer_ID: from INT to VARCHAR
    -- Order_ID: from INT to VARCHAR
    -- Product_ID: from INT to VARCHAR
    -- delivery_date: from VARCHAR to DATE
    -- order_date: from VARCHAR to DATE
    SELECT
        "Customer_Status",
        "order_quantity",
        "total_order_price",
        "unit_cost_price",
        CAST("Customer_ID" AS VARCHAR) AS "Customer_ID",
        CAST("Order_ID" AS VARCHAR) AS "Order_ID",
        CAST("Product_ID" AS VARCHAR) AS "Product_ID",
        CAST("delivery_date" AS DATE) AS "delivery_date",
        CAST("order_date" AS DATE) AS "order_date"
    FROM "orders_renamed_dedup_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "orders_renamed_dedup_cleaned_casted"