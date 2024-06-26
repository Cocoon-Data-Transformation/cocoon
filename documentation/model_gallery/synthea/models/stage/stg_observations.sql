-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"observations_renamed" AS (
    -- Rename: Renaming columns
    -- DATE_ -> observation_date
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CATEGORY -> category
    -- CODE -> measurement_code
    -- DESCRIPTION -> measurement_description
    -- VALUE_ -> measurement_value
    -- UNITS -> measurement_unit
    -- TYPE -> value_type
    SELECT 
        "DATE_" AS "observation_date",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CATEGORY" AS "category",
        "CODE" AS "measurement_code",
        "DESCRIPTION" AS "measurement_description",
        "VALUE_" AS "measurement_value",
        "UNITS" AS "measurement_unit",
        "TYPE" AS "value_type"
    FROM "observations"
),

"observations_renamed_dedup" AS (
    -- Deduplication: Removed 556 duplicated rows
    SELECT DISTINCT * FROM "observations_renamed"
),

"observations_renamed_dedup_cleaned" AS (
    -- Clean unusual string values: 
    -- measurement_value: Inconsistent number formats ('1.0' vs '1'), and mixing of boolean ('Yes'/'No') with numerical ('0.0'/'1.0') representations.
    -- measurement_unit: The problem is that some values in the measurement_unit column do not represent standard measurement units. Specifically, '{score}', '{nominal}', 'a', '/a', '{#}', '{INR}', '{presence}', '{SG}', and '{T-score}' are not standard units but rather indicate the type of measurement or scoring system used. These should be mapped to more appropriate representations or left empty if they don't correspond to a specific unit. The correct values should use standard unit notation where applicable, and non-unit indicators should be removed or clarified. 
    SELECT
        "observation_date",
        "patient_id",
        "encounter_id",
        "category",
        "measurement_code",
        "measurement_description",
        "measurement_value",
        CASE
            WHEN "measurement_unit" = '{score}' THEN ''
            WHEN "measurement_unit" = '{nominal}' THEN ''
            WHEN "measurement_unit" = 'a' THEN ''
            WHEN "measurement_unit" = '/a' THEN ''
            WHEN "measurement_unit" = '{#}' THEN ''
            WHEN "measurement_unit" = '{INR}' THEN 'INR'
            WHEN "measurement_unit" = '{presence}' THEN ''
            WHEN "measurement_unit" = '{SG}' THEN ''
            WHEN "measurement_unit" = '{T-score}' THEN ''
            WHEN "measurement_unit" = 'Cel' THEN '°C'
            WHEN "measurement_unit" = '[pH]' THEN 'pH'
            WHEN "measurement_unit" = '[degF]' THEN '°F'
            WHEN "measurement_unit" = 'm[IU]/L' THEN 'mIU/L'
            WHEN "measurement_unit" = 'mm[Hg]' THEN 'mmHg'
            WHEN "measurement_unit" = '10*3/uL' THEN '10³/µL'
            WHEN "measurement_unit" = '10*6/uL' THEN '10⁶/µL'
            ELSE "measurement_unit"
        END AS "measurement_unit",
        "value_type"
    FROM "observations_renamed_dedup"
),

"observations_renamed_dedup_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- measurement_unit: ['']
    SELECT 
        CASE
            WHEN "measurement_unit" = '' THEN NULL
            ELSE "measurement_unit"
        END AS "measurement_unit",
        "category",
        "observation_date",
        "patient_id",
        "encounter_id",
        "value_type",
        "measurement_code",
        "measurement_description",
        "measurement_value"
    FROM "observations_renamed_dedup_cleaned"
),

"observations_renamed_dedup_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- measurement_value: from VARCHAR to DECIMAL
    -- observation_date: from VARCHAR to TIMESTAMP
    -- patient_id: from VARCHAR to UUID
    SELECT
        "measurement_unit",
        "category",
        "value_type",
        "measurement_code",
        "measurement_description",
        CAST("encounter_id" AS UUID) AS "encounter_id",
        CASE
            WHEN regexp_full_match("measurement_value", '^\d+(\.\d+)?$') THEN CAST("measurement_value" AS DECIMAL)
            WHEN regexp_full_match("measurement_value", '^(Yes|No)$') THEN CAST(CASE WHEN "measurement_value" = 'Yes' THEN 1 ELSE 0 END AS DECIMAL)
            WHEN regexp_full_match("measurement_value", '^Never smoked tobacco \(finding\)$') THEN CAST(NULL AS DECIMAL)
            WHEN regexp_full_match("measurement_value", '^Ex-smoker \(finding\)$') THEN "measurement_value"
            WHEN regexp_full_match("measurement_value", '^Urine .+ (test|finding).*$') THEN CASE 
            WHEN "measurement_value" LIKE '%++%' THEN 2
            WHEN "measurement_value" LIKE '%+%' THEN 1
            WHEN "measurement_value" LIKE '%negative%' THEN 0
            ELSE NULL
        END
            WHEN regexp_full_match("measurement_value", '^(3 to 5 times a week|5 or more times a week)$') THEN CASE 
            WHEN "measurement_value" = '3 to 5 times a week' THEN 4
            WHEN "measurement_value" = '5 or more times a week' THEN 5
            ELSE NULL
        END
            WHEN regexp_full_match("measurement_value", '^(More than high school|High school diploma or GED)$') THEN CASE 
            WHEN "measurement_value" = 'More than high school' THEN 2
            WHEN "measurement_value" = 'High school diploma or GED' THEN 1
            ELSE NULL
        END
            WHEN regexp_full_match("measurement_value", '^(Private insurance|Medicare|Medicaid)$') THEN "measurement_value"
            WHEN regexp_full_match("measurement_value", '^(Full-time work|Part-time or temporary work)$') THEN "measurement_value"
            WHEN regexp_full_match("measurement_value", '^I have housing$') THEN CAST(NULL AS DECIMAL)
            WHEN regexp_full_match("measurement_value", '^White$') THEN CAST(CASE WHEN "measurement_value" = 'White' THEN NULL ELSE "measurement_value" END AS DECIMAL)
            WHEN regexp_full_match("measurement_value", '^(English|Language other than English)$') THEN CAST(CASE 
            WHEN "measurement_value" = 'English' THEN '1' 
            WHEN "measurement_value" = 'Language other than English' THEN '2'
            ELSE NULL 
        END AS DECIMAL)
            WHEN regexp_full_match("measurement_value", '^(Not at all|A little bit|Somewhat)$') THEN CAST(
          CASE 
            WHEN "measurement_value" = 'Not at all' THEN '0'
            WHEN "measurement_value" = 'A little bit' THEN '1'
            WHEN "measurement_value" = 'Somewhat' THEN '2'
            ELSE NULL
          END 
        AS DECIMAL)
            WHEN regexp_full_match("measurement_value", '^I choose not to answer this question$') THEN CAST(CASE WHEN "measurement_value" = 'I choose not to answer this question' THEN NULL ELSE "measurement_value" END AS DECIMAL)
            ELSE "measurement_value"
        END AS "measurement_value",
        CAST("observation_date" AS TIMESTAMP) AS "observation_date",
        CAST("patient_id" AS UUID) AS "patient_id"
    FROM "observations_renamed_dedup_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "observations_renamed_dedup_cleaned_null_casted"