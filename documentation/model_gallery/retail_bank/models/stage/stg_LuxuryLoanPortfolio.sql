-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"LuxuryLoanPortfolio_renamed" AS (
    -- Rename: Renaming columns
    -- funded_amount -> loan_amount
    -- funded_date -> funding_date
    -- duration_years -> loan_duration_years
    -- duration_months -> loan_duration_months
    -- _10_yr_treasury_index_date_funded -> treasury_index_rate
    -- interest_rate -> interest_rate_decimal
    -- payments -> monthly_payment
    -- total_past_payments -> total_payments_made
    -- loan_balance -> current_loan_balance
    -- purpose -> loan_purpose
    -- firstname -> first_name
    -- middlename -> middle_name
    -- lastname -> last_name
    -- social -> ssn
    -- phone -> phone_number
    -- title -> job_title
    -- employment_length -> employment_length_years
    -- tax_class_at_present -> current_tax_class
    -- building_class_at_present -> current_building_class
    -- total_units -> items_financed
    -- tax_class_at_time_of_sale -> sale_tax_class
    SELECT 
        "loan_id",
        "funded_amount" AS "loan_amount",
        "funded_date" AS "funding_date",
        "duration_years" AS "loan_duration_years",
        "duration_months" AS "loan_duration_months",
        "_10_yr_treasury_index_date_funded" AS "treasury_index_rate",
        "interest_rate_percent",
        "interest_rate" AS "interest_rate_decimal",
        "payments" AS "monthly_payment",
        "total_past_payments" AS "total_payments_made",
        "loan_balance" AS "current_loan_balance",
        "property_value",
        "purpose" AS "loan_purpose",
        "firstname" AS "first_name",
        "middlename" AS "middle_name",
        "lastname" AS "last_name",
        "social" AS "ssn",
        "phone" AS "phone_number",
        "title" AS "job_title",
        "employment_length" AS "employment_length_years",
        "building_class_category",
        "tax_class_at_present" AS "current_tax_class",
        "building_class_at_present" AS "current_building_class",
        "address_1",
        "address_2",
        "zip_code",
        "city",
        "state",
        "total_units" AS "items_financed",
        "land_square_feet",
        "gross_square_feet",
        "tax_class_at_time_of_sale" AS "sale_tax_class"
    FROM "LuxuryLoanPortfolio"
),

"LuxuryLoanPortfolio_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "loan_id",
        "loan_amount",
        "funding_date",
        "loan_duration_years",
        "loan_duration_months",
        "treasury_index_rate",
        "interest_rate_percent",
        "interest_rate_decimal",
        "monthly_payment",
        "total_payments_made",
        "current_loan_balance",
        "property_value",
        "loan_purpose",
        "first_name",
        "middle_name",
        "last_name",
        "ssn",
        "phone_number",
        "employment_length_years",
        "building_class_category",
        "current_tax_class",
        "current_building_class",
        "address_1",
        "address_2",
        "zip_code",
        "city",
        "state",
        "items_financed",
        "land_square_feet",
        "gross_square_feet",
        "sale_tax_class",
        TRIM("job_title") AS "job_title"
    FROM "LuxuryLoanPortfolio_renamed"
),

