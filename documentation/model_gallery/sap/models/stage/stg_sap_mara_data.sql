-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-06 05:08:48.627318+00:00
WITH 
"sap_mara_data_projected" AS (
    -- Projection: Selecting 128 out of 129 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "mandt",
        "matnr",
        "ersda",
        "ernam",
        "laeda",
        "aenam",
        "vpsta",
        "pstat",
        "lvorm",
        "mtart",
        "mbrsh",
        "matkl",
        "bismt",
        "meins",
        "bstme",
        "zeinr",
        "zeiar",
        "zeivr",
        "zeifo",
        "aeszn",
        "blatt",
        "blanz",
        "ferth",
        "formt",
        "groes",
        "wrkst",
        "normt",
        "labor",
        "ekwsl",
        "brgew",
        "ntgew",
        "gewei",
        "volum",
        "voleh",
        "behvo",
        "raube",
        "tempb",
        "disst",
        "tragr",
        "stoff",
        "spart",
        "kunnr",
        "eannr",
        "wesch",
        "bwvor",
        "bwscl",
        "saiso",
        "etiar",
        "etifo",
        "entar",
        "ean11",
        "numtp",
        "laeng",
        "breit",
        "hoehe",
        "meabm",
        "prdha",
        "aeklk",
        "cadkz",
        "qmpur",
        "ergew",
        "ergei",
        "ervol",
        "ervoe",
        "gewto",
        "volto",
        "vabme",
        "kzrev",
        "kzkfg",
        "xchpf",
        "vhart",
        "fuelg",
        "stfak",
        "magrv",
        "begru",
        "datab",
        "liqdt",
        "saisj",
        "plgtp",
        "mlgut",
        "extwg",
        "satnr",
        "attyp",
        "kzkup",
        "kznfm",
        "pmata",
        "mstae",
        "mstav",
        "mstde",
        "mstdv",
        "taklv",
        "rbnrm",
        "mhdrz",
        "mhdhb",
        "mhdlp",
        "inhme",
        "inhal",
        "vpreh",
        "etiag",
        "inhbr",
        "cmeth",
        "cuobf",
        "kzumw",
        "kosch",
        "sprof",
        "nrfhg",
        "mfrpn",
        "mfrnr",
        "bmatn",
        "mprof",
        "kzwsm",
        "saity",
        "profl",
        "ihivi",
        "iloos",
        "serlv",
        "kzgvh",
        "xgchp",
        "kzeff",
        "compl",
        "iprkz",
        "rdmhd",
        "przus",
        "mtpos_mara",
        "bflme",
        "nsnid",
        "_fivetran_rowid",
        "_fivetran_deleted"
    FROM "memory"."main"."sap_mara_data"
),

