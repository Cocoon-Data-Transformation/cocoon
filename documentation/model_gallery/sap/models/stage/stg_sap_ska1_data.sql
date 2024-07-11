-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 14:47:45.973739+00:00
WITH 
"sap_ska1_data_projected" AS (
    -- Projection: Selecting 19 out of 20 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "mandt",
        "ktopl",
        "saknr",
        "bilkt",
        "gvtyp",
        "vbund",
        "xbilk",
        "sakan",
        "erdat",
        "ernam",
        "ktoks",
        "xloev",
        "xspea",
        "xspeb",
        "xspep",
        "func_area",
        "mustr",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_ska1_data"
),

"sap_ska1_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- mandt -> company_code
    -- ktopl -> chart_of_accounts
    -- saknr -> gl_account_number
    -- bilkt -> balance_sheet_account_type
    -- gvtyp -> pl_account_type
    -- vbund -> partner_company_id
    -- xbilk -> is_balance_sheet_account
    -- sakan -> gl_account_group_currency
    -- erdat -> creation_date
    -- ernam -> creator_username
    -- ktoks -> account_group
    -- xloev -> is_marked_for_deletion
    -- xspea -> is_posting_blocked_client
    -- xspeb -> is_posting_blocked_company
    -- xspep -> is_posting_blocked_profit_center
    -- func_area -> functional_area
    -- mustr -> sample_account_indicator
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "mandt" AS "company_code",
        "ktopl" AS "chart_of_accounts",
        "saknr" AS "gl_account_number",
        "bilkt" AS "balance_sheet_account_type",
        "gvtyp" AS "pl_account_type",
        "vbund" AS "partner_company_id",
        "xbilk" AS "is_balance_sheet_account",
        "sakan" AS "gl_account_group_currency",
        "erdat" AS "creation_date",
        "ernam" AS "creator_username",
        "ktoks" AS "account_group",
        "xloev" AS "is_marked_for_deletion",
        "xspea" AS "is_posting_blocked_client",
        "xspeb" AS "is_posting_blocked_company",
        "xspep" AS "is_posting_blocked_profit_center",
        "func_area" AS "functional_area",
        "mustr" AS "sample_account_indicator",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_ska1_data_projected"
),

"sap_ska1_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- chart_of_accounts: The problem is that 'dabe' is the only value present in the chart_of_accounts column, and it's not a recognized accounting term. It's likely a typo for 'debit', which is a common term in accounting. The correct value should be 'debit'. 
    -- is_balance_sheet_account: The problem is that 'x' is not a clear indicator of balance sheet account status. Typically, a boolean column like this would use values such as 'true'/'false', 'yes'/'no', or 1/0 to indicate whether an account is a balance sheet account or not. The single value 'x' is ambiguous and doesn't provide a clear opposite for non-balance sheet accounts. The correct values should be more explicit boolean indicators. 
    SELECT
        "company_code",
        CASE
            WHEN "chart_of_accounts" = '''dabe''' THEN '''debit'''
            ELSE "chart_of_accounts"
        END AS "chart_of_accounts",
        "gl_account_number",
        "balance_sheet_account_type",
        "pl_account_type",
        "partner_company_id",
        CASE
            WHEN "is_balance_sheet_account" = '''x''' THEN '''yes'''
            ELSE "is_balance_sheet_account"
        END AS "is_balance_sheet_account",
        "gl_account_group_currency",
        "creation_date",
        "creator_username",
        "account_group",
        "is_marked_for_deletion",
        "is_posting_blocked_client",
        "is_posting_blocked_company",
        "is_posting_blocked_profit_center",
        "functional_area",
        "sample_account_indicator",
        "row_id",
        "is_deleted"
    FROM "sap_ska1_data_projected_renamed"
),

"sap_ska1_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- balance_sheet_account_type: from DECIMAL to VARCHAR
    -- company_code: from INT to VARCHAR
    -- creation_date: from INT to DATE
    -- functional_area: from DECIMAL to VARCHAR
    -- gl_account_group_currency: from INT to VARCHAR
    -- gl_account_number: from INT to VARCHAR
    -- is_balance_sheet_account: from VARCHAR to BOOLEAN
    -- is_marked_for_deletion: from DECIMAL to VARCHAR
    -- is_posting_blocked_client: from DECIMAL to VARCHAR
    -- is_posting_blocked_company: from DECIMAL to VARCHAR
    -- is_posting_blocked_profit_center: from DECIMAL to VARCHAR
    -- partner_company_id: from DECIMAL to VARCHAR
    -- pl_account_type: from DECIMAL to VARCHAR
    -- sample_account_indicator: from DECIMAL to VARCHAR
    SELECT
        "chart_of_accounts",
        "creator_username",
        "account_group",
        "row_id",
        "is_deleted",
        CAST("balance_sheet_account_type" AS VARCHAR) AS "balance_sheet_account_type",
        CAST("company_code" AS VARCHAR) AS "company_code",
        strptime(CAST("creation_date" AS VARCHAR), '%Y%m%d') AS "creation_date",
        CAST("functional_area" AS VARCHAR) AS "functional_area",
        CAST("gl_account_group_currency" AS VARCHAR) AS "gl_account_group_currency",
        CAST("gl_account_number" AS VARCHAR) AS "gl_account_number",
        CAST("is_balance_sheet_account" = 'x' AS BOOLEAN) AS "is_balance_sheet_account",
        CAST("is_marked_for_deletion" AS VARCHAR) AS "is_marked_for_deletion",
        CAST("is_posting_blocked_client" AS VARCHAR) AS "is_posting_blocked_client",
        CAST("is_posting_blocked_company" AS VARCHAR) AS "is_posting_blocked_company",
        CAST("is_posting_blocked_profit_center" AS VARCHAR) AS "is_posting_blocked_profit_center",
        CAST("partner_company_id" AS VARCHAR) AS "partner_company_id",
        CAST("pl_account_type" AS VARCHAR) AS "pl_account_type",
        CAST("sample_account_indicator" AS VARCHAR) AS "sample_account_indicator"
    FROM "sap_ska1_data_projected_renamed_cleaned"
),

"sap_ska1_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 7 columns with unacceptable missing values
    -- functional_area has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_marked_for_deletion has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_posting_blocked_client has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_posting_blocked_company has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_posting_blocked_profit_center has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- partner_company_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sample_account_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "chart_of_accounts",
        "creator_username",
        "account_group",
        "row_id",
        "is_deleted",
        "balance_sheet_account_type",
        "company_code",
        "creation_date",
        "gl_account_group_currency",
        "gl_account_number",
        "is_balance_sheet_account",
        "pl_account_type"
    FROM "sap_ska1_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_ska1_data_projected_renamed_cleaned_casted_missing_handled"