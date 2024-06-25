-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"issue_type_projected" AS (
    -- Projection: Selecting 4 out of 5 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "description",
        "name",
        "subtask"
    FROM "issue_type"
),

"issue_type_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> issue_type_id
    -- description -> issue_description
    -- name -> issue_type
    -- subtask -> is_subtask
    SELECT 
        "id" AS "issue_type_id",
        "description" AS "issue_description",
        "name" AS "issue_type",
        "subtask" AS "is_subtask"
    FROM "issue_type_projected"
),

"issue_type_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- issue_description: The problem is that 'A problem or error.' and 'Bugs track problems or errors.' are redundant representations of the same concept. They both refer to issues or bugs in a system. The correct values should be distinct and represent different types of issues. 'Track large pieces of work.' is a distinct value and doesn't need to be changed. 
    SELECT
        "issue_type_id",
        CASE
            WHEN "issue_description" = 'Bugs track problems or errors.' THEN 'A problem or error.'
            ELSE "issue_description"
        END AS "issue_description",
        "issue_type",
        "is_subtask"
    FROM "issue_type_projected_renamed"
),

"issue_type_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- issue_type_id: from INT to VARCHAR
    SELECT
        "issue_description",
        "issue_type",
        "is_subtask",
        CAST("issue_type_id" AS VARCHAR) AS "issue_type_id"
    FROM "issue_type_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "issue_type_projected_renamed_cleaned_casted"