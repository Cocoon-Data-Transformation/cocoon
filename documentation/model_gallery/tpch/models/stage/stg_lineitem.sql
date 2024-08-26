-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:23:44.499443+00:00
WITH 
"lineitem_renamed" AS (
    -- Rename: Renaming columns
    -- L_ORDERKEY -> order_id
    -- L_PARTKEY -> part_id
    -- L_SUPPKEY -> supplier_id
    -- L_LINENUMBER -> line_number
    -- L_QUANTITY -> quantity
    -- L_EXTENDEDPRICE -> extended_price
    -- L_DISCOUNT -> discount_rate
    -- L_TAX -> tax_rate
    -- L_RETURNFLAG -> return_flag
    -- L_LINESTATUS -> line_status
    -- L_SHIPDATE -> ship_date
    -- L_COMMITDATE -> commit_date
    -- L_RECEIPTDATE -> receipt_date
    -- L_SHIPINSTRUCT -> shipping_instructions
    -- L_SHIPMODE -> shipping_mode
    -- L_COMMENT -> comments
    SELECT 
        "L_ORDERKEY" AS "order_id",
        "L_PARTKEY" AS "part_id",
        "L_SUPPKEY" AS "supplier_id",
        "L_LINENUMBER" AS "line_number",
        "L_QUANTITY" AS "quantity",
        "L_EXTENDEDPRICE" AS "extended_price",
        "L_DISCOUNT" AS "discount_rate",
        "L_TAX" AS "tax_rate",
        "L_RETURNFLAG" AS "return_flag",
        "L_LINESTATUS" AS "line_status",
        "L_SHIPDATE" AS "ship_date",
        "L_COMMITDATE" AS "commit_date",
        "L_RECEIPTDATE" AS "receipt_date",
        "L_SHIPINSTRUCT" AS "shipping_instructions",
        "L_SHIPMODE" AS "shipping_mode",
        "L_COMMENT" AS "comments"
    FROM "memory"."main"."lineitem"
),

"lineitem_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "order_id",
        "part_id",
        "supplier_id",
        "line_number",
        "quantity",
        "extended_price",
        "discount_rate",
        "tax_rate",
        "return_flag",
        "line_status",
        "ship_date",
        "commit_date",
        "receipt_date",
        "shipping_instructions",
        "shipping_mode",
        TRIM("comments") AS "comments"
    FROM "lineitem_renamed"
),

"lineitem_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- comments: The problem is that all the values in the comments column are incomplete phrases or sentence fragments without clear meaning or context. They appear to be truncated or partial sentences, making them difficult to interpret or use meaningfully. Since there's no clear pattern or way to reconstruct the full sentences, and the fragments don't carry any coherent meaning on their own, the best approach is to map all these unusual values to an empty string.
    SELECT
        "order_id",
        "part_id",
        "supplier_id",
        "line_number",
        "quantity",
        "extended_price",
        "discount_rate",
        "tax_rate",
        "return_flag",
        "line_status",
        "ship_date",
        "commit_date",
        "receipt_date",
        "shipping_instructions",
        "shipping_mode",
        CASE
            WHEN "comments" = 'blithely bold excuses wake fluffily' THEN NULL
            WHEN "comments" = 'egular courts above the' THEN NULL
            WHEN "comments" = 'ly final dependencies: slyly bold' THEN NULL
            WHEN "comments" = 'ongside of the furiously brave acco' THEN NULL
            WHEN "comments" = 'ven requests. deposits breach a' THEN NULL
            ELSE "comments"
        END AS "comments"
    FROM "lineitem_renamed_trimmed"
),

"lineitem_renamed_trimmed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- shipping_instructions: ['NONE']
    SELECT 
        CASE
            WHEN "shipping_instructions" = 'NONE' THEN NULL
            ELSE "shipping_instructions"
        END AS "shipping_instructions",
        "receipt_date",
        "supplier_id",
        "extended_price",
        "part_id",
        "comments",
        "order_id",
        "ship_date",
        "quantity",
        "return_flag",
        "line_status",
        "line_number",
        "tax_rate",
        "commit_date",
        "discount_rate",
        "shipping_mode"
    FROM "lineitem_renamed_trimmed_cleaned"
),

"lineitem_renamed_trimmed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- commit_date: from VARCHAR to DATE
    -- receipt_date: from VARCHAR to DATE
    -- ship_date: from VARCHAR to DATE
    SELECT
        "shipping_instructions",
        "supplier_id",
        "extended_price",
        "part_id",
        "comments",
        "order_id",
        "quantity",
        "return_flag",
        "line_status",
        "line_number",
        "tax_rate",
        "discount_rate",
        "shipping_mode",
        CAST("commit_date" AS DATE) 
        AS "commit_date",
        CAST("receipt_date" AS DATE) 
        AS "receipt_date",
        CAST("ship_date" AS DATE) 
        AS "ship_date"
    FROM "lineitem_renamed_trimmed_cleaned_null"
)

-- COCOON BLOCK END
SELECT *
FROM "lineitem_renamed_trimmed_cleaned_null_casted"