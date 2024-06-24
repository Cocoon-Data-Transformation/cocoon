-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sales_account_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "name"
    FROM "sales_account"
),

"sales_account_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> account_id
    -- name -> account_name
    SELECT 
        id AS account_id,
        name AS account_name
    FROM sales_account_projected
),

"sales_account_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_id: from INT to VARCHAR
    SELECT
        "account_name",
        CAST("account_id" AS VARCHAR) AS "account_id"
    FROM "sales_account_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "sales_account_projected_renamed_casted"