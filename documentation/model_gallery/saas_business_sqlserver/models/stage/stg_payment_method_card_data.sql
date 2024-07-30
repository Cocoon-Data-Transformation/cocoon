-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:45:56.972689+00:00
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
    FROM "MyAppDB"."dbo"."payment_method_card_data"
),

"payment_method_card_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- brand -> card_brand_hash
    -- description -> payment_method_description
    -- fingerprint -> card_fingerprint
    -- funding -> funding_type
    -- type -> payment_method_type
    -- wallet_type -> digital_wallet_type
    SELECT 
        "payment_method_id",
        "brand" AS "card_brand_hash",
        "charge_id",
        "description" AS "payment_method_description",
        "fingerprint" AS "card_fingerprint",
        "funding" AS "funding_type",
        "type" AS "payment_method_type",
        "wallet_type" AS "digital_wallet_type"
    FROM "payment_method_card_data_projected"
),

"payment_method_card_data_projected_renamed_casted" AS (
    -- Column Type Casting: 
    -- charge_id: from FLOAT to VARCHAR
    -- digital_wallet_type: from FLOAT to VARCHAR
    -- payment_method_description: from FLOAT to VARCHAR
    -- payment_method_type: from FLOAT to VARCHAR
    SELECT
        "payment_method_id",
        "card_brand_hash",
        "card_fingerprint",
        "funding_type",
        CAST("charge_id" AS VARCHAR) 
        AS "charge_id",
        CAST("digital_wallet_type" AS VARCHAR) 
        AS "digital_wallet_type",
        CAST("payment_method_description" AS VARCHAR(MAX)) 
        AS "payment_method_description",
        CAST("payment_method_type" AS VARCHAR) 
        AS "payment_method_type"
    FROM "payment_method_card_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT *
FROM "payment_method_card_data_projected_renamed_casted"