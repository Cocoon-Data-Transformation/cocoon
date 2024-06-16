-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"german_credit_data_renamed" AS (
    -- Rename: Renaming columns
    -- checking_status -> checking_account_status
    -- duration -> credit_duration_months
    -- purpose -> credit_purpose
    -- savings_status -> savings_account_status
    -- employment -> employment_length_years
    -- installment_commitment -> installment_rate_percentage
    -- personal_status -> personal_status_sex
    -- other_parties -> other_parties_involved
    -- residence_since -> residence_length_years
    -- other_payment_plans -> has_other_payment_plans
    -- housing -> housing_situation
    -- existing_credits -> num_existing_credits
    -- job -> job_qualification
    -- own_telephone -> has_telephone
    -- foreign_worker -> is_foreign_worker
    -- class -> credit_risk_class
    SELECT 
        "checking_status" AS "checking_account_status",
        "duration" AS "credit_duration_months",
        "credit_history",
        "purpose" AS "credit_purpose",
        "credit_amount",
        "savings_status" AS "savings_account_status",
        "employment" AS "employment_length_years",
        "installment_commitment" AS "installment_rate_percentage",
        "personal_status" AS "personal_status_sex",
        "other_parties" AS "other_parties_involved",
        "residence_since" AS "residence_length_years",
        "property_magnitude",
        "age",
        "other_payment_plans" AS "has_other_payment_plans",
        "housing" AS "housing_situation",
        "existing_credits" AS "num_existing_credits",
        "job" AS "job_qualification",
        "num_dependents",
        "own_telephone" AS "has_telephone",
        "foreign_worker" AS "is_foreign_worker",
        "class" AS "credit_risk_class"
    FROM "german_credit_data"
),

"german_credit_data_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- personal_status_sex: The problem is the abbreviations 'div/dep/mar' and 'div/sep' are inconsistent and unclear. 'div/dep/mar' likely means divorced, departed, or married. 'div/sep' likely means divorced or separated. The values should be expanded to full words for clarity. Since the statuses for males are fully written out, we'll map the female value to match that pattern. We'll also assume 'departed' means 'widowed' to match 'mar/wid'. 
    SELECT
        "checking_account_status",
        "credit_duration_months",
        "credit_history",
        "credit_purpose",
        "credit_amount",
        "savings_account_status",
        "employment_length_years",
        "installment_rate_percentage",
        CASE
            WHEN "personal_status_sex" = 'female div/dep/mar' THEN 'female divorced/widowed/married'
            WHEN "personal_status_sex" = 'male mar/wid' THEN 'male married/widowed'
            WHEN "personal_status_sex" = 'male div/sep' THEN 'male divorced/separated'
            ELSE "personal_status_sex"
        END AS "personal_status_sex",
        "other_parties_involved",
        "residence_length_years",
        "property_magnitude",
        "age",
        "has_other_payment_plans",
        "housing_situation",
        "num_existing_credits",
        "job_qualification",
        "num_dependents",
        "has_telephone",
        "is_foreign_worker",
        "credit_risk_class"
    FROM "german_credit_data_renamed"
),

"german_credit_data_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- savings_account_status: ['no known savings']
    -- property_magnitude: ['no known property']
    -- has_telephone: ['none']
    SELECT 
        CASE
            WHEN "savings_account_status" = 'no known savings' THEN NULL
            ELSE "savings_account_status"
        END AS "savings_account_status",
        CASE
            WHEN "property_magnitude" = 'no known property' THEN NULL
            ELSE "property_magnitude"
        END AS "property_magnitude",
        CASE
            WHEN "has_telephone" = 'none' THEN NULL
            ELSE "has_telephone"
        END AS "has_telephone",
        "credit_risk_class",
        "is_foreign_worker",
        "checking_account_status",
        "credit_duration_months",
        "personal_status_sex",
        "job_qualification",
        "housing_situation",
        "credit_history",
        "credit_purpose",
        "credit_amount",
        "installment_rate_percentage",
        "employment_length_years",
        "num_existing_credits",
        "num_dependents",
        "other_parties_involved",
        "has_other_payment_plans",
        "age",
        "residence_length_years"
    FROM "german_credit_data_renamed_cleaned"
),

"german_credit_data_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- is_foreign_worker: from VARCHAR to BOOLEAN
    SELECT
        "savings_account_status",
        "property_magnitude",
        "has_telephone",
        "credit_risk_class",
        "checking_account_status",
        "credit_duration_months",
        "personal_status_sex",
        "job_qualification",
        "housing_situation",
        "credit_history",
        "credit_purpose",
        "credit_amount",
        "installment_rate_percentage",
        "employment_length_years",
        "num_existing_credits",
        "num_dependents",
        "other_parties_involved",
        "has_other_payment_plans",
        "age",
        "residence_length_years",
        CAST(CASE WHEN "is_foreign_worker" = 'yes' THEN TRUE ELSE FALSE END AS BOOLEAN) AS "is_foreign_worker"
    FROM "german_credit_data_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "german_credit_data_renamed_cleaned_null_casted"