-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"ship_mode_renamed" AS (
    -- Rename: Renaming columns
    -- SM_SHIP_MODE_SK -> ship_mode_surrogate_key
    -- SM_SHIP_MODE_ID -> ship_mode_id
    -- SM_TYPE -> shipping_service_type
    -- SM_CODE -> shipping_method_code
    -- SM_CARRIER -> carrier_name
    -- SM_CONTRACT -> contract_id
    SELECT 
        "SM_SHIP_MODE_SK" AS "ship_mode_surrogate_key",
        "SM_SHIP_MODE_ID" AS "ship_mode_id",
        "SM_TYPE" AS "shipping_service_type",
        "SM_CODE" AS "shipping_method_code",
        "SM_CARRIER" AS "carrier_name",
        "SM_CONTRACT" AS "contract_id"
    FROM "ship_mode"
),

"ship_mode_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- carrier_name: The problem is that some carrier names have typos or inconsistent formatting. BARIAN is likely a misspelling of "BAVARIAN". GERMA is probably a truncation of "GERMAN". RUPEKSA doesn't seem to be a known carrier name and may be a data entry error. PRIVATECARRIER is inconsistent with the formatting of other entries, which are typically all uppercase without spaces. The correct values should be standardized to all uppercase, with typos and inconsistencies corrected. 
    SELECT
        "ship_mode_surrogate_key",
        "ship_mode_id",
        "shipping_service_type",
        "shipping_method_code",
        CASE
            WHEN "carrier_name" = 'BARIAN' THEN 'BAVARIAN'
            WHEN "carrier_name" = 'GERMA' THEN 'GERMAN'
            WHEN "carrier_name" = 'RUPEKSA' THEN ''
            WHEN "carrier_name" = 'PRIVATECARRIER' THEN 'PRIVATE CARRIER'
            ELSE "carrier_name"
        END AS "carrier_name",
        "contract_id"
    FROM "ship_mode_renamed"
),

"ship_mode_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- carrier_name: ['']
    SELECT 
        CASE
            WHEN "carrier_name" = '' THEN NULL
            ELSE "carrier_name"
        END AS "carrier_name",
        "contract_id",
        "shipping_service_type",
        "shipping_method_code",
        "ship_mode_surrogate_key",
        "ship_mode_id"
    FROM "ship_mode_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "ship_mode_renamed_cleaned_null"