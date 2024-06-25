-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"company_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> company_id
    SELECT 
        id AS company_id,
        is_deleted
    FROM company_data
),

"company_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- company_id: from INT to VARCHAR
    SELECT
        "is_deleted",
        CAST("company_id" AS VARCHAR) AS "company_id"
    FROM "company_data_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "company_data_renamed_casted"