"sap_mara_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- mandt -> client
    -- matnr -> material_number
    -- ersda -> creation_date
    -- ernam -> creator_name
    -- laeda -> last_change_date
    -- aenam -> last_changed_by
    -- vpsta -> complete_material_maintenance_status
    -- pstat -> maintenance_status
    -- lvorm -> deletion_block_flag
    -- mtart -> material_type
    -- mbrsh -> industry_sector
    -- matkl -> material_group
    -- bismt -> old_material_number
    -- meins -> base_unit_of_measure
    -- bstme -> purchase_order_uom
    -- zeinr -> rework_time
    -- zeiar -> production_procurement_time
    -- zeivr -> administrative_lead_time
    -- zeifo -> inhouse_production_time
    -- aeszn -> change_document_number
    -- blatt -> specification_page_number
    -- blanz -> number_of_sheets
    -- ferth -> production_memo
    -- formt -> material_format
    -- groes -> dimensions
    -- wrkst -> material_composition
    -- normt -> industry_standard_description
    -- labor -> lab_office
    -- ekwsl -> purchasing_value_key
    -- brgew -> gross_weight
    -- gewei -> weight_unit
    -- voleh -> volume_unit
    -- behvo -> container_requirements
    -- raube -> shelf_life_expiration
    -- tempb -> temperature_conditions
    -- disst -> distribution_status
    -- tragr -> transportation_group
    -- stoff -> hazardous_material_number
    -- spart -> division
    -- kunnr -> customer_number
    -- eannr -> ean_category
    -- wesch -> material_weight
    -- bwvor -> valuation_procedure
    -- bwscl -> valuation_class
    -- saiso -> season
    -- etiar -> hazmat_packaging_type
    -- etifo -> hazmat_form
    -- ean11 -> ean
    -- numtp -> number_type
    -- laeng -> length
    -- breit -> width
    -- hoehe -> height
    -- meabm -> max_storage_period
    -- prdha -> product_hierarchy
    -- aeklk -> purchase_order_text_key
    -- cadkz -> cad_indicator
    -- qmpur -> qm_procurement_active
    -- ergei -> allowed_packaging_weight
    -- ervoe -> proposer_name
    -- gewto -> gross_weight_tolerance
    -- volto -> volume_tolerance
    -- vabme -> variable_purchase_order_unit
    -- kzrev -> revision_level_indicator
    -- xchpf -> batch_management_required
    -- vhart -> packaging_material_type
    -- fuelg -> fill_quantity
    -- magrv -> packaging_material_group
    -- begru -> authorization_group
    -- datab -> valid_from_date
    -- liqdt -> deletion_flag
    -- saisj -> season_year
    -- plgtp -> planning_type
    -- mlgut -> storage_conditions
    -- extwg -> external_material_group
    -- satnr -> cross_plant_configurable_material
    -- attyp -> material_category
    -- kzkup -> co_product_indicator
    -- kznfm -> follow_up_material_indicator
    -- pmata -> pricing_reference_material
    -- mstae -> cross_plant_material_status
    -- mstav -> general_item_category_group
    -- mstde -> material_specific_status
    -- mstdv -> material_specific_status_usage
    -- taklv -> tax_classification
    -- rbnrm -> catalog_profile
    -- mhdrz -> min_remaining_shelf_life
    -- mhdhb -> shelf_life_expiration_date
    -- mhdlp -> storage_percentage
    -- inhme -> contents_unit
    -- inhal -> net_contents
    -- vpreh -> comparison_price_unit
    -- etiag -> hazmat_label_group
    -- inhbr -> gross_contents
    -- cmeth -> consumption_mode
    -- cuobf -> internal_object_number
    -- kzumw -> environmentally_relevant_indicator
    -- kosch -> product_allocation_procedure
    -- sprof -> sales_price_factor
    -- nrfhg -> central_article_number
    -- mfrpn -> manufacturer_part_number
    -- mfrnr -> manufacturer_number
    -- bmatn -> base_material_number
    -- mprof -> pricing_profile
    -- saity -> season_category
    -- profl -> profile
    -- ihivi -> hierarchy_category
    -- serlv -> serial_number_profile
    -- kzgvh -> packaging_material_indicator
    -- xgchp -> cross_plant_batch_management
    -- kzeff -> effectivity_parameter_indicator
    -- compl -> completion_level
    -- iprkz -> shelf_life_period_indicator
    -- rdmhd -> round_lot_size
    -- przus -> price_control_indicator
    -- mtpos_mara -> general_item_category_group_mara
    -- bflme -> lead_time_offset
    -- nsnid -> nato_stock_number
    -- _fivetran_rowid -> row_id
    -- _fivetran_deleted -> is_deleted
    SELECT 
        "mandt" AS "client",
        "matnr" AS "material_number",
        "ersda" AS "creation_date",
        "ernam" AS "creator_name",
        "laeda" AS "last_change_date",
        "aenam" AS "last_changed_by",
        "vpsta" AS "complete_material_maintenance_status",
        "pstat" AS "maintenance_status",
        "lvorm" AS "deletion_block_flag",
        "mtart" AS "material_type",
        "mbrsh" AS "industry_sector",
        "matkl" AS "material_group",
        "bismt" AS "old_material_number",
        "meins" AS "base_unit_of_measure",
        "bstme" AS "purchase_order_uom",
        "zeinr" AS "rework_time",
        "zeiar" AS "production_procurement_time",
        "zeivr" AS "administrative_lead_time",
        "zeifo" AS "inhouse_production_time",
        "aeszn" AS "change_document_number",
        "blatt" AS "specification_page_number",
        "blanz" AS "number_of_sheets",
        "ferth" AS "production_memo",
        "formt" AS "material_format",
        "groes" AS "dimensions",
        "wrkst" AS "material_composition",
        "normt" AS "industry_standard_description",
        "labor" AS "lab_office",
        "ekwsl" AS "purchasing_value_key",
        "brgew" AS "gross_weight",
        "ntgew",
        "gewei" AS "weight_unit",
        "volum",
        "voleh" AS "volume_unit",
        "behvo" AS "container_requirements",
        "raube" AS "shelf_life_expiration",
        "tempb" AS "temperature_conditions",
        "disst" AS "distribution_status",
        "tragr" AS "transportation_group",
        "stoff" AS "hazardous_material_number",
        "spart" AS "division",
        "kunnr" AS "customer_number",
        "eannr" AS "ean_category",
        "wesch" AS "material_weight",
        "bwvor" AS "valuation_procedure",
        "bwscl" AS "valuation_class",
        "saiso" AS "season",
        "etiar" AS "hazmat_packaging_type",
        "etifo" AS "hazmat_form",
        "entar",
        "ean11" AS "ean",
        "numtp" AS "number_type",
        "laeng" AS "length",
        "breit" AS "width",
        "hoehe" AS "height",
        "meabm" AS "max_storage_period",
        "prdha" AS "product_hierarchy",
        "aeklk" AS "purchase_order_text_key",
        "cadkz" AS "cad_indicator",
        "qmpur" AS "qm_procurement_active",
        "ergew",
        "ergei" AS "allowed_packaging_weight",
        "ervol",
        "ervoe" AS "proposer_name",
        "gewto" AS "gross_weight_tolerance",
        "volto" AS "volume_tolerance",
        "vabme" AS "variable_purchase_order_unit",
        "kzrev" AS "revision_level_indicator",
        "kzkfg",
        "xchpf" AS "batch_management_required",
        "vhart" AS "packaging_material_type",
        "fuelg" AS "fill_quantity",
        "stfak",
        "magrv" AS "packaging_material_group",
        "begru" AS "authorization_group",
        "datab" AS "valid_from_date",
        "liqdt" AS "deletion_flag",
        "saisj" AS "season_year",
        "plgtp" AS "planning_type",
        "mlgut" AS "storage_conditions",
        "extwg" AS "external_material_group",
        "satnr" AS "cross_plant_configurable_material",
        "attyp" AS "material_category",
        "kzkup" AS "co_product_indicator",
        "kznfm" AS "follow_up_material_indicator",
        "pmata" AS "pricing_reference_material",
        "mstae" AS "cross_plant_material_status",
        "mstav" AS "general_item_category_group",
        "mstde" AS "material_specific_status",
        "mstdv" AS "material_specific_status_usage",
        "taklv" AS "tax_classification",
        "rbnrm" AS "catalog_profile",
        "mhdrz" AS "min_remaining_shelf_life",
        "mhdhb" AS "shelf_life_expiration_date",
        "mhdlp" AS "storage_percentage",
        "inhme" AS "contents_unit",
        "inhal" AS "net_contents",
        "vpreh" AS "comparison_price_unit",
        "etiag" AS "hazmat_label_group",
        "inhbr" AS "gross_contents",
        "cmeth" AS "consumption_mode",
        "cuobf" AS "internal_object_number",
        "kzumw" AS "environmentally_relevant_indicator",
        "kosch" AS "product_allocation_procedure",
        "sprof" AS "sales_price_factor",
        "nrfhg" AS "central_article_number",
        "mfrpn" AS "manufacturer_part_number",
        "mfrnr" AS "manufacturer_number",
        "bmatn" AS "base_material_number",
        "mprof" AS "pricing_profile",
        "kzwsm",
        "saity" AS "season_category",
        "profl" AS "profile",
        "ihivi" AS "hierarchy_category",
        "iloos",
        "serlv" AS "serial_number_profile",
        "kzgvh" AS "packaging_material_indicator",
        "xgchp" AS "cross_plant_batch_management",
        "kzeff" AS "effectivity_parameter_indicator",
        "compl" AS "completion_level",
        "iprkz" AS "shelf_life_period_indicator",
        "rdmhd" AS "round_lot_size",
        "przus" AS "price_control_indicator",
        "mtpos_mara" AS "general_item_category_group_mara",
        "bflme" AS "lead_time_offset",
        "nsnid" AS "nato_stock_number",
        "_fivetran_rowid" AS "row_id",
        "_fivetran_deleted" AS "is_deleted"
    FROM "sap_mara_data_projected"
),

