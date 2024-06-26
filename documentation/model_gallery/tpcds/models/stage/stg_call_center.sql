-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"call_center_renamed" AS (
    -- Rename: Renaming columns
    -- CC_CALL_CENTER_SK -> call_center_surrogate_key
    -- CC_CALL_CENTER_ID -> call_center_id
    -- CC_REC_START_DATE -> record_start_date
    -- CC_REC_END_DATE -> record_end_date
    -- CC_CLOSED_DATE_SK -> closed_date_key
    -- CC_OPEN_DATE_SK -> open_date_key
    -- CC_NAME -> call_center_name
    -- CC_CLASS -> size_class
    -- CC_EMPLOYEES -> employee_count
    -- CC_SQ_FT -> square_footage
    -- CC_HOURS -> operating_hours
    -- CC_MANAGER -> manager_name
    -- CC_MKT_ID -> market_id
    -- CC_MKT_CLASS -> market_class
    -- CC_MKT_DESC -> market_description
    -- CC_MARKET_MANAGER -> market_manager_name
    -- CC_DIVISION -> division_id
    -- CC_DIVISION_NAME -> division_name
    -- CC_COMPANY -> company_id
    -- CC_COMPANY_NAME -> company_name
    -- CC_STREET_NUMBER -> street_number
    -- CC_STREET_NAME -> street_name
    -- CC_STREET_TYPE -> street_type
    -- CC_SUITE_NUMBER -> suite_number
    -- CC_CITY -> city
    -- CC_COUNTY -> county
    -- CC_STATE -> state
    -- CC_ZIP -> call_center_zip_code
    -- CC_COUNTRY -> country
    -- CC_GMT_OFFSET -> gmt_offset
    -- CC_TAX_PERCENTAGE -> tax_percentage
    SELECT 
        "CC_CALL_CENTER_SK" AS "call_center_surrogate_key",
        "CC_CALL_CENTER_ID" AS "call_center_id",
        "CC_REC_START_DATE" AS "record_start_date",
        "CC_REC_END_DATE" AS "record_end_date",
        "CC_CLOSED_DATE_SK" AS "closed_date_key",
        "CC_OPEN_DATE_SK" AS "open_date_key",
        "CC_NAME" AS "call_center_name",
        "CC_CLASS" AS "size_class",
        "CC_EMPLOYEES" AS "employee_count",
        "CC_SQ_FT" AS "square_footage",
        "CC_HOURS" AS "operating_hours",
        "CC_MANAGER" AS "manager_name",
        "CC_MKT_ID" AS "market_id",
        "CC_MKT_CLASS" AS "market_class",
        "CC_MKT_DESC" AS "market_description",
        "CC_MARKET_MANAGER" AS "market_manager_name",
        "CC_DIVISION" AS "division_id",
        "CC_DIVISION_NAME" AS "division_name",
        "CC_COMPANY" AS "company_id",
        "CC_COMPANY_NAME" AS "company_name",
        "CC_STREET_NUMBER" AS "street_number",
        "CC_STREET_NAME" AS "street_name",
        "CC_STREET_TYPE" AS "street_type",
        "CC_SUITE_NUMBER" AS "suite_number",
        "CC_CITY" AS "city",
        "CC_COUNTY" AS "county",
        "CC_STATE" AS "state",
        "CC_ZIP" AS "call_center_zip_code",
        "CC_COUNTRY" AS "country",
        "CC_GMT_OFFSET" AS "gmt_offset",
        "CC_TAX_PERCENTAGE" AS "tax_percentage"
    FROM "call_center"
),

