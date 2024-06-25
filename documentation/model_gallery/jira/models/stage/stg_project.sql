-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"project_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "description",
        "key_",
        "lead_id",
        "name",
        "permission_scheme_id",
        "project_category_id",
        "project_type_key"
    FROM "project"
),

"project_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> project_id
    -- description -> project_description
    -- key_ -> project_key
    -- name -> project_name
    -- project_category_id -> category_id
    -- project_type_key -> project_type
    SELECT 
        "id" AS "project_id",
        "description" AS "project_description",
        "key_" AS "project_key",
        "lead_id",
        "name" AS "project_name",
        "permission_scheme_id",
        "project_category_id" AS "category_id",
        "project_type_key" AS "project_type"
    FROM "project_projected"
),

"project_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- project_name: The problem is inconsistent capitalization and specificity in project names. "Test Project" is capitalized and generic, while "test bug tracking project" and "test classique project" are lowercase and more specific. The most frequent and generic form is "Test Project", which should be used for consistency. 
    SELECT
        "project_id",
        "project_description",
        "project_key",
        "lead_id",
        CASE
            WHEN "project_name" = 'test bug tracking project' THEN 'Test Project'
            WHEN "project_name" = 'test classique project' THEN 'Test Project'
            ELSE "project_name"
        END AS "project_name",
        "permission_scheme_id",
        "category_id",
        "project_type"
    FROM "project_projected_renamed"
),

"project_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- category_id: from DECIMAL to VARCHAR
    -- lead_id: from VARCHAR to UUID
    -- project_description: from DECIMAL to VARCHAR
    SELECT
        "project_id",
        "project_key",
        "project_name",
        "permission_scheme_id",
        "project_type",
        CAST("category_id" AS VARCHAR) AS "category_id",
        CASE 
            WHEN "lead_id" ~ ':[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
            THEN CAST(REGEXP_EXTRACT("lead_id", '([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})$') AS UUID)
            ELSE TRY_CAST("lead_id" AS UUID)
        END AS "lead_id",
        CAST("project_description" AS VARCHAR) AS "project_description"
    FROM "project_projected_renamed_cleaned"
),

"project_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- lead_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- project_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "project_id",
        "project_key",
        "project_name",
        "permission_scheme_id",
        "project_type",
        "category_id"
    FROM "project_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "project_projected_renamed_cleaned_casted_missing_handled"