-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"credit_note_line_item_data_projected" AS (
    -- Projection: Selecting 10 out of 11 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "credit_note_id",
        "id",
        "amount",
        "discount_amount",
        "description",
        "livemode",
        "quantity",
        "type",
        "unit_amount",
        "unit_amount_decimal"
    FROM "credit_note_line_item_data"
),

"credit_note_line_item_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> line_item_id
    -- amount -> total_amount
    -- description -> item_description
    -- livemode -> is_live_mode
    -- type -> line_item_type
    -- unit_amount -> unit_price_cents
    -- unit_amount_decimal -> unit_price_precise
    SELECT 
        "credit_note_id",
        "id" AS "line_item_id",
        "amount" AS "total_amount",
        "discount_amount",
        "description" AS "item_description",
        "livemode" AS "is_live_mode",
        "quantity",
        "type" AS "line_item_type",
        "unit_amount" AS "unit_price_cents",
        "unit_amount_decimal" AS "unit_price_precise"
    FROM "credit_note_line_item_data_projected"
),

"credit_note_line_item_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- item_description: The problem is that 'description_here' is a placeholder value and not a real item description. This is unusual because it doesn't provide any actual information about the item. The correct value should be an empty string, as we don't have the real description and leaving it blank is more appropriate than using a placeholder. 
    SELECT
        "credit_note_id",
        "line_item_id",
        "total_amount",
        "discount_amount",
        CASE
            WHEN "item_description" = '''description_here''' THEN ''''
            ELSE "item_description"
        END AS "item_description",
        "is_live_mode",
        "quantity",
        "line_item_type",
        "unit_price_cents",
        "unit_price_precise"
    FROM "credit_note_line_item_data_projected_renamed"
),

"credit_note_line_item_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- discount_amount: from INT to DECIMAL
    -- total_amount: from INT to DECIMAL
    -- unit_price_precise: from INT to DECIMAL
    SELECT
        "credit_note_id",
        "line_item_id",
        "item_description",
        "is_live_mode",
        "quantity",
        "line_item_type",
        "unit_price_cents",
        CAST("discount_amount" AS DECIMAL) AS "discount_amount",
        CAST("total_amount" AS DECIMAL) AS "total_amount",
        CAST("unit_price_precise" AS DECIMAL) AS "unit_price_precise"
    FROM "credit_note_line_item_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "credit_note_line_item_data_projected_renamed_cleaned_casted"