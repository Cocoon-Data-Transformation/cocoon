-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"CRM_Events_renamed" AS (
    -- Rename: Renaming columns
    -- product -> financial_product
    -- sub_product -> specific_product
    -- issue -> complaint_category
    -- sub_issue -> complaint_subcategory
    -- consumer_complaint_narrative -> complaint_details
    -- consumer_consent_provided -> public_consent
    -- submitted_via -> submission_method
    -- company_response_to_consumer -> resolution_type
    SELECT 
        "date_received",
        "product" AS "financial_product",
        "sub_product" AS "specific_product",
        "issue" AS "complaint_category",
        "sub_issue" AS "complaint_subcategory",
        "consumer_complaint_narrative" AS "complaint_details",
        "tags",
        "consumer_consent_provided" AS "public_consent",
        "submitted_via" AS "submission_method",
        "date_sent_to_company",
        "company_response_to_consumer" AS "resolution_type",
        "timely_response",
        "consumer_disputed",
        "complaint_id",
        "client_id"
    FROM "CRM_Events"
),

"CRM_Events_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- complaint_category: The complaint_category column has several issues: 1. 'Closing/Cancelling account' overlaps with 'Account opening, closing, or management'. 2. 'Other' and 'Other fee' are vague categories that don't provide specific information. 3. Some categories are very specific (e.g., 'Balance transfer fee') while others are broad (e.g., 'Billing disputes'). 4. There's inconsistency in naming conventions (e.g., 'APR or interest rate' vs 'Balance transfer fee'). To address these issues, we'll map overlapping categories together, replace vague categories with more specific ones where possible, and standardize naming conventions. 
    SELECT
        "date_received",
        "financial_product",
        "specific_product",
        CASE
            WHEN "complaint_category" = 'Closing/Cancelling account' THEN 'Account opening, closing, or management'
            WHEN "complaint_category" = 'Other' THEN 'Miscellaneous issues'
            WHEN "complaint_category" = 'Other fee' THEN 'Miscellaneous fee issues'
            WHEN "complaint_category" = 'APR or interest rate' THEN 'Interest rate issues'
            WHEN "complaint_category" = 'Customer service / Customer relations' THEN 'Customer service issues'
            WHEN "complaint_category" = 'Credit card protection / Debt protection' THEN 'Credit protection issues'
            WHEN "complaint_category" = 'Forbearance / Workout plans' THEN 'Repayment plans'
            WHEN "complaint_category" = 'Collection debt dispute' THEN 'Debt collection issues'
            ELSE "complaint_category"
        END AS "complaint_category",
        "complaint_subcategory",
        "complaint_details",
        "tags",
        "public_consent",
        "submission_method",
        "date_sent_to_company",
        "resolution_type",
        "timely_response",
        "consumer_disputed",
        "complaint_id",
        "client_id"
    FROM "CRM_Events_renamed"
),

"CRM_Events_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- complaint_details: from FLOAT to VARCHAR
    -- complaint_subcategory: from FLOAT to VARCHAR
    -- date_received: from VARCHAR to DATE
    -- date_sent_to_company: from VARCHAR to DATE
    -- public_consent: from FLOAT to VARCHAR
    SELECT
        "financial_product",
        "specific_product",
        "complaint_category",
        "tags",
        "submission_method",
        "resolution_type",
        "timely_response",
        "consumer_disputed",
        "complaint_id",
        "client_id",
        CAST("complaint_details" AS VARCHAR) AS "complaint_details",
        CAST("complaint_subcategory" AS VARCHAR) AS "complaint_subcategory",
        CAST("date_received" AS DATE) AS "date_received",
        CAST("date_sent_to_company" AS DATE) AS "date_sent_to_company",
        CAST("public_consent" AS VARCHAR) AS "public_consent"
    FROM "CRM_Events_renamed_cleaned"
),

"CRM_Events_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 5 columns with unacceptable missing values
    -- complaint_details has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- complaint_subcategory has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- consumer_disputed has 5.3 percent missing. Strategy: 🔄 Unchanged
    -- public_consent has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tags has 83.0 percent missing. Strategy: 🔄 Unchanged
    SELECT
        "financial_product",
        "specific_product",
        "complaint_category",
        "tags",
        "submission_method",
        "resolution_type",
        "timely_response",
        "consumer_disputed",
        "complaint_id",
        "client_id",
        "date_received",
        "date_sent_to_company"
    FROM "CRM_Events_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "CRM_Events_renamed_cleaned_casted_missing_handled"