"sap_mara_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- complete_material_maintenance_status: The problem is that the complete_material_maintenance_status column contains only one value, 'k', which is unusual and does not convey meaningful information about maintenance status. Single letter codes are typically not used for maintenance status, as they are not descriptive or easily understandable. The correct values for a maintenance status column would typically be more descriptive, such as 'Completed', 'In Progress', 'Pending', or 'Not Started'. However, without more context or information about the intended meaning of 'k', it's difficult to map it to a specific status. In this case, it's best to map it to an empty string to indicate that the data is not meaningful or is missing. 
    -- maintenance_status: The problem is that 'k' is the only value present in the maintenance_status column, and it's unclear what this single letter represents in terms of maintenance status. Single letter codes are typically not used for maintenance statuses, as they are not self-explanatory. Without additional context or a data dictionary, it's impossible to determine what 'k' stands for or what the correct values should be. Given this lack of information, the best approach is to keep the value as is, but flag it for further investigation or clarification from the data source. 
    -- industry_sector: The problem is that 'm' is the only value in the industry_sector column, and it's not a standard industry sector abbreviation. It lacks clarity and doesn't provide meaningful information about the industry sector. The correct values for industry sectors should typically be more descriptive and recognizable, such as 'Technology', 'Healthcare', 'Finance', etc. However, without more context or information about the dataset, it's impossible to determine what 'm' might stand for or what the correct industry sector should be. 
    -- old_material_number: The problem is that the column 'old_material_number' contains only one unique value: 'updated desc'. This is unusual because material numbers are typically alphanumeric codes used to identify specific materials or products. The value 'updated desc' appears to be a placeholder or an error, possibly indicating that the actual material numbers were updated or replaced with this generic description. Since we don't have the actual material numbers and can't determine what they should be, the best approach is to map this meaningless value to an empty string. 
    SELECT
        "client",
        "material_number",
        "creation_date",
        "creator_name",
        "last_change_date",
        "last_changed_by",
        CASE
            WHEN "complete_material_maintenance_status" = '''k''' THEN ''''
            ELSE "complete_material_maintenance_status"
        END AS "complete_material_maintenance_status",
        "maintenance_status",
        "deletion_block_flag",
        "material_type",
        CASE
            WHEN "industry_sector" = '''m''' THEN NULL
            ELSE "industry_sector"
        END AS "industry_sector",
        "material_group",
        CASE
            WHEN "old_material_number" = '''updated desc''' THEN ''''
            ELSE "old_material_number"
        END AS "old_material_number",
        "base_unit_of_measure",
        "purchase_order_uom",
        "rework_time",
        "production_procurement_time",
        "administrative_lead_time",
        "inhouse_production_time",
        "change_document_number",
        "specification_page_number",
        "number_of_sheets",
        "production_memo",
        "material_format",
        "dimensions",
        "material_composition",
        "industry_standard_description",
        "lab_office",
        "purchasing_value_key",
        "gross_weight",
        "ntgew",
        "weight_unit",
        "volum",
        "volume_unit",
        "container_requirements",
        "shelf_life_expiration",
        "temperature_conditions",
        "distribution_status",
        "transportation_group",
        "hazardous_material_number",
        "division",
        "customer_number",
        "ean_category",
        "material_weight",
        "valuation_procedure",
        "valuation_class",
        "season",
        "hazmat_packaging_type",
        "hazmat_form",
        "entar",
        "ean",
        "number_type",
        "length",
        "width",
        "height",
        "max_storage_period",
        "product_hierarchy",
        "purchase_order_text_key",
        "cad_indicator",
        "qm_procurement_active",
        "ergew",
        "allowed_packaging_weight",
        "ervol",
        "proposer_name",
        "gross_weight_tolerance",
        "volume_tolerance",
        "variable_purchase_order_unit",
        "revision_level_indicator",
        "kzkfg",
        "batch_management_required",
        "packaging_material_type",
        "fill_quantity",
        "stfak",
        "packaging_material_group",
        "authorization_group",
        "valid_from_date",
        "deletion_flag",
        "season_year",
        "planning_type",
        "storage_conditions",
        "external_material_group",
        "cross_plant_configurable_material",
        "material_category",
        "co_product_indicator",
        "follow_up_material_indicator",
        "pricing_reference_material",
        "cross_plant_material_status",
        "general_item_category_group",
        "material_specific_status",
        "material_specific_status_usage",
        "tax_classification",
        "catalog_profile",
        "min_remaining_shelf_life",
        "shelf_life_expiration_date",
        "storage_percentage",
        "contents_unit",
        "net_contents",
        "comparison_price_unit",
        "hazmat_label_group",
        "gross_contents",
        "consumption_mode",
        "internal_object_number",
        "environmentally_relevant_indicator",
        "product_allocation_procedure",
        "sales_price_factor",
        "central_article_number",
        "manufacturer_part_number",
        "manufacturer_number",
        "base_material_number",
        "pricing_profile",
        "kzwsm",
        "season_category",
        "profile",
        "hierarchy_category",
        "iloos",
        "serial_number_profile",
        "packaging_material_indicator",
        "cross_plant_batch_management",
        "effectivity_parameter_indicator",
        "completion_level",
        "shelf_life_period_indicator",
        "round_lot_size",
        "price_control_indicator",
        "general_item_category_group_mara",
        "lead_time_offset",
        "nato_stock_number",
        "row_id",
        "is_deleted"
    FROM "sap_mara_data_projected_renamed"
),

