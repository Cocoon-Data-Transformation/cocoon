-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"field_option_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "name"
    FROM "field_option"
),

"field_option_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> field_id
    -- name -> option_name
    SELECT 
        "id" AS "field_id",
        "name" AS "option_name"
    FROM "field_option_projected"
),

"field_option_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- option_name: The problem is that the option_name column contains inconsistent values. 'This is the summary of the issue.' is a full sentence among shorter labels, which is unusual. 'opt 2' and 'opt 4' are inconsistently named compared to the other options. The correct values should be concise labels that describe the option or status. 'Impediment' and 'To Do' are already in the correct format. 
    SELECT
        "field_id",
        CASE
            WHEN "option_name" = 'This is the summary of the issue.' THEN 'Summary'
            WHEN "option_name" = 'opt 2' THEN 'Option 2'
            WHEN "option_name" = 'opt 4' THEN 'Option 4'
            ELSE "option_name"
        END AS "option_name"
    FROM "field_option_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "field_option_projected_renamed_cleaned"