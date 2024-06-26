-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"customer_demographics_renamed" AS (
    -- Rename: Renaming columns
    -- CD_DEMO_SK -> demographic_id
    -- CD_GENDER -> gender
    -- CD_MARITAL_STATUS -> marital_status
    -- CD_EDUCATION_STATUS -> education_level
    -- CD_PURCHASE_ESTIMATE -> purchase_estimate
    -- CD_CREDIT_RATING -> credit_rating
    -- CD_DEP_COUNT -> total_dependents
    -- CD_DEP_EMPLOYED_COUNT -> employed_dependents
    -- CD_DEP_COLLEGE_COUNT -> dependents_in_college
    SELECT 
        "CD_DEMO_SK" AS "demographic_id",
        "CD_GENDER" AS "gender",
        "CD_MARITAL_STATUS" AS "marital_status",
        "CD_EDUCATION_STATUS" AS "education_level",
        "CD_PURCHASE_ESTIMATE" AS "purchase_estimate",
        "CD_CREDIT_RATING" AS "credit_rating",
        "CD_DEP_COUNT" AS "total_dependents",
        "CD_DEP_EMPLOYED_COUNT" AS "employed_dependents",
        "CD_DEP_COLLEGE_COUNT" AS "dependents_in_college"
    FROM "customer_demographics"
),

"customer_demographics_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- education_level: ['Unknown']
    SELECT 
        CASE
            WHEN "education_level" = 'Unknown' THEN NULL
            ELSE "education_level"
        END AS "education_level",
        "employed_dependents",
        "gender",
        "total_dependents",
        "purchase_estimate",
        "marital_status",
        "credit_rating",
        "demographic_id",
        "dependents_in_college"
    FROM "customer_demographics_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "customer_demographics_renamed_null"