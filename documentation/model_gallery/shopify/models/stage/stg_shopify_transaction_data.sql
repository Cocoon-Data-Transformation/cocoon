-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_transaction_data_projected" AS (
    -- Projection: Selecting 30 out of 31 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "order_id",
        "refund_id",
        "amount",
        "authorization_",
        "created_at",
        "processed_at",
        "device_id",
        "gateway",
        "source_name",
        "message",
        "currency",
        "location_id",
        "parent_id",
        "payment_avs_result_code",
        "kind",
        "currency_exchange_id",
        "currency_exchange_adjustment",
        "currency_exchange_original_amount",
        "currency_exchange_final_amount",
        "currency_exchange_currency",
        "error_code",
        "status",
        "test",
        "user_id",
        "payment_credit_card_bin",
        "payment_cvv_result_code",
        "payment_credit_card_number",
        "payment_credit_card_company",
        "receipt"
    FROM "shopify_transaction_data"
),

"shopify_transaction_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> transaction_id
    -- authorization_ -> authorization_code
    -- gateway -> payment_gateway
    -- message -> transaction_message
    -- currency -> currency_code
    -- parent_id -> parent_transaction_id
    -- payment_avs_result_code -> avs_result_code
    -- kind -> transaction_type
    -- currency_exchange_id -> exchange_id
    -- currency_exchange_adjustment -> exchange_adjustment
    -- currency_exchange_original_amount -> exchange_original_amount
    -- currency_exchange_final_amount -> exchange_final_amount
    -- currency_exchange_currency -> exchange_currency
    -- status -> transaction_status
    -- test -> is_test_transaction
    -- payment_credit_card_bin -> credit_card_bin
    -- payment_cvv_result_code -> cvv_result_code
    -- payment_credit_card_number -> credit_card_number
    -- payment_credit_card_company -> credit_card_company
    -- receipt -> receipt_details
    SELECT 
        "id" AS "transaction_id",
        "order_id",
        "refund_id",
        "amount",
        "authorization_" AS "authorization_code",
        "created_at",
        "processed_at",
        "device_id",
        "gateway" AS "payment_gateway",
        "source_name",
        "message" AS "transaction_message",
        "currency" AS "currency_code",
        "location_id",
        "parent_id" AS "parent_transaction_id",
        "payment_avs_result_code" AS "avs_result_code",
        "kind" AS "transaction_type",
        "currency_exchange_id" AS "exchange_id",
        "currency_exchange_adjustment" AS "exchange_adjustment",
        "currency_exchange_original_amount" AS "exchange_original_amount",
        "currency_exchange_final_amount" AS "exchange_final_amount",
        "currency_exchange_currency" AS "exchange_currency",
        "error_code",
        "status" AS "transaction_status",
        "test" AS "is_test_transaction",
        "user_id",
        "payment_credit_card_bin" AS "credit_card_bin",
        "payment_cvv_result_code" AS "cvv_result_code",
        "payment_credit_card_number" AS "credit_card_number",
        "payment_credit_card_company" AS "credit_card_company",
        "receipt" AS "receipt_details"
    FROM "shopify_transaction_data_projected"
),

"shopify_transaction_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- payment_gateway: The problem is that 'gateway_here' is not a real payment gateway name but a placeholder. This indicates that the actual payment gateway information was not properly filled in or was intentionally obscured. In a real dataset, we would expect to see names of actual payment gateways such as PayPal, Stripe, Square, etc. Since we don't have any information about what the real gateway should be, we can't map it to a correct value. In this case, it's best to map it to an empty string to indicate missing data. 
    -- source_name: The problem is that 'source_name' appears to be a column header that has been mistakenly included in the data values, rather than actual source name data. This is unusual because column names should typically be separate from the data values. The correct values for a source_name column would be actual names of sources, not the column header itself. Since we don't have information about the correct source names, we should map this to an empty string to remove the erroneous data. 
    -- transaction_message: The problem is that 'message_here' is a placeholder value and not an actual transaction message. It appears to be the only value in the column, which suggests that real transaction messages are missing or were not properly recorded. The correct values should be actual transaction messages specific to each transaction, but since we don't have that information, we can't map it to a meaningful value. 
    SELECT
        "transaction_id",
        "order_id",
        "refund_id",
        "amount",
        "authorization_code",
        "created_at",
        "processed_at",
        "device_id",
        CASE
            WHEN "payment_gateway" = 'gateway_here' THEN ''
            ELSE "payment_gateway"
        END AS "payment_gateway",
        CASE
            WHEN "source_name" = 'source_name' THEN ''
            ELSE "source_name"
        END AS "source_name",
        CASE
            WHEN "transaction_message" = 'message_here' THEN ''
            ELSE "transaction_message"
        END AS "transaction_message",
        "currency_code",
        "location_id",
        "parent_transaction_id",
        "avs_result_code",
        "transaction_type",
        "exchange_id",
        "exchange_adjustment",
        "exchange_original_amount",
        "exchange_final_amount",
        "exchange_currency",
        "error_code",
        "transaction_status",
        "is_test_transaction",
        "user_id",
        "credit_card_bin",
        "cvv_result_code",
        "credit_card_number",
        "credit_card_company",
        "receipt_details"
    FROM "shopify_transaction_data_projected_renamed"
),