"sap_mara_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- administrative_lead_time: from DECIMAL to INT
    -- authorization_group: from DECIMAL to VARCHAR
    -- base_material_number: from DECIMAL to VARCHAR
    -- batch_management_required: from DECIMAL to BOOLEAN
    -- cad_indicator: from DECIMAL to BOOLEAN
    -- catalog_profile: from DECIMAL to VARCHAR
    -- central_article_number: from DECIMAL to VARCHAR
    -- change_document_number: from DECIMAL to VARCHAR
    -- co_product_indicator: from DECIMAL to BOOLEAN
    -- consumption_mode: from DECIMAL to VARCHAR
    -- container_requirements: from DECIMAL to VARCHAR
    -- contents_unit: from DECIMAL to VARCHAR
    -- creation_date: from INT to DATE
    -- cross_plant_batch_management: from DECIMAL to BOOLEAN
    -- cross_plant_configurable_material: from DECIMAL to BOOLEAN
    -- cross_plant_material_status: from DECIMAL to VARCHAR
    -- customer_number: from DECIMAL to VARCHAR
    -- deletion_block_flag: from DECIMAL to BOOLEAN
    -- deletion_flag: from INT to BIT
    -- dimensions: from DECIMAL to VARCHAR
    -- distribution_status: from DECIMAL to VARCHAR
    -- division: from DECIMAL to VARCHAR
    -- ean: from DECIMAL to VARCHAR
    -- ean_category: from DECIMAL to VARCHAR
    -- effectivity_parameter_indicator: from DECIMAL to VARCHAR
    -- entar: from DECIMAL to VARCHAR
    -- environmentally_relevant_indicator: from DECIMAL to VARCHAR
    -- external_material_group: from DECIMAL to VARCHAR
    -- follow_up_material_indicator: from DECIMAL to VARCHAR
    -- general_item_category_group: from DECIMAL to VARCHAR
    -- hazardous_material_number: from DECIMAL to VARCHAR
    -- hazmat_form: from DECIMAL to VARCHAR
    -- hazmat_label_group: from DECIMAL to VARCHAR
    -- hazmat_packaging_type: from DECIMAL to VARCHAR
    -- hierarchy_category: from DECIMAL to VARCHAR
    -- iloos: from DECIMAL to VARCHAR
    -- industry_standard_description: from DECIMAL to VARCHAR
    -- inhouse_production_time: from DECIMAL to VARCHAR
    -- kzkfg: from DECIMAL to VARCHAR
    -- kzwsm: from DECIMAL to VARCHAR
    -- lab_office: from DECIMAL to VARCHAR
    -- last_change_date: from INT to DATE
    -- lead_time_offset: from DECIMAL to VARCHAR
    -- manufacturer_number: from DECIMAL to VARCHAR
    -- manufacturer_part_number: from DECIMAL to VARCHAR
    -- material_category: from DECIMAL to VARCHAR
    -- material_composition: from DECIMAL to VARCHAR
    -- material_format: from DECIMAL to VARCHAR
    -- material_group: from DECIMAL to VARCHAR
    -- material_number: from INT to VARCHAR
    -- max_storage_period: from DECIMAL to VARCHAR
    -- nato_stock_number: from DECIMAL to VARCHAR
    -- number_type: from DECIMAL to VARCHAR
    -- packaging_material_group: from DECIMAL to VARCHAR
    -- packaging_material_indicator: from DECIMAL to VARCHAR
    -- packaging_material_type: from DECIMAL to VARCHAR
    -- planning_type: from DECIMAL to VARCHAR
    -- price_control_indicator: from DECIMAL to VARCHAR
    -- pricing_profile: from DECIMAL to VARCHAR
    -- pricing_reference_material: from DECIMAL to VARCHAR
    -- product_allocation_procedure: from DECIMAL to VARCHAR
    -- product_hierarchy: from DECIMAL to VARCHAR
    -- production_memo: from DECIMAL to VARCHAR
    -- production_procurement_time: from DECIMAL to VARCHAR
    -- profile: from DECIMAL to VARCHAR
    -- proposer_name: from DECIMAL to VARCHAR
    -- purchase_order_text_key: from DECIMAL to VARCHAR
    -- purchase_order_uom: from DECIMAL to VARCHAR
    -- purchasing_value_key: from DECIMAL to VARCHAR
    -- qm_procurement_active: from DECIMAL to VARCHAR
    -- revision_level_indicator: from DECIMAL to VARCHAR
    -- rework_time: from DECIMAL to VARCHAR
    -- round_lot_size: from DECIMAL to VARCHAR
    -- sales_price_factor: from DECIMAL to VARCHAR
    -- season: from DECIMAL to VARCHAR
    -- season_category: from DECIMAL to VARCHAR
    -- season_year: from DECIMAL to VARCHAR
    -- serial_number_profile: from DECIMAL to VARCHAR
    -- shelf_life_expiration: from DECIMAL to VARCHAR
    -- shelf_life_period_indicator: from DECIMAL to VARCHAR
    -- specification_page_number: from DECIMAL to VARCHAR
    -- storage_conditions: from DECIMAL to VARCHAR
    -- tax_classification: from DECIMAL to VARCHAR
    -- temperature_conditions: from DECIMAL to VARCHAR
    -- transportation_group: from DECIMAL to VARCHAR
    -- valuation_class: from DECIMAL to VARCHAR
    -- valuation_procedure: from DECIMAL to VARCHAR
    -- variable_purchase_order_unit: from DECIMAL to VARCHAR
    -- volume_unit: from DECIMAL to VARCHAR
    -- weight_unit: from DECIMAL to VARCHAR
    SELECT
        "client",
        "creator_name",
        "last_changed_by",
        "complete_material_maintenance_status",
        "maintenance_status",
        "material_type",
        "industry_sector",
        "old_material_number",
        "base_unit_of_measure",
        "number_of_sheets",
        "gross_weight",
        "ntgew",
        "volum",
        "material_weight",
        "length",
        "width",
        "height",
        "ergew",
        "allowed_packaging_weight",
        "ervol",
        "gross_weight_tolerance",
        "volume_tolerance",
        "fill_quantity",
        "stfak",
        "valid_from_date",
        "material_specific_status",
        "material_specific_status_usage",
        "min_remaining_shelf_life",
        "shelf_life_expiration_date",
        "storage_percentage",
        "net_contents",
        "comparison_price_unit",
        "gross_contents",
        "internal_object_number",
        "completion_level",
        "general_item_category_group_mara",
        "row_id",
        "is_deleted",
        CAST("administrative_lead_time" AS INT) AS "administrative_lead_time",
        CAST("authorization_group" AS VARCHAR) AS "authorization_group",
        CAST("base_material_number" AS VARCHAR) AS "base_material_number",
        CAST("batch_management_required" AS BOOLEAN) AS "batch_management_required",
        CAST("cad_indicator" AS BOOLEAN) AS "cad_indicator",
        CAST("catalog_profile" AS VARCHAR) AS "catalog_profile",
        CAST("central_article_number" AS VARCHAR) AS "central_article_number",
        CAST("change_document_number" AS VARCHAR) AS "change_document_number",
        CAST("co_product_indicator" AS BOOLEAN) AS "co_product_indicator",
        CAST("consumption_mode" AS VARCHAR) AS "consumption_mode",
        CAST("container_requirements" AS VARCHAR) AS "container_requirements",
        CAST("contents_unit" AS VARCHAR) AS "contents_unit",
        strptime(CAST("creation_date" AS VARCHAR), '%Y%m%d') AS "creation_date",
        CAST("cross_plant_batch_management" AS BOOLEAN) AS "cross_plant_batch_management",
        CAST("cross_plant_configurable_material" AS BOOLEAN) AS "cross_plant_configurable_material",
        CAST("cross_plant_material_status" AS VARCHAR) AS "cross_plant_material_status",
        CAST("customer_number" AS VARCHAR) AS "customer_number",
        CAST("deletion_block_flag" AS BOOLEAN) AS "deletion_block_flag",
        CAST("deletion_flag" AS BIT) AS "deletion_flag",
        CAST("dimensions" AS VARCHAR) AS "dimensions",
        CAST("distribution_status" AS VARCHAR) AS "distribution_status",
        CAST("division" AS VARCHAR) AS "division",
        CAST("ean" AS VARCHAR) AS "ean",
        CAST("ean_category" AS VARCHAR) AS "ean_category",
        CAST("effectivity_parameter_indicator" AS VARCHAR) AS "effectivity_parameter_indicator",
        CAST("entar" AS VARCHAR) AS "entar",
        CAST("environmentally_relevant_indicator" AS VARCHAR) AS "environmentally_relevant_indicator",
        CAST("external_material_group" AS VARCHAR) AS "external_material_group",
        CAST("follow_up_material_indicator" AS VARCHAR) AS "follow_up_material_indicator",
        CAST("general_item_category_group" AS VARCHAR) AS "general_item_category_group",
        CAST("hazardous_material_number" AS VARCHAR) AS "hazardous_material_number",
        CAST("hazmat_form" AS VARCHAR) AS "hazmat_form",
        CAST("hazmat_label_group" AS VARCHAR) AS "hazmat_label_group",
        CAST("hazmat_packaging_type" AS VARCHAR) AS "hazmat_packaging_type",
        CAST("hierarchy_category" AS VARCHAR) AS "hierarchy_category",
        CAST("iloos" AS VARCHAR) AS "iloos",
        CAST("industry_standard_description" AS VARCHAR) AS "industry_standard_description",
        CAST("inhouse_production_time" AS VARCHAR) AS "inhouse_production_time",
        CAST("kzkfg" AS VARCHAR) AS "kzkfg",
        CAST("kzwsm" AS VARCHAR) AS "kzwsm",
        CAST("lab_office" AS VARCHAR) AS "lab_office",
        CASE 
            WHEN "last_change_date" BETWEEN 10000101 AND 99991231 
            THEN strptime(CAST("last_change_date" AS VARCHAR), '%Y%m%d')
            ELSE NULL
        END AS "last_change_date",
        CAST("lead_time_offset" AS VARCHAR) AS "lead_time_offset",
        CAST("manufacturer_number" AS VARCHAR) AS "manufacturer_number",
        CAST("manufacturer_part_number" AS VARCHAR) AS "manufacturer_part_number",
        CAST("material_category" AS VARCHAR) AS "material_category",
        CAST("material_composition" AS VARCHAR) AS "material_composition",
        CAST("material_format" AS VARCHAR) AS "material_format",
        CAST("material_group" AS VARCHAR) AS "material_group",
        CAST("material_number" AS VARCHAR) AS "material_number",
        CAST("max_storage_period" AS VARCHAR) AS "max_storage_period",
        CAST("nato_stock_number" AS VARCHAR) AS "nato_stock_number",
        CAST("number_type" AS VARCHAR) AS "number_type",
        CAST("packaging_material_group" AS VARCHAR) AS "packaging_material_group",
        CAST("packaging_material_indicator" AS VARCHAR) AS "packaging_material_indicator",
        CAST("packaging_material_type" AS VARCHAR) AS "packaging_material_type",
        CAST("planning_type" AS VARCHAR) AS "planning_type",
        CAST("price_control_indicator" AS VARCHAR) AS "price_control_indicator",
        CAST("pricing_profile" AS VARCHAR) AS "pricing_profile",
        CAST("pricing_reference_material" AS VARCHAR) AS "pricing_reference_material",
        CAST("product_allocation_procedure" AS VARCHAR) AS "product_allocation_procedure",
        CAST("product_hierarchy" AS VARCHAR) AS "product_hierarchy",
        CAST("production_memo" AS VARCHAR) AS "production_memo",
        CAST("production_procurement_time" AS VARCHAR) AS "production_procurement_time",
        CAST("profile" AS VARCHAR) AS "profile",
        CAST("proposer_name" AS VARCHAR) AS "proposer_name",
        CAST("purchase_order_text_key" AS VARCHAR) AS "purchase_order_text_key",
        CAST("purchase_order_uom" AS VARCHAR) AS "purchase_order_uom",
        CAST("purchasing_value_key" AS VARCHAR) AS "purchasing_value_key",
        CAST("qm_procurement_active" AS VARCHAR) AS "qm_procurement_active",
        CAST("revision_level_indicator" AS VARCHAR) AS "revision_level_indicator",
        CAST("rework_time" AS VARCHAR) AS "rework_time",
        CAST("round_lot_size" AS VARCHAR) AS "round_lot_size",
        CAST("sales_price_factor" AS VARCHAR) AS "sales_price_factor",
        CAST("season" AS VARCHAR) AS "season",
        CAST("season_category" AS VARCHAR) AS "season_category",
        CAST("season_year" AS VARCHAR) AS "season_year",
        CAST("serial_number_profile" AS VARCHAR) AS "serial_number_profile",
        CAST("shelf_life_expiration" AS VARCHAR) AS "shelf_life_expiration",
        CAST("shelf_life_period_indicator" AS VARCHAR) AS "shelf_life_period_indicator",
        CAST("specification_page_number" AS VARCHAR) AS "specification_page_number",
        CAST("storage_conditions" AS VARCHAR) AS "storage_conditions",
        CAST("tax_classification" AS VARCHAR) AS "tax_classification",
        CAST("temperature_conditions" AS VARCHAR) AS "temperature_conditions",
        CAST("transportation_group" AS VARCHAR) AS "transportation_group",
        CAST("valuation_class" AS VARCHAR) AS "valuation_class",
        CAST("valuation_procedure" AS VARCHAR) AS "valuation_procedure",
        CAST("variable_purchase_order_unit" AS VARCHAR) AS "variable_purchase_order_unit",
        CAST("volume_unit" AS VARCHAR) AS "volume_unit",
        CAST("weight_unit" AS VARCHAR) AS "weight_unit"
    FROM "sap_mara_data_projected_renamed_cleaned"
),

