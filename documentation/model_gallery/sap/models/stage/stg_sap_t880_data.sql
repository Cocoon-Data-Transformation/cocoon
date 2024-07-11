-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 14:57:07.957386+00:00
WITH 
"sap_t880_data_projected" AS (
    -- Projection: Selecting 23 out of 24 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "mandt",
        "rcomp",
        "name1",
        "cntry",
        "name2",
        "langu",
        "stret",
        "pobox",
        "pstlc",
        "city",
        "curr",
        "modcp",
        "glsip",
        "resta",
        "rform",
        "zweig",
        "mcomp",
        "mclnt",
        "lccomp",
        "strt2",
        "indpo",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_t880_data"
),

"sap_t880_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- mandt -> mandate_number
    -- rcomp -> company_code
    -- name1 -> company_name
    -- cntry -> country
    -- name2 -> company_name_secondary
    -- langu -> language_code
    -- stret -> street_address
    -- pobox -> po_box
    -- pstlc -> postal_code
    -- curr -> currency
    -- modcp -> model_company
    -- glsip -> global_site_id
    -- resta -> restaurant_code
    -- rform -> company_form
    -- zweig -> branch_code
    -- mcomp -> main_company_code
    -- mclnt -> main_client_code
    -- lccomp -> local_company_code
    -- strt2 -> street_address_secondary
    -- indpo -> industry_position
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "mandt" AS "mandate_number",
        "rcomp" AS "company_code",
        "name1" AS "company_name",
        "cntry" AS "country",
        "name2" AS "company_name_secondary",
        "langu" AS "language_code",
        "stret" AS "street_address",
        "pobox" AS "po_box",
        "pstlc" AS "postal_code",
        "city",
        "curr" AS "currency",
        "modcp" AS "model_company",
        "glsip" AS "global_site_id",
        "resta" AS "restaurant_code",
        "rform" AS "company_form",
        "zweig" AS "branch_code",
        "mcomp" AS "main_company_code",
        "mclnt" AS "main_client_code",
        "lccomp" AS "local_company_code",
        "strt2" AS "street_address_secondary",
        "indpo" AS "industry_position",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_t880_data_projected"
),

"sap_t880_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- language_code: The problem is that 'D' and 'E' are not standard language codes. Standard language codes typically use two letters (ISO 639-1) or three letters (ISO 639-2/3). 'D' likely stands for 'Deutsch' (German) and 'E' for 'English'. The correct values should be the ISO 639-1 codes for these languages. 
    SELECT
        "mandate_number",
        "company_code",
        "company_name",
        "country",
        "company_name_secondary",
        CASE
            WHEN "language_code" = '''D''' THEN '''de'''
            WHEN "language_code" = '''E''' THEN '''en'''
            ELSE "language_code"
        END AS "language_code",
        "street_address",
        "po_box",
        "postal_code",
        "city",
        "currency",
        "model_company",
        "global_site_id",
        "restaurant_code",
        "company_form",
        "branch_code",
        "main_company_code",
        "main_client_code",
        "local_company_code",
        "street_address_secondary",
        "industry_position",
        "row_id",
        "is_deleted"
    FROM "sap_t880_data_projected_renamed"
),

"sap_t880_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- branch_code: from DECIMAL to VARCHAR
    -- company_code: from INT to VARCHAR
    -- company_form: from DECIMAL to VARCHAR
    -- company_name_secondary: from DECIMAL to VARCHAR
    -- global_site_id: from DECIMAL to VARCHAR
    -- industry_position: from DECIMAL to VARCHAR
    -- local_company_code: from DECIMAL to VARCHAR
    -- main_client_code: from INT to VARCHAR
    -- main_company_code: from DECIMAL to VARCHAR
    -- mandate_number: from INT to VARCHAR
    -- model_company: from DECIMAL to VARCHAR
    -- po_box: from DECIMAL to VARCHAR
    -- restaurant_code: from DECIMAL to VARCHAR
    -- street_address_secondary: from DECIMAL to VARCHAR
    SELECT
        "company_name",
        "country",
        "language_code",
        "street_address",
        "postal_code",
        "city",
        "currency",
        "row_id",
        "is_deleted",
        CAST("branch_code" AS VARCHAR) AS "branch_code",
        CAST("company_code" AS VARCHAR) AS "company_code",
        CAST("company_form" AS VARCHAR) AS "company_form",
        CAST("company_name_secondary" AS VARCHAR) AS "company_name_secondary",
        CAST("global_site_id" AS VARCHAR) AS "global_site_id",
        CAST("industry_position" AS VARCHAR) AS "industry_position",
        CAST("local_company_code" AS VARCHAR) AS "local_company_code",
        CAST("main_client_code" AS VARCHAR) AS "main_client_code",
        CAST("main_company_code" AS VARCHAR) AS "main_company_code",
        CAST("mandate_number" AS VARCHAR) AS "mandate_number",
        CAST("model_company" AS VARCHAR) AS "model_company",
        CAST("po_box" AS VARCHAR) AS "po_box",
        CAST("restaurant_code" AS VARCHAR) AS "restaurant_code",
        CAST("street_address_secondary" AS VARCHAR) AS "street_address_secondary"
    FROM "sap_t880_data_projected_renamed_cleaned"
),

"sap_t880_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 7 columns with unacceptable missing values
    -- company_form has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- global_site_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_position has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- local_company_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- main_company_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- model_company has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- po_box has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "company_name",
        "country",
        "language_code",
        "street_address",
        "postal_code",
        "city",
        "currency",
        "row_id",
        "is_deleted",
        "branch_code",
        "company_code",
        "company_name_secondary",
        "main_client_code",
        "mandate_number",
        "restaurant_code",
        "street_address_secondary"
    FROM "sap_t880_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_t880_data_projected_renamed_cleaned_casted_missing_handled"