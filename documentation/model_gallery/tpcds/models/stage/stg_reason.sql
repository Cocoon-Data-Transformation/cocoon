-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"reason_renamed" AS (
    -- Rename: Renaming columns
    -- R_REASON_SK -> reason_surrogate_key
    -- R_REASON_ID -> reason_id
    -- R_REASON_DESC -> reason_description
    SELECT 
        "R_REASON_SK" AS "reason_surrogate_key",
        "R_REASON_ID" AS "reason_id",
        "R_REASON_DESC" AS "reason_description"
    FROM "reason"
)

-- COCOON BLOCK END
SELECT * FROM "reason_renamed"