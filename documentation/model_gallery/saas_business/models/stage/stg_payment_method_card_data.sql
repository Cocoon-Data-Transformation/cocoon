-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"payment_method_card_data_projected" AS (
    -- Projection: Selecting 8 out of 9 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "payment_method_id",
        "brand",
        "charge_id",
        "description",
        "fingerprint",
        "funding",
        "type",
        "wallet_type"
    FROM "payment_method_card_data"
),

"payment_method_card_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- brand -> payment_provider_id
    -- fingerprint -> card_fingerprint
    -- funding -> funding_type
    -- type -> payment_method_type
    -- wallet_type -> digital_wallet_type
    SELECT 
        "payment_method_id",
        "brand" AS "payment_provider_id",
        "charge_id",
        "description",
        "fingerprint" AS "card_fingerprint",
        "funding" AS "funding_type",
        "type" AS "payment_method_type",
        "wallet_type" AS "digital_wallet_type"
    FROM "payment_method_card_data_projected"
),

"payment_method_card_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- charge_id: from DECIMAL to VARCHAR
    -- description: from DECIMAL to VARCHAR
    -- digital_wallet_type: from DECIMAL to VARCHAR
    -- payment_method_type: from DECIMAL to VARCHAR
    SELECT
        "payment_method_id",
        "payment_provider_id",
        "card_fingerprint",
        "funding_type",
        CAST("charge_id" AS VARCHAR) AS "charge_id",
        CAST("description" AS VARCHAR) AS "description",
        CAST("digital_wallet_type" AS VARCHAR) AS "digital_wallet_type",
        CAST("payment_method_type" AS VARCHAR) AS "payment_method_type"
    FROM "payment_method_card_data_projected_renamed"
),

"payment_method_card_data_projected_renamed_casted_missing_handled" AS (
    -- Handling missing values: There are 3 columns with unacceptable missing values
    -- charge_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- description has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- payment_method_type has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "payment_method_id",
        "payment_provider_id",
        "card_fingerprint",
        "funding_type",
        "digital_wallet_type"
    FROM "payment_method_card_data_projected_renamed_casted"
)

-- COCOON BLOCK END
SELECT * FROM "payment_method_card_data_projected_renamed_casted_missing_handled"