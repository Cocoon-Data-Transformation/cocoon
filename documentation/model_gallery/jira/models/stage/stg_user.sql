-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"user_projected" AS (
    -- Projection: Selecting 6 out of 7 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "email",
        "locale",
        "name",
        "time_zone",
        "username"
    FROM "user"
),

"user_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> user_id
    -- locale -> language_preference
    -- name -> full_name
    SELECT 
        "id" AS "user_id",
        "email",
        "locale" AS "language_preference",
        "name" AS "full_name",
        "time_zone",
        "username"
    FROM "user_projected"
),

"user_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- email: from DECIMAL to VARCHAR
    -- username: from DECIMAL to VARCHAR
    SELECT
        "user_id",
        "language_preference",
        "full_name",
        "time_zone",
        CAST("email" AS VARCHAR) AS "email",
        CAST("username" AS VARCHAR) AS "username"
    FROM "user_projected_renamed"
),

"user_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- email has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- username has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "user_id",
        "language_preference",
        "full_name",
        "time_zone"
    FROM "user_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "user_projected_renamed_casted_missing_handled"