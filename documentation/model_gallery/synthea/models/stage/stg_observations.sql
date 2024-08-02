-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:25:51.682407+00:00
WITH 
"observations_renamed" AS (
    -- Rename: Renaming columns
    -- DATE_ -> observation_datetime
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CATEGORY -> observation_category
    -- CODE -> observation_code
    -- DESCRIPTION -> observation_description
    -- VALUE_ -> observation_value
    -- TYPE -> value_type
    SELECT 
        "DATE_" AS "observation_datetime",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CATEGORY" AS "observation_category",
        "CODE" AS "observation_code",
        "DESCRIPTION" AS "observation_description",
        "VALUE_" AS "observation_value",
        "UNITS",
        "TYPE" AS "value_type"
    FROM "memory"."main"."observations"
),

"observations_renamed_dedup" AS (
    -- Deduplication: Removed 556 duplicated rows
    SELECT DISTINCT *
    FROM "observations_renamed"
),

"observations_renamed_dedup_cleaned" AS (
    -- Clean unusual string values: 
    -- observation_value: Numeric values are inconsistently represented as strings ('1.0') and floats (14.0). Boolean concepts use 'Yes'/'No' and '1.0'/'0.0'.
    -- UNITS: The problem is that some values in the UNITS column are inconsistent or unclear. '{score}', '{nominal}', and '{#}' are not standard unit representations and should be replaced with more specific units or left empty if no appropriate unit exists. 'a' and '/a' are likely inconsistent representations of 'year'. Other values like '{INR}', '{presence}', '{SG}', and '{T-score}' use curly braces inconsistently and should be standardized. The correct values should use consistent formatting and clear, standard unit representations where possible.
    SELECT
        "observation_datetime",
        "patient_id",
        "encounter_id",
        "observation_category",
        "observation_code",
        "observation_description",
        "observation_value",
        CASE
            WHEN "UNITS" = '{score}' THEN NULL
            WHEN "UNITS" = '{nominal}' THEN NULL
            WHEN "UNITS" = '{#}' THEN NULL
            WHEN "UNITS" = 'a' THEN 'year'
            WHEN "UNITS" = '/a' THEN 'year'
            WHEN "UNITS" = '{INR}' THEN 'INR'
            WHEN "UNITS" = '{presence}' THEN NULL
            WHEN "UNITS" = '{SG}' THEN 'SG'
            WHEN "UNITS" = '{T-score}' THEN 'T-score'
            WHEN "UNITS" = '[pH]' THEN 'pH'
            WHEN "UNITS" = '[degF]' THEN '°F'
            WHEN "UNITS" = '{1.73_m2}' THEN '1.73 m²'
            ELSE "UNITS"
        END AS "UNITS",
        "value_type"
    FROM "observations_renamed_dedup"
),

"observations_renamed_dedup_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- observation_datetime: from VARCHAR to TIMESTAMP
    -- patient_id: from VARCHAR to UUID
    SELECT
        "observation_category",
        "observation_code",
        "observation_description",
        "observation_value",
        "UNITS",
        "value_type",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("observation_datetime" AS TIMESTAMP) 
        AS "observation_datetime",
        CAST("patient_id" AS UUID) 
        AS "patient_id"
    FROM "observations_renamed_dedup_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "observations_renamed_dedup_cleaned_casted"