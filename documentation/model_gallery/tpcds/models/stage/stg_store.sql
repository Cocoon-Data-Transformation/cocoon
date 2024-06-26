-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"store_renamed" AS (
    -- Rename: Renaming columns
    -- S_STORE_SK -> store_surrogate_key
    -- S_STORE_ID -> store_id
    -- S_REC_START_DATE -> record_start_date
    -- S_REC_END_DATE -> record_end_date
    -- S_CLOSED_DATE_SK -> store_close_date
    -- S_STORE_NAME -> store_name
    -- S_NUMBER_EMPLOYEES -> employee_count
    -- S_FLOOR_SPACE -> store_floor_space
    -- S_HOURS -> store_hours
    -- S_MANAGER -> store_manager
    -- S_MARKET_ID -> market_id
    -- S_GEOGRAPHY_CLASS -> geography_class
    -- S_MARKET_DESC -> market_description
    -- S_MARKET_MANAGER -> market_manager
    -- S_DIVISION_ID -> division_id
    -- S_DIVISION_NAME -> division_name
    -- S_COMPANY_ID -> company_id
    -- S_COMPANY_NAME -> company_name
    -- S_STREET_NUMBER -> store_street_number
    -- S_STREET_NAME -> store_street_name
    -- S_STREET_TYPE -> store_street_type
    -- S_SUITE_NUMBER -> store_suite_number
    -- S_CITY -> store_city
    -- S_COUNTY -> store_county
    -- S_STATE -> store_state
    -- S_ZIP -> store_zip_code
    -- S_COUNTRY -> store_country
    -- S_GMT_OFFSET -> store_gmt_offset
    -- S_TAX_PRECENTAGE -> store_tax_percentage
    SELECT 
        "S_STORE_SK" AS "store_surrogate_key",
        "S_STORE_ID" AS "store_id",
        "S_REC_START_DATE" AS "record_start_date",
        "S_REC_END_DATE" AS "record_end_date",
        "S_CLOSED_DATE_SK" AS "store_close_date",
        "S_STORE_NAME" AS "store_name",
        "S_NUMBER_EMPLOYEES" AS "employee_count",
        "S_FLOOR_SPACE" AS "store_floor_space",
        "S_HOURS" AS "store_hours",
        "S_MANAGER" AS "store_manager",
        "S_MARKET_ID" AS "market_id",
        "S_GEOGRAPHY_CLASS" AS "geography_class",
        "S_MARKET_DESC" AS "market_description",
        "S_MARKET_MANAGER" AS "market_manager",
        "S_DIVISION_ID" AS "division_id",
        "S_DIVISION_NAME" AS "division_name",
        "S_COMPANY_ID" AS "company_id",
        "S_COMPANY_NAME" AS "company_name",
        "S_STREET_NUMBER" AS "store_street_number",
        "S_STREET_NAME" AS "store_street_name",
        "S_STREET_TYPE" AS "store_street_type",
        "S_SUITE_NUMBER" AS "store_suite_number",
        "S_CITY" AS "store_city",
        "S_COUNTY" AS "store_county",
        "S_STATE" AS "store_state",
        "S_ZIP" AS "store_zip_code",
        "S_COUNTRY" AS "store_country",
        "S_GMT_OFFSET" AS "store_gmt_offset",
        "S_TAX_PRECENTAGE" AS "store_tax_percentage"
    FROM "store"
),

"store_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "store_surrogate_key",
        "store_id",
        "record_start_date",
        "record_end_date",
        "store_close_date",
        "store_name",
        "employee_count",
        "store_floor_space",
        "store_hours",
        "store_manager",
        "market_id",
        "geography_class",
        "market_description",
        "market_manager",
        "division_id",
        "division_name",
        "company_id",
        "company_name",
        "store_street_number",
        "store_street_type",
        "store_suite_number",
        "store_city",
        "store_county",
        "store_state",
        "store_zip_code",
        "store_country",
        "store_gmt_offset",
        "store_tax_percentage",
        TRIM("store_street_name") AS "store_street_name"
    FROM "store_renamed"
),

