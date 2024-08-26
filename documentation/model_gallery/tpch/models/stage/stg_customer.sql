-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:22:15.794717+00:00
WITH 
"customer_renamed" AS (
    -- Rename: Renaming columns
    -- C_CUSTKEY -> customer_id
    -- C_NAME -> customer_name
    -- C_ADDRESS -> address
    -- C_NATIONKEY -> nation_id
    -- C_PHONE -> phone_number
    -- C_ACCTBAL -> account_balance
    -- C_MKTSEGMENT -> market_segment
    -- C_COMMENT -> comments
    SELECT 
        "C_CUSTKEY" AS "customer_id",
        "C_NAME" AS "customer_name",
        "C_ADDRESS" AS "address",
        "C_NATIONKEY" AS "nation_id",
        "C_PHONE" AS "phone_number",
        "C_ACCTBAL" AS "account_balance",
        "C_MKTSEGMENT" AS "market_segment",
        "C_COMMENT" AS "comments"
    FROM "memory"."main"."customer"
),

"customer_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "customer_id",
        "customer_name",
        "address",
        "nation_id",
        "phone_number",
        "account_balance",
        "comments",
        TRIM("market_segment") AS "market_segment"
    FROM "customer_renamed"
),

"customer_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- customer_id: The problem is that the customer_id values have inconsistent patterns and lengths. The most unusual value is 'IVhzIApeRb ot' because it contains a space, which is atypical for customer IDs. The other values have varying lengths and character patterns. The correct values should follow a consistent format, ideally without spaces and with a standard length. Since 'KvpyuHCplrB84WgAiGV6sYpZq7Tj' is the longest and most complex ID, it appears to be the most likely format for a proper customer ID.
    -- customer_name: The problem is that the customer_name column contains values that are not typical names.  The values '1', '3', '4', and 'c' appear to be placeholders or data entry errors.  'NCwDVaWNe6tEgvwfmRchLXak' looks like a random string, possibly an ID that was mistakenly placed in the name column.  None of these are valid customer names. The correct approach would be to replace these  invalid entries with an empty string, indicating missing data, as we don't have enough  information to determine the actual customer names.
    -- address: The problem is that two values ('E' and '13') do not follow the phone number format of the other entries. The correct values should be in the format XX-XXX-XXX-XXXX, where X represents digits. The value 'E' is completely invalid as a phone number, while '13' is likely a partial or incorrect entry.
    -- nation_id: The nation_id column contains inconsistent data types and formats. '15' appears to be a valid numeric ID, while '23-768-687-3665' looks like a phone number, and '2866.83', '7498.12', '794.47' are decimal numbers. These inconsistencies suggest data entry errors or misplaced information from other columns. Since '15' is the only value that resembles a typical integer ID format and is the most frequent, we'll consider it as the correct format for nation_id. The other values should be treated as errors and mapped to an empty string, as they don't contain valid nation ID information.
    -- phone_number: The problem is that the phone_number column contains values that are not phone numbers. The value '121.65' appears to be a decimal number, while 'AUTOMOBILE', 'HOUSEHOLD', and 'MACHINERY' seem to be category names, possibly from another column. Only '9-567-846-8931' resembles a valid phone number format. The correct values should all be phone numbers or empty strings if the actual phone number is unknown.
    -- account_balance: The problem is that the account_balance column contains non-numeric values which are inappropriate for an account balance. The only correct value is '711.56', which is a numeric balance. The other values are either a vehicle type ('AUTOMOBILE') or nonsensical sentences, which have no place in an account balance field. The correct values should all be numeric account balances or empty strings if the balance is unknown.
    -- market_segment: The problem is that the market_segment column contains some unusual and grammatically incorrect values. 'HOUSEHOLD' appears to be a valid market segment descriptor, while 'even accounts', 'pending accounts haggle furiously deposit', and 'silent packages' are not typical market segment descriptors and contain grammatical issues or nonsensical phrases. The correct values should be standardized market segment descriptors. Since 'HOUSEHOLD' is the only clear and valid segment, we'll map the unusual values to empty strings, as we don't have enough information to accurately categorize them into other segments.
    SELECT
        CASE
            WHEN "customer_id" = 'IVhzIApeRb ot' THEN 'IVhzIApeRbot'
            WHEN "customer_id" = 'XSTf4' THEN 'XSTf4000000000000000000000000'
            WHEN "customer_id" = 'XxVSJsLAGtn' THEN 'XxVSJsLAGtn00000000000000000'
            WHEN "customer_id" = 'MG9kdTD2WBHm' THEN 'MG9kdTD2WBHm0000000000000000'
            ELSE "customer_id"
        END AS "customer_id",
        CASE
            WHEN "customer_name" = '1' THEN NULL
            WHEN "customer_name" = '3' THEN NULL
            WHEN "customer_name" = '4' THEN NULL
            WHEN "customer_name" = 'c' THEN NULL
            WHEN "customer_name" = 'NCwDVaWNe6tEgvwfmRchLXak' THEN NULL
            ELSE "customer_name"
        END AS "customer_name",
        CASE
            WHEN "address" = 'E' THEN NULL
            WHEN "address" = '13' THEN NULL
            ELSE "address"
        END AS "address",
        CASE
            WHEN "nation_id" = '23-768-687-3665' THEN NULL
            WHEN "nation_id" = '2866.83' THEN NULL
            WHEN "nation_id" = '7498.12' THEN NULL
            WHEN "nation_id" = '794.47' THEN NULL
            ELSE "nation_id"
        END AS "nation_id",
        CASE
            WHEN "phone_number" = '121.65' THEN NULL
            WHEN "phone_number" = 'AUTOMOBILE' THEN NULL
            WHEN "phone_number" = 'HOUSEHOLD' THEN NULL
            WHEN "phone_number" = 'MACHINERY' THEN NULL
            ELSE "phone_number"
        END AS "phone_number",
        CASE
            WHEN "account_balance" = 'AUTOMOBILE' THEN NULL
            WHEN "account_balance" = 'accounts wake furiously even instructions' THEN NULL
            WHEN "account_balance" = 'pending requests wake carefully express' THEN NULL
            WHEN "account_balance" = 'special packages hang ironic' THEN NULL
            ELSE "account_balance"
        END AS "account_balance",
        "comments",
        CASE
            WHEN "market_segment" = 'even accounts' THEN NULL
            WHEN "market_segment" = 'pending accounts haggle furiously deposit' THEN NULL
            WHEN "market_segment" = 'silent packages' THEN NULL
            ELSE "market_segment"
        END AS "market_segment"
    FROM "customer_renamed_trimmed"
),

"customer_renamed_trimmed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_balance: from VARCHAR to DECIMAL
    -- nation_id: from VARCHAR to INT
    SELECT
        "customer_id",
        "customer_name",
        "address",
        "phone_number",
        "comments",
        "market_segment",
        CAST("account_balance" AS DECIMAL) 
        AS "account_balance",
        CAST("nation_id" AS INT) 
        AS "nation_id"
    FROM "customer_renamed_trimmed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "customer_renamed_trimmed_cleaned_casted"