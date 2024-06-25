-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"contact_data_projected" AS (
    -- Projection: Selecting 12 out of 13 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_deleted",
        "property_email",
        "id",
        "property_company",
        "property_firstname",
        "property_lastname",
        "property_email_1",
        "property_createdate",
        "property_jobtitle",
        "property_annualrevenue",
        "property_hs_calculated_merged_vids",
        "property_created_at"
    FROM "contact_data"
),

"contact_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_deleted -> is_deleted
    -- property_email -> primary_email_hash
    -- id -> contact_id
    -- property_company -> company_name
    -- property_firstname -> first_name_hash
    -- property_lastname -> last_name_hash
    -- property_email_1 -> secondary_email_hash
    -- property_createdate -> create_date
    -- property_jobtitle -> job_title
    -- property_annualrevenue -> annual_revenue
    -- property_hs_calculated_merged_vids -> merged_contact_ids
    -- property_created_at -> created_at
    SELECT 
        _fivetran_deleted AS is_deleted,
        property_email AS primary_email_hash,
        id AS contact_id,
        property_company AS company_name,
        property_firstname AS first_name_hash,
        property_lastname AS last_name_hash,
        property_email_1 AS secondary_email_hash,
        property_createdate AS create_date,
        property_jobtitle AS job_title,
        property_annualrevenue AS annual_revenue,
        property_hs_calculated_merged_vids AS merged_contact_ids,
        property_created_at AS created_at
    FROM contact_data_projected
),

"contact_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- contact_id: from INT to VARCHAR
    -- create_date: from VARCHAR to TIMESTAMP
    -- created_at: from VARCHAR to TIMESTAMP
    -- job_title: from DECIMAL to VARCHAR
    SELECT
        "is_deleted",
        "primary_email_hash",
        "company_name",
        "first_name_hash",
        "last_name_hash",
        "secondary_email_hash",
        "annual_revenue",
        "merged_contact_ids",
        CAST("contact_id" AS VARCHAR) AS "contact_id",
        CAST("create_date" AS TIMESTAMP) AS "create_date",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("job_title" AS VARCHAR) AS "job_title"
    FROM "contact_data_projected_renamed"
),

"contact_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- company_name has 95.45 percent missing. Strategy: 🗑️ Drop Column
    -- job_title has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "is_deleted",
        "primary_email_hash",
        "first_name_hash",
        "last_name_hash",
        "secondary_email_hash",
        "annual_revenue",
        "merged_contact_ids",
        "contact_id",
        "create_date",
        "created_at"
    FROM "contact_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "contact_data_projected_renamed_casted_missing_handled"