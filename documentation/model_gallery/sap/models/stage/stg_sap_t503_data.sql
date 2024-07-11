-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 14:55:10.122332+00:00
WITH 
"sap_t503_data_projected" AS (
    -- Projection: Selecting 18 out of 19 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "mandt",
        "persg",
        "persk",
        "abart",
        "abtyp",
        "antyp",
        "trfkz",
        "zeity",
        "aksta",
        "ansta",
        "austa",
        "konty",
        "burkz",
        "molga",
        "typsz",
        "inwid",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_t503_data"
),

"sap_t503_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- mandt -> client_code
    -- persg -> employee_group
    -- persk -> employee_subgroup
    -- abart -> payroll_area
    -- abtyp -> payroll_type
    -- antyp -> employment_type
    -- trfkz -> tariff_indicator
    -- zeity -> time_management_status
    -- aksta -> payroll_status
    -- ansta -> employment_status
    -- austa -> termination_status
    -- konty -> account_type
    -- burkz -> posting_indicator
    -- molga -> country_grouping
    -- typsz -> special_payment_type
    -- inwid -> in_house_pay_scale
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "mandt" AS "client_code",
        "persg" AS "employee_group",
        "persk" AS "employee_subgroup",
        "abart" AS "payroll_area",
        "abtyp" AS "payroll_type",
        "antyp" AS "employment_type",
        "trfkz" AS "tariff_indicator",
        "zeity" AS "time_management_status",
        "aksta" AS "payroll_status",
        "ansta" AS "employment_status",
        "austa" AS "termination_status",
        "konty" AS "account_type",
        "burkz" AS "posting_indicator",
        "molga" AS "country_grouping",
        "typsz" AS "special_payment_type",
        "inwid" AS "in_house_pay_scale",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_t503_data_projected"
),

"sap_t503_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- client_code: from INT to VARCHAR
    -- country_grouping: from DECIMAL to VARCHAR
    -- employment_type: from DECIMAL to VARCHAR
    -- in_house_pay_scale: from DECIMAL to VARCHAR
    -- special_payment_type: from DECIMAL to VARCHAR
    SELECT
        "employee_group",
        "employee_subgroup",
        "payroll_area",
        "payroll_type",
        "tariff_indicator",
        "time_management_status",
        "payroll_status",
        "employment_status",
        "termination_status",
        "account_type",
        "posting_indicator",
        "row_id",
        "is_deleted",
        CAST("client_code" AS VARCHAR) AS "client_code",
        CAST("country_grouping" AS VARCHAR) AS "country_grouping",
        CAST("employment_type" AS VARCHAR) AS "employment_type",
        CAST("in_house_pay_scale" AS VARCHAR) AS "in_house_pay_scale",
        CAST("special_payment_type" AS VARCHAR) AS "special_payment_type"
    FROM "sap_t503_data_projected_renamed"
),

"sap_t503_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- country_grouping has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- employment_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- in_house_pay_scale has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- special_payment_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "employee_group",
        "employee_subgroup",
        "payroll_area",
        "payroll_type",
        "tariff_indicator",
        "time_management_status",
        "payroll_status",
        "employment_status",
        "termination_status",
        "account_type",
        "posting_indicator",
        "row_id",
        "is_deleted",
        "client_code"
    FROM "sap_t503_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_t503_data_projected_renamed_casted_missing_handled"