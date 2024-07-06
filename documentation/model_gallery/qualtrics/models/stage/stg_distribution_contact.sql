-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-05 22:46:51.239370+00:00
WITH 
"distribution_contact_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "contact_id",
        "distribution_id",
        "contact_frequency_rule_id",
        "contact_lookup_id",
        "opened_at",
        "response_completed_at",
        "response_id",
        "response_started_at",
        "sent_at",
        "status",
        "survey_link",
        "survey_session_id"
    FROM "memory"."main"."distribution_contact"
),

"distribution_contact_projected_renamed" AS (
    -- Rename: Renaming columns
    -- opened_at -> survey_opened_at
    -- sent_at -> survey_sent_at
    -- status -> survey_status
    SELECT 
        "contact_id",
        "distribution_id",
        "contact_frequency_rule_id",
        "contact_lookup_id",
        "opened_at" AS "survey_opened_at",
        "response_completed_at",
        "response_id",
        "response_started_at",
        "sent_at" AS "survey_sent_at",
        "status" AS "survey_status",
        "survey_link",
        "survey_session_id"
    FROM "distribution_contact_projected"
),

"distribution_contact_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- contact_frequency_rule_id: from DECIMAL to VARCHAR
    -- response_completed_at: from DECIMAL to TIMESTAMP
    -- response_id: from DECIMAL to VARCHAR
    -- response_started_at: from DECIMAL to TIMESTAMP
    -- survey_opened_at: from VARCHAR to TIMESTAMP
    -- survey_sent_at: from VARCHAR to TIMESTAMP
    -- survey_session_id: from DECIMAL to VARCHAR
    SELECT
        "contact_id",
        "distribution_id",
        "contact_lookup_id",
        "survey_status",
        "survey_link",
        CAST("contact_frequency_rule_id" AS VARCHAR) AS "contact_frequency_rule_id",
        CAST("response_completed_at" AS TIMESTAMP) AS "response_completed_at",
        CAST("response_id" AS VARCHAR) AS "response_id",
        CAST("response_started_at" AS TIMESTAMP) AS "response_started_at",
        CAST("survey_opened_at" AS TIMESTAMP) AS "survey_opened_at",
        CAST("survey_sent_at" AS TIMESTAMP) AS "survey_sent_at",
        CAST("survey_session_id" AS VARCHAR) AS "survey_session_id"
    FROM "distribution_contact_projected_renamed"
),

"distribution_contact_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- contact_frequency_rule_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- survey_opened_at has 20.0 percent missing. Strategy: 🔄 Unchanged
    -- survey_session_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "contact_id",
        "distribution_id",
        "contact_lookup_id",
        "survey_status",
        "survey_link",
        "response_completed_at",
        "response_id",
        "response_started_at",
        "survey_opened_at",
        "survey_sent_at"
    FROM "distribution_contact_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "distribution_contact_projected_renamed_casted_missing_handled"