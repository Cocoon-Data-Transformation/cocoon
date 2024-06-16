-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"aac_shelter_cat_outcome_eng_renamed" AS (
    -- Rename: Renaming columns
    -- color -> color_description
    -- datetime -> outcome_datetime
    -- monthyear -> outcome_month_year
    -- name -> animal_name
    -- sex_upon_outcome -> cat_sex_upon_outcome
    -- count_ -> record_count
    -- sex -> cat_sex
    -- Spay_Neuter -> spay_neuter_status
    -- Periods -> outcome_periods
    -- Period_Range -> outcome_period_range
    -- outcome_age__days_ -> outcome_age_days
    -- outcome_age__years_ -> outcome_age_years
    -- Cat_Kitten__outcome_ -> outcome_animal_category
    -- sex_age_outcome -> cat_sex_age_outcome
    -- age_group -> age_group_bucket
    -- dob_year -> birth_year
    -- dob_month -> birth_month
    -- dob_monthyear -> birth_month_year
    -- breed1 -> primary_breed
    -- breed2 -> secondary_breed
    -- cfa_breed -> cfa_breed_status
    -- domestic_breed -> is_domestic_breed
    -- color1 -> primary_color
    -- color2 -> secondary_color
    -- coat -> coat_color
    SELECT 
        "age_upon_outcome",
        "animal_id",
        "animal_type",
        "breed",
        "color" AS "color_description",
        "date_of_birth",
        "datetime" AS "outcome_datetime",
        "monthyear" AS "outcome_month_year",
        "name" AS "animal_name",
        "outcome_subtype",
        "outcome_type",
        "sex_upon_outcome" AS "cat_sex_upon_outcome",
        "count_" AS "record_count",
        "sex" AS "cat_sex",
        "Spay_Neuter" AS "spay_neuter_status",
        "Periods" AS "outcome_periods",
        "Period_Range" AS "outcome_period_range",
        "outcome_age__days_" AS "outcome_age_days",
        "outcome_age__years_" AS "outcome_age_years",
        "Cat_Kitten__outcome_" AS "outcome_animal_category",
        "sex_age_outcome" AS "cat_sex_age_outcome",
        "age_group" AS "age_group_bucket",
        "dob_year" AS "birth_year",
        "dob_month" AS "birth_month",
        "dob_monthyear" AS "birth_month_year",
        "outcome_month",
        "outcome_year",
        "outcome_weekday",
        "outcome_hour",
        "breed1" AS "primary_breed",
        "breed2" AS "secondary_breed",
        "cfa_breed" AS "cfa_breed_status",
        "domestic_breed" AS "is_domestic_breed",
        "coat_pattern",
        "color1" AS "primary_color",
        "color2" AS "secondary_color",
        "coat" AS "coat_color"
    FROM "aac_shelter_cat_outcome_eng"
),

"aac_shelter_cat_outcome_eng_renamed_dedup" AS (
    -- Deduplication: Removed 7 duplicated rows
    SELECT DISTINCT * FROM "aac_shelter_cat_outcome_eng_renamed"
),

"aac_shelter_cat_outcome_eng_renamed_dedup_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "age_upon_outcome",
        "animal_id",
        "animal_type",
        "breed",
        "color_description",
        "date_of_birth",
        "outcome_datetime",
        "outcome_month_year",
        "animal_name",
        "outcome_subtype",
        "outcome_type",
        "cat_sex_upon_outcome",
        "record_count",
        "cat_sex",
        "spay_neuter_status",
        "outcome_periods",
        "outcome_period_range",
        "outcome_age_days",
        "outcome_age_years",
        "outcome_animal_category",
        "cat_sex_age_outcome",
        "age_group_bucket",
        "birth_year",
        "birth_month",
        "birth_month_year",
        "outcome_month",
        "outcome_year",
        "outcome_weekday",
        "outcome_hour",
        "primary_breed",
        "secondary_breed",
        "cfa_breed_status",
        "is_domestic_breed",
        "coat_pattern",
        "secondary_color",
        TRIM("primary_color") AS "primary_color",
        TRIM("coat_color") AS "coat_color"
    FROM "aac_shelter_cat_outcome_eng_renamed_dedup"
),

"aac_shelter_cat_outcome_eng_renamed_dedup_trimmed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- animal_name: ['X']
    -- outcome_type: ['Missing']
    -- cat_sex_upon_outcome: ['Unknown']
    -- cat_sex_age_outcome: ['Unknown Kitten', 'Unknown Cat']
    -- primary_color: ['Breed Specific']
    SELECT 
        CASE
            WHEN "animal_name" = 'X' THEN NULL
            ELSE "animal_name"
        END AS "animal_name",
        CASE
            WHEN "outcome_type" = 'Missing' THEN NULL
            ELSE "outcome_type"
        END AS "outcome_type",
        CASE
            WHEN "cat_sex_upon_outcome" = 'Unknown' THEN NULL
            ELSE "cat_sex_upon_outcome"
        END AS "cat_sex_upon_outcome",
        CASE
            WHEN "cat_sex_age_outcome" = 'Unknown Kitten' THEN NULL
            WHEN "cat_sex_age_outcome" = 'Unknown Cat' THEN NULL
            ELSE "cat_sex_age_outcome"
        END AS "cat_sex_age_outcome",
        CASE
            WHEN "primary_color" = 'Breed Specific' THEN NULL
            ELSE "primary_color"
        END AS "primary_color",
        "outcome_month_year",
        "breed",
        "spay_neuter_status",
        "color_description",
        "outcome_subtype",
        "outcome_age_years",
        "birth_year",
        "outcome_weekday",
        "birth_month",
        "outcome_period_range",
        "birth_month_year",
        "secondary_breed",
        "animal_id",
        "record_count",
        "outcome_age_days",
        "outcome_periods",
        "date_of_birth",
        "outcome_hour",
        "coat_color",
        "coat_pattern",
        "secondary_color",
        "age_upon_outcome",
        "animal_type",
        "outcome_year",
        "age_group_bucket",
        "outcome_datetime",
        "outcome_animal_category",
        "primary_breed",
        "cat_sex",
        "is_domestic_breed",
        "outcome_month",
        "cfa_breed_status"
    FROM "aac_shelter_cat_outcome_eng_renamed_dedup_trimmed"
),

"aac_shelter_cat_outcome_eng_renamed_dedup_trimmed_null_casted" AS (
    -- Column Type Casting: 
    -- birth_month_year: from VARCHAR to DATE
    -- date_of_birth: from VARCHAR to TIMESTAMP
    -- outcome_datetime: from VARCHAR to TIMESTAMP
    -- outcome_month_year: from VARCHAR to DATE
    -- outcome_period_range: from INT to VARCHAR
    SELECT
        "animal_name",
        "outcome_type",
        "cat_sex_upon_outcome",
        "cat_sex_age_outcome",
        "primary_color",
        "breed",
        "spay_neuter_status",
        "color_description",
        "outcome_subtype",
        "outcome_age_years",
        "birth_year",
        "outcome_weekday",
        "birth_month",
        "secondary_breed",
        "animal_id",
        "record_count",
        "outcome_age_days",
        "outcome_periods",
        "outcome_hour",
        "coat_color",
        "coat_pattern",
        "secondary_color",
        "age_upon_outcome",
        "animal_type",
        "outcome_year",
        "age_group_bucket",
        "outcome_animal_category",
        "primary_breed",
        "cat_sex",
        "is_domestic_breed",
        "outcome_month",
        "cfa_breed_status",
        TO_DATE("birth_month_year" || '-01', 'YYYY-MM-DD') AS "birth_month_year",
        CAST("date_of_birth" AS TIMESTAMP) AS "date_of_birth",
        CAST("outcome_datetime" AS TIMESTAMP) AS "outcome_datetime",
        CAST("outcome_month_year" AS DATE) AS "outcome_month_year",
        CAST("outcome_period_range" AS VARCHAR) AS "outcome_period_range"
    FROM "aac_shelter_cat_outcome_eng_renamed_dedup_trimmed_null"
)

-- COCOON BLOCK END
SELECT * FROM "aac_shelter_cat_outcome_eng_renamed_dedup_trimmed_null_casted"