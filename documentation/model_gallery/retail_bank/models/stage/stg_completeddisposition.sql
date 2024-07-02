-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completeddisposition_renamed" AS (
    -- Rename: Renaming columns
    -- disp_id -> disposition_id
    -- type -> relationship_type
    SELECT 
        "disp_id" AS "disposition_id",
        "client_id",
        "account_id",
        "type" AS "relationship_type"
    FROM "completeddisposition"
)

-- COCOON BLOCK END
SELECT * FROM "completeddisposition_renamed"