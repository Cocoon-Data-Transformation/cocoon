-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"deal_company_data_renamed" AS (
    -- Rename: Renaming columns
    -- type_id -> deal_type_id
    SELECT 
        "company_id",
        "deal_id",
        "type_id" AS "deal_type_id"
    FROM "deal_company_data"
)

-- COCOON BLOCK END
SELECT * FROM "deal_company_data_renamed"