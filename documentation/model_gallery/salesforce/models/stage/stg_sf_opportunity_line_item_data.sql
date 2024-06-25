-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"sf_opportunity_line_item_data_removeWideColumns" AS (
    -- Remove wide columns with pattern. The regex and columns are:
    -- ^celigo_sfnsio_.*_c$: celigo_sfnsio_contract_item_id_c, celigo_sfnsio_contract_term_c, celigo_sfnsio_end_date_c, celigo_sfnsio_list_rate_c, celigo_sfnsio_net_suite_line_id_c, celigo_sfnsio_start_date_c
    -- ^netsuite_conn_.*_c$: netsuite_conn_discount_item_c, netsuite_conn_end_date_c, netsuite_conn_from_contract_item_id_c, netsuite_conn_item_category_c, netsuite_conn_list_rate_c, netsuite_conn_net_suite_item_id_import_c, netsuite_conn_net_suite_item_key_id_c, netsuite_conn_pushed_from_net_suite_c, netsuite_conn_start_date_c, netsuite_conn_term_contract_pricing_type_c ...
    -- ^one_saas_app_.*_c$: one_saas_app_included_c, one_saas_app_quantity_invoiced_c, one_saas_app_quantity_not_invoiced_c
    SELECT 
        "_fivetran_active",
        "_fivetran_synced",
        "created_by_id",
        "created_date",
        "description",
        "discount",
        "event_volume_c",
        "has_quantity_schedule",
        "has_revenue_schedule",
        "has_schedule",
        "hvr_use_case_c",
        "id",
        "is_deleted",
        "last_modified_by_id",
        "last_modified_date",
        "last_referenced_date",
        "last_viewed_date",
        "list_price",
        "months_c",
        "name",
        "opportunity_id",
        "pricebook_entry_id",
        "product_2_id",
        "product_code",
        "product_code_stamped_c",
        "product_family_c",
        "quantity",
        "roadmap_connections_c",
        "row_volume_c",
        "sbqq_parent_id_c",
        "sbqq_quote_line_c",
        "sbqq_subscription_type_c",
        "service_date",
        "sort_order",
        "system_modstamp",
        "total_price",
        "unit_price"
    FROM "sf_opportunity_line_item_data"
),

"sf_opportunity_line_item_data_removeWideColumns_projected" AS (
    -- Projection: Selecting 36 out of 37 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "_fivetran_active",
        "created_by_id",
        "created_date",
        "description",
        "discount",
        "event_volume_c",
        "has_quantity_schedule",
        "has_revenue_schedule",
        "has_schedule",
        "hvr_use_case_c",
        "id",
        "is_deleted",
        "last_modified_by_id",
        "last_modified_date",
        "last_referenced_date",
        "last_viewed_date",
        "list_price",
        "months_c",
        "name",
        "opportunity_id",
        "pricebook_entry_id",
        "product_2_id",
        "product_code",
        "product_code_stamped_c",
        "product_family_c",
        "quantity",
        "roadmap_connections_c",
        "row_volume_c",
        "sbqq_parent_id_c",
        "sbqq_quote_line_c",
        "sbqq_subscription_type_c",
        "service_date",
        "sort_order",
        "system_modstamp",
        "total_price",
        "unit_price"
    FROM "sf_opportunity_line_item_data_removeWideColumns"
),

"sf_opportunity_line_item_data_removeWideColumns_projected_renamed" AS (
    -- Rename: Renaming columns
    -- _fivetran_active -> is_active
    -- created_by_id -> creator_id
    -- created_date -> creation_datetime
    -- description -> item_description
    -- discount -> discount_amount
    -- event_volume_c -> event_volume
    -- hvr_use_case_c -> hvr_use_case
    -- id -> line_item_id
    -- last_modified_by_id -> last_modifier_id
    -- last_modified_date -> last_modified_datetime
    -- months_c -> duration_months
    -- name -> product_name
    -- product_2_id -> product_id
    -- product_code_stamped_c -> stamped_product_code
    -- product_family_c -> product_family
    -- roadmap_connections_c -> roadmap_connections
    -- row_volume_c -> row_volume
    -- sbqq_parent_id_c -> sbqq_parent_id
    -- sbqq_quote_line_c -> sbqq_quote_line
    -- sbqq_subscription_type_c -> subscription_type
    -- system_modstamp -> last_modified_timestamp
    SELECT 
        "_fivetran_active" AS "is_active",
        "created_by_id" AS "creator_id",
        "created_date" AS "creation_datetime",
        "description" AS "item_description",
        "discount" AS "discount_amount",
        "event_volume_c" AS "event_volume",
        "has_quantity_schedule",
        "has_revenue_schedule",
        "has_schedule",
        "hvr_use_case_c" AS "hvr_use_case",
        "id" AS "line_item_id",
        "is_deleted",
        "last_modified_by_id" AS "last_modifier_id",
        "last_modified_date" AS "last_modified_datetime",
        "last_referenced_date",
        "last_viewed_date",
        "list_price",
        "months_c" AS "duration_months",
        "name" AS "product_name",
        "opportunity_id",
        "pricebook_entry_id",
        "product_2_id" AS "product_id",
        "product_code",
        "product_code_stamped_c" AS "stamped_product_code",
        "product_family_c" AS "product_family",
        "quantity",
        "roadmap_connections_c" AS "roadmap_connections",
        "row_volume_c" AS "row_volume",
        "sbqq_parent_id_c" AS "sbqq_parent_id",
        "sbqq_quote_line_c" AS "sbqq_quote_line",
        "sbqq_subscription_type_c" AS "subscription_type",
        "service_date",
        "sort_order",
        "system_modstamp" AS "last_modified_timestamp",
        "total_price",
        "unit_price"
    FROM "sf_opportunity_line_item_data_removeWideColumns_projected"
),

"sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- product_name: The problem is twofold: 1) There are typos in 'sof  serve' and 'sof  ware', which should be 'soft serve' and 'software' respectively. 2) The naming convention is inconsistent, with most plans using lowercase letters (a, b, d, e, f, g, h) but 'self serve' and the misspelled versions using full words. To maintain consistency, we should keep the most frequent format, which is the lowercase letter plans. 'self serve', 'soft serve', and 'software' don't fit this pattern, so they should be assigned new, consistent names. 
    -- opportunity_id: The problem is that two values ('0061G00000I L0vQAF' and '0061G00000Is1  QAJ') contain unexpected spaces, which are likely typos or data entry errors. The correct values should follow the pattern of the other valid entries, which is a string of 18 characters without spaces. The most frequent and correct pattern is '0061G00000HhviAQAR'. 
    -- pricebook_entry_id: The problem is that two of the values ('01u1G000002Kc PQAS' and '01u1G000002Kc qQAC') contain spaces, which is unusual for ID fields. The correct values should follow the pattern of the other IDs, which is a 15-character string without spaces. The most likely explanation is that these are typos, where a space was accidentally inserted. The correct values should be '01u1G000002KcPQAS' and '01u1G000002KcqQAC' respectively, removing the space. 
    -- sbqq_quote_line: The problem is that two values contain spaces ('a4R1G000000X xmUAC' and 'a4R1G000000Xr kUAK'), which is inconsistent with the pattern of the other IDs. The correct values should not contain spaces. The most likely explanation is that these are typos, and the spaces should be removed to match the pattern of the other IDs. 
    -- subscription_type: The problem is that 'X' is an unclear and non-descriptive value for a subscription type. It doesn't provide any meaningful information about the subscription. The correct values should be descriptive of the subscription type. In this case, 'Renewable' is a clear and descriptive value, while 'X' is not. 
    SELECT
        "is_active",
        "creator_id",
        "creation_datetime",
        "item_description",
        "discount_amount",
        "event_volume",
        "has_quantity_schedule",
        "has_revenue_schedule",
        "has_schedule",
        "hvr_use_case",
        "line_item_id",
        "is_deleted",
        "last_modifier_id",
        "last_modified_datetime",
        "last_referenced_date",
        "last_viewed_date",
        "list_price",
        "duration_months",
        CASE
            WHEN "product_name" = 'sof  serve' THEN 'plan i'
            WHEN "product_name" = 'sof  ware' THEN 'plan j'
            WHEN "product_name" = 'self serve' THEN 'plan k'
            ELSE "product_name"
        END AS "product_name",
        CASE
            WHEN "opportunity_id" = '0061G00000I L0vQAF' THEN '0061G00000IL0vQAF'
            WHEN "opportunity_id" = '0061G00000Is1  QAJ' THEN '0061G00000Is1QAJ'
            ELSE "opportunity_id"
        END AS "opportunity_id",
        CASE
            WHEN "pricebook_entry_id" = '01u1G000002Kc PQAS' THEN '01u1G000002KcPQAS'
            WHEN "pricebook_entry_id" = '01u1G000002Kc qQAC' THEN '01u1G000002KcqQAC'
            ELSE "pricebook_entry_id"
        END AS "pricebook_entry_id",
        "product_id",
        "product_code",
        "stamped_product_code",
        "product_family",
        "quantity",
        "roadmap_connections",
        "row_volume",
        "sbqq_parent_id",
        CASE
            WHEN "sbqq_quote_line" = 'a4R1G000000X xmUAC' THEN 'a4R1G000000XxmUAC'
            WHEN "sbqq_quote_line" = 'a4R1G000000Xr kUAK' THEN 'a4R1G000000XrkUAK'
            ELSE "sbqq_quote_line"
        END AS "sbqq_quote_line",
        CASE
            WHEN "subscription_type" = 'X' THEN ''
            ELSE "subscription_type"
        END AS "subscription_type",
        "service_date",
        "sort_order",
        "last_modified_timestamp",
        "total_price",
        "unit_price"
    FROM "sf_opportunity_line_item_data_removeWideColumns_projected_renamed"
),

"sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- subscription_type: ['']
    SELECT 
        CASE
            WHEN "subscription_type" = '' THEN NULL
            ELSE "subscription_type"
        END AS "subscription_type",
        "last_referenced_date",
        "sbqq_parent_id",
        "service_date",
        "pricebook_entry_id",
        "row_volume",
        "event_volume",
        "last_viewed_date",
        "list_price",
        "is_deleted",
        "has_quantity_schedule",
        "product_code",
        "total_price",
        "last_modified_timestamp",
        "duration_months",
        "opportunity_id",
        "is_active",
        "sbqq_quote_line",
        "creation_datetime",
        "item_description",
        "roadmap_connections",
        "product_family",
        "product_name",
        "line_item_id",
        "quantity",
        "sort_order",
        "hvr_use_case",
        "stamped_product_code",
        "last_modifier_id",
        "has_schedule",
        "product_id",
        "has_revenue_schedule",
        "unit_price",
        "last_modified_datetime",
        "creator_id",
        "discount_amount"
    FROM "sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned"
),

"sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- creation_datetime: from VARCHAR to TIMESTAMP
    -- event_volume: from DECIMAL to VARCHAR
    -- has_quantity_schedule: from DECIMAL to BOOLEAN
    -- has_revenue_schedule: from DECIMAL to BOOLEAN
    -- has_schedule: from DECIMAL to BOOLEAN
    -- is_active: from DECIMAL to BOOLEAN
    -- item_description: from DECIMAL to VARCHAR
    -- last_modified_datetime: from VARCHAR to TIMESTAMP
    -- last_modified_timestamp: from VARCHAR to TIMESTAMP
    -- last_referenced_date: from DECIMAL to DATE
    -- last_viewed_date: from DECIMAL to DATE
    -- list_price: from INT to DECIMAL
    -- roadmap_connections: from DECIMAL to VARCHAR
    -- row_volume: from DECIMAL to VARCHAR
    -- service_date: from DECIMAL to DATE
    -- sort_order: from DECIMAL to INT
    -- stamped_product_code: from DECIMAL to VARCHAR
    SELECT
        "subscription_type",
        "sbqq_parent_id",
        "pricebook_entry_id",
        "is_deleted",
        "product_code",
        "total_price",
        "duration_months",
        "opportunity_id",
        "sbqq_quote_line",
        "product_family",
        "product_name",
        "line_item_id",
        "quantity",
        "hvr_use_case",
        "last_modifier_id",
        "product_id",
        "unit_price",
        "creator_id",
        "discount_amount",
        CAST("creation_datetime" AS TIMESTAMP) AS "creation_datetime",
        CAST("event_volume" AS VARCHAR) AS "event_volume",
        CAST("has_quantity_schedule" AS BOOLEAN) AS "has_quantity_schedule",
        CAST("has_revenue_schedule" AS BOOLEAN) AS "has_revenue_schedule",
        CAST("has_schedule" AS BOOLEAN) AS "has_schedule",
        CAST("is_active" AS BOOLEAN) AS "is_active",
        CAST("item_description" AS VARCHAR) AS "item_description",
        CAST("last_modified_datetime" AS TIMESTAMP) AS "last_modified_datetime",
        CAST("last_modified_timestamp" AS TIMESTAMP) AS "last_modified_timestamp",
        CAST("last_referenced_date" AS DATE) AS "last_referenced_date",
        CAST("last_viewed_date" AS DATE) AS "last_viewed_date",
        CAST("list_price" AS DECIMAL) AS "list_price",
        CAST("roadmap_connections" AS VARCHAR) AS "roadmap_connections",
        CAST("row_volume" AS VARCHAR) AS "row_volume",
        CAST("service_date" AS DATE) AS "service_date",
        CAST("sort_order" AS INT) AS "sort_order",
        CAST("stamped_product_code" AS VARCHAR) AS "stamped_product_code"
    FROM "sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned_null"
),

"sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 17 columns with unacceptable missing values
    -- discount_amount has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- event_volume has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- has_quantity_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- has_revenue_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- has_schedule has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- is_deleted has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- item_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_referenced_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_viewed_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_family has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- roadmap_connections has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- row_volume has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sbqq_parent_id has 90.0 percent missing. Strategy: 🔄 Unchanged
    -- service_date has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sort_order has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- stamped_product_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "subscription_type",
        "sbqq_parent_id",
        "pricebook_entry_id",
        "is_deleted",
        "product_code",
        "total_price",
        "duration_months",
        "opportunity_id",
        "sbqq_quote_line",
        "product_family",
        "product_name",
        "line_item_id",
        "quantity",
        "hvr_use_case",
        "last_modifier_id",
        "product_id",
        "unit_price",
        "creator_id",
        "creation_datetime",
        "last_modified_datetime",
        "last_modified_timestamp",
        "list_price"
    FROM "sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sf_opportunity_line_item_data_removeWideColumns_projected_renamed_cleaned_null_casted_missing_handled"