-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"web_site_renamed" AS (
    -- Rename: Renaming columns
    -- WEB_SITE_SK -> website_surrogate_key
    -- WEB_SITE_ID -> website_id
    -- WEB_REC_START_DATE -> record_start_date
    -- WEB_REC_END_DATE -> record_end_date
    -- WEB_NAME -> website_name
    -- WEB_OPEN_DATE_SK -> web_open_date
    -- WEB_CLOSE_DATE_SK -> web_close_date
    -- WEB_CLASS -> web_classification
    -- WEB_MANAGER -> site_manager
    -- WEB_MKT_ID -> market_id
    -- WEB_MKT_CLASS -> market_classification
    -- WEB_MKT_DESC -> market_description
    -- WEB_MARKET_MANAGER -> market_manager
    -- WEB_COMPANY_ID -> company_id
    -- WEB_COMPANY_NAME -> company_name
    -- WEB_STREET_NUMBER -> street_number
    -- WEB_STREET_NAME -> street_name
    -- WEB_STREET_TYPE -> street_type
    -- WEB_SUITE_NUMBER -> suite_number
    -- WEB_CITY -> web_city
    -- WEB_COUNTY -> web_county
    -- WEB_STATE -> web_state
    -- WEB_ZIP -> zip_code
    -- WEB_COUNTRY -> web_country
    -- WEB_GMT_OFFSET -> gmt_offset
    -- WEB_TAX_PERCENTAGE -> tax_percentage
    SELECT 
        "WEB_SITE_SK" AS "website_surrogate_key",
        "WEB_SITE_ID" AS "website_id",
        "WEB_REC_START_DATE" AS "record_start_date",
        "WEB_REC_END_DATE" AS "record_end_date",
        "WEB_NAME" AS "website_name",
        "WEB_OPEN_DATE_SK" AS "web_open_date",
        "WEB_CLOSE_DATE_SK" AS "web_close_date",
        "WEB_CLASS" AS "web_classification",
        "WEB_MANAGER" AS "site_manager",
        "WEB_MKT_ID" AS "market_id",
        "WEB_MKT_CLASS" AS "market_classification",
        "WEB_MKT_DESC" AS "market_description",
        "WEB_MARKET_MANAGER" AS "market_manager",
        "WEB_COMPANY_ID" AS "company_id",
        "WEB_COMPANY_NAME" AS "company_name",
        "WEB_STREET_NUMBER" AS "street_number",
        "WEB_STREET_NAME" AS "street_name",
        "WEB_STREET_TYPE" AS "street_type",
        "WEB_SUITE_NUMBER" AS "suite_number",
        "WEB_CITY" AS "web_city",
        "WEB_COUNTY" AS "web_county",
        "WEB_STATE" AS "web_state",
        "WEB_ZIP" AS "zip_code",
        "WEB_COUNTRY" AS "web_country",
        "WEB_GMT_OFFSET" AS "gmt_offset",
        "WEB_TAX_PERCENTAGE" AS "tax_percentage"
    FROM "web_site"
),