"call_center_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- operating_hours: The problem is that '8AM-8AM' is an unusual representation for 24-hour operation. It's inconsistent with the more common format seen in '8AM-4PM'. The correct values should represent the actual operating hours clearly. For 24-hour operation, it's more standard to use '24 hours' or '12AM-11:59PM'. 
    -- market_class: The problem is that both values in the market_class column are incomplete phrases that do not represent clear market classifications. They appear to be truncated or partial sentences without any meaningful market categorization. The correct values for a market_class column should be concise, clear categories describing the market segment or classification. Since the existing values are meaningless in this context, they should be mapped to an empty string. 
    -- market_description: The problem is that both values in the market_description column are incomplete sentences with abrupt endings and lack clear meaning. They appear to be truncated or corrupted text that does not provide any useful information about market description. The correct approach is to map these meaningless values to empty strings. 
    SELECT
        "call_center_surrogate_key",
        "call_center_id",
        "record_start_date",
        "record_end_date",
        "closed_date_key",
        "open_date_key",
        "call_center_name",
        "size_class",
        "employee_count",
        "square_footage",
        CASE
            WHEN "operating_hours" = '8AM-8AM' THEN '24 hours'
            ELSE "operating_hours"
        END AS "operating_hours",
        "manager_name",
        "market_id",
        CASE
            WHEN "market_class" = 'A bit narrow forms matter animals. Consist' THEN ''
            WHEN "market_class" = 'More than other authori' THEN ''
            ELSE "market_class"
        END AS "market_class",
        CASE
            WHEN "market_description" = 'Largely blank years put substantially deaf, new others. Question' THEN ''
            WHEN "market_description" = 'Shared others could not count fully dollars. New members ca' THEN ''
            ELSE "market_description"
        END AS "market_description",
        "market_manager_name",
        "division_id",
        "division_name",
        "company_id",
        "company_name",
        "street_number",
        "street_name",
        "street_type",
        "suite_number",
        "city",
        "county",
        "state",
        "call_center_zip_code",
        "country",
        "gmt_offset",
        "tax_percentage"
    FROM "call_center_renamed"
),

"call_center_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- market_class: ['']
    -- market_description: ['']
    SELECT 
        CASE
            WHEN "market_class" = '' THEN NULL
            ELSE "market_class"
        END AS "market_class",
        CASE
            WHEN "market_description" = '' THEN NULL
            ELSE "market_description"
        END AS "market_description",
        "call_center_name",
        "gmt_offset",
        "suite_number",
        "street_name",
        "street_type",
        "size_class",
        "open_date_key",
        "company_id",
        "state",
        "manager_name",
        "square_footage",
        "call_center_surrogate_key",
        "operating_hours",
        "division_name",
        "county",
        "record_end_date",
        "market_manager_name",
        "company_name",
        "closed_date_key",
        "employee_count",
        "call_center_zip_code",
        "record_start_date",
        "city",
        "street_number",
        "country",
        "market_id",
        "division_id",
        "tax_percentage",
        "call_center_id"
    FROM "call_center_renamed_cleaned"
),

"call_center_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- call_center_zip_code: from INT to VARCHAR
    -- closed_date_key: from DECIMAL to VARCHAR
    -- gmt_offset: from INT to DECIMAL
    -- record_end_date: from VARCHAR to DATE
    -- record_start_date: from VARCHAR to DATE
    -- street_number: from INT to VARCHAR
    SELECT
        "market_class",
        "market_description",
        "call_center_name",
        "suite_number",
        "street_name",
        "street_type",
        "size_class",
        "open_date_key",
        "company_id",
        "state",
        "manager_name",
        "square_footage",
        "call_center_surrogate_key",
        "operating_hours",
        "division_name",
        "county",
        "market_manager_name",
        "company_name",
        "employee_count",
        "city",
        "country",
        "market_id",
        "division_id",
        "tax_percentage",
        "call_center_id",
        CAST("call_center_zip_code" AS VARCHAR) AS "call_center_zip_code",
        CAST("closed_date_key" AS VARCHAR) AS "closed_date_key",
        CAST("gmt_offset" AS DECIMAL) AS "gmt_offset",
        CAST("record_end_date" AS DATE) AS "record_end_date",
        CAST("record_start_date" AS DATE) AS "record_start_date",
        CAST("street_number" AS VARCHAR) AS "street_number"
    FROM "call_center_renamed_cleaned_null"
),

"call_center_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- market_class has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- market_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_end_date has 50.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "call_center_name",
        "suite_number",
        "street_name",
        "street_type",
        "size_class",
        "open_date_key",
        "company_id",
        "state",
        "manager_name",
        "square_footage",
        "call_center_surrogate_key",
        "operating_hours",
        "division_name",
        "county",
        "market_manager_name",
        "company_name",
        "employee_count",
        "city",
        "country",
        "market_id",
        "division_id",
        "tax_percentage",
        "call_center_id",
        "call_center_zip_code",
        "closed_date_key",
        "gmt_offset",
        "record_end_date",
        "record_start_date",
        "street_number"
    FROM "call_center_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "call_center_renamed_cleaned_null_casted_missing_handled"