"shopify_transaction_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- payment_gateway: ['']
    -- source_name: ['']
    -- transaction_message: ['']
    SELECT 
        CASE
            WHEN "payment_gateway" = '' THEN NULL
            ELSE "payment_gateway"
        END AS "payment_gateway",
        CASE
            WHEN "source_name" = '' THEN NULL
            ELSE "source_name"
        END AS "source_name",
        CASE
            WHEN "transaction_message" = '' THEN NULL
            ELSE "transaction_message"
        END AS "transaction_message",
        "exchange_currency",
        "location_id",
        "transaction_type",
        "error_code",
        "credit_card_company",
        "amount",
        "transaction_id",
        "user_id",
        "order_id",
        "exchange_final_amount",
        "credit_card_number",
        "avs_result_code",
        "cvv_result_code",
        "parent_transaction_id",
        "refund_id",
        "transaction_status",
        "authorization_code",
        "credit_card_bin",
        "currency_code",
        "device_id",
        "exchange_adjustment",
        "exchange_original_amount",
        "is_test_transaction",
        "exchange_id",
        "created_at",
        "processed_at",
        "receipt_details"
    FROM "shopify_transaction_data_projected_renamed_cleaned"
),

"shopify_transaction_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- credit_card_bin: from DECIMAL to VARCHAR
    -- credit_card_company: from DECIMAL to VARCHAR
    -- credit_card_number: from DECIMAL to VARCHAR
    -- cvv_result_code: from DECIMAL to VARCHAR
    -- device_id: from DECIMAL to VARCHAR
    -- error_code: from DECIMAL to VARCHAR
    -- exchange_adjustment: from DECIMAL to VARCHAR
    -- exchange_currency: from DECIMAL to VARCHAR
    -- exchange_final_amount: from DECIMAL to VARCHAR
    -- exchange_id: from DECIMAL to VARCHAR
    -- exchange_original_amount: from DECIMAL to VARCHAR
    -- location_id: from DECIMAL to VARCHAR
    -- order_id: from INT to VARCHAR
    -- parent_transaction_id: from DECIMAL to VARCHAR
    -- processed_at: from VARCHAR to TIMESTAMP
    -- receipt_details: from VARCHAR to JSON
    -- refund_id: from DECIMAL to VARCHAR
    -- transaction_id: from INT to VARCHAR
    -- user_id: from DECIMAL to VARCHAR
    SELECT
        "payment_gateway",
        "source_name",
        "transaction_message",
        "transaction_type",
        "amount",
        "avs_result_code",
        "transaction_status",
        "authorization_code",
        "currency_code",
        "is_test_transaction",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("credit_card_bin" AS VARCHAR) AS "credit_card_bin",
        CAST("credit_card_company" AS VARCHAR) AS "credit_card_company",
        CAST("credit_card_number" AS VARCHAR) AS "credit_card_number",
        CAST("cvv_result_code" AS VARCHAR) AS "cvv_result_code",
        CAST("device_id" AS VARCHAR) AS "device_id",
        CAST("error_code" AS VARCHAR) AS "error_code",
        CAST("exchange_adjustment" AS VARCHAR) AS "exchange_adjustment",
        CAST("exchange_currency" AS VARCHAR) AS "exchange_currency",
        CAST("exchange_final_amount" AS VARCHAR) AS "exchange_final_amount",
        CAST("exchange_id" AS VARCHAR) AS "exchange_id",
        CAST("exchange_original_amount" AS VARCHAR) AS "exchange_original_amount",
        CAST("location_id" AS VARCHAR) AS "location_id",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("parent_transaction_id" AS VARCHAR) AS "parent_transaction_id",
        CAST("processed_at" AS TIMESTAMP) AS "processed_at",
        CAST("receipt_details" AS JSON) AS "receipt_details",
        CAST("refund_id" AS VARCHAR) AS "refund_id",
        CAST("transaction_id" AS VARCHAR) AS "transaction_id",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "shopify_transaction_data_projected_renamed_cleaned_null"
),

"shopify_transaction_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 7 columns with unacceptable missing values
    -- device_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- error_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- location_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_gateway has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- source_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transaction_message has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "transaction_type",
        "amount",
        "avs_result_code",
        "transaction_status",
        "authorization_code",
        "currency_code",
        "is_test_transaction",
        "created_at",
        "credit_card_bin",
        "credit_card_company",
        "credit_card_number",
        "cvv_result_code",
        "exchange_adjustment",
        "exchange_currency",
        "exchange_final_amount",
        "exchange_id",
        "exchange_original_amount",
        "order_id",
        "parent_transaction_id",
        "processed_at",
        "receipt_details",
        "refund_id",
        "transaction_id"
    FROM "shopify_transaction_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_transaction_data_projected_renamed_cleaned_null_casted_missing_handled"