"LuxuryLoanPortfolio_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- loan_purpose: The problem is that 'commerical property' is misspelled. It should be 'commercial property'. The other values appear to be correct. The correct values should be 'home', 'investment property', 'commercial property', and 'boat'. 
    -- current_tax_class: The problem is that the tax class representations are inconsistent. The values '2', '2A', '2B', and '2C' seem to represent variations of the same tax class 2. Similarly, '1C' and '1A' are likely variations of tax class 1. The correct values should be simplified to the main tax class numbers without letter suffixes for consistency. 
    -- address_1: Some addresses have extra spaces, e.g., '17 EAST 12TH   STREET' vs '17 EAST 12TH STREET'.
    -- address_2: The problem is that some values in the address_2 column mix letters with numbers inconsistently. The correct values should be purely numeric, as the majority of the entries are. The unusual entries appear to be apartment or unit numbers, where the letter likely represents a building or section. To standardize, we'll keep only the numeric part for consistency. 
    -- job_title: 'Owner' and 'owner' are redundant. 'VP' is an abbreviation of 'Vice President', which is already present.
    SELECT
        "loan_id",
        "loan_amount",
        "funding_date",
        "loan_duration_years",
        "loan_duration_months",
        "treasury_index_rate",
        "interest_rate_percent",
        "interest_rate_decimal",
        "monthly_payment",
        "total_payments_made",
        "current_loan_balance",
        "property_value",
        CASE
            WHEN "loan_purpose" = 'commerical property' THEN 'commercial property'
            ELSE "loan_purpose"
        END AS "loan_purpose",
        "first_name",
        "middle_name",
        "last_name",
        "ssn",
        "phone_number",
        "employment_length_years",
        "building_class_category",
        CASE
            WHEN "current_tax_class" = '2C' THEN '2'
            WHEN "current_tax_class" = '2A' THEN '2'
            WHEN "current_tax_class" = '2B' THEN '2'
            WHEN "current_tax_class" = '1C' THEN '1'
            WHEN "current_tax_class" = '1A' THEN '1'
            ELSE "current_tax_class"
        END AS "current_tax_class",
        "current_building_class",
        "address_1",
        CASE
            WHEN "address_2" = '10C' THEN '10'
            WHEN "address_2" = '11E' THEN '11'
            WHEN "address_2" = '11F' THEN '11'
            WHEN "address_2" = '10K' THEN '10'
            WHEN "address_2" = '10I' THEN '10'
            WHEN "address_2" = '33D' THEN '33'
            WHEN "address_2" = '33B' THEN '33'
            WHEN "address_2" = '33C' THEN '33'
            WHEN "address_2" = '104N' THEN '104'
            WHEN "address_2" = '10B/C' THEN '10'
            WHEN "address_2" = '10C/D' THEN '10'
            WHEN "address_2" = '10DS' THEN '10'
            WHEN "address_2" = '10HN' THEN '10'
            WHEN "address_2" = '116A' THEN '116'
            WHEN "address_2" = '11G-1' THEN '11'
            WHEN "address_2" = '12Y' THEN '12'
            WHEN "address_2" = 'B2E' THEN '2'
            WHEN "address_2" = 'B302' THEN '302'
            ELSE "address_2"
        END AS "address_2",
        "zip_code",
        "city",
        "state",
        "items_financed",
        "land_square_feet",
        "gross_square_feet",
        "sale_tax_class",
        "job_title"
    FROM "LuxuryLoanPortfolio_renamed_trimmed"
),

"LuxuryLoanPortfolio_renamed_trimmed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- funding_date: from VARCHAR to DATE
    -- sale_tax_class: from INT to VARCHAR
    -- zip_code: from INT to VARCHAR
    SELECT
        "loan_id",
        "loan_amount",
        "loan_duration_years",
        "loan_duration_months",
        "treasury_index_rate",
        "interest_rate_percent",
        "interest_rate_decimal",
        "monthly_payment",
        "total_payments_made",
        "current_loan_balance",
        "property_value",
        "loan_purpose",
        "first_name",
        "middle_name",
        "last_name",
        "ssn",
        "phone_number",
        "employment_length_years",
        "building_class_category",
        "current_tax_class",
        "current_building_class",
        "address_1",
        "address_2",
        "city",
        "state",
        "items_financed",
        "land_square_feet",
        "gross_square_feet",
        "job_title",
        CAST("funding_date" AS DATE) AS "funding_date",
        CAST("sale_tax_class" AS VARCHAR) AS "sale_tax_class",
        CAST("zip_code" AS VARCHAR) AS "zip_code"
    FROM "LuxuryLoanPortfolio_renamed_trimmed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "LuxuryLoanPortfolio_renamed_trimmed_cleaned_casted"