"sap_mara_data_projected_renamed_cleaned_casted_missing_handled" AS (
    -- Handling missing values: There are 82 columns with unacceptable missing values
    -- administrative_lead_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- allowed_packaging_weight has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- authorization_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- base_material_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- batch_management_required has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cad_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- catalog_profile has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- central_article_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- change_document_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- co_product_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- consumption_mode has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- contents_unit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cross_plant_batch_management has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cross_plant_configurable_material has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- cross_plant_material_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- customer_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- deletion_block_flag has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- dimensions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- distribution_status has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- division has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ean has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- ean_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- effectivity_parameter_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- entar has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- environmentally_relevant_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- external_material_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- follow_up_material_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- general_item_category_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- hierarchy_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- iloos has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- industry_standard_description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- inhouse_production_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- kzkfg has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- kzwsm has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- lab_office has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- last_change_date has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- last_changed_by has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- lead_time_offset has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- material_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- material_composition has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- material_format has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- material_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- max_storage_period has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- nato_stock_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- number_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- packaging_material_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- packaging_material_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- packaging_material_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- planning_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- price_control_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pricing_profile has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- pricing_reference_material has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_allocation_procedure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- product_hierarchy has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- production_memo has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- production_procurement_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- profile has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- proposer_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchase_order_text_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchase_order_uom has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- purchasing_value_key has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- qm_procurement_active has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- revision_level_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- rework_time has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- round_lot_size has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- sales_price_factor has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- season has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- season_category has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- season_year has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- serial_number_profile has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shelf_life_expiration has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shelf_life_period_indicator has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- specification_page_number has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- storage_conditions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tax_classification has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- temperature_conditions has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- transportation_group has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- valuation_class has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- valuation_procedure has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- variable_purchase_order_unit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- volume_unit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- weight_unit has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "client",
        "creator_name",
        "last_changed_by",
        "complete_material_maintenance_status",
        "maintenance_status",
        "material_type",
        "industry_sector",
        "old_material_number",
        "base_unit_of_measure",
        "number_of_sheets",
        "gross_weight",
        "ntgew",
        "volum",
        "material_weight",
        "length",
        "width",
        "height",
        "ergew",
        "ervol",
        "gross_weight_tolerance",
        "volume_tolerance",
        "fill_quantity",
        "stfak",
        "valid_from_date",
        "material_specific_status",
        "material_specific_status_usage",
        "min_remaining_shelf_life",
        "shelf_life_expiration_date",
        "storage_percentage",
        "net_contents",
        "comparison_price_unit",
        "gross_contents",
        "internal_object_number",
        "completion_level",
        "general_item_category_group_mara",
        "row_id",
        "is_deleted",
        "container_requirements",
        "creation_date",
        "deletion_flag",
        "hazardous_material_number",
        "hazmat_form",
        "hazmat_label_group",
        "hazmat_packaging_type",
        "last_change_date",
        "manufacturer_number",
        "manufacturer_part_number",
        "material_number"
    FROM "sap_mara_data_projected_renamed_cleaned_casted"
)

-- COCOON BLOCK END
SELECT * FROM "sap_mara_data_projected_renamed_cleaned_casted_missing_handled"