"store_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- store_name: The problem is that 'able' and 'ought' are common English words rather than typical store names. They appear to be placeholders or errors in the data entry process. Since there are no clear correct store names to map these to, and we don't have additional context about what these stores might actually be, the most appropriate action is to map them to empty strings. 
    -- market_description: The problem is that both values in the market_description column are incomplete sentences that lack clear market descriptions. They appear to be truncated or nonsensical fragments rather than meaningful market descriptions. The correct approach would be to map these meaningless values to empty strings, as they do not provide any useful information about the market. 
    -- store_street_type: The problem is inconsistency in abbreviation formatting and an uncommon abbreviation. 'Dr.' is period-terminated while 'Wy' is not. 'Wy' is an uncommon abbreviation for 'Way'. The correct values should be consistently formatted and use standard abbreviations. 
    SELECT
        "store_surrogate_key",
        "store_id",
        "record_start_date",
        "record_end_date",
        "store_close_date",
        CASE
            WHEN "store_name" = 'able' THEN ''
            WHEN "store_name" = 'ought' THEN ''
            ELSE "store_name"
        END AS "store_name",
        "employee_count",
        "store_floor_space",
        "store_hours",
        "store_manager",
        "market_id",
        "geography_class",
        CASE
            WHEN "market_description" = 'Enough high areas stop expectations. Elaborate, local is' THEN ''
            WHEN "market_description" = 'Parliamentary candidates wait then heavy, keen mil' THEN ''
            ELSE "market_description"
        END AS "market_description",
        "market_manager",
        "division_id",
        "division_name",
        "company_id",
        "company_name",
        "store_street_number",
        CASE
            WHEN "store_street_type" = 'Wy' THEN 'Way'
            ELSE "store_street_type"
        END AS "store_street_type",
        "store_suite_number",
        "store_city",
        "store_county",
        "store_state",
        "store_zip_code",
        "store_country",
        "store_gmt_offset",
        "store_tax_percentage",
        "store_street_name"
    FROM "store_renamed_trimmed"
),

"store_renamed_trimmed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- store_name: ['']
    -- geography_class: ['Unknown']
    -- market_description: ['']
    -- division_name: ['Unknown']
    -- company_name: ['Unknown']
    SELECT 
        CASE
            WHEN "store_name" = '' THEN NULL
            ELSE "store_name"
        END AS "store_name",
        CASE
            WHEN "geography_class" = 'Unknown' THEN NULL
            ELSE "geography_class"
        END AS "geography_class",
        CASE
            WHEN "market_description" = '' THEN NULL
            ELSE "market_description"
        END AS "market_description",
        CASE
            WHEN "division_name" = 'Unknown' THEN NULL
            ELSE "division_name"
        END AS "division_name",
        CASE
            WHEN "company_name" = 'Unknown' THEN NULL
            ELSE "company_name"
        END AS "company_name",
        "store_id",
        "store_surrogate_key",
        "store_floor_space",
        "store_close_date",
        "company_id",
        "store_country",
        "store_state",
        "store_street_type",
        "store_hours",
        "store_county",
        "store_zip_code",
        "market_manager",
        "store_gmt_offset",
        "record_end_date",
        "store_city",
        "store_tax_percentage",
        "employee_count",
        "record_start_date",
        "store_suite_number",
        "store_street_name",
        "store_manager",
        "market_id",
        "division_id",
        "store_street_number"
    FROM "store_renamed_trimmed_cleaned"
),

"store_renamed_trimmed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- record_end_date: from VARCHAR to DATE
    -- record_start_date: from VARCHAR to DATE
    -- store_close_date: from DECIMAL to DATE
    -- store_street_number: from INT to VARCHAR
    -- store_zip_code: from INT to VARCHAR
    SELECT
        "store_name",
        "geography_class",
        "market_description",
        "division_name",
        "company_name",
        "store_id",
        "store_surrogate_key",
        "store_floor_space",
        "company_id",
        "store_country",
        "store_state",
        "store_street_type",
        "store_hours",
        "store_county",
        "market_manager",
        "store_gmt_offset",
        "store_city",
        "store_tax_percentage",
        "employee_count",
        "store_suite_number",
        "store_street_name",
        "store_manager",
        "market_id",
        "division_id",
        CAST("record_end_date" AS DATE) AS "record_end_date",
        CAST("record_start_date" AS DATE) AS "record_start_date",
        "store_close_date" AS "store_close_date",
        CAST("store_street_number" AS VARCHAR) AS "store_street_number",
        CAST("store_zip_code" AS VARCHAR) AS "store_zip_code"
    FROM "store_renamed_trimmed_cleaned_null"
),

"store_renamed_trimmed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 6 columns with unacceptable missing values
    -- company_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- division_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- geography_class has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- market_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- record_end_date has 50.0 percent missing. Strategy: 🔄 Unchanged
    -- store_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "store_id",
        "store_surrogate_key",
        "store_floor_space",
        "company_id",
        "store_country",
        "store_state",
        "store_street_type",
        "store_hours",
        "store_county",
        "market_manager",
        "store_gmt_offset",
        "store_city",
        "store_tax_percentage",
        "employee_count",
        "store_suite_number",
        "store_street_name",
        "store_manager",
        "market_id",
        "division_id",
        "record_end_date",
        "record_start_date",
        "store_close_date",
        "store_street_number",
        "store_zip_code"
    FROM "store_renamed_trimmed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "store_renamed_trimmed_cleaned_null_casted_missing_handled"