"web_site_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- market_classification: The problem is that both values in the market_classification column are incomplete sentences that do not represent clear market classifications. They appear to be truncated or nonsensical phrases rather than meaningful categories. The correct values for market classifications should be clear, concise categories describing the market segment or type of product/service. Since we don't have enough context to determine what the intended classifications were, the best approach is to map these unusual values to an empty string. 
    -- market_description: The problem is that both values in the market_description column are incoherent sentences that do not describe markets in any meaningful way. They appear to be randomly generated text or gibberish. The correct values should be empty strings since the existing text provides no useful market description information. 
    -- company_name: The problem is that both 'cally' and 'ese' appear to be incomplete or truncated company names. Without more context or information about the full company names, it's difficult to determine the correct complete names. These values are likely the result of data truncation or improper data entry. The correct values should be the full company names, but we don't have enough information to determine what those are. 
    -- street_type: The problem is inconsistent abbreviation and punctuation styles in the street_type column. 'Cir.' uses a period at the end, while 'Ln' does not. The correct values should use a consistent style, preferably without periods for brevity and consistency with common addressing standards. 
    SELECT
        "website_surrogate_key",
        "website_id",
        "record_start_date",
        "record_end_date",
        "website_name",
        "web_open_date",
        "web_close_date",
        "web_classification",
        "site_manager",
        "market_id",
        CASE
            WHEN "market_classification" = 'Completely excellent things ought to pro' THEN ''
            WHEN "market_classification" = 'Grey lines ought to result indeed centres. Tod' THEN ''
            ELSE "market_classification"
        END AS "market_classification",
        CASE
            WHEN "market_description" = 'Lucky passengers know. Red details will not hang alive, international s' THEN ''
            WHEN "market_description" = 'Well similar decisions used to keep hardly democratic, personal priorities.' THEN ''
            ELSE "market_description"
        END AS "market_description",
        "market_manager",
        "company_id",
        CASE
            WHEN "company_name" = 'cally' THEN ''
            WHEN "company_name" = 'ese' THEN ''
            ELSE "company_name"
        END AS "company_name",
        "street_number",
        "street_name",
        CASE
            WHEN "street_type" = 'Cir.' THEN 'Cir'
            ELSE "street_type"
        END AS "street_type",
        "suite_number",
        "web_city",
        "web_county",
        "web_state",
        "zip_code",
        "web_country",
        "gmt_offset",
        "tax_percentage"
    FROM "web_site_renamed"
),

"web_site_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- market_classification: ['']
    -- market_description: ['']
    -- company_name: ['']
    SELECT 
        CASE
            WHEN "market_classification" = '' THEN NULL
            ELSE "market_classification"
        END AS "market_classification",
        CASE
            WHEN "market_description" = '' THEN NULL
            ELSE "market_description"
        END AS "market_description",
        CASE
            WHEN "company_name" = '' THEN NULL
            ELSE "company_name"
        END AS "company_name",
        "gmt_offset",
        "suite_number",
        "website_id",
        "street_name",
        "street_type",
        "company_id",
        "web_state",
        "market_manager",
        "web_country",
        "web_open_date",
        "site_manager",
        "website_name",
        "web_county",
        "record_end_date",
        "website_surrogate_key",
        "web_city",
        "zip_code",
        "record_start_date",
        "street_number",
        "web_close_date",
        "market_id",
        "web_classification",
        "tax_percentage"
    FROM "web_site_renamed_cleaned"
),

"web_site_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- record_end_date: from VARCHAR to DATE
    -- record_start_date: from VARCHAR to DATE
    -- street_number: from INT to VARCHAR
    -- web_close_date: from DECIMAL to DATE
    -- web_open_date: from INT to DATE
    -- zip_code: from INT to VARCHAR
    SELECT
        "market_classification",
        "market_description",
        "company_name",
        "gmt_offset",
        "suite_number",
        "website_id",
        "street_name",
        "street_type",
        "company_id",
        "web_state",
        "market_manager",
        "web_country",
        "site_manager",
        "website_name",
        "web_county",
        "website_surrogate_key",
        "web_city",
        "market_id",
        "web_classification",
        "tax_percentage",
        CAST("record_end_date" AS DATE) AS "record_end_date",
        CAST("record_start_date" AS DATE) AS "record_start_date",
        CAST("street_number" AS VARCHAR) AS "street_number",
        "web_close_date" AS "web_close_date",
        julian(DATE '1858-11-17' + CAST("web_open_date" AS INTEGER)) AS "web_open_date",
        CAST("zip_code" AS VARCHAR) AS "zip_code"
    FROM "web_site_renamed_cleaned_null"
),

"web_site_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- company_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- market_classification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- market_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_end_date has 50.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "gmt_offset",
        "suite_number",
        "website_id",
        "street_name",
        "street_type",
        "company_id",
        "web_state",
        "market_manager",
        "web_country",
        "site_manager",
        "website_name",
        "web_county",
        "website_surrogate_key",
        "web_city",
        "market_id",
        "web_classification",
        "tax_percentage",
        "record_end_date",
        "record_start_date",
        "street_number",
        "web_close_date",
        "web_open_date",
        "zip_code"
    FROM "web_site_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "web_site_renamed_cleaned_null_casted_missing_handled"