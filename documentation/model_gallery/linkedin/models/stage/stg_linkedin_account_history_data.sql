-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"linkedin_account_history_data_renamed" AS (
    -- Rename: Renaming columns
    -- id -> account_id
    -- last_modified_time -> last_update_time
    -- created_time -> account_creation_time
    -- name -> encrypted_account_name
    -- currency -> account_currency
    -- version_tag -> revision_number
    SELECT 
        "id" AS "account_id",
        "last_modified_time" AS "last_update_time",
        "created_time" AS "account_creation_time",
        "name" AS "encrypted_account_name",
        "currency" AS "account_currency",
        "version_tag" AS "revision_number"
    FROM "linkedin_account_history_data"
),

"linkedin_account_history_data_renamed_casted" AS (
    -- Column Type Casting: 
    -- account_creation_time: from VARCHAR to TIMESTAMP
    -- last_update_time: from VARCHAR to TIMESTAMP
    SELECT
        "account_id",
        "encrypted_account_name",
        "account_currency",
        "revision_number",
        CAST("account_creation_time" AS TIMESTAMP) AS "account_creation_time",
        CAST("last_update_time" AS TIMESTAMP) AS "last_update_time"
    FROM "linkedin_account_history_data_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "linkedin_account_history_data_renamed_casted"