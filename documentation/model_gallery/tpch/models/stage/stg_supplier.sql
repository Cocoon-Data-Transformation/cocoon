-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:28:27.866538+00:00
WITH 
"supplier_renamed" AS (
    -- Rename: Renaming columns
    -- S_SUPPKEY -> supplier_id
    -- S_NAME -> supplier_name
    -- S_ADDRESS -> supplier_address
    -- S_NATIONKEY -> nation_id
    -- S_PHONE -> supplier_phone
    -- S_ACCTBAL -> account_balance
    -- S_COMMENT -> supplier_comments
    SELECT 
        "S_SUPPKEY" AS "supplier_id",
        "S_NAME" AS "supplier_name",
        "S_ADDRESS" AS "supplier_address",
        "S_NATIONKEY" AS "nation_id",
        "S_PHONE" AS "supplier_phone",
        "S_ACCTBAL" AS "account_balance",
        "S_COMMENT" AS "supplier_comments"
    FROM "memory"."main"."supplier"
),

"supplier_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "supplier_id",
        "supplier_name",
        "supplier_address",
        "nation_id",
        "supplier_phone",
        "supplier_comments",
        TRIM("account_balance") AS "account_balance"
    FROM "supplier_renamed"
),

"supplier_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- supplier_name: The problem is that all values in the supplier_name column appear to be encrypted, hashed, or randomly generated strings. These do not resemble typical supplier names, which would usually be recognizable company or individual names. Without additional information to decode these strings, it's impossible to determine the correct supplier names. Therefore, the best approach is to map all these unusual values to an empty string, indicating that the actual supplier name is unknown or unavailable.
    -- supplier_address: The problem is that the supplier_address column contains unusual values. The values '15', '4', and '5' are unusually short for addresses and likely represent incomplete data. The values 'G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3' and 'gf0JBoQDd7tgrzrddZ' appear to be random strings rather than valid addresses. These random strings are meaningless and should be replaced with empty strings to indicate missing data. The short numeric values should be kept as is, as they might represent valid partial address information (like building numbers).
    -- nation_id: The problem is that some values in the nation_id column resemble phone numbers (14-606-487-0570, 15-679-861-2259, 25-843-787-7479) rather than typical nation IDs. The correct values should be short numeric codes. The most frequent valid value is '1', and there's also a '17', which follows the same pattern of being a short numeric code. We'll map the phone number-like values to empty strings as they don't seem to represent valid nation IDs.
    -- supplier_phone: The problem is that the supplier_phone column contains three decimal numbers (4032.68, 4641.08, and 9915.24) which are not valid phone numbers. The correct values should be in the format of xx-xxx-xxx-xxxx, as seen in the two most frequent entries. Since these decimal numbers are meaningless in the context of phone numbers, they should be mapped to an empty string.
    -- supplier_comments: The problem is that the values in the supplier_comments column are incomplete sentences that seem to be truncated. They lack proper context and meaning. The correct values should be complete sentences or meaningful phrases related to supplier comments. However, without more context or the full dataset, it's difficult to determine what the complete sentences should be.
    -- account_balance: The problem is that some entries in the account_balance column contain text descriptions instead of numeric values. Account balances should typically be numeric values representing monetary amounts. The correct values are the numeric entries like '4192.40' and '5755.94'. The text entries are meaningless in this context and should be removed or replaced with empty strings.
    SELECT
        "supplier_id",
        CASE
            WHEN "supplier_name" = '89eJ5ksX3ImxJQBvxObC' THEN NULL
            WHEN "supplier_name" = 'Bk7ah4CK8SYQTepEmvMkkgMwg' THEN NULL
            WHEN "supplier_name" = 'Gcdm2rJRzl5qlTVzc' THEN NULL
            WHEN "supplier_name" = 'N kD4on9OM Ipw3' THEN NULL
            WHEN "supplier_name" = 'q1' THEN NULL
            ELSE "supplier_name"
        END AS "supplier_name",
        CASE
            WHEN "supplier_address" = 'G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3' THEN NULL
            WHEN "supplier_address" = 'gf0JBoQDd7tgrzrddZ' THEN NULL
            ELSE "supplier_address"
        END AS "supplier_address",
        CASE
            WHEN "nation_id" = '14-606-487-0570' THEN NULL
            WHEN "nation_id" = '15-679-861-2259' THEN NULL
            WHEN "nation_id" = '25-843-787-7479' THEN NULL
            ELSE "nation_id"
        END AS "nation_id",
        CASE
            WHEN "supplier_phone" = '4032.68' THEN NULL
            WHEN "supplier_phone" = '4641.08' THEN NULL
            WHEN "supplier_phone" = '9915.24' THEN NULL
            ELSE "supplier_phone"
        END AS "supplier_phone",
        CASE
            WHEN "supplier_comments" = 'blithely silent requests after the express dependencies are sl' THEN NULL
            WHEN "supplier_comments" = 'each slyly above the careful' THEN NULL
            ELSE "supplier_comments"
        END AS "supplier_comments",
        CASE
            WHEN "account_balance" = 'quickly above the quickly ironic deposits affix' THEN NULL
            WHEN "account_balance" = 'riously even requests above the exp' THEN NULL
            WHEN "account_balance" = 'slyly bold instructions. idle deposi' THEN NULL
            ELSE "account_balance"
        END AS "account_balance"
    FROM "supplier_renamed_trimmed"
),

"supplier_renamed_trimmed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- account_balance: from VARCHAR to DECIMAL
    -- nation_id: from VARCHAR to INT
    SELECT
        "supplier_id",
        "supplier_name",
        "supplier_address",
        "supplier_phone",
        "supplier_comments",
        CAST("account_balance" AS DECIMAL) 
        AS "account_balance",
        CAST("nation_id" AS INT) 
        AS "nation_id"
    FROM "supplier_renamed_trimmed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "supplier_renamed_trimmed_cleaned_casted"