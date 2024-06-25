-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"project_category_projected" AS (
    -- Projection: Selecting 3 out of 4 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "description",
        "name"
    FROM "project_category"
),

"project_category_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> category_id
    -- description -> category_description
    -- name -> category_name
    SELECT 
        "id" AS "category_id",
        "description" AS "category_description",
        "name" AS "category_name"
    FROM "project_category_projected"
),

"project_category_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- category_description: The problem is that the category_description column contains a question about database structure instead of an actual category description. This is completely inappropriate for a category description field. The correct value should be an empty string or NULL, as we don't have the actual category description information. 
    -- category_name: The problem is that 'test-category' appears to be a placeholder value rather than a genuine category name. It's likely used as a temporary or default value during testing or development, and doesn't represent an actual product category. In a real dataset, we would expect to see meaningful category names that describe the types of products being sold. 
    SELECT
        "category_id",
        CASE
            WHEN "category_description" = 'will this create a project_category table?' THEN ''
            ELSE "category_description"
        END AS "category_description",
        CASE
            WHEN "category_name" = 'test-category' THEN ''
            ELSE "category_name"
        END AS "category_name"
    FROM "project_category_projected_renamed"
),

"project_category_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- category_description: ['']
    -- category_name: ['']
    SELECT 
        CASE
            WHEN "category_description" = '' THEN NULL
            ELSE "category_description"
        END AS "category_description",
        CASE
            WHEN "category_name" = '' THEN NULL
            ELSE "category_name"
        END AS "category_name",
        "category_id"
    FROM "project_category_projected_renamed_cleaned"
),

"project_category_projected_renamed_cleaned_null_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- category_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- category_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "category_id"
    FROM "project_category_projected_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "project_category_projected_renamed_cleaned_null